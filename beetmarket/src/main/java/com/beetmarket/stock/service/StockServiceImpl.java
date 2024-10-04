package com.beetmarket.stock.service;

import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.beetmarket.stock.mapper.StockMapper;
import com.beetmarket.stock.vo.CashVO;
import com.beetmarket.stock.vo.StockVO;
import com.beetmarket.stock.vo.Stock_As_BiVO;
import com.beetmarket.stock.vo.Stock_HoldVO;
import com.beetmarket.stock.vo.Stock_InfoVO;
import com.beetmarket.stock.vo.Stock_OrderVO;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
@Qualifier("StockServiceImpl")
public class StockServiceImpl implements StockService {

	@Inject
	private StockMapper mapper;
	
	@Override
	public List<StockVO> stockList(){
	
		return mapper.stockList();
	}

	@Override
	public Integer updateStockInfo(Stock_InfoVO vo) {
		
		Integer result = mapper.updateStockInfo(vo);
		
		return result;
	}
	
	@Override
	public Stock_InfoVO getStockInfo(StockVO vo) {
		
		Stock_InfoVO result = mapper.getStockInfo(vo);
		
		return result;
	}

	@Override
	public Integer updateStockAsBi(Stock_As_BiVO vo) {
		
		Integer result = mapper.updateStockAsBi(vo);
		
		return result;
	}

	@Override
	public Stock_As_BiVO getStockAsBi(StockVO vo) {
		
		Stock_As_BiVO result = mapper.getStockAsBi(vo);
		
		return result;
	}
	@Override
	public Long makeCash(String id) {
		
		Long result = mapper.makeCash(id);
		
		return result;
	}
    @Override
    public CashVO getCashInfoById(String id) {
        return mapper.getCashInfoById(id);
    }
    
    @Override
    public Long StockOrder(Stock_OrderVO vo) {
    	return mapper.StockOrder(vo); 
    }

	@Override
	public List<Stock_OrderVO> getOrderList(String id) {
		return mapper.getOrderList(id);
	}
    @Override
    public Integer saveStockHold(Stock_HoldVO vo) {
    	return mapper.saveStockHold(vo);
    }

    @Override
    public Stock_HoldVO getStockHold(String id, String companyCode) {
        return mapper.getStockHold(id, companyCode); // 특정 종목의 보유 주식 정보 조회
    }

    @Override
    public Integer updateStockHoldCount(String id, String companyCode, int stockCount, String orderType) {
        if ("매수".equals(orderType)) {
        	return mapper.updateStockHoldCount(id, companyCode, stockCount, "매수");
        } else 
        	return mapper.updateStockHoldCount(id, companyCode, stockCount, "매도");
        
    }
    @Override
    public Integer updateCash(String id, int updatedAmount) {
    	return mapper.updateCash(id, updatedAmount);
    }
    @Override
    public List<Stock_HoldVO> getStockHoldList(String id) {
    	return mapper.getStockHoldList(id); // MyBatis 매퍼 호출
    }
    @Override
    public Integer updateStockHold(Stock_HoldVO existingHold) {
    	return mapper.updateStockHold(existingHold);
    }
    // 토큰을 DB에 저장하거나 업데이트하는 메서드
    @Override
    public Integer insertOrUpdateToken(Timestamp expried, String tokenCode) {
        Map<String, Object> params = new HashMap<>();
        params.put("expried", expried);
        params.put("token_code", tokenCode);
        
        return mapper.insertOrUpdateToken(params);
    }
    // DB에서 토큰을 가져오는 메서드
    public String getTokenFromDB(int tokenNo) {
        return mapper.getTokenFromDB(tokenNo);
    }
    
    @Override
    public Integer processOrder(Stock_OrderVO order, int matchedPrice, String orderStatus) {
        // 체결된 가격으로 업데이트
        order.setPrice(matchedPrice);
        order.setOrder_status(orderStatus);  // 주문 상태를 '체결'로 변경
        // DB에서 주문 상태를 업데이트 (매수/매도 모두 포함)
        Integer updateResult = mapper.updateOrderStatus(order);
        if (updateResult == 0) {
            return 0; // 주문 상태 업데이트 실패 시 0 반환
        }

        // 매수 주문 처리
        if ("매수".equals(order.getOrder_type())) {


            // 기존 보유 주식 정보를 가져옴
            Stock_HoldVO existingHold = mapper.getStockHold(order.getId(), order.getCompany_code());

            if (existingHold != null) {
                // 기존 보유 주식이 있을 경우 가중 평균 단가를 계산
                int existingStockCount = existingHold.getStock_hold_cnt();
                double existingPrice = existingHold.getPrice(); // 기존 주식의 평균 가격
                int newStockCount = order.getStock_count(); // 새로 매수한 주식 수량
                double newPrice = matchedPrice; // 새로 매수한 주식의 체결 가격

                // 가중 평균 단가 계산 (기존 가격 * 기존 수량 + 새 가격 * 새 수량) / (기존 수량 + 새 수량)
                double newAveragePrice = ((existingPrice * existingStockCount) + (newPrice * newStockCount)) / (existingStockCount + newStockCount);

                // 보유 주식의 가격과 수량 업데이트
                existingHold.setPrice((int) newAveragePrice);  // 가중 평균 단가를 정수로 변환하여 저장
                existingHold.setStock_hold_cnt(existingStockCount + newStockCount); // 총 보유 주식 수량 업데이트

                mapper.updateStockHold(existingHold);  // 보유 주식 업데이트
            } else {
                // 기존 보유 주식이 없을 경우 새로 추가
                Stock_HoldVO newHold = new Stock_HoldVO();
                newHold.setId(order.getId());
                newHold.setOrder_date(new Date());
                newHold.setCompany_code(order.getCompany_code());
                newHold.setPrice(matchedPrice); // 첫 매수 가격 설정
                newHold.setStock_hold_cnt(order.getStock_count()); // 매수한 수량 설정
                mapper.saveStockHold(newHold);  // 새로 보유 주식 저장
            }
        }

        // 매도 주문 처리
        else if ("매도".equals(order.getOrder_type())) {
            // 계좌 잔액에 매도 가격만큼 추가
        	Integer cashResult = updateCash(order.getId(), order.getPrice() * order.getStock_count());
            if (cashResult == 0) {
                return 0; // 잔액 업데이트 실패 시 0 반환
            }

            // 보유 주식 수량 감소 처리
            Integer holdResult = updateStockHoldCount(order.getId(), order.getCompany_code(), order.getStock_count(), "매도");
            if (holdResult == 0) {
                return 0; // 보유 주식 수량 업데이트 실패 시 0 반환
            }
        }

        return 1; // 모든 과정이 성공적으로 완료되면 1 반환
    }


	@Override
	public List<Stock_OrderVO> getPendingOrders(String companyCode) {
		return mapper.getPendingOrders(companyCode);
	}
	
	 @Override
	 public Integer updateOrderStatus(Stock_OrderVO order) {
		 return mapper.updateOrderStatus(order);
	 }
	 
	@Override
    // 보유 수량 조회 서비스 메서드
    public Integer getHoldingQuantity(String company_code, String id) {
        return mapper.getHoldingQuantity(company_code, id);
    }
}	