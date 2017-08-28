<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

	<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/latest/css/bootstrap.min.css">
	<script src="http://code.jquery.com/jquery-1.10.2.js"></script> 
	<script src="//maxcdn.bootstrapcdn.com/bootstrap/latest/js/bootstrap.min.js"></script>
	<!-- 스프링 시큐리티 ajax csrf설정 403에러  -->
	<meta name="_csrf" content="${_csrf.token}" />
	<!-- default header name is X-CSRF-TOKEN -->
	<meta name="_csrf_header" content="${_csrf.headerName}" />
	<!-- 스프링 시큐리티 ajax csrf설정 403에러  -->
	
	
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>

body {
/* 	background-color: #fafafa; */
    box-shadow : rgba(0,0,0,0.5) 0 0 0 9999px;
	background: #f4f5f7;
	line-height: 20px;
}

#popupDiv {
	top : 0px;
	position: absolute;
	display: none; 
}
#popup_mask {
	position: fixed;
	width: 100%;
	height: 100%;
	top: 0px;
	left: 0px;
 	display: none; 
 	background-color:#000;
 	opacity: 0.8;
}


.glyphicon glyphicon-heart {
	background: white;
	color: white;
}

hr {
	border: 1px solid #d4d6d8;
}
.boardBox {
  display: -webkit-flex;
  display: flex;
  -webkit-flex-flow: row wrap;
  flex-flow: row wrap;
  position: relative;
  margin: auto;
  border: 1px solid #dee0e2;
  width: 100%;
  background-color: white;
 /*  overflow: hidden; */
}
/* .c1 {
	height: 20%;
	border-bottom: 1px solid #dee0e2;
} */
.c2 {
	/* min-height: 400px; */
/* 	height: 40%; */
	border-bottom: 1px solid #fafafa;
}

.c3 {
	height: 10%;
	border-bottom: 1px solid #fafafa;
}
.c4{
/* 	
	height: 30%;
	border-bottom: 1px solid #fafafa; */
}

.c5{
	height: 10%;
	border-bottom: 1px solid #fafafa;
}

.c1, .c2, .c3, .c4, .c5 {
  width: 100%;
/*   border: 1px solid gray; */
}

.c1, .c3, .c4, .c5 {
	padding: 0px 20px;
}

/* PC화면일시  */
@media (min-width: 800px) {  
	.boardBox {
	  max-width: 1000px;
	  height: 800px;
	}
  .c2 {
  	  order: 2;
	  position: absolute;
	  float: left;
	  width: 60%;
	  height: 100%;
	  text-align: center;
	
	  border-right: 1px solid #fafafa;
  }	
  .c1 {
  	order: 1;
  	height: 20%;
  	margin-left : 60%;
  	width: 40%;
  	padding: 0px 10px;
  	border-bottom: 1px solid #fafafa;
  }
  .c3{
 	position: relative;
  	order: 4;
  	height: 15%;
  	margin-left : 60%;
 	width: 40%;
 	border-bottom: 1px solid #fafafa;
 	padding: 0px 10px;
  }
  .c5{
  	order: 5;
  	height: 10%;
  	margin-left : 60%;
 	width: 40%;
	padding: 0px 10px;
  }
  .c4 {
  	order: 3;
    height: 60%;
  /* 	position: absolute; */
 	margin-left : 60%;
 	width: 40%;
 	overflow:scroll; 
 	border-bottom: 1px solid #fafafa;
 	overflow-x:hidden;
    padding: 0px 30px; 
  }

}
.replyTextArea {
	background: 0 0;
    border: none;
    color: #262626;
    font-size: inherit;
    outline: none;
    padding: 0;
    resize: none; 
    max-height: 60px;
/*     max-height: 200px; */
}
	
</style>
</head>
<body>
  	<br>
  	<br>
  	<br>
  	<br>
  	<br>
  	<div class="boardBox">
			<div class="c1" > <!-- 유저이름,타이틀 div -->
				<br>
				<div><img src="/displayFile?fileName=${boardVO.profileimage}" class="img-circle" width="80px" height="80px"> <label>${boardVO.displayname}</label> </div>
				<div><label>${boardVO.title}</label></div>
				<div>
				<!-- 게시판 주인과 로그인 유저의 아이디가 같을시 수정,삭제 버튼 활성화 -->
					<c:if
						test="${boardVO.username eq pageContext.request.userPrincipal.name}">
						<a href="#" id="modify">수정</a>
						<a href="#" id="delete">삭제</a>
					</c:if>
				</div>	
			</div>
		
			<div class="c2">
			    <img src="/displayFile?fileName=${boardVO.photo}" style="width: 100%; height: 100%; vertical-align: middle" />
			</div>
			
			<div class="c3">
				<a href="#" id="heartCancle" style="display: none; color:red"><span class="glyphicon glyphicon-heart" style="font-size: 50px; "></span></a>
				<a href="#" id="heartClick" style="display: block; color: red"><span class="glyphicon glyphicon-heart-empty" style="font-size:50px;"></span></a>
				<br><label>좋아요</label>
				<label id="heartCnt">${boardVO.heartcnt}</label> <label>개</label> <br>
			</div>
			
			<div class="c4" >
				<div>
					<label>${boardVO.username}</label>
				</div>
				<input type="hidden" id="contentVal" value="${boardVO.content}"> <span id="content"></span> <br>
				<br>
				<label> 댓글  </label>
						<!-- 댓글영역 -->
				<div id='replyArea' class="row">
		
					<div id='replyShow'>
		
						<!-- 현재 이 글에 있는 댓글들을 추가할 div-->
						<div id='replyAttacher'>
		
							<!-- 실제 reply들을 포함. (안쪽 행 하나하나는 div id='replyXXX') : 등록 후 HttpStatus.OK 를 받으면 Attach -->
							<div id='repliesArea'></div>
		
						</div>
		
					</div>
		
				</div>
			</div>
			
			<div class="c5">
<!-- 			<input id="inputReply" type="text" />  -->
			<textarea id="replyInput" class="replyTextArea" style="height: 20px" rows="2" cols="40" placeholder="댓글달기..."></textarea>
			<input id="replySend"type="button" value="등록"/>
			</div>
		
				
			
		</div>

		<form action="" method="post">
			<input type="hidden" name="boardno" id="boardno"
				value="${boardVO.boardno}"> <input type="hidden"
				name="${_csrf.parameterName}" value="${_csrf.token}" />
		</form>
		<input type="hidden" id="username"
			value="${pageContext.request.userPrincipal.name}">
		<!-- 현재 로그인 유저 아이디 -->
		<input type="hidden" id="boardUsername" value="${boardVO.username}">
		<!-- 게시판 주인 아이디 -->
		<br>
		<br>
		<br>
		<br>
	<br>
	<br>
	
	<div id ="popup_mask" class="popup">
	</div>
	<div id="popupDiv" style="height: 400px; width: 350px" class="popup">
		<img src="" id="popupImg" width="400px" height="350px">
		<button id="popCloseBtn">close</button>
	<!-- 	  	이미지 사이즈를 고정하거나 DIV를 고정 (수정사항 고민중) -->
	</div>	
	<img src="/displayFile?fileName=${boardVO.profileimage}" class="img-circle testimg" width="40px" height="40px">
				
	
	
	<br>
	<br>
	<br>
	<script type="text/javascript">
 
	 
	// 처리 도중 서버에 Request를 보내는 함수가 있다면 늦게 처리돼서 
	// 이 부분을 가장 먼저 수행(403 Forbidden 방지) 
	$(function () {
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$(document).ajaxSend(function(e, xhr, options) {
			xhr.setRequestHeader(header, token);
		});
	});
	
	var loadingImage;
	loadingImage = "<img id='loadingImage' src='${pageContext.request.contextPath}/resource/imageIcon/replyloading.gif'>";
	$(document).ready(function(){
	
	var boardno = $("#boardno").val(); //게시판번호
	var username = $("#username").val();//username 


	$(".replyTextArea").on('keydown keyup', function () {
 		adjustHeight();
	});
	var adjustHeight = function() {
		  var textEle = $(".replyTextArea")
		  var textEleHeight = $(".replyTextArea").prop('scrollHeight');
		  textEle.css('height', textEleHeight);
		};
	var contentText =$("#contentVal").val().replace(/<s>/g," ").replace(/<e>/g,"\n");
	$("#content").text(contentText);

	
	$("#modify").click(function(event) {
		event.preventDefault(); //화면 링크 방지 
		$("form").attr("action","/board/modify");
		$("form").submit();
	});
	
	$("#delete").click(function(event) {
		event.preventDefault(); //화면 링크 방지 
		$("form").attr("action","/board/delete");
		$("form").submit();
	});
	
	$("#heartClick").click(function(event){
		event.preventDefault(); //화면 링크 방지 
		if(username){
		$('#heartClick').css("display","none"); 
	    $('#heartCancle').css("display","block"); 
	    var heartCnt = $("#heartCnt").text();
		heartCnt = parseInt(heartCnt)+1;
		$("#heartCnt").text(heartCnt);
		
	    $.ajax({
            url : "/board/heartClick",
            type : "post",
            data : {
              	boardno : boardno,
              	username : username
            },
            dataType : "text",
            success : function(result) {
         		if(result==="success"){
					console.log("success");
         		}else{
         			console.log("Fail");
         		}
            }
         });
		}else{
			alert("로그인 해주세요");
		}
	});
	$("#heartCancle").click(function(event){
		event.preventDefault(); //화면 링크 방지 
		$('#heartClick').css("display","block"); 
	    $('#heartCancle').css("display","none"); 
	    var heartCnt = $("#heartCnt").text();
		heartCnt = parseInt(heartCnt)-1;
		$("#heartCnt").text(heartCnt);
		
	    $.ajax({
            url : "/board/heartCancle",
            type : "post",
            data : {
              	boardno : boardno,
              	username : username
            },
            dataType : "text",
            success : function(result) {
         		if(result==="success"){
					console.log("success");
         		}else{
         			console.log("Fail");
         		}
            }
         }); 
			
	});

	// 1차 댓글 작성 후 request 버튼
	$("#replySend").click(function(event) {
		if(username){
			var content = $("#replyInput").val();
			sendReply(content, 0);} 
		else alert('로그인 후 댓글 달것');
	});
	
	$(".testimg").click(function(event){
		console.log("클릭");
	
	 	$("#popupImg").attr('src',$(this).attr('src')); 
	 	
	 /* 	var tx = ($(window).width()-$("#popupDiv").width())/2;
	 	var ty = ($(window).height()-$("#popupDiv").height())/2; */
	 	
	 /* 	 $("#popupDiv").css({left:tx+"px",top:ty+"px"}); */
		 $("#popupDiv").css({
			"top": (($(window).height()-$("#popupDiv").outerHeight())/2+$(window).scrollTop())+"px",
			"left": (($(window).width()-$("#popupDiv").outerWidth())/2+$(window).scrollLeft())+"px"
		}); 
		
	    $("#popup_mask").css("display","block"); 
	    $("#popupDiv").css("display","block"); 
	    
		$("body").css("overflow","hidden");//스크롤바 없애기
	});
	
	$("#popCloseBtn").click(function(event){
		console.log("closeBtn 클릭");
		$("#popup_mask").css("display","none"); 
		$("#popupDiv").css("display","none"); 
		$("body").css("overflow","auto");//스크롤바 생성
	});
	
	$(".popup").click(function(event){
		console.log("closeBtn 클릭");
		$("#popup_mask").css("display","none"); 
		$("#popupDiv").css("display","none"); 
		$("body").css("overflow","auto");//스크롤바 생성
	});
	
	
	loadReplies();
	
	if(username){
		console.log(username);
		//로그인 회원이 좋아요 체크했는지 
		heartCheck(username,boardno);
	}else{
		console.log("가입 없음");
	}

	/* @@@@@@@@@@@@@@@@@@@@@@@@@@@@@밑에서부터 예찬 소스 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/
	
	// 처음 게시물 열 때 댓글 로드
	function loadReplies(){
		
		// 댓글 전체 프레임 지움 후 생성하여 붙임
		$('#repliesArea').remove();
		var repliesArea = "<div id='repliesArea'> </div>";
		$('#replyAttacher').append(repliesArea);
	    $('#replyAttacher').append(loadingImage);
		
		// 댓글 요청
		$.ajax({
			type : 'GET',
			url : '/rest/reply/' + '${boardVO.boardno}',
			dataType : 'json',
			data : {"boardHolder" : '${boardVO.username}'},
			success : function(response, httpstatus) {
				// 게시물에 댓글이 아예 없는 경우
				if(httpstatus == 'nocontent'){ 
					// 로딩 이미지 삭제
					$('#loadingImage').remove();
					return 0;
				}
				
				//해당 댓글에 볼 수 있는 댓글들
				for(var i in response.replies) {
					
					// 1차 댓글의 번호, 댓글쓴이, 내용 
					var parentReplyno = response.replies[i].parentReply.replyno;
					var parentUsername = response.replies[i].parentReply.username;
					var parentContent = response.replies[i].parentReply.content;

					// 1차 댓글 프레임
					var newParentReply ="<div id='reply" + parentReplyno + "'>"+
								    	"<span id='username'></span>"+
								   		"<span id='content'></span>"+
								  	 	"<span id='reReplyBtn'></span>"+
								  	 	"<div id='reReplyArea'></div>"+
								   		"</div>";
					
					// 1차 댓글영역에 댓글 프레임을 달고
					$('#repliesArea').append(newParentReply);
					
					// 댓글 영역 -> 1차 댓글 프레임 -> 댓글쓴이,내용, 댓글달기 버튼 innerHTML 표시 및 이벤트 설정
					$('#reply'+ parentReplyno).children('#username').append(parentUsername);
					$('#reply'+ parentReplyno).children('#content').append(parentContent);
					
					// 1차 댓글의 버튼이 없는 경우
					// 1. 자식댓글이 있는 경우 이거나
					// 2. 자식댓글이 없더라도 1차 댓글을 내가 쓴 경우
					if( (response.replies[i].childReplies.length == 0) && ('${pageContext.request.userPrincipal.name}' != parentUsername) ){
						
						// '댓글달기' 버튼 생성
						var reReplyBtn = document.createElement("input");
						reReplyBtn.type="button";
						reReplyBtn.value="댓글달기";
						
						$('#reply'+ parentReplyno).children('#reReplyBtn').append(reReplyBtn);
						// 1차 댓글의 createReply()인자는 자기 자신의 번호 -> 자식 댓글의 부모로 설정될 것
						$('#reply'+ parentReplyno).children('#reReplyBtn').click(function (){
							alert('부모 버튼');
							createReply(parentReplyno);
						});
					}
					
					// 만약 2차 댓글이 있으면
					if(response.replies[i].childReplies.length != 0){
						// 모든 i번째 1차 댓글에 대한 2차 댓글 j개를 돌면서
						for(var j in response.replies[i].childReplies) {
							// 2차 댓글의 번호, 댓글쓴이, 내용, 부모의 번호 저장
							var childReplyno = response.replies[i].childReplies[j].replyno;
							var childUsername = response.replies[i].childReplies[j].username;
							var childContent = response.replies[i].childReplies[j].content;
							// 2차 댓글 프레임
							var newChildReply = "<div id='reply" + childReplyno + "'>"+
										    	"<span id='username'></span>"+
										   		"<span id='content'></span>"+
										  	 	"<span id='reReplyBtn'></span>"+
										   		"</div>";
										   		
							// 댓글 영역 -> 1차 댓글 프레임 -> 2차 댓글 영역 -> 2차 댓글 프레임 달기
						    $('#reply'+ parentReplyno).children('#reReplyArea').append(newChildReply);
							
							// 댓글 영역 -> 1차 댓글 프레임 -> 2차 댓글 영역 -> 2차 댓글 프레임 -> 댓글쓴이,내용, 댓글달기 버튼 innerHTML 표시 및 이벤트 설정
						    $('#reply'+ childReplyno).children('#username').append(childUsername);
						    $('#reply'+ childReplyno).children('#content').append(childContent);
						   
						    // 2차 댓글 버튼이 없는 경우
						    // 1. 2차 댓글이 2개 이상일 때 마지막꺼 빼고 전부다
						    // 2. 마지막으로 내가 댓글을 단 경우(1개 달렸을 떄도 고려)
						    
						    //마지막 댓글의 경우
						    if( j == (response.replies[i].childReplies.length-1) ){
					    		if(response.replies[i].childReplies[j].username != '${pageContext.request.userPrincipal.name}'){
									// '댓글달기' 버튼 생성
									var reReplyBtn = document.createElement("input");
									reReplyBtn.type="button";
									reReplyBtn.value="댓글달기";
									
									$('#reply'+ childReplyno).children('#reReplyBtn').append(reReplyBtn);
							   
							   		// 2차 댓글의 createReply()인자는 자신과 관계된 1차 댓글의 번호와 자기 자신의 번호
							   		$('#reply'+ childReplyno).children('#reReplyBtn').click(function (){
								    	alert('자식 버튼');
								    	createReply(parentReplyno);
								    });
					    		}
						    }
						  }
						} // 2차 댓글 등록 종료
				
					} // 모든 댓글 등록 종료
					
				// 이 게시물에서의 비밀댓글 갯수(1차만 표현)
				var secretReplyCount = response.secretReplyCount;
				for(var i=0; i<secretReplyCount; i++)
					$('#repliesArea').append("<div style='color:#ff0000'>비밀댓글입니다</div>");
				
				// 로딩 이미지 삭제
				$('#loadingImage').remove();
			}, // success
			error : function(response) { // 실패시
				// 로딩 이미지 삭제
				$('#loadingImage').remove();
				alert("reply load Failed! " + response.status);
			}
		});
	}; // loadReplies()
	
	// 2차 댓글 입력창 만드는 함수
	// 1차 댓글 답글 -> 1차 댓글 번호가 인자
    // 2차 댓글 답글 -> 2차 댓글과 연관된 1차 댓글의 번호가 인자
    // 즉, 이 댓글이 만들어 질 때 무조건 parentno로 설정될 번호가 넘어온다.
	function createReply(parentReplyno){
		// 2차 댓글 입력 프레임 생성
		var childReplyInput = "<div id='inputReply'>"
		+ "<input id=newReplyText type='text'/>"
		+ "<input id=newReplySubmit type='button' value='2차달기'/>"
		+ "</div>";
		
		$('#repliesArea').find('#inputReply').remove();
		// 2차 댓글 입력 프레임 1차 댓글 맨 아래(2차 댓글 여러개 있으면 그 중 맨 아래)에 삽입
		$('#reply'+parentReplyno).children('#reReplyArea').append(childReplyInput);
		
		// 2차 댓글 입력 프레임에서 버튼 가져옴
		var sendBtn = $('#reply'+parentReplyno).children('#reReplyArea').children('#inputReply').children('#newReplySubmit');
		
		// 버튼에 리스너 설정
		sendBtn.click(function(){
			var content = $('#reply'+parentReplyno).children('#reReplyArea').children('#inputReply').children('#newReplyText').val();
			sendReply(content, parentReplyno);
		});
		
		
	}; // createReply()


	// 댓글 등록 요청  (댓글내용, 루트 댓글 번호(1차 댓글은 0))
	function sendReply(content, parentReplyno){
			var datas = {
							"reply" : {	
								"boardno" : '${boardVO.boardno}',
								"username" : username,
								"content" : content
							},
							"parentno" : parentReplyno
						};
			var jsonData = JSON.stringify(datas);
			
			$.ajax({
				method : 'POST',
				url : '/rest/reply/' + '${boardVO.boardno}',
				data : jsonData,
				contentType: "application/json",
				success : function(response){
					loadReplies();
				},
				error : function(response){
					if(response.status == "409") // CONFLICT
						alert('이미 댓글을 달아서 안된다');
					else if(response.status == "400") // BAD_REQUEST
						alert('로그인해라');
					else alert("sendReply실패");
				}
			});
	};    
});
	//회원 좋아요 체크상태 확인
	function heartCheck(username,boardno) {
	 $.ajax({
        url : "/board/heartCheck",
        type : 'get',
        data : {
          	boardno : boardno,
          	username : username
        },
        dataType : "text",
        success : function(result) {
     		if(result==="check"){
     			$('#heartClick').css("display","none"); 
      		    $('#heartCancle').css("display","block"); 
     		}else{
     			console.log("NoCheck");
     		}
        }
     });	
	 
	 
	 
	 
	 
}	 
	
	
	
</script>
</body>
</html>