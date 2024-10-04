/**
 * 날짜 시간 관련 처리해주는 js
 */

/**
* 날짜에 월이나 년을 빼주는 함수
* dateString 문자열 형태 날짜
* period 빼고 싶은 월이나 년 ex) 5m,1y
*/
function subtractDate(dateString, period) {
	// 입력된 문자열을 Date 객체로 변환
	const date = new Date(dateString);
	
	if(period.indexOf('m')>=0) {
		let months = period.substring(0, 1);
		// 월을 변경 (월은 0부터 시작하므로 주의)
		date.setMonth(date.getMonth() - months);		
	} else {
		let year = period.substring(0, 1);
		// 월을 변경 (월은 0부터 시작하므로 주의)
		date.setFullYear(date.getFullYear() - year);	
	}
	
	
	// 'yyyy-mm-dd' 형식으로 변환
	const year = date.getFullYear();
	const month = String(date.getMonth() + 1).padStart(2, '0'); // 월은 1부터 시작하므로 +1
	const day = String(date.getDate()).padStart(2, '0');
	
	return `${year}-${month}-${day}`;
}

/**
* 데이트 타입을 yyyy-mm-dd 형태의 문자열로 변환 
*/
function dateToString(date) {	
	// 'yyyy-mm-dd' 형식으로 변환
	const year = date.getFullYear();
	const month = String(date.getMonth() + 1).padStart(2, '0'); // 월은 1부터 시작하므로 +1
	const day = String(date.getDate()).padStart(2, '0');
	
	return `${year}-${month}-${day}`;
}