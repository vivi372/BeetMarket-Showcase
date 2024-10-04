<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>WebSocket Test Page</title>
    <!-- crypto-js.min.js 들어갈자리, for use aes256 decode -->
    <script src="/resources/js/crypto-js.min.js"></script>

    <!-- 화면분할을 위한 div 처리 -->
    <style>
        div.row {
            width: 100%;
            display: flex;
            border: 1px solid #003458;
        }
        div.left {
            width: 300px;
            float: left;
            box-sizing: border-box;
            font-size: 12px; 
        }
        div.middle {
            width: 300px;
            float: left;
            box-sizing: border-box;
            background: #ece6cc;
        }   
        div.right {
            width: 300px;
            float: left;
            box-sizing: border-box;
            background: #ece6cc;
        }   
    </style>

    <script>
        var stockcode1="";
        var stockcode2="";
        var htsid="";
        
        var g_app_key="<%= request.getAttribute("app_key") %>";
        var g_appsecret="<%= request.getAttribute("appsecret") %>";
        var g_approval_key="<%= request.getAttribute("approval_key") %>";
        
        var ping=0;
        var pingpong=0;
        var encryptkey='';
        var iv='';
        
        var escapable = /[\x00-\x1f\ud800-\udfff\u200c\u2028-\u202f\u2060-\u206f\ufff0-\uffff]/g;
        
        function filterUnicode(quoted) {
            escapable.lastIndex = 0;
            if (!escapable.test(quoted)) return quoted;
            return quoted.replace(escapable, function(a){
                return '';
            });
        }

        function aes256Decode(secretKey, Iv, data) {
            const cipher = CryptoJS.AES.decrypt(data, CryptoJS.enc.Utf8.parse(secretKey), {
                iv: CryptoJS.enc.Utf8.parse(Iv),
                padding: CryptoJS.pad.Pkcs7,
                mode: CryptoJS.mode.CBC
            });
            aes256DecodeData = cipher.toString(CryptoJS.enc.Utf8);
            return aes256DecodeData;
        }

        var log = function(s,f) {
            if (document.readyState !== "complete") {
                log.buffer.push(s);
            } else {
                if (f == 1) {
                    document.getElementById("output").style.fontSize = "12px";
                    document.getElementById("output").innerHTML += (s + "\n");
                } else if (f == 2) {
                    document.getElementById("output_1").style.fontSize = "12px";
                    document.getElementById("output_1").innerHTML += (s + "\n");
                }
            }
        }
        log.buffer = [];

        var log1 = function(a,s) {
            if (document.readyState !== "complete") {
                log1.buffer.push(s);
            } else {
                document.getElementById("output1").style.fontSize = "12px";
                if (a == "02") {
                    document.getElementById("output1").style.color = "red";
                } else if (a == "01") {
                    document.getElementById("output1").style.color = "blue";
                }
                document.getElementById("output1").innerHTML += (s + "\n");
            }
        }
        log1.buffer = [];

        var log2 = function(s, f) {
            if (document.readyState !== "complete") {
                log2.buffer.push(s);
            } else {
                if (f == 1) {
                    document.getElementById("output2").style.fontSize = "12px";
                    document.getElementById("output2").innerHTML += (s + "\n");
                } else if (f == 2) {
                    document.getElementById("output2_1").style.fontSize = "12px";
                    document.getElementById("output2_1").innerHTML += (s + "\n");
                }
            }
        }
        log2.buffer = [];

        var log3 = function(s) {
            if (document.readyState !== "complete") {
                log3.buffer.push(s);
            } else {
                document.getElementById("output3").style.fontSize = "12px";
                document.getElementById("output3").innerHTML += (s + "\n");
            }
        }
        log3.buffer = [];

        try {
            url = "ws://ops.koreainvestment.com:21000";
            w = new WebSocket(url);
        } catch (e) {
            log(e);
        }

        w.onopen = function() {
            log3("[Connection OK]");    
            log3("[OPS(WebSocket) Test Ready.]");
        }

        w.onclose = function(e) {
            log3("[CONNECTION CLOSED]");
        }

        w.onmessage = function(e) {
            var recvdata = filterUnicode(e.data);
            if (recvdata[0] == 0 || recvdata[0] == 1) {
                var strArray = recvdata.split('|');
                var trid = strArray[1];
                var bodydata = (strArray[3]);

                if (strArray[0] == 1) {
                    var decodedata = aes256Decode(encryptkey, iv, bodydata);

                    if (trid == "H0STCNI0" || trid == "H0STCNI9") {
                        var arrObject = "고 객 I D,계 좌 번 호,주 문 번 호,원주문 번 호,매도매수 구분,정 정 구 분,주 문 종 류,주 문 조 건,주식단축종목코드,체 결 수 량,체 결 단 가,주식체결 시간,거 부 여 부,체 결 여 부,접 수 여 부,지 점 번 호,주 문 수 량,계  좌  명,체결  종목명,신 용 구 분,신용 대출일자,체결종목명40,주 문 가 격".split(',');
                        var strResult = decodedata.split('^');
                        document.getElementById("output1").innerHTML = ("");
                        for (var i = 0; i < strResult.length; i++) {
                            log1(strResult[4], arrObject[i] + "[" + strResult[i] + "]");
                        }
                    } 
                } else if (strArray[0] == 0) {
                    if (trid == "H0STASP0") {
                        var strResult = bodydata.split('^');
                        var screenflag = (stockcode1 == strResult[0]) ? 1 : 2;

                        if (screenflag == 1) {
                            document.getElementById("output").innerHTML = ("");
                        } else if (screenflag == 2) {
                            document.getElementById("output_1").innerHTML = ("");
                        }

                        log("유가증권 단축 종목코드 [" + strResult[0] + "]", screenflag);
                        log("영업 시간[" + strResult[1] + "]시간 구분 코드[" + strResult[2] + "]", screenflag);
                        log("====================================", screenflag);

                        for (var j = 3; j <= 22; j++) {
                            log("호가[" + j + "]: [" + strResult[j] + "] 잔량: [" + strResult[22 + j] + "]", screenflag);
                        }
                        log("====================================", screenflag);
                    } else if (trid == "H0STCNT0") {
                        var objectlist = "유가증권단축종목코드,주식체결시간,주식현재가,전일대비부호,전일대비,전일대비율,가중평균주식가격,주식시가,주식최고가,주식최저가,매도호가1,매수호가1,체결거래량,누적거래량,누적거래대금,매도체결건수,매수체결건수,순매수 체결건수,체결강도,총 매도수량,총 매수수량,체결구분,매수비율,전일 거래량대비등락율,시가시간,시가대비 구분,시가대비,최고가 시간,고가대비구분,고가대비,최저가시간,저가대비구분,저가대비,영업일자,신 장운영 구분코드,거래정지 여부,매도호가잔량,매수호가잔량,총 매도호가잔량,총 매수호가잔량,거래량 회전율,전일 동시간 누적거래량,전일 동시간 누적거래량 비율,시간구분코드,임의종료구분코드,정적VI발동기준가".split(',');
                        var strResult = bodydata.split('^');
                        var objectarray = objectlist;

                        var screenflag = (stockcode1 == strResult[0]) ? 1 : 2;

                        if (screenflag == 1) {
                            document.getElementById("output2").innerHTML = ("");
                        } else if (screenflag == 2) {
                            document.getElementById("output2_1").innerHTML = ("");
                        }

                        var tot_loop_cnt = strArray[2];
                        var k = 1;
                        log2("주식 체결 건수 [" + "00" + k + "/" + tot_loop_cnt + "]", screenflag);
                        log2("====================================", screenflag);
                        
                        for (var i = 0; i < strResult.length; i++) {
                            log2(objectarray[i] + "[" + strResult[i] + "]", screenflag);
                        }
                    }
                }
            } else {
                console.log("[RECV] < [" + recvdata.length + "] " + recvdata);
            }
        }

        window.onload = function() {
            document.getElementById("hokaregButton1").onclick = function() {
                var stockcode_tmp = document.getElementById("inputMessage1").value;
                stockcode1 = stockcode_tmp;
                var result = '{"header": {"approval_key":"' + g_approval_key + '","custtype":"P","tr_type":"1","content-type":"utf-8"},"body": {"input": {"tr_id":"H0STASP0","tr_key":"' + stockcode1 + '"}}}';

                log3("[SEND] : 주식호가1등록요청");
                try {
                    w.send(result);
                } catch(e) {
                    log3(e);
                }
                document.getElementById("output3").scrollTop = document.getElementById("output3").scrollHeight;
            }
            
            document.getElementById("hokaderegButton1").onclick = function() {
                stockcode1 = document.getElementById("inputMessage1").value;
                var result = '{"header": {"approval_key":"' + g_approval_key + '","custtype":"P","tr_type":"2","content-type":"utf-8"},"body": {"input": {"tr_id":"H0STASP0","tr_key":"' + stockcode1 + '"}}}';
                stockcode1 = ""
                log3("[SEND] : 주식호가1등록해지요청");
                try {
                    w.send(result);
                } catch(e) {
                    log3(e);
                }
                document.getElementById("output3").scrollTop = document.getElementById("output3").scrollHeight;
            }

            document.getElementById("hokaregButton2").onclick = function() {
                var stockcode_tmp = document.getElementById("inputMessage2").value;
                if (stockcode_tmp == stockcode2 || stockcode_tmp == stockcode1) {
                    alert("이미 등록된 종목코드 입니다.");
                } else {
                    stockcode2 = stockcode_tmp;
                    var result = '{"header": {"approval_key":"' + g_approval_key + '","custtype":"P","tr_type":"1","content-type":"utf-8"},"body": {"input": {"tr_id":"H0STASP0","tr_key":"' + stockcode2 + '"}}}';

                    log3("[SEND] : 주식호가2등록요청");
                    try {
                        w.send(result);
                    } catch(e) {
                        log3(e);
                    }
                }
                document.getElementById("output3").scrollTop = document.getElementById("output3").scrollHeight;
            }
            
            document.getElementById("hokaderegButton2").onclick = function() {
                stockcode2 = document.getElementById("inputMessage2").value;
                var result = '{"header": {"approval_key":"' + g_approval_key + '","custtype":"P","tr_type":"2","content-type":"utf-8"},"body": {"input": {"tr_id":"H0STASP0","tr_key":"' + stockcode2 + '"}}}';
                stockcode2 = ""
                log3("[SEND] : 주식호가2등록해지요청");
                try {
                    w.send(result);
                } catch(e) {
                    log3(e);
                }
                document.getElementById("output3").scrollTop = document.getElementById("output3").scrollHeight;
            }

            document.getElementById("bidregButton1").onclick = function() {
                stockcode1 = document.getElementById("inputMessage1").value;
                var result = '{"header":{"approval_key":"' + g_approval_key + '","custtype":"P","tr_type":"1","content-type":"utf-8"},"body": {"input": {"tr_id":"H0STCNT0","tr_key":"' + stockcode1 + '"}}}';
                log3("[SEND] : 주식체결등록요청");
                try {
                    w.send(result);
                } catch(e) {
                    log3(e);
                }
                document.getElementById("output3").scrollTop = document.getElementById("output3").scrollHeight;
            }
            
            document.getElementById("bidderegButton1").onclick = function() {
                stockcode1 = document.getElementById("inputMessage1").value;
                var result = '{"header":{"approval_key":"' + g_approval_key + '","custtype":"P","tr_type":"2","content-type":"utf-8"},"body": {"input": {"tr_id":"H0STCNT0","tr_key":"' + stockcode1 + '"}}}';
                log3("[SEND] : 주식체결등록해지요청");
                stockcode1 = "";
                try {
                    w.send(result);
                } catch(e) {
                    log3(e);
                }
                document.getElementById("output3").scrollTop = document.getElementById("output3").scrollHeight;
            }

            document.getElementById("bidregButton2").onclick = function() {
                stockcode2 = document.getElementById("inputMessage2").value;
                var result = '{"header":{"approval_key":"' + g_approval_key + '","custtype":"P","tr_type":"1","content-type":"utf-8"},"body": {"input": {"tr_id":"H0STCNT0","tr_key":"' + stockcode2 + '"}}}';
                log3("[SEND] : 주식체결등록요청");
                try {
                    w.send(result);
                } catch(e) {
                    log3(e);
                }
                document.getElementById("output3").scrollTop = document.getElementById("output3").scrollHeight;
            }
            
            document.getElementById("bidderegButton2").onclick = function() {
                stockcode2 = document.getElementById("inputMessage2").value;
                var result = '{"header":{"approval_key":"' + g_approval_key + '","custtype":"P","tr_type":"2","content-type":"utf-8"},"body": {"input": {"tr_id":"H0STCNT0","tr_key":"' + stockcode2 + '"}}}';
                log3("[SEND] : 주식체결등록해지요청");
                try {
                    w.send(result);
                } catch(e) {
                    log3(e);
                }
                document.getElementById("output3").scrollTop = document.getElementById("output3").scrollHeight;
            }

            document.getElementById("bidalamButton").onclick = function() {
                htsid = document.getElementById("inputMessage_id").value;
                var result = '{"header": {"approval_key":"' + g_approval_key + '","custtype":"P","tr_type":"1","content-type":"utf-8"},"body": {"input": {"tr_id":"H0STCNI0","tr_key":"' + htsid + '"}}}';
                log3("[SEND] : HTSID[" + htsid + "] 주식체결통보등록요청");
                try {
                    w.send(result);
                } catch(e) {
                    log3(e);
                }
                document.getElementById("output3").scrollTop = document.getElementById("output3").scrollHeight;
            }
            
            document.getElementById("xbidalamButton").onclick = function() {
                htsid = document.getElementById("inputMessage_id").value;
                var result = '{"header": {"approval_key":"' + g_approval_key + '","custtype":"P","tr_type":"2","content-type":"utf-8"},"body": {"input": {"tr_id":"H0STCNI0","tr_key":"' + htsid + '"}}}';
                log3("[SEND] : HTSID[" + htsid + "] 주식체결등록통보해지요청");
                try {
                    w.send(result);
                } catch(e) {
                    log3(e);
                }
                document.getElementById("output3").scrollTop = document.getElementById("output3").scrollHeight;
            }

            document.getElementById("closeButton").onclick = function() {
                w.close();
            }
        }
    </script>
</head>
<body>
    <!-- 화면분할을 위한 div 처리 -->
    <!-- output3, command box -->
    <div style="background-color:#EEEEEE">
        <pre id="output3" style="width: 100%; height: 10%; overflow: auto;"></pre>
    </div>
    <!-- output, 주식호가1 box  -->
    <div class="left" style="background-color:#FFF5EE">
        <input type="text" id="inputMessage1" style="width: 180px; height: 20px" value="005930"><br>
        <button id="hokaregButton1" style="width: 80px; height: 20px; font-size: 12px">주식호가</button>
        <button id="hokaderegButton1" style="width: 100px; height: 20px; font-size: 12px">주식호가해제</button>
        <button id="closeButton" style="width: 100px; height: 20px; font-size: 12px">연결해제</button>
        <pre id="output" style="width: 100%; height: 100%; overflow: auto;"></pre>
    </div>
    <!-- output, 주식체결1 box  -->
    <div class="right" style="background-color:#FFFFFF"><br>
        <button id="bidregButton1" style="width: 80px; height: 20px; font-size: 12px">주식체결</button>
        <button id="bidderegButton1" style="width: 100px; height: 20px; font-size: 12px">주식체결해제</button>
        <pre id="output2" style="width: 100%; height: 100%; overflow: auto;"></pre>
    </div>
    <!-- output, 주식호가2 box  -->
    <div class="left" style="background-color:#FFF5EE">
        <input type="text" id="inputMessage2" style="width: 180px; height: 20px font-size: 12px" value="000660"><br>
        <button id="hokaregButton2" style="width: 80px; height: 20px; font-size: 12px">주식호가</button>
        <button id="hokaderegButton2" style="width: 100px; height: 20px; font-size: 12px">주식호가해제</button>
        <pre id="output_1" style="width: 100%; height: 100%; overflow: auto;"></pre>
    </div>
    <!-- output, 주식체결2 box  -->
    <div class="right" style="background-color:#FFFFFF"><br>
        <button id="bidregButton2" style="width: 80px; height: 20px; font-size: 12px">주식체결</button>
        <button id="bidderegButton2" style="width: 100px; height: 20px; font-size: 12px">주식체결해제</button>
        <pre id="output2_1" style="width: 100%; height: 100%; overflow: auto;"></pre>
    </div>
    <!-- output, 주식체결통보 box  -->
    <div class="middle">
        <input type="text" id="inputMessage_id" style="width: 80px; height: 20px" value="101334"><br>
        <button id="bidalamButton" style="width: 100px; height: 20px; font-size: 12px">주식체결통보</button>
        <button id="xbidalamButton" style="width: 120px; height: 20px; font-size: 12px">주식체결통보해제</button>
        <pre id="output1" style="width: 100%; height: 100%; overflow: auto;"></pre>
    </div>
</body>
</html>
