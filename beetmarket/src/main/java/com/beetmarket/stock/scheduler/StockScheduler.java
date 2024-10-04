package com.beetmarket.stock.scheduler;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import com.beetmarket.stock.controller.StockController;
import com.beetmarket.stock.service.StockService;
import com.beetmarket.stock.vo.StockVO;
import com.beetmarket.stock.vo.Stock_As_BiVO;
import com.beetmarket.stock.vo.Stock_OrderVO;

import java.util.Arrays;
import java.util.List;


@Component
public class StockScheduler {

	// 자동 DI 
	@Autowired 
	@Qualifier("StockServiceImpl")
	private StockService stockService;
    @Autowired
    private StockController stockController;

    private List<String> stockCodes = Arrays.asList(
    	    "005930", // 삼성전자
    	    "000660", // SK하이닉스
    	    "005380", // 현대차
    	    "051910", // LG화학
    	    "005490", // POSCO홀딩스
    	    "035720", // 카카오
    	    "035420", // NAVER
    	    "068270", // 셀트리온
    	    "015760", // 한국전력
    	    "207940"  // 삼성바이오로직스
    	);

    // 각 스케줄러의 인덱스를 별도로 관리
    private int infoCurrentIndex = 0; // fetchStockInfo용 인덱스
    private int biCurrentIndex = 0;   // fetchStockAsBi용 인덱스

    // 실행 횟수 카운터
    private int infoExecutionCount = 0;
    private int biExecutionCount = 0;

//    @Scheduled(cron = "0 */1 * * * ?")  // 1분마다 실행
    public synchronized void fetchStockInfo() {
        infoExecutionCount++; // 실행 횟수 증가
        System.out.println("fetchStockInfo 실행 횟수: " + infoExecutionCount);
        executeStockUpdate();
    }

//    @Scheduled(cron = "0/90 * * * * ?")   // 90초마다 실행
    public synchronized void fetchStockAsBi() {
        biExecutionCount++; // 실행 횟수 증가
        System.out.println("fetchStockAsBi 실행 횟수: " + biExecutionCount);
        executeStockBiUpdate();
    }

    private void executeStockUpdate() {
        if (infoCurrentIndex >= stockCodes.size()) {
            infoCurrentIndex = 0;  // 마지막 종목까지 처리하면 처음으로 돌아감
        }
        String stockCode = stockCodes.get(infoCurrentIndex);
        StockVO vo = new StockVO();
        vo.setCompany_code(stockCode);
        try {
            stockController.updateStockInfoData(vo);
            System.out.println(stockCode + " 주식 정보가 업데이트되었습니다.");
        } catch (Exception e) {
            System.err.println("Error fetching stock data for: " + stockCode);
            e.printStackTrace();
        }
        infoCurrentIndex++;
    }

    private void executeStockBiUpdate() {
        if (biCurrentIndex >= stockCodes.size()) {
            biCurrentIndex = 0;  // 마지막 종목까지 처리하면 처음으로 돌아감
        }
        String stockCode = stockCodes.get(biCurrentIndex);
        StockVO vo = new StockVO();
        vo.setCompany_code(stockCode);
        
        try {
            // 호가 업데이트
            stockController.updateStockAsBi(vo);
            System.out.println(stockCode + " 주식 호가가 업데이트되었습니다.");

            // 미체결된 주문을 가져옴
            List<Stock_OrderVO> pendingOrders = stockService.getPendingOrders(stockCode); // 미체결 주문 리스트 조회
            Stock_As_BiVO currentAsBi = stockService.getStockAsBi(vo); // 최신 호가 조회

            for (Stock_OrderVO order : pendingOrders) {
                // 매수 주문
                if ("매수".equals(order.getOrder_type()) && order.getPrice() >= Integer.parseInt(currentAsBi.getAskp1())) {
                    // 매수 주문의 가격이 매도 1호가와 같거나 클 때 체결
                    stockService.processOrder(order, Integer.parseInt(currentAsBi.getAskp1()), "예약체결");
                    System.out.println(order.getStock_order_no() + " 매수 주문 체결됨.");
                }
                // 매도 주문
                else if ("매도".equals(order.getOrder_type()) && order.getPrice() <= Integer.parseInt(currentAsBi.getBidp1())) {
                    // 매도 주문의 가격이 매수 1호가와 같거나 작을 때 체결
                    stockService.processOrder(order, Integer.parseInt(currentAsBi.getBidp1()), "예약체결");
                    System.out.println(order.getStock_order_no() + " 매도 주문 체결됨.");
                }
            }
        } catch (Exception e) {
            System.err.println("Error fetching stock data for: " + stockCode);
            e.printStackTrace();
        }
        biCurrentIndex++;
    }

}