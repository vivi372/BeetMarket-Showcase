package com.beetmarket.stock.mapper;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.beetmarket.stock.vo.CashVO;
import com.beetmarket.stock.vo.StockVO;
import com.beetmarket.stock.vo.Stock_As_BiVO;
import com.beetmarket.stock.vo.Stock_HoldVO;
import com.beetmarket.stock.vo.Stock_InfoVO;
import com.beetmarket.stock.vo.Stock_OrderVO;

public interface StockMapper {
	
	// 1-1 list
	public List<StockVO> stockList();
	// 2. 주식 정보 데이터 DB에 업데이트하기
	public Integer updateStockInfo(Stock_InfoVO vo);
	// 3. 주식 정보 데이터 DB에서 가져오기
	public Stock_InfoVO getStockInfo(StockVO vo);
	// 4. 주식 정보 데이터 DB에 업데이트하기
	public Integer updateStockAsBi(Stock_As_BiVO vo);
	// 5. 주식 정보 데이터 DB에서 가져오기
	public Stock_As_BiVO getStockAsBi(StockVO vo);
	// 6. 주식 계좌 만들기
	public Long makeCash(@Param("id")String id);
	// 7. 계좌 정보 가져오기
	public CashVO getCashInfoById(String id);
	// 8. 계좌 정보 가져오기
	public Long StockOrder(Stock_OrderVO vo);
	// 9. 주식 주문 내역 리스트 가져오기
	List<Stock_OrderVO> getOrderList(String id);
	// 10. 매수 시 보유 주식 저장
	public Integer saveStockHold(Stock_HoldVO vo); 
	// 11. 매도 시 보유 주식 감소
	public Integer updateStockHoldCount(@Param("id")String id, @Param("company_code")String companyCode,@Param("stockCount") int stockCount, @Param("orderType")String orderType); // 보유 주식 수량 업데이트
	// 12. 특정 종목의 보유 주식 조회
	public Stock_HoldVO getStockHold(@Param("id")String id, @Param("company_code")String companyCode);
	// 13. 보유 현금 업데이트
	public Integer updateCash(@Param("id") String id, @Param("money")int money); 
	// 14. 보유 종목 리스트
	public List<Stock_HoldVO> getStockHoldList(String id);
	// 15. 보유 종목 추가 매수시 DB업데이트
	public Integer updateStockHold(Stock_HoldVO existingHold);
	// 16. 토큰 DB에 저장하고 업데이트
	public Integer insertOrUpdateToken(Map<String, Object> params);
	// 17. DB에 저장된 토큰 불러오기
	public String getTokenFromDB(int tokenNo);
    // 18.주문 상태 업데이트
    public Integer updateOrderStatus(Stock_OrderVO order);
    // 19. 미체결된 주문 조회
   	public List<Stock_OrderVO> getPendingOrders(String companyCode);
   	// 20. 보유 수량 조회 메서드
   	public Integer getHoldingQuantity(@Param("company_code") String company_code, @Param("id") String id);
}