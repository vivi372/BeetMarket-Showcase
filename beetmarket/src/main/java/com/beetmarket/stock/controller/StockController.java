package com.beetmarket.stock.controller;

import java.io.IOException;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.beetmarket.member.vo.LoginVO;
import com.beetmarket.stock.service.StockService;
import com.beetmarket.stock.vo.CashVO;
import com.beetmarket.stock.vo.StockVO;
import com.beetmarket.stock.vo.Stock_As_BiVO;
import com.beetmarket.stock.vo.Stock_HoldVO;
import com.beetmarket.stock.vo.Stock_InfoVO;
import com.beetmarket.stock.vo.Stock_OrderVO;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import lombok.extern.log4j.Log4j;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/stock")
@Log4j
public class StockController {

	@Autowired
	private TokenController tokenController; // TokenController를 Autowired로 주입

	private final String APP_KEY = "PSdTPt6Y6Y8jlz2bZavylela0LPunIuP9CAq"; // 실제 키로 교체 필요
	private final String APP_SECRET = "5A9NiHMzRkPIxx6rujN5hkpZ/LI4lEU69Yh34G4b9YzUxgrSgQMPTMpztTzoXtdIytjMYr6UwlH+CMNQxI33p04UmV4c4KhKrNnWXmV0Y0Qpjp2+Tn4Jxg6iPNNNU5F0pt+m0NQ0ZDnuW+I0CKgjxYTYdwtu7QDmPF/5Z4CCYDVCqwot0zo="; // 실제
																																																								// 키로
																																																								// 교체
																																																								// 필요

	// 자동 DI
	@Autowired
	@Qualifier("StockServiceImpl")
	private StockService stockService;

	@GetMapping("/stockMain.do")
	public String stockMain(Model model, HttpSession session) {
		tokenController.getTokenP(session);
		String cachedToken = stockService.getTokenFromDB(1); // token_no를 1로 가정
		log.info("@@@@@@@@@@@@@@@@@ cachedToken=" + cachedToken);
		model.addAttribute("stockList", stockService.stockList());

		return "stock/stockMain";
	}

	@GetMapping("/stockList.do")
	public String stockList(Model model) {

		StockVO vo = new StockVO();
		vo.setCompany_code("051910");
		this.updateStockAsBi(vo);

		return "stock/stockList";
	}

	// 주식 정보 업데이트
	@GetMapping(value = "/updateStockInfoData.do", produces = "text/plain; charset=UTF-8")
	public ResponseEntity<String> updateStockInfoData(StockVO vo) {

		String cachedToken = stockService.getTokenFromDB(1); // token_no를 1로 가정
		log.info("@@@@@@@@@@@@@@@@@ cachedToken=" + cachedToken);
//        log.info("@@@@@@@@@@@@@@@@@ ="+ vo);
		OkHttpClient client = new OkHttpClient().newBuilder().build();
//        log.info("@@@@@@@@@@@@@@@@@ token: " + cachedToken);
		Request request = new Request.Builder()
				.url("https://openapivts.koreainvestment.com:29443/uapi/domestic-stock/v1/quotations/inquire-price?"
						+ "fid_cond_mrkt_div_code=J" + "&fid_input_iscd=" + vo.getCompany_code())
				.get().addHeader("authorization", "Bearer " + cachedToken).addHeader("appkey", APP_KEY)
				.addHeader("appsecret", APP_SECRET).addHeader("tr_id", "FHKST01010100").build();

		try {
			Response response = client.newCall(request).execute();
			String responseBody = response.body().string(); // ResponseBody를 변수에 저장

			// JSON 파싱
			Gson gson = new Gson();
			JsonObject jsonObject = JsonParser.parseString(responseBody).getAsJsonObject().getAsJsonObject("output");

			// 필요한 필드들을 파싱하여 StockInfo 객체에 담음
			Stock_InfoVO stockInfo = gson.fromJson(jsonObject, Stock_InfoVO.class);

			stockInfo.setCompany_code(vo.getCompany_code());
			// DB에 데이터 삽입
			stockService.updateStockInfo(stockInfo);

			if (response.isSuccessful()) {
				return new ResponseEntity<String>(responseBody, HttpStatus.OK); // 성공 시 JSON 반환
			} else {
				return new ResponseEntity<String>("", HttpStatus.OK);
			}

		} catch (IOException e) {
			return new ResponseEntity<String>(e.getMessage(), HttpStatus.OK);
		}
	}

	// 주식 정보 DB에서 가져오기
	@GetMapping(value = "/getStockInfoData.do", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public Stock_InfoVO getStockInfoData(Model model, StockVO vo) {

		Stock_InfoVO infoVO = stockService.getStockInfo(vo);

		return infoVO;

	}

	// 주식 호가 가져오기
	@GetMapping(value = "/updateStockAsBi.do", produces = "text/plain; charset=UTF-8")
	public ResponseEntity<String> updateStockAsBi(StockVO vo) {

		String cachedToken = stockService.getTokenFromDB(1); // token_no를 1로 가정
		log.info("@@@@@@@@@@@@@@@@@ cachedToken=" + cachedToken);

		log.info("@@@@@@@@@@@@@@@@@ updateStockAsBi=" + vo);
		OkHttpClient client = new OkHttpClient().newBuilder().build();

		Request request = new Request.Builder().url(
				"https://openapivts.koreainvestment.com:29443/uapi/domestic-stock/v1/quotations/inquire-asking-price-exp-ccn?"
						+ "fid_cond_mrkt_div_code=J" + "&fid_input_iscd=" + vo.getCompany_code())
				.get().addHeader("authorization", "Bearer " + cachedToken).addHeader("appkey", APP_KEY)
				.addHeader("appsecret", APP_SECRET).addHeader("tr_id", "FHKST01010200").build();

		try {
			Response response = client.newCall(request).execute();
			String responseBody = response.body().string(); // ResponseBody를 변수에 저장

			log.info("@@@@@@@@@@@@@@@@@ updateStockAsBi: " + responseBody);

			// JSON 파싱
			Gson gson = new Gson();
			JsonObject jsonObject = JsonParser.parseString(responseBody).getAsJsonObject();

			// output1에서 데이터를 추출
			JsonObject output1 = jsonObject.getAsJsonObject("output1");

			Stock_As_BiVO stock_As_BiVO = new Stock_As_BiVO();
			stock_As_BiVO.setAskp1(output1.get("askp1").getAsString());
			stock_As_BiVO.setAskp2(output1.get("askp2").getAsString());
			stock_As_BiVO.setAskp3(output1.get("askp3").getAsString());
			stock_As_BiVO.setAskp4(output1.get("askp4").getAsString());
			stock_As_BiVO.setAskp5(output1.get("askp5").getAsString());
			stock_As_BiVO.setBidp1(output1.get("bidp1").getAsString());
			stock_As_BiVO.setBidp2(output1.get("bidp2").getAsString());
			stock_As_BiVO.setBidp3(output1.get("bidp3").getAsString());
			stock_As_BiVO.setBidp4(output1.get("bidp4").getAsString());
			stock_As_BiVO.setBidp5(output1.get("bidp5").getAsString());

			// 잔량 및 증감 필드 설정
			stock_As_BiVO.setAskp_rsqn1(output1.get("askp_rsqn1").getAsString());
			stock_As_BiVO.setAskp_rsqn2(output1.get("askp_rsqn2").getAsString());
			stock_As_BiVO.setAskp_rsqn3(output1.get("askp_rsqn3").getAsString());
			stock_As_BiVO.setAskp_rsqn4(output1.get("askp_rsqn4").getAsString());
			stock_As_BiVO.setAskp_rsqn5(output1.get("askp_rsqn5").getAsString());
			stock_As_BiVO.setBidp_rsqn1(output1.get("bidp_rsqn1").getAsString());
			stock_As_BiVO.setBidp_rsqn2(output1.get("bidp_rsqn2").getAsString());
			stock_As_BiVO.setBidp_rsqn3(output1.get("bidp_rsqn3").getAsString());
			stock_As_BiVO.setBidp_rsqn4(output1.get("bidp_rsqn4").getAsString());
			stock_As_BiVO.setBidp_rsqn5(output1.get("bidp_rsqn5").getAsString());

			// 총 매도/매수 잔량 설정
			stock_As_BiVO.setTotal_askp_rsqn(output1.get("total_askp_rsqn").getAsString());
			stock_As_BiVO.setTotal_bidp_rsqn(output1.get("total_bidp_rsqn").getAsString());

			// 회사 코드 및 체크 날짜 설정
			stock_As_BiVO.setCompany_code(vo.getCompany_code());
			stock_As_BiVO.setCheckDate(new Date()); // 현재 날짜 설정

			// DB에 데이터 삽입
			stockService.updateStockAsBi(stock_As_BiVO);

			if (response.isSuccessful()) {
				return new ResponseEntity<>(responseBody, HttpStatus.OK); // 성공 시 JSON 반환
			} else {
				return new ResponseEntity<>("", HttpStatus.OK);
			}

		} catch (IOException e) {
			return new ResponseEntity<>(e.getMessage(), HttpStatus.OK);
		}
	}

	// 회사 코드에 따른 매수/매도 호가 정보를 JSON으로 반환
	@GetMapping(value = "/getStockAsPr.do", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public Stock_As_BiVO getStockAsBi(Model model, StockVO vo) {

		Stock_As_BiVO stock_As_BiVO = stockService.getStockAsBi(vo);

		return stock_As_BiVO;
	}

	@PostMapping(value = "/StockOrder.do", produces = "application/json; charset=UTF-8")
	public ResponseEntity<Map<String, Object>> StockOrder(@RequestBody Stock_OrderVO vo, HttpSession session) {
		// 로그로 VO 값 확인
		log.info("Stock Order VO: {}" + vo);
		vo.setOrder_date(new Date());
		int price = vo.getPrice(); // 주문 가격
		int stck_askp1 = vo.getStck_askp1(); // 매도 호가 (매수 시 참고)
		int stck_bidp1 = vo.getStck_bidp1(); // 매수 호가 (매도 시 참고)
		String orderType = vo.getOrder_type(); // 주문 종류 (매수 또는 매도)
		String id = vo.getId(); // 주문자 ID
		String companyCode = vo.getCompany_code(); // 종목 코드
		int stockCount = vo.getStock_count(); // 주문 수량
		int totalOrderAmount = price * stockCount; // 총 주문 금액
		int accountBalance = vo.getAccount_balance(); // JSP에서 전달받은 계좌 잔액

		Map<String, Object> responseBody = new HashMap<>();

		try {
			if ("매수".equals(orderType)) {
				// 매수 주문 처리
				if (price >= stck_askp1) {
					// 매수 주문 가격이 매도 호가보다 크거나 같으면 체결 가능
					if (accountBalance >= totalOrderAmount) {
						// 계좌 잔액이 충분한 경우에만 매수 체결
						vo.setPrice(stck_askp1); // 매도 호가로 매수 처리
						vo.setOrder_status("즉시체결");

						// 보유 주식 업데이트
						Stock_HoldVO existingHold = stockService.getStockHold(id, companyCode);
						if (existingHold != null) {
							// 기존에 보유한 주식이 있으면 수량과 가격을 업데이트 (가중 평균 단가 계산)
							int existingStockCount = existingHold.getStock_hold_cnt();
							int newStockCount = existingStockCount + stockCount;

							// 기존 주식 가격과 새로운 주식 가격의 가중 평균
							int newAveragePrice = ((existingHold.getPrice() * existingStockCount)
									+ (stck_askp1 * stockCount)) / newStockCount;

							// 보유 주식 정보 업데이트
							existingHold.setPrice(newAveragePrice); // 평균 가격으로 업데이트
							existingHold.setStock_hold_cnt(newStockCount); // 수량 업데이트

							stockService.updateStockHold(existingHold); // 보유 주식 업데이트

						} else {
							// 기존 보유 주식이 없으면 새로운 보유 주식 추가
							Stock_HoldVO stockHold = new Stock_HoldVO();
							stockHold.setOrder_date(new Date()); // 주문 일자
							stockHold.setPrice(stck_askp1); // 체결 가격
							stockHold.setStock_hold_cnt(stockCount); // 보유 수량
							stockHold.setId(id); // 주문자 ID
							stockHold.setCompany_code(companyCode); // 종목 코드

							// 서비스 호출하여 보유 주식 저장
							stockService.saveStockHold(stockHold);
						}

						// 계좌 잔액 차감
						stockService.updateCash(id, accountBalance - totalOrderAmount);

					} else {
						// 계좌 잔액 부족
						responseBody.put("status", "error");
						responseBody.put("message", "매수 실패: 계좌 잔액이 부족합니다.");
						return ResponseEntity.badRequest().body(responseBody);
					}
				} else {
					// 매수 가격이 매도 호가보다 낮으면 미체결 상태로 처리 (잔액은 차감)
					if (accountBalance >= totalOrderAmount) {
						vo.setOrder_status("미체결");

						// 계좌에서 주문 금액 차감
						stockService.updateCash(id, accountBalance - totalOrderAmount);

						responseBody.put("message", "매수 주문이 미체결되었습니다. 호가를 확인하세요.");
					} else {
						responseBody.put("status", "error");
						responseBody.put("message", "매수 실패: 계좌 잔액이 부족합니다.");
						return ResponseEntity.badRequest().body(responseBody);
					}
				}
			} else if ("매도".equals(orderType)) {
				// 매도 주문 처리
				Stock_HoldVO existingHold = stockService.getStockHold(id, companyCode);

				if (existingHold != null && existingHold.getStock_hold_cnt() >= stockCount) {
					// 보유 주식이 충분하면 매도 가능
					if (price <= stck_bidp1) {
						// 매도 주문 가격이 매수 호가보다 작거나 같으면 체결 가능
						vo.setPrice(stck_bidp1); // 매수 호가로 매도 처리
						vo.setOrder_status("즉시체결");

						// 보유 주식 수량 업데이트 (매도)
						stockService.updateStockHoldCount(id, companyCode, stockCount, "매도");

						// 매도 금액을 계좌에 추가
						stockService.updateCash(id, accountBalance + totalOrderAmount);
					} else {
						// 매도 가격이 매수 호가보다 높으면 미체결 상태로 처리 (잔액 변동 없음)
						vo.setOrder_status("미체결");
						responseBody.put("message", "매도 주문이 미체결되었습니다. 호가를 확인하세요.");
					}
				} else {
					// 보유 주식 수량이 부족할 경우 매도 불가
					responseBody.put("status", "error");
					responseBody.put("message", "매도 실패: 보유한 주식 수량이 부족합니다.");
					return ResponseEntity.badRequest().body(responseBody);
				}
			}

			// 서비스 호출하여 주문 처리
			stockService.StockOrder(vo);

			// 성공 시 응답 데이터 구성
			responseBody.put("status", "success");
			responseBody.put("orderNumber", vo.getStock_order_no());
			responseBody.put("orderState", vo.getOrder_status());
			responseBody.put("price", vo.getPrice());

			return ResponseEntity.ok(responseBody); // 성공 시 JSON 반환

		} catch (Exception e) {
			// 예외 발생 시 오류 메시지 반환
			responseBody.put("status", "error");
			responseBody.put("message", "주문 처리 중 오류가 발생했습니다.");
			responseBody.put("errorDetails", e.getMessage());

			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(responseBody);
		}
	}

	// 주식 계좌 만들기
	@PostMapping(value = "/makeCash.do", produces = "text/plain; charset=UTF-8")
	public ResponseEntity<String> makeCash(@RequestParam("id") String id, HttpSession session) {

		try {
			log.info("makeCash" + id);
			// 서비스 호출을 통해 계좌 생성
			stockService.makeCash(id);

			// 성공 응답 반환
			return ResponseEntity.ok("계좌가 성공적으로 생성되었습니다.");
		} catch (Exception e) {
			// 예외 처리 후, 클라이언트에게 에러 응답 전송
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("계좌 생성 중 오류가 발생했습니다.");
		}
	}

	// 계좌 정보 조회 메서드
	@GetMapping("/getCashInfo.do")
	public ResponseEntity<CashVO> getCashInfo(HttpSession session) {
		// 세션에서 LoginVO 객체를 가져옴
		LoginVO loginVO = (LoginVO) session.getAttribute("login");

		// loginVO가 null인지 확인 후 ID를 가져옴
		if (loginVO != null) {
			String id = loginVO.getId(); // LoginVO 객체에서 id 값을 가져옴
			CashVO cashInfo = stockService.getCashInfoById(id); // ID로 계좌 정보 조회
			if (cashInfo != null) {
				return ResponseEntity.ok(cashInfo); // 계좌 정보가 있으면 해당 정보를 반환
			}
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
		} else {
			// 로그인되지 않은 경우 처리
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null); // 계좌 정보가 없으면 404 상태 반환
		}

	}

	// 주문 내역 조회 메서드
	@GetMapping("/getOrderList.do")
	public ResponseEntity<List<Stock_OrderVO>> getOrderList(HttpSession session) {
		// 세션에서 LoginVO 객체를 가져옴
		LoginVO loginVO = (LoginVO) session.getAttribute("login");

		// 로그인 여부 확인
		if (loginVO != null) {
			String id = loginVO.getId(); // LoginVO 객체에서 id 값을 가져옴
			List<Stock_OrderVO> stockOrderList = stockService.getOrderList(id); // ID로 주문 내역 조회

			if (stockOrderList != null && !stockOrderList.isEmpty()) {
				return ResponseEntity.ok(stockOrderList); // 주문 내역이 있으면 반환
			} else {
				// 주문 내역이 없는 경우
				return ResponseEntity.ok(Collections.emptyList()); // 빈 리스트 반환
			}
		} else {
			// 로그인되지 않은 경우
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build(); // 401 상태 반환
		}
	}

	// 보유 주식 목록 조회 메서드
	@GetMapping("/getStockHoldList.do")
	public ResponseEntity<List<Stock_HoldVO>> getStockHoldList(HttpSession session) {
		// 세션에서 LoginVO 객체를 가져옴
		LoginVO loginVO = (LoginVO) session.getAttribute("login");

		// 로그인 여부 확인
		if (loginVO != null) {
			String id = loginVO.getId(); // LoginVO 객체에서 id 값을 가져옴
			List<Stock_HoldVO> stockHoldList = stockService.getStockHoldList(id); // ID로 보유 주식 조회

			if (stockHoldList != null && !stockHoldList.isEmpty()) {
				return ResponseEntity.ok(stockHoldList); // 보유 주식 목록이 있으면 반환
			} else {
				// 보유 주식 목록이 없는 경우
				return ResponseEntity.ok(Collections.emptyList()); // 빈 리스트 반환
			}
		} else {
			// 로그인되지 않은 경우
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build(); // 401 상태 반환
		}
	}

	@PostMapping(value = "/cancelOrder.do", produces = "application/json; charset=UTF-8")
	public ResponseEntity<Map<String, Object>> cancelOrder(@RequestBody Stock_OrderVO vo, HttpSession session) {
		LoginVO loginVO = (LoginVO) session.getAttribute("login");
		String id = loginVO.getId(); // LoginVO 객체에서 id 값을 가져옴
		Map<String, Object> responseBody = new HashMap<>();
		log.info(id);
		if (id == null) {
			responseBody.put("status", "error");
			responseBody.put("message", "로그인이 필요합니다.");
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(responseBody);
		}

		// vo에 세션 id를 설정
		vo.setId(id);

		log.info(vo);

		try {
			// 주문 상태가 미체결인지 확인
			if ("미체결".equals(vo.getOrder_status())) {
				// 주문 가격 * 수량을 더해서 계좌 잔액 복원
				int refundAmount = vo.getPrice() * vo.getStock_count();

				// 계좌 잔액 업데이트 (미체결된 주문의 금액 환불)
				stockService.updateCash(vo.getId(), vo.getAccount_balance() + refundAmount);

				// 주문 상태를 취소로 변경
				vo.setOrder_status("취소");
				stockService.updateOrderStatus(vo);

				responseBody.put("status", "success");
				responseBody.put("message", "주문이 성공적으로 취소되었습니다.");
			} else {
				responseBody.put("status", "error");
				responseBody.put("message", "주문은 미체결 상태가 아니므로 취소할 수 없습니다.");
			}

			return ResponseEntity.ok(responseBody);

		} catch (Exception e) {
			responseBody.put("status", "error");
			responseBody.put("message", "주문 취소 중 오류가 발생했습니다.");
			responseBody.put("errorDetails", e.getMessage());

			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(responseBody);
		}
	}

	@GetMapping("/getHoldingQuantity.do")
	@ResponseBody
	public Map<String, Object> getHoldingQuantity(@RequestParam("company_code") String company_code,
			HttpSession session) {
		LoginVO loginVO = (LoginVO) session.getAttribute("login");
		String id = loginVO.getId(); // LoginVO 객체에서 id 값을 가져옴

		// 보유 수량 조회
		int holdingQuantity = stockService.getHoldingQuantity(company_code, id);

		System.out.println("holdingQuantity: " + holdingQuantity); // 디버깅 용도

		// 결과를 JSON 형태로 반환
		Map<String, Object> result = new HashMap<>();
		result.put("holdingQuantity", holdingQuantity);

		System.out.println("result: " + result); // 디버깅 용도
		return result;
	}

}
