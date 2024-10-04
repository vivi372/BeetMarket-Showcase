<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <script src="https://cdn.jsdelivr.net/npm/echarts@5.4.3/dist/echarts.min.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <script
          src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
    <script
          src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script
          src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons"
          rel="stylesheet">
     <!-- Custom CSS for layout -->
    <style>
        body {
            font-family: 'Arial', sans-serif;
        }
        #main {
            width: 100%;
            height: 400px;
        }
        .chart-container {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }
        .stock-list, .trade-form {
            border: 1px solid #ddd;
            padding: 20px;
            background-color: #f9f9f9;
            margin-top: 20px;
        }
        .stock-list h4, .trade-form h4 {
            text-align: center;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .trade-form button {
            width: 100%;
        }
        .trade-form {
            display: none; /* 기본적으로 매수/매도 폼을 숨김 */
        }
        .stock-info {
            display: none; /* 기본적으로 상단 종목 정보를 숨김 */
        }
            .stock-info-container {
        max-width: 800px;
        margin: 0 auto;
        background-color: #f8f9fa;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
   		}

	    .table {
	        margin-top: 20px;
	    }
	
	    .table-hover tbody tr:hover {
	        background-color: #f1f1f1;
	    }
	
	    .table th, .table td {
	        vertical-align: middle;
	    }
	
	    /* Highlight colors for stock changes */
	    .highlight-positive {
	        color: red;
	        font-weight: bold;
	    }
	
	    .highlight-negative {
	        color: blue;
	        font-weight: bold;
	    }
         .stock-info-container, .trade-form {
            margin-top: 20px;
        }
        .ask-bid-table th, .ask-bid-table td {
            text-align: center;
            vertical-align: middle;
        }
        .ask-price {
            color: red;
            font-weight: bold;
        }
        .bid-price {
            color: blue;
            font-weight: bold;
        }
        .nav-tabs .nav-link {
		    color: #007bff;
		    border-radius: 0;
		    padding: 10px 20px;
		    margin-right: 5px;
		    border: 1px solid transparent;
		    transition: background-color 0.3s ease;
		}
		
		.nav-tabs .nav-link:hover {
		    background-color: #f8f9fa;
		    border-color: #ddd;
		}
		
		.nav-tabs .nav-link.active {
		    background-color: #007bff;
		    color: white;
		    border-color: #007bff;
		}
		.btn {
		    transition: background-color 0.3s ease, color 0.3s ease;
		}
		
		.btn-success:hover {
		    background-color: #28a745;
		    color: white;
		}
		
		.btn-danger:hover {
		    background-color: #dc3545;
		    color: white;
		}
		
		.btn-primary {
		    background-color: #007bff;
		    border: none;
		}
		
		.btn-primary:hover {
		    background-color: #0056b3;
		}
		.ask-bid-table {
		    margin-top: 20px;
		}
		
		.ask-price:hover, .bid-price:hover {
		    cursor: pointer;
		    background-color: #f8f9fa;
		    border-radius: 5px;
		    transition: background-color 0.3s ease;
		}
        @media (max-width: 768px) {
		    .col-md-2 {
		        width: 100%;
		        margin-bottom: 20px;
		    }
		    
		    .col-md-5 {
		        width: 100%;
		    }
		
		    .chart-container {
		        height: 300px;
		    }
		
		    .stock-info-container, .trade-form {
		        padding: 10px;
		    }
		
		    .btn {
		        width: 100%;
		    }
		}
        .order-list table {
		    margin-top: 20px;
		    border-collapse: separate;
		    border-spacing: 0 10px;
		}
		
		.order-list table th {
		    background-color: #007bff;
		    color: white;
		}
		
		.order-list table tr {
		    background-color: white;
		    border-radius: 5px;
		    box-shadow: 0 2px 3px rgba(0, 0, 0, 0.1);
		}
		
		.order-list table td {
		    padding: 15px;
		    text-align: center;
		}
		        
    </style>
 
<script type="text/javascript">
function drawChart(chartData) {
    // 종목 이름 설정
    const stockName = chartData.output1.hts_kor_isnm;

    // chartData를 확인
    console.log(chartData);
 	
    // 날짜 포맷팅 함수
    function formatDate(date) {
        if (date.length === 8) {  // 입력 값이 8자리인지 확인
            var year = date.substring(0, 4);  // 연도 추출
            var month = date.substring(4, 6); // 월 추출
            var day = date.substring(6, 8);   // 일 추출
            return `\${year}-\${month}-\${day}`; // YYYY-MM-DD 형식으로 반환
        } else {
            console.error("잘못된 날짜 형식입니다.");  // 날짜 형식 오류 시 로그 출력
            return null;
        }
    }

    // output2 데이터를 오래된 시간순으로 정렬
    chartData.output2.sort(function(a, b) {
        var timeA = a.stck_bsop_date; // 날짜로만 비교
        var timeB = b.stck_bsop_date;
        return timeA.localeCompare(timeB); // 오름차순 정렬
    });

    // chartData.output2 데이터를 이용해 차트를 그리기
    var rawData = chartData.output2.map(item => {
    	 
        return [
            formatDate(item.stck_bsop_date), // 날짜 포맷
            parseFloat(item.stck_oprc),
            parseFloat(item.stck_clpr),
            parseFloat(item.stck_lwpr),
            parseFloat(item.stck_hgpr),
            parseFloat(item.acml_vol) // 거래량을 사용
        ];
    });

    var chartDom = document.getElementById('main');
    var myChart = echarts.init(chartDom);
    var option;

    const upColor = '#00da3c';
    const downColor = '#ec0000';

    function splitData(rawData) {
        let categoryData = [];
        let values = [];
        let volumes = [];
        for (let i = 0; i < rawData.length; i++) {
            categoryData.push(rawData[i].splice(0, 1)[0]); // 날짜 분리
            values.push(rawData[i]); // OHLC 데이터
            volumes.push([i, rawData[i][4], rawData[i][0] > rawData[i][1] ? 1 : -1]); // 거래량
        }
        return {
            categoryData: categoryData, // 날짜 데이터
            values: values, // OHLC 데이터
            volumes: volumes // 거래량 데이터
        };
    }

    function calculateMA(dayCount, data) {
        var result = [];
        for (var i = 0, len = data.values.length; i < len; i++) {
            if (i < dayCount) {
                result.push('-');
                continue;
            }
            var sum = 0;
            for (var j = 0; j < dayCount; j++) {
                sum += data.values[i - j][1]; // 종가 사용
            }
            result.push(+(sum / dayCount).toFixed(3));
        }
        return result;
    }

    var data = splitData(rawData);
    myChart.setOption(
        (option = {
            animation: false,
            legend: {
                bottom: 10,
                left: 'center',
                data: [stockName, 'MA5', 'MA10', 'MA20', 'MA30'] // 종목명을 동적으로 설정
            },
            tooltip: {
                trigger: 'axis',
                axisPointer: {
                    type: 'cross'
                },
                borderWidth: 1,
                borderColor: '#ccc',
                padding: 10,
                textStyle: {
                    color: '#000'
                },
                position: function (pos, params, el, elRect, size) {
                    const obj = {
                        top: 10
                    };
                    obj[['left', 'right'][+(pos[0] < size.viewSize[0] / 2)]] = 30;
                    return obj;
                }
            },
            axisPointer: {
                link: [
                    {
                        xAxisIndex: 'all'
                    }
                ],
                label: {
                    backgroundColor: '#777'
                }
            },
            toolbox: {
                feature: {
                    dataZoom: {
                        yAxisIndex: false
                    },
                    brush: {
                        type: ['lineX', 'clear']
                    }
                }
            },
            brush: {
                xAxisIndex: 'all',
                brushLink: 'all',
                outOfBrush: {
                    colorAlpha: 0.1
                }
            },
            visualMap: {
                show: false,
                seriesIndex: 5,
                dimension: 2,
                pieces: [
                    {
                        value: 1,
                        color: downColor
                    },
                    {
                        value: -1,
                        color: upColor
                    }
                ]
            },
            grid: [
                {
                    left: '10%',
                    right: '8%',
                    height: '50%'
                },
                {
                    left: '10%',
                    right: '8%',
                    top: '63%',
                    height: '16%'
                }
            ],
            xAxis: [
                {
                    type: 'category',
                    data: data.categoryData, // 날짜 데이터 설정
                    boundaryGap: false,
                    axisLine: { onZero: false },
                    splitLine: { show: false },
                    min: 'dataMin',
                    max: 'dataMax',
                    axisPointer: {
                        z: 100
                    }
                },
                {
                    type: 'category',
                    gridIndex: 1,
                    data: data.categoryData,
                    boundaryGap: false,
                    axisLine: { onZero: false },
                    axisTick: { show: false },
                    splitLine: { show: false },
                    axisLabel: { show: false },
                    min: 'dataMin',
                    max: 'dataMax'
                }
            ],
            yAxis: [
                {
                    scale: true,
                    splitArea: {
                        show: true
                    }
                },
                {
                    scale: true,
                    gridIndex: 1,
                    splitNumber: 2,
                    axisLabel: { show: false },
                    axisLine: { show: false },
                    axisTick: { show: false },
                    splitLine: { show: false }
                }
            ],
            dataZoom: [
                {
                    type: 'inside',
                    xAxisIndex: [0, 1],
                    start: 1,
                    end: 100
                },
                {
                    show: true,
                    xAxisIndex: [0, 1],
                    type: 'slider',
                    top: '85%',
                    start: 98,
                    end: 100
                }
            ],
            series: [
                {
                    name: stockName, // 종목명으로 설정
                    type: 'candlestick',
                    data: data.values,
                    itemStyle: {
                        color: upColor,
                        color0: downColor,
                        borderColor: undefined,
                        borderColor0: undefined
                    }
                },
                {
                    name: 'MA5',
                    type: 'line',
                    data: calculateMA(5, data),
                    smooth: true,
                    lineStyle: {
                        opacity: 0.5
                    }
                },
                {
                    name: 'MA10',
                    type: 'line',
                    data: calculateMA(10, data),
                    smooth: true,
                    lineStyle: {
                        opacity: 0.5
                    }
                },
                {
                    name: 'MA20',
                    type: 'line',
                    data: calculateMA(20, data),
                    smooth: true,
                    lineStyle: {
                        opacity: 0.5
                    }
                },
                {
                    name: 'MA30',
                    type: 'line',
                    data: calculateMA(30, data),
                    smooth: true,
                    lineStyle: {
                        opacity: 0.5
                    }
                },
                {
                    name: 'Volume',
                    type: 'bar',
                    xAxisIndex: 1,
                    yAxisIndex: 1,
                    data: data.volumes
                }
            ]
        }),
        true
    );

    option && myChart.setOption(option);
}


</script>
          
          
<script type="text/javascript">
    
$(function() {
    loadAccountInfo();
    updateOrderList();
    getChartData(0,0);
    $('.trade-form').show();
    getStockInfo("005930");// 주식 정보를 가져온 후 바로 업데이트
	getStockAsPr("005930");
	getHoldingQuantity("005930")
	loadStockHoldList();
    // 차트 데이터를 가져오는 함수
    function getChartData(period_div_code, company_code) {
        
        // company_code가 0이거나 null이면 기본값 "삼성전자로"로 설정
        if (!company_code || company_code === 0) {
            company_code = "005930";
        }
        
        // period_div_code가 0이거나 null이면 기본값 "KOSPI"로 설정
        if (!period_div_code || period_div_code === 0) {
        	period_div_code = "M";
        }
        // 날짜 계산 (오늘 날짜와 10년 전 날짜)
        const today = new Date();
        const tenYearsAgo = new Date();
        tenYearsAgo.setFullYear(today.getFullYear() - 10);

        function formatDate(date) {
            let year = date.getFullYear();
            let month = ('0' + (date.getMonth() + 1)).slice(-2);
            let day = ('0' + date.getDate()).slice(-2);
            return year + month + day;
        }

        // 요청할 데이터
        let data = {
        	company_code: company_code,
            period_div_code: period_div_code,  // 일봉(D), 주봉(W), 월봉(M)
            startDate: formatDate(tenYearsAgo),
            endDate: formatDate(today)
        };

        console.log("Request data: ", data);

        // AJAX 요청으로 데이터 가져오기
        $.ajax({
            type: "post",  // POST 요청
            url: "/chart/getChartDate.do",  // 요청할 URL
            data: JSON.stringify(data),  // JSON 데이터 전송
            contentType: "application/json; charset=UTF-8",  // Content-Type 설정
            dataType: "json",  // 서버에서 반환되는 데이터를 JSON으로 파싱
            success: function(result) {
                console.log("Received data: ", result);  // 이미 JSON으로 파싱된 데이터를 출력
                drawChart(result);  // 파싱된 데이터를 사용하여 차트를 그리기
            },
            error: function(xhr, status, er) {
                console.error("Error: ", er);
                alert("차트 데이터 요청 중 오류가 발생했습니다.");
            }
        });
    }
    
 
	// 주식 정보 불러오기
    function getStockInfo(company_code) {

        // Ajax 요청을 통해 주식 정보를 가져옴
        $.ajax({
            url: '/stock/getStockInfoData.do',
            type: 'GET',
            data: { company_code: company_code },
            success: function(response) {
            	
                // 응답받은 데이터를 사용하여 주식 정보를 업데이트
                $('#stockName').text(response.company_name);
                $('#stockPrice').text(parseInt(response.stck_prpr).toLocaleString());
                $('#stockPer').text(response.per);
                $('#stockPbr').text(response.pbr);
                $('#stockEps').text(response.eps);
                $('#stockBps').text(response.bps);
                $('#stockChange').text(parseInt(response.prdy_vrss).toLocaleString());
                $('#stockChangeRate').text(response.prdy_ctrt);
                $('#acmlTrPbmn').text(parseInt(response.acml_tr_pbmn).toLocaleString());
                $('#acmlVol').text(response.acml_vol);
                $('#stockOpenPrice').text(parseInt(response.stck_oprc).toLocaleString());
                $('#stockHighPrice').text(parseInt(response.stck_hgpr).toLocaleString());
                $('#stockLowPrice').text(parseInt(response.stck_lwpr).toLocaleString());
                $('#stockMaxPrice').text(parseInt(response.stck_mxpr).toLocaleString());
                $('#stockMinPrice').text(parseInt(response.stck_llam).toLocaleString());
            },
            error: function(xhr, status, error) {
                console.log("주식 정보를 가져오는데 실패했습니다.");
            }
        });
    }

    // 라디오 버튼이 클릭될 때마다 차트 종류에 따라 작동
    $('input[name="optradio"]').change(function() {
        let period_div_code = $(this).val();  // 선택된 값(D, W, M)
        let company_code = $(this).closest('label').attr('data-company_code');
        
        getChartData(period_div_code, company_code);  // 차트 데이터 가져오기
    });
    
    $('.change-rate').each(function() {
        // data-rate 속성에서 값을 가져옴
        var rate = parseFloat($(this).data('rate'));

        // 수익률이 양수면 빨간색, 음수면 연한 파란색 적용
        if (rate > 0) {
            $(this).css('color', 'red');
        } else if (rate < 0) {
            $(this).css('color', 'blue');
        } else {
            $(this).css('color', 'black'); // 0%는 검정색
        }
    });
    
    

    $('.stock-item').on('click', function() {
        var company_code = $(this).data('company_code'); 
        var company_name = $(this).data('company_name'); 
        var company_no = $(this).data('company_no'); 
        var stockPrice = $(this).find('.price').text().replace(/[^\d]/g, ''); // 숫자 이외의 문자를 제거
        
        $('#stockName').text("종목명: " + company_name); // 종목명 표시
        $('#stockCode').text(company_code); // 종목 코드 표시
        
        // 라디오 버튼의 data-company_code 속성에 해당 값 설정
        $('label[for="dayChart"]').attr('data-company_code', company_code);
        $('label[for="weekChart"]').attr('data-company_code', company_code);
        $('label[for="monthChart"]').attr('data-company_code', company_code);
        
        console.log("클릭 메소드 실행시 나오는 company_code: ", company_code);

        // 매수 탭의 수량을 0으로 설정하고, 가격을 주식 리스트에 표시된 가격으로 설정
        $('#quantity-buy').val(0);
        $('#price-buy').val(stockPrice.trim());  // 숫자만 있는 값을 설정

        // 매도 탭의 수량을 0으로 설정하고, 가격을 주식 리스트에 표시된 가격으로 설정
        $('#quantity-sell').val(0);
        $('#price-sell').val(stockPrice.trim());  // 숫자만 있는 값을 설정

        // 차트 및 주식 정보를 업데이트
        getChartData('M', company_code);  
        getStockInfo(company_code); // 주식 정보를 가져온 후 바로 업데이트
        getStockAsPr(company_code);
        
        // 매수/매도 탭에서 보유 수량도 가져와서 업데이트 (매도용)
        getHoldingQuantity(company_code);
        
        // 관련 정보를 보여줌
        $('.stock-info').show();
        $('.trade-form').show();
    });


    $('#buyBtn, #sellBtn').on('click', function() {
        // 버튼에 있는 data-status로 매수/매도 상태를 결정
	    var orderType = $(this).data('status');
	
	    // 현재 활성화된 탭에 따라 매수/매도에 맞는 요소 선택
	    var price, quantity;
	    if (orderType === '매수') {
	        price = $('#price-buy').val();
	        quantity = $('#quantity-buy').val();
	    } else if (orderType === '매도') {
	        price = $('#price-sell').val();
	        quantity = $('#quantity-sell').val();
	    }
        var companyCode = $('#stockCode').text(); // 종목코드는 텍스트로 표시된 부분에서 가져옴
        var accountBalance = $('#accountBalance-buy').text().replace(/,/g, ''); // 잔액 정보 수집, 콤마 제거
        var id = '${login.id}';

        // askp1, bidp1 값을 수집
        var askp1 = $('#ask-price1').data('price'); // 매도호가 1
        var bidp1 = $('#bid-price1').data('price'); // 매수호가 1

        console.log(price);
        console.log(quantity);
        console.log(companyCode);
        console.log(id);
        console.log(orderType);
        console.log("askp1: ", askp1); // 매도호가 1 확인
        console.log("bidp1: ", bidp1); // 매수호가 1 확인
        console.log("accountBalance:", accountBalance); // 잔액 확인
        // 입력값 검증
        if (!price || !quantity || !companyCode || !id) {
            alert('모든 필드를 입력해주세요.');
            return;
        }

        // 서버로 전달할 데이터
        var requestData = {
            price: price,
            stock_count: quantity,
            company_code: companyCode,
            order_type: orderType,
            id: id,
            stck_askp1: askp1, // 매도호가 1 추가
            stck_bidp1: bidp1,  // 매수호가 1 추가
            account_balance: accountBalance // 계좌 잔액 추가
        };

        // AJAX 요청
        $.ajax({
            type: 'POST',
            url: '/stock/StockOrder.do', // 실제 서버에서 처리할 URL
            contentType: 'application/json; charset=UTF-8',
            data: JSON.stringify(requestData), // 데이터를 JSON으로 변환하여 전송
            success: function(response) {
                alert('주문이 성공적으로 처리되었습니다.');
                // 주문 완료 후 계좌 잔액을 다시 불러와서 업데이트
                loadAccountInfo();
                updateOrderList();
                loadStockHoldList();
                getHoldingQuantity(companyCode);
        	    if (orderType === '매수') {
        	        $('#price-buy').val(0);
        	        $('#quantity-buy').val(0);
        	        $('#totalAmount-buy').val(0); 
        	    } else if (orderType === '매도') {
        	        $('#price-sell').val(0);
        	        $('#quantity-sell').val(0);
        	        $('#totalAmount-sell').val(0); 
        	    }
            },
            error: function(xhr, status, error) {
                alert('주문 처리 중 오류가 발생했습니다: ' + xhr.responseText);
            }
        });
    });

    
    // 탭이 전환될 때마다 비동기적으로 데이터 로드
    $('#stock-info-tab').on('click', function () {
        $('#stock-info').load('/stock/getStockInfo.do');
    });

    $('#trade-form-tab').on('click', function () {
        $('#trade-form').load('/trade/getTradeForm.do');
    });
    
    
 	// 주식 정보를 불러온 후 호가 테이블도 업데이트
    function getStockAsPr(company_code) {
        // 요청할 데이터 (쿼리 문자열로 변환)
        let url = "/stock/getStockAsPr.do?company_code=" + encodeURIComponent(company_code);

        console.log("Request URL: ", url);

        // AJAX 요청으로 데이터 가져오기 (GET 방식)
        $.ajax({
            type: "get",  // GET 요청
            url: url,     // 쿼리 문자열을 포함한 URL
            contentType: "application/json; charset=UTF-8",  // Content-Type 설정
            dataType: "json",  // 서버에서 반환되는 데이터를 JSON으로 파싱
            success: function(result) {
                console.log("@@@Received data: ", result);  // 이미 JSON으로 파싱된 데이터를 출력

                // 매수/매도 탭 각각의 테이블 업데이트
                updateAskBidTable(result, 'buy');
                updateAskBidTable(result, 'sell');
            },
            error: function(xhr, status, er) {
                console.error("Error: ", er);
                alert("요청 중 오류가 발생했습니다.");
            }
        });
    }


    
    function updateAskBidTable(data, tabType) {
        var tableBody;

        // 탭 타입에 따라 매수/매도 테이블을 선택
        if (tabType === 'buy') {
            tableBody = $('#askBidTable-buy');
        } else if (tabType === 'sell') {
            tableBody = $('#askBidTable-sell');
        }

        tableBody.empty(); // 기존 데이터를 모두 지움

        // 매도/매수 호가 및 잔량을 테이블에 추가
        var rows = '';

        rows += '<tr>';
        rows += '<td class="ask-price" id="ask-price1" data-price="' + data.askp1 + '">' + (data.askp1 ? parseInt(data.askp1).toLocaleString() : '-') + '</td>';
        rows += '<td>' + (data.askp_rsqn1 ? parseInt(data.askp_rsqn1).toLocaleString() : '-') + '</td>';
        rows += '<td class="bid-price" id="bid-price1" data-price="' + data.bidp1 + '">' + (data.bidp1 ? parseInt(data.bidp1).toLocaleString() : '-') + '</td>';
        rows += '<td>' + (data.bidp_rsqn1 ? parseInt(data.bidp_rsqn1).toLocaleString() : '-') + '</td>';
        rows += '</tr>';

        rows += '<tr>';
        rows += '<td class="ask-price" data-price="' + data.askp2 + '">' + (data.askp2 ? parseInt(data.askp2).toLocaleString() : '-') + '</td>';
        rows += '<td>' + (data.askp_rsqn2 ? parseInt(data.askp_rsqn2).toLocaleString() : '-') + '</td>';
        rows += '<td class="bid-price" data-price="' + data.bidp2 + '">' + (data.bidp2 ? parseInt(data.bidp2).toLocaleString() : '-') + '</td>';
        rows += '<td>' + (data.bidp_rsqn2 ? parseInt(data.bidp_rsqn2).toLocaleString() : '-') + '</td>';
        rows += '</tr>';

        rows += '<tr>';
        rows += '<td class="ask-price" data-price="' + data.askp3 + '">' + (data.askp3 ? parseInt(data.askp3).toLocaleString() : '-') + '</td>';
        rows += '<td>' + (data.askp_rsqn3 ? parseInt(data.askp_rsqn3).toLocaleString() : '-') + '</td>';
        rows += '<td class="bid-price" data-price="' + data.bidp3 + '">' + (data.bidp3 ? parseInt(data.bidp3).toLocaleString() : '-') + '</td>';
        rows += '<td>' + (data.bidp_rsqn3 ? parseInt(data.bidp_rsqn3).toLocaleString() : '-') + '</td>';
        rows += '</tr>';

        rows += '<tr>';
        rows += '<td class="ask-price" data-price="' + data.askp4 + '">' + (data.askp4 ? parseInt(data.askp4).toLocaleString() : '-') + '</td>';
        rows += '<td>' + (data.askp_rsqn4 ? parseInt(data.askp_rsqn4).toLocaleString() : '-') + '</td>';
        rows += '<td class="bid-price" data-price="' + data.bidp4 + '">' + (data.bidp4 ? parseInt(data.bidp4).toLocaleString() : '-') + '</td>';
        rows += '<td>' + (data.bidp_rsqn4 ? parseInt(data.bidp_rsqn4).toLocaleString() : '-') + '</td>';
        rows += '</tr>';

        rows += '<tr>';
        rows += '<td class="ask-price" data-price="' + data.askp5 + '">' + (data.askp5 ? parseInt(data.askp5).toLocaleString() : '-') + '</td>';
        rows += '<td>' + (data.askp_rsqn5 ? parseInt(data.askp_rsqn5).toLocaleString() : '-') + '</td>';
        rows += '<td class="bid-price" data-price="' + data.bidp5 + '">' + (data.bidp5 ? parseInt(data.bidp5).toLocaleString() : '-') + '</td>';
        rows += '<td>' + (data.bidp_rsqn5 ? parseInt(data.bidp_rsqn5).toLocaleString() : '-') + '</td>';
        rows += '</tr>';

        tableBody.append(rows); // 테이블에 행 추가
    }


		
 	// 각 ask-price, bid-price 요소에 클릭 이벤트 추가
    $(document).on('click', '.ask-price, .bid-price', function() {
        var clickedPrice = $(this).data('price'); // 클릭된 가격 가져오기
        console.log("clickedPrice: ", clickedPrice); // 데이터가 제대로 전달되는지 확인

        // 현재 활성화된 탭에 따라 가격 입력 필드 설정
        var activeTab = $('#tradeTabContent .tab-pane.active').attr('id'); // 현재 활성화된 탭의 id를 가져옴

        if (activeTab === 'buy') {
            $('#price-buy').val(clickedPrice); // 매수 탭일 경우 price-buy 필드에 가격 설정
        } else if (activeTab === 'sell') {
            $('#price-sell').val(clickedPrice); // 매도 탭일 경우 price-sell 필드에 가격 설정
        }
    });
 	
 	// 계좌 생성 버튼 클릭 시 모달을 통해 확인
    $('#confirmAccountBtn').on('click', function() {
        var idValue = $('#Cashid').val();  // 입력 필드에서 id 값 가져오기
        console.log("id:", idValue);
        
        // ID가 비어있거나 없을 경우 에러 처리
        if (!idValue || idValue.trim() === '') {
        	alert('계좌 생성 실패: 유효한 ID가 필요합니다.'); // 알림창으로 에러 메시지 표시
            $('#cashModal').modal('hide'); // 모달 닫기
            $('body').removeClass('modal-open'); // 모달 관련 CSS 제거
            $('.modal-backdrop').remove(); // 모달 뒤의 회색 배경 제거
            return; // ID가 없으면 계좌 생성 요청 중단
        }

        $.ajax({
            type: "POST",
            url: "/stock/makeCash.do", // 실제 서버에서 처리하는 URL
            contentType: "application/x-www-form-urlencoded; charset=UTF-8", // 문자열로 데이터를 전송
            data: { id: idValue }, // JSON이 아닌 단순 문자열로 데이터 전송
            success: function(response) {
                $('#cashModal').modal('hide'); // 모달 닫기
                $('body').removeClass('modal-open'); // 모달 관련 CSS 제거
                $('.modal-backdrop').remove(); // 모달 뒤의 회색 배경 제거
                alert('계좌가 성공적으로 생성되었습니다.'); // 성공메세지 표시
                loadAccountInfo();
            },
            error: function(xhr, status, error) {
                $('#cashModal').modal('hide'); // 모달 닫기
                $('body').removeClass('modal-open'); // 모달 관련 CSS 제거
                $('.modal-backdrop').remove(); // 모달 뒤의 회색 배경 제거
                alert('계좌 생성 중 오류가 발생했습니다: ' + xhr.responseText); // 알림창으로 에러 메시지 표시
               
            }
        });
    });


	// 계좌 정보를 불러오는 함수
	function loadAccountInfo() {
	    $.ajax({
	        type: "GET",
	        url: "/stock/getCashInfo.do", 
	        contentType: "application/json; charset=UTF-8",
	        dataType: "json",
	        success: function(response) {
	            if (response && response.money !== undefined && response.money !== null) {
	                $('#accountBalance-buy').text(response.money.toLocaleString()); // 잔액 표시
	                $('.createAccountButton').hide(); // 계좌 개설 버튼 숨기기
	                $('#sellBtn').show(); 
	                $('#buyBtn').show(); 
	            } else {
	                $('#accountBalance-buy').text('계좌 정보 없음'); // 계좌 정보가 없다고 표시
	                $('#createAccountButton').show(); // 계좌 개설 버튼 표시
	                $('#sellBtn').css('display', 'none'); // 강제로 버튼 숨기기
	                $('#buyBtn').css('display', 'none');  // 강제로 버튼 숨기기
	            }
	        },
	        error: function(xhr, status, error) {
	            console.error("계좌 정보를 불러오는데 오류가 발생했습니다.");
	            $('#accountBalance').text('오류 발생'); // 오류 메시지 표시
	            $('#createAccountButton').show(); 
	            $('#sellBtn').css('display', 'none'); 
	            $('#buyBtn').css('display', 'none');  
	        }
	    });
	}
	// 주문 리스트 업데이트
	function updateOrderList() {
	    $.ajax({
	        type: 'GET',
	        url: '/stock/getOrderList.do',
	        dataType: 'json',
	        success: function(response) {
	            let orderList = response;
	            let orderListHtml = '';
	            console.log("getOrderList:", orderList);
	            
	            orderList.forEach(function(order) {
	                let orderDate = new Date(order.order_date);
	                let formattedDate = orderDate.getFullYear() + '-' + 
	                                    ('0' + (orderDate.getMonth() + 1)).slice(-2) + '-' + 
	                                    ('0' + orderDate.getDate()).slice(-2) + ' ' +
	                                    ('0' + orderDate.getHours()).slice(-2) + ':' + 
	                                    ('0' + orderDate.getMinutes()).slice(-2);
	
	                let cancelBtn = '';
	                if (order.order_status === '미체결') {
	                    cancelBtn = '<button class="btn btn-danger" onclick="cancelOrder(' +
	                                order.stock_order_no + ', \'' + order.order_status + '\', ' + 
	                                order.price + ', ' + order.stock_count + ')">취소</button>';
	                }
	
	                orderListHtml += 
	                    '<tr>' +
	                        '<td>' + order.company_name + '</td>' +
	                        '<td>' + order.stock_order_no + '</td>' +
	                        '<td>' + order.order_type + '</td>' +
	                        '<td>' + order.order_status + '</td>' +
	                        '<td>' + parseInt(order.price).toLocaleString() + '</td>' +
	                        '<td>' + order.stock_count + '</td>' +
	                        '<td>' + formattedDate + '</td>' +
	                        '<td>' + cancelBtn + '</td>' +
	                    '</tr>';
	            });
	
	            $('#orderListTable').html(orderListHtml);
	        },
	        error: function(xhr, status, error) 	{
	            console.error('주문 내역을 가져오는 중 오류가 발생했습니다.');
	        }
	    });
	}

 

 	// 주문 취소 기능
    window.cancelOrder = function(orderNo, orderStatus, price, stockCount) {
        // 잔액을 가져옴
        let accountBalance = getAccountBalance();
        
        // 미체결 상태를 확인 후 요청에 추가
        if (orderStatus === "미체결") {
            $.ajax({
                type: 'POST',
                url: '/stock/cancelOrder.do',
                data: JSON.stringify({
                    stock_order_no: orderNo,
                    order_status: orderStatus,  // 주문 상태도 함께 전송
                    price: price,               // 주문 가격
                    stock_count: stockCount,    // 주문 수량
                    account_balance: accountBalance,  // 계좌 잔액 추가
                }),
                contentType: 'application/json; charset=UTF-8',
                success: function(response) {
                    if (response.status === 'success') {
                        alert('주문이 성공적으로 취소되었습니다.');
                        loadAccountInfo();
                        updateOrderList();  // 주문 리스트 업데이트
                    } else {
                        alert('주문 취소 중 오류가 발생했습니다: ' + response.message);
                    }
                },
                error: function(xhr, status, error) {
                    console.error('주문 취소 중 오류가 발생했습니다.');
                }
            });
        } else {
            alert("미체결 상태가 아닌 주문은 취소할 수 없습니다.");
        }
    };
    // 잔액 가져오는 함수
    function getAccountBalance1() {
        let balanceText = $('#accountBalance').text(); // 잔액을 텍스트에서 가져옴
        return parseInt(balanceText.replace(/,/g, '')); // 콤마 제거 후 숫자로 변환
    }

 	// 총 금액 계산 함수 (매수/매도에 따라 처리)
    function calculateTotalAmount(type) {
        var quantity = parseFloat($('#quantity-' + type).val()); // 입력된 수량
        var price = parseFloat($('#price-' + type).val()); // 입력된 가격

        if (!isNaN(quantity) && !isNaN(price)) {
            var totalAmount = quantity * price; // 총 금액 계산
            $('#totalAmount-' + type).val(totalAmount.toLocaleString()); // 계산된 총 금액을 표시
        }
    }

    // 비율 버튼 클릭 시 수량을 계산
    function setQuantityByPercent(percent) {
        let accountBalance = getAccountBalance1();
        let price = parseFloat($('#price').val());

        if (!isNaN(accountBalance) && !isNaN(price) && price > 0) {
            let quantity = Math.floor((accountBalance * percent) / price); // 소수점 이하 버림
            $('#quantity').val(quantity); // 수량 필드에 계산된 수량 설정
            calculateTotalAmount(); // 총 금액 계산
        } else {
            alert("먼저 가격을 입력하세요.");
        }
    }

 	// 매수 탭에서 잔액 기반으로 수량 계산
    $('#percent25-buy').click(function() { calculateQuantityByPercent('buy', 0.25); });
    $('#percent50-buy').click(function() { calculateQuantityByPercent('buy', 0.50); });
    $('#percent75-buy').click(function() { calculateQuantityByPercent('buy', 0.75); });
    $('#percent100-buy').click(function() { calculateQuantityByPercent('buy', 1.00); });

    // 매도 탭에서 보유 수량 기반으로 수량 계산
    $('#percent25-sell').click(function() { calculateQuantityByPercent('sell', 0.25); });
    $('#percent50-sell').click(function() { calculateQuantityByPercent('sell', 0.50); });
    $('#percent75-sell').click(function() { calculateQuantityByPercent('sell', 0.75); });
    $('#percent100-sell').click(function() { calculateQuantityByPercent('sell', 1.00); });

    // 수량 및 가격에 따른 총 금액 계산
    $('#quantity-buy, #price-buy').on('input', function() { calculateTotalAmount('buy'); });
    $('#quantity-sell, #price-sell').on('input', function() { calculateTotalAmount('sell'); });

 	// 차트를 그리는 함수
    function drawHoldingsChart(data) {
        var chartDom = document.getElementById('holdingsChart');
        var myChart = echarts.init(chartDom);
        var option;

        option = {
            title: {
                text: '보유 주식 및 잔액',
                left: 'center'
            },
            tooltip: {
                trigger: 'item'
            },
            legend: {
                top: '5%',
                left: 'center'
            },
            series: [
                {
                    name: '보유 자산',
                    type: 'pie',
                    radius: ['40%', '70%'],
                    avoidLabelOverlap: false,
                    itemStyle: {
                        borderRadius: 10,
                        borderColor: '#fff',
                        borderWidth: 2
                    },
                    label: {
                        show: false,
                        position: 'center'
                    },
                    emphasis: {
                        label: {
                            show: true,
                            fontSize: '20',
                            fontWeight: 'bold'
                        }
                    },
                    labelLine: {
                        show: false
                    },
                    data: data
                }
            ]
        };

        myChart.setOption(option);
    }

    function loadStockHoldList() {
        $.ajax({
            type: 'GET',
            url: '/stock/getStockHoldList.do', // 보유 주식 데이터를 가져오는 서버 URL
            dataType: 'json', // JSON 형태로 데이터를 처리
            success: function(response) {
                let stockHoldList = response;
                let stockHoldHtml = '';
                let chartData = [];

                stockHoldList.forEach(function(stockHold) {
                    // 현재가 가져오기 (stock-info에서 사용되는 stockPrice 활용)
                    let currentPrice = stockHold.stck_prpr; // 현재가
                    let holdCount = stockHold.stock_hold_cnt; // 보유 수량
                    let purchasePrice = stockHold.price; // 체결 가격
                    
                    // 매입금액 = 체결 가격 * 보유 수량
                    let purchaseAmount = purchasePrice * holdCount;

                    // 평가금액 = 현재가 * 보유 수량
                    let evalAmount = currentPrice * holdCount;

                    // 수익률 = (현재가 - 체결가) / 체결가 * 100
                    let profitRate = ((currentPrice - purchasePrice) / purchasePrice * 100).toFixed(2);

                    // 수익률에 따른 색상 결정
                    let profitRateColor = profitRate >= 0 ? 'red' : 'blue'; // 양수면 빨간색, 음수면 파란색

                    // 평가금액에 따른 색상 결정
                    let evalAmountColor = evalAmount >= purchaseAmount ? 'red' : 'blue'; // 평가금액이 매입금액보다 높으면 빨간색, 낮으면 파란색

                    // HTML 동적으로 추가
                    stockHoldHtml += 
                        '<tr>' +
                            '<td>' + stockHold.company_name + '</td>' +
                            '<td>' + holdCount.toLocaleString() + '</td>' +
                            '<td>' + parseInt(currentPrice).toLocaleString() + ' 원</td>' + // 현재가
                            '<td style="color:' + profitRateColor + ';">' + profitRate + ' %</td>' + // 수익률
                            '<td>' + purchaseAmount.toLocaleString() + ' 원</td>' + // 매입금액
                            '<td style="color:' + evalAmountColor + ';">' + evalAmount.toLocaleString() + ' 원</td>' + // 평가금액
                        '</tr>';

                    // 차트에 추가할 데이터 생성
                    chartData.push({
                        value: evalAmount,
                        name: stockHold.company_name
                    });
                });

                // 테이블에 데이터를 삽입
                $('#stockHoldListTable').html(stockHoldHtml);

                // 차트를 그릴 때 잔액도 포함
                var accountBalance = parseFloat($('#accountBalance-buy').text().replace(/,/g, '')); 
                chartData.push({
                    value: accountBalance,
                    name: '잔액'
                });

                drawHoldingsChart(chartData); // 차트 그리기
            },
            error: function(xhr, status, error) {
                console.error('보유 주식 정보를 가져오는 중 오류가 발생했습니다.');
            }
        });
    }


	
 	// 총 금액 계산
    function calculateTotalAmount(type) {
        if (type === 'buy') {
            var quantity = parseFloat($('#quantity-buy').val()); // 입력된 매수 수량
            var price = parseFloat($('#price-buy').val()); // 입력된 매수 가격

            if (!isNaN(quantity) && !isNaN(price)) {
                var totalAmount = quantity * price; // 총 금액 계산
                $('#totalAmount-buy').val(totalAmount.toLocaleString()); // 계산된 총 금액을 표시
            }
        } else if (type === 'sell') {
            var quantity = parseFloat($('#quantity-sell').val()); // 입력된 매도 수량
            var price = parseFloat($('#price-sell').val()); // 입력된 매도 가격

            if (!isNaN(quantity) && !isNaN(price)) {
                var totalAmount = quantity * price; // 총 금액 계산
                $('#totalAmount-sell').val(totalAmount.toLocaleString()); // 계산된 총 금액을 표시
            }
        }
    }

	
    // 잔액을 가져오는 함수 (매수 시)
    function getAccountBalance() {
        var balanceText = $('#accountBalance-buy').text().replace(/,/g, '');
        return parseInt(balanceText) || 0;
    }


 	// 보유 주식 수량 가져오기
    function getHoldingQuantity(company_code) {
        $.ajax({
            url: '/stock/getHoldingQuantity.do',
            type: 'GET',
            data: { company_code: company_code },
            dataType: 'json',
            success: function(response) {
                console.log("getHoldingQuantity의 response", response);
                holdingQuantity = response.holdingQuantity || 0; // 데이터를 전역 변수에 저장
                $('#holdingQuantity').text(holdingQuantity); // 보유 수량을 매도 탭에 표시
            },
            error: function(xhr, status, error) {
                console.error("보유 수량을 가져오는 데 실패했습니다.");
                holdingQuantity = 0; // 실패했을 때 0으로 설정
                $('#holdingQuantity').text(0); // 매도 탭에 0으로 표시
            }
        });
    }
	
	
 	// 수량 계산 함수 (잔액 또는 보유 수량에 따른 수량 계산)
    function calculateQuantityByPercent(type, percent) {
        var price = parseFloat($('#price-' + type).val()); // 매수/매도 가격 가져오기
        console.log('계산하자',price);
        if (isNaN(price) || price <= 0) {
            alert('가격을 먼저 입력해주세요.');
            return;
        }

        if (type === 'buy') {
            // 매수 시 계좌 잔액 사용
            var accountBalance = getAccountBalance(); 
            if (isNaN(accountBalance) || accountBalance <= 0) {
                alert('계좌 잔액이 부족합니다.');
                return;
            }

            var quantity = Math.floor((accountBalance * percent) / price);
            $('#quantity-buy').val(quantity);
            calculateTotalAmount('buy');

        } else if (type === 'sell') {
            // 매도 시 보유 수량을 HTML에서 가져와 사용
            var holdingQuantity = parseFloat($('#holdingQuantity').text().replace(/,/g, '')); // 보유 수량 가져오기
            console.log('holdingQuantity',holdingQuantity);
            if (isNaN(holdingQuantity) || holdingQuantity <= 0) {
                alert('보유 수량이 부족합니다.');
                return;
            }

            var quantity = Math.floor((holdingQuantity * percent));
            console.log('percent',percent);
            console.log('quantity',quantity);
            console.log('(holdingQuantity * percent) / price)',(holdingQuantity * percent));
            $('#quantity-sell').val(quantity);
            calculateTotalAmount('sell');
        }
    }


});



</script>      
</head>


<body>

    	<!-- Layout: Left (Stock List), Center (Chart), Right (Trade Form) -->  
    	<div class="row">
            <!-- Left: Stock List -->
			<div class="col-md-2 stock-list">
			    <h4>주식 리스트</h4>
			    <ul class="list-group">
			        <c:forEach items="${stockList}" var="vo">
			        <li class="list-group-item d-flex justify-content-between align-items-center stock-item" data-company_code="${vo.company_code}" data-company_no="${vo.company_no}" data-company_name="${vo.company_name}">
			            <div>
			                <strong>${vo.company_name}</strong><br>
			                <small class="text-muted">${vo.company_code}</small>  <!-- 주식 코드 -->
			            </div>
			            <div class="text-right">
			                <!-- 현재가를 원화로 표시 -->
			                <span class="d-block price"><fmt:formatNumber value="${vo.stck_prpr}" type="number" groupingUsed="true"/> 원</span> <!-- 현재가 -->
			                <small class="d-block change-rate" data-rate="${vo.prdy_ctrt}">${vo.prdy_ctrt}<span>%</span></small> <!-- 전일 대비 수익률 -->
			            </div>
			        </li>
			        </c:forEach>
			    </ul>
			</div>

            <!-- Center: Chart -->
            <div class="col-md-5">
                <div class="chart-container">
                    <div id="main"></div>
                </div>

                <!-- Chart Type Selection -->
                <div class="form-check">
                    <label class="form-check-label" for="dayChart" data-company_code="">
                        <input type="radio" class="form-check-input" name="optradio" value="D" id="dayChart">일봉
                    </label>
                </div>
                <div class="form-check">
                    <label class="form-check-label" for="weekChart" data-company_code="">
                        <input type="radio" class="form-check-input" name="optradio" value="W" id="weekChart">주봉
                    </label>
                </div>
                <div class="form-check">
                    <label class="form-check-label" for="monthChart" data-company_code="">
                        <input type="radio" class="form-check-input" name="optradio" value="M" id="monthChart">월봉
                    </label>
                </div>
            </div>

            <!-- Right: Trade Form -->
            <div class="col-md-5">
		    <div class="container">
		        <!-- 네비게이션 탭 -->
		        <ul class="nav nav-tabs" id="myTab" role="tablist">
			        <li class="nav-item">
	                    <a class="nav-link active" id="stock-info-tab" data-toggle="tab" href="#stock-info" role="tab" aria-controls="stock-info" aria-selected="true">종목 정보</a>
	                </li>
	                <li class="nav-item">
	                    <a class="nav-link" id="trade-form-tab" data-toggle="tab" href="#trade-form" role="tab" aria-controls="trade-form" aria-selected="false">매수 / 매도</a>
	                </li>
	                <c:if test="${!empty login}">
	                <li class="nav-item">
	                    <a class="nav-link" id="order-list-tab" data-toggle="tab" href="#order-list" role="tab" aria-controls="order-list" aria-selected="false">주문 내역</a>
	                </li>
	                <li class="nav-item">
		                <a class="nav-link" id="stock-hold-tab" data-toggle="tab" href="#stock-hold" role="tab" aria-controls="stock-hold" aria-selected="false">보유 주식</a>
		            </li>
	                </c:if>
		        </ul>
		
		        <!-- 탭 콘텐츠 -->
		        <div class="tab-content" id="myTabContent">
		            <!-- 종목 정보 -->
		            <div class="tab-pane fade show active" id="stock-info" role="tabpanel" aria-labelledby="stock-info-tab">
		                <div class="container stock-info-container">
						    <h4 class="text-center my-4" id="stockName">종목명: 삼성전자</h4>
						    <h6 class="text-center my-4" id="stockCode">005930</h6>
						    <table class="table table-bordered table-hover table-striped text-center">
						        <thead class="thead-light">
						            <tr>
						                <th>항목</th>
						                <th>내용</th>
						            </tr>
						        </thead>
						        <tbody>
						            <tr>
						                <td>주가</td>
						                <td><span id="stockPrice"></span> 원</td>
						            </tr>
						            <tr>
						                <td>PER</td>
						                <td><span id="stockPer"></span></td>
						            </tr>
						            <tr>
						                <td>PBR</td>
						                <td><span id="stockPbr"></span></td>
						            </tr>
						            <tr>
						                <td>EPS</td>
						                <td><span id="stockEps"></span></td>
						            </tr>
						            <tr>
						                <td>BPS</td>
						                <td><span id="stockBps"></span></td>
						            </tr>
						            <tr>
						                <td>전일 대비</td>
						                <td><span id="stockChange"></span></td>
						            </tr>
						            <tr>
						                <td>전일 대비율</td>
						                <td><span id="stockChangeRate"></span>%</td>
						            </tr>
						            <tr>
						                <td>누적 거래 대금</td>
						                <td><span id="acmlTrPbmn"></span> 원</td>
						            </tr>
						            <tr>
						                <td>누적 거래량</td>
						                <td><span id="acmlVol"></span></td>
						            </tr>
						            <tr>
						                <td>시가</td>
						                <td><span id="stockOpenPrice"></span> 원</td>
						            </tr>
						            <tr>
						                <td>고가</td>
						                <td><span id="stockHighPrice"></span> 원</td>
						            </tr>
						            <tr>
						                <td>저가</td>
						                <td><span id="stockLowPrice"></span> 원</td>
						            </tr>
						            <tr>
						                <td>최고가</td>
						                <td><span id="stockMaxPrice"></span> 원</td>
						            </tr>
						            <tr>
						                <td>최저가</td>
						                <td><span id="stockMinPrice"></span> 원</td>
						            </tr>
						        </tbody>
						    </table>
						</div>
		            </div>
		
		            <!-- 매수/매도 폼 -->
					<div class="tab-pane fade" id="trade-form" role="tabpanel" aria-labelledby="trade-form-tab">
					    <div class="container trade-form">
					  
					        <!-- 매수/매도 탭 -->
					        <ul class="nav nav-tabs" id="tradeTabs" role="tablist">
					            <li class="nav-item">
					                <a class="nav-link active" id="buy-tab" data-toggle="tab" href="#buy" role="tab" aria-controls="buy" aria-selected="true">매수</a>
					            </li>
					            <li class="nav-item">
					                <a class="nav-link" id="sell-tab" data-toggle="tab" href="#sell" role="tab" aria-controls="sell" aria-selected="false">매도</a>
					            </li>
					        </ul>
					
							<!-- 매수/매도 탭 콘텐츠 -->
							<div class="tab-content" id="tradeTabContent">
							    <!-- 매수 탭 -->
							    <div class="tab-pane fade show active" id="buy" role="tabpanel" aria-labelledby="buy-tab">
							        <form>
							            <!-- 호가 테이블 (매수) -->
							            <table class="table ask-bid-table">
							                <thead>
							                    <tr>
							                        <th>매도호가</th>
							                        <th>수량</th>
							                        <th>매수호가</th>
							                        <th>수량</th>
							                    </tr>
							                </thead>
							                <tbody id="askBidTable-buy">
							                    <!-- AJAX로 동적으로 데이터를 채울 부분 -->
							                </tbody>
							            </table>
							
							            <!-- 수량 입력 -->
							            <div class="form-group">
							                <label for="quantity-buy">수량</label>
							                <input type="number" class="form-control" id="quantity-buy" placeholder="수량 입력">
							            </div>
							            <!-- 가격 입력 -->
							            <div class="form-group">
							                <label for="price-buy">가격</label>
							                <input type="number" class="form-control" id="price-buy" placeholder="가격 입력">
							            </div>
							
							            <!-- 잔액을 기준으로 수량 계산 버튼들 -->
							            <div class="btn-group" role="group">
							                <button type="button" class="btn btn-info" id="percent25-buy">25%</button>
							                <button type="button" class="btn btn-info" id="percent50-buy">50%</button>
							                <button type="button" class="btn btn-info" id="percent75-buy">75%</button>
							                <button type="button" class="btn btn-info" id="percent100-buy">100%</button>
							            </div>
							
							            <!-- 총 금액 계산 -->
							            <div class="form-group mt-3">
							                <label for="totalAmount-buy">총 금액</label>
							                <input type="text" class="form-control" id="totalAmount-buy" placeholder="총 금액" readonly>
							            </div>
							
							            <!-- 잔액 -->
							            <div class="row">
							                <div class="col-md-5">
							                    <span style="font-size: 20px; font-weight: bold;">잔액: <span id="accountBalance-buy" style="font-size: 20px; font-weight: bold;"></span></span>
							                </div>
							            </div>
							
							            <!-- 매수 버튼 -->
							            <button type="button" class="btn btn-success" id="buyBtn" data-status="매수">매수</button>
							            <button id="createAccountButton" type="button" class="btn btn-primary createAccountButton" data-toggle="modal" data-target="#cashModal">계좌 개설</button>
							        </form>
							    </div>
							
							    <!-- 매도 탭 -->
							    <div class="tab-pane fade" id="sell" role="tabpanel" aria-labelledby="sell-tab">
							        <form>
							            <!-- 호가 테이블 (매도) -->
							            <table class="table ask-bid-table">
							                <thead>
							                    <tr>
							                        <th>매도호가</th>
							                        <th>수량</th>
							                        <th>매수호가</th>
							                        <th>수량</th>
							                    </tr>
							                </thead>
							                <tbody id="askBidTable-sell">
							                    <!-- AJAX로 동적으로 데이터를 채울 부분 -->
							                </tbody>
							            </table>
							
							            <!-- 수량 입력 -->
							            <div class="form-group">
							                <label for="quantity-sell">수량</label>
							                <input type="number" class="form-control" id="quantity-sell" placeholder="수량 입력">
							            </div>
							            <!-- 가격 입력 -->
							            <div class="form-group">
							                <label for="price-sell">가격</label>
							                <input type="number" class="form-control" id="price-sell" placeholder="가격 입력">
							            </div>
							
							            <!-- 보유 수량을 기준으로 계산하는 버튼들 -->
							            <div class="btn-group" role="group">
							                <button type="button" class="btn btn-info" id="percent25-sell">25%</button>
							                <button type="button" class="btn btn-info" id="percent50-sell">50%</button>
							                <button type="button" class="btn btn-info" id="percent75-sell">75%</button>
							                <button type="button" class="btn btn-info" id="percent100-sell">100%</button>
							            </div>
							
							            <!-- 총 금액 계산 -->
							            <div class="form-group mt-3">
							                <label for="totalAmount-sell">총 금액</label>
							                <input type="text" class="form-control" id="totalAmount-sell" placeholder="총 금액" readonly>
							            </div>
							
							            <!-- 보유 수량 표시 -->
							            <div class="row">
							                <div class="col-md-5">
							                    <span style="font-size: 20px; font-weight: bold;">보유 수량: <span id="holdingQuantity" style="font-size: 20px; font-weight: bold;"></span></span>
							                </div>
							            </div>
							
							            <!-- 매도 버튼 -->
							            <button type="button" class="btn btn-danger" id="sellBtn" data-status="매도">매도</button>
							            <button id="createAccountButton" type="button" class="btn btn-primary createAccountButton" data-toggle="modal" data-target="#cashModal">계좌 개설</button>
							        </form>
							    </div>
							</div>
					    </div>
					</div>
		            
		        	<!-- 주문 내역 -->
	                <div class="tab-pane fade" id="order-list" role="tabpanel" aria-labelledby="order-list-tab">
	                    <div class="container order-list">
	                        <h4>주문 내역</h4>
	                        <table class="table table-bordered table-hover">
						    <thead>
						        <tr>
						            <th>주문 번호</th>
						            <th>회사명</th>
						            <th>주문 종류</th>
						            <th>주문 상태</th>
						            <th>가격</th>
						            <th>수량</th>
						            <th>주문 일자</th>
						            <th>취소</th>
						        </tr>
						    </thead>
						    <tbody id="orderListTable">
						        <!-- 주문 내역이 동적으로 추가됩니다 -->
						    </tbody>
						</table>
	                    </div>
	                </div>
	                
	                <!-- 보유 주식 -->
		            <div class="tab-pane fade" id="stock-hold" role="tabpanel" aria-labelledby="stock-hold-tab">
		                <div class="container stock-hold-container">
		                    
		                     <div id="holdingsChart" style="width: 400px; height: 500px;"></div> <!-- 차트 영역 -->
		                    <table class="table table-bordered table-hover">
		                        <thead>
		                            <tr>
					                    <th>회사명</th>
					                    <th>수량</th>
					                    <th>현재가</th>
					                    <th>수익률</th>
					                    <th>매입 금액</th>
					                    <th>평가 금액</th>
					                </tr>
		                        </thead>
		                        <tbody id="stockHoldListTable">
		                            <!-- 보유 주식이 동적으로 추가됩니다 -->
		                        </tbody>
		                    </table>
		                </div>
		            </div>
	                
		        </div>
		    </div>

     </div>
</div>

<!-- Modal -->
<div class="modal fade" id="cashModal" tabindex="-1" aria-labelledby="cashModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="cashModalLabel">계좌 개설 확인</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        계좌를 개설하시겠습니까?
      </div>
      <div class="modal-footer">
      	<input type="hidden" class="form-control" id="Cashid" name="Cashid" value="${login.id}">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
        <button type="button" class="btn btn-primary" id="confirmAccountBtn">확인</button>
      </div>
    </div>
  </div>
</div>
<!-- 계좌 생성 결과 메시지를 표시할 영역 -->
<div id="resultMessage" class="mt-3"></div>
</body>
</html>
