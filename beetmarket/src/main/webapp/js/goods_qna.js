/**
 * 상품 qna 처리 객체
 */

// 이곳이 실행이 되는지 확인 할 수 있다.
console.log("GoodsQna Module .........................");

// 일반 게시판 댓글을 처리하는 객체 선언 - jquery의 ajax 사용 : ajax(), getJSON(), get(), post()
let Goods_QnaService = {
	
	// 1. 상품 qna 리스트 처리 함수 - replyService.list(page, 성공함수, 실패함수);
	"list" : function(page, callback, error){
		console.log("상품 qna리스트 ----------------------");
		// page가 없으면 1로 세팅한다.
		if(!page) page = 1;
		console.log("page : " + page + ", goodsNo : " + goodsNo);
		
		// ajax 형태를 만들어 처리한다. - getJSON()
		$.getJSON(
			"/goods_qna/list.do?page=" + page + "&goodsNo=" + goodsNo,
			// 데이터 가져오기를 성공하면 실행되는 함수. data가 서버에서 넘겨주는 JSON 데이터
			function(data){
				console.log(data);
				console.log(JSON.stringify(data));
				// callback이 있으면 실행 -> html tag를 만들어 표시하는 함수 실행
				if(callback) callback(data);
			}
			
		).fail(function(xhr, status, err){
			console.log("상품 qna 데이터 가져오기 오류 ***********************");
			console.log("xhr" + xhr);
			console.log("status" + status);
			console.log("err" + err);
			// error이 있으면 실행
			if(error) error();
			else alert("상품 qna 가져 오는 중 오류 발생");
		});
	},

	// 2. 일반 게시판 댓글 등록 처리 함수 - replyService.write(댓글객체, 성공함수, 실패함수);
	"write" : function(reply, callback, error){
		console.log("댓글 등록 ----------------------");
		
		$.ajax({
			type : "post", // 데이터 전송 방식
			url : "/boardreply/write.do",
			data : JSON.stringify(reply), // 서버에 전송되는 데이터 - body
			contentType : "application/json; charset=utf-8", // 서버에 전송되는 데이터 타입과 엔코딩
			// 성공했을 때의 함수.
			success : function(result, status, xhr){
				if(callback) callback(result);
				else alert(result);
			},
			// 실해했을 때의 함수.
			error : function(xhr, status, er){
				console.log("xhr : " + xhr);
				console.log("status : " + status);
				console.log("er : " + er);
				if(error) error(er);
				else alert("댓글 수정에 실패했습니다.");
			}
		});
	},

	// 3. 일반 게시판 댓글 수정 처리 함수 - replyService.update(댓글객체, 성공함수, 실패함수);
	"update" : function(reply, callback, error){
		console.log("댓글 수정 ----------------------");
		
		$.ajax({
			type : "post", // 데이터 전송 방식
			url : "/boardreply/update.do",
			data : JSON.stringify(reply), // 서버에 전송되는 데이터 - body : rno, content
			contentType : "application/json; charset=utf-8", // 서버에 전송되는 데이터 타입과 엔코딩
			// 성공했을 때의 함수.
			success : function(result, status, xhr){
				if(callback) callback(result);
				else alert(result);
			},
			error : function(xhr, status, er){
				console.log("xhr : " + xhr);
				console.log("status : " + status);
				console.log("er : " + er);
				if(error) error(er);
				else alert("댓글 수정에 실패했습니다.");
			}
		});
		
	},

	// 일반 게시판 댓글 리스트 처리 함수 - replyService.delete(rno, 성공함수, 실패함수);
	"delete" : function(rno, callback, error){
		console.log("댓글 삭제 ----------------------");
		$.ajax({
			type : "get", // 데이터 전송 방식
			url : "/boardreply/delete.do?rno=" + rno,
			// 성공했을 때의 함수.
			success : function(result, status, xhr){
				if(callback) callback(result);
				else alert(result);
			},
			error : function(xhr, status, er){
				console.log("xhr : " + xhr);
				console.log("status : " + status);
				console.log("er : " + er);
				if(error) error(er);
				else alert("댓글 삭제에 실패했습니다.");
			}
		});
	}

};