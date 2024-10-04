/**
 * 
 */
/**
 * 입력된 수를 ,가 포함된 수로 바꾼다.
 */
 function numWithComma(strNum){
	//입력된 수를 정수 타입으로 변환
	num = parseInt(strNum);
	//수에다 3자리마다 , 삽입
	return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
}
/**
 * 입력된 수에서 ,제거(가격 계산을 위해 사용)
 */
function numWithoutComma(strNum) {
	//수에 존재하는 ,를 ''로 바꾼다.
	return strNum.toString().replace(/,/g, '');
}
/**
 * 입력된 태그의 있에 가격을 ,를 붙힌 가격으로 바꾼다.<br>
 * 만약 가격이 0이면 무료로 바꾼다<br>
 * $num - 가격이 입력되어있는 태그의 선택자
 */
function printComma($num) {
	if($num.text() == 0) {
		//가격이 0이면 무료로 바꾸고 뒤에 있는 '원'을 제거한다. 
		$num.text('무료');
		$num.siblings(".won").text("");
	} else {
		//가격이 0이 아니면 가격에 ,를 붙히고 '원'을 생성한다.
		$num.text(numWithComma($num.text()));
		$num.siblings(".won").text("원");			
	}
}
