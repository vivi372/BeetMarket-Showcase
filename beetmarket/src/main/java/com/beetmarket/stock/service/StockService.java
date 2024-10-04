package com.beetmarket.stock.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.beetmarket.stock.vo.CashVO;
import com.beetmarket.stock.vo.StockVO;
import com.beetmarket.stock.vo.Stock_As_BiVO;
import com.beetmarket.stock.vo.Stock_HoldVO;
import com.beetmarket.stock.vo.Stock_InfoVO;
import com.beetmarket.stock.vo.Stock_OrderVO;

public interface StockService {

	// 1. 종목 리스트
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
	public Long makeCash(String id);
	// 7. 계좌 정보 가져오기
	public CashVO getCashInfoById(String id);
	// 8. 계좌 정보 가져오기
	public Long StockOrder(Stock_OrderVO vo);
	// 9. 주식 주문 내역 리스트 가져오기
	List<Stock_OrderVO> getOrderList(String id);
	// 10. 매수 시 보유 주식 저장
	public Integer saveStockHold(Stock_HoldVO vo); 
	// 11. 매도 시 보유 주식 감소
	public Integer updateStockHoldCount(String id, String companyCode, int stockCount, String orderType); // 보유 주식 수량 업데이트
	// 12. 특정 종목의 보유 주식 조회
	public Stock_HoldVO getStockHold(String id, String companyCode);
	// 13. 보유 현금 업데이트
	public Integer updateCash(String id, int newAmount);
	// 14. 보유 종목 리스트
	public List<Stock_HoldVO> getStockHoldList(String id);
	// 15. 보유 종목 추가 매수시 DB업데이트
	public Integer updateStockHold(Stock_HoldVO existingHold);
	// 16. 토큰 DB에 저장하고 업데이트
	public Integer insertOrUpdateToken(@Param("expried") java.sql.Timestamp expried,  @Param("token_code") String tokenCode);;
	// 17. DB에 저장된 토큰 불러오기
	public String getTokenFromDB(int tokenNo);
	// 18. 미체결 주문 업데이트
	public Integer processOrder(Stock_OrderVO order, int matchedPrice, String orderStatus);
    // 19. 미체결된 주문 조회
	public List<Stock_OrderVO> getPendingOrders(String companyCode);
	// 20. 주문 상태 업데이트
    public Integer updateOrderStatus(Stock_OrderVO order);
    // 21. 보유 수량 조회 서비스 메서드
    public Integer getHoldingQuantity(String company_code, String user_id) ;
}