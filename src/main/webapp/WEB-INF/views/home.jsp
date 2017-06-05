<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<html>
<head>
	
	<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/latest/css/bootstrap.min.css">
	<script src="http://code.jquery.com/jquery-1.10.2.js"></script> 
	<script src="//maxcdn.bootstrapcdn.com/bootstrap/latest/js/bootstrap.min.js"></script>
	<script src="/resource/masonry.pkgd.min.js"></script>
	<link href="<c:url value="/resource/css/main.css" />" rel="stylesheet">

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

</head>
<body>
	<div style="width: 100%; height: 400px; background-color: black"> 
		
	 </div> 
	
	<ul id="grid" class="grid effect-8">
	<c:forEach items="${boardList}" var="board" > 
		<li class="shown"><a href="/board/read?boardno=${board.boardno}">
			<img src='/displayFile?fileName=${board.photo}'>
			<label>${board.title}</label>
			</a>
		</li>
	</c:forEach> 
	</ul>
	
	<br>
	<br>
	<br>
	<a href="/board/register">글쓰기</a>
	
	<!-- <script src="http://code.jquery.com/jquery-1.10.2.js"></script>  -->
	<script type="text/javascript">
	 $(document).ready(function () {  
		 
			setTimeout(function(){
				$(".grid").masonry({ 
					itemSelector:'.shown',
					columnWidth: 40
					}); 
				
			}, 1);


			
	/* 	$('#bbbb').trigger("click");
		
		$("#bbbb").click(function(event) {
			$(".grid").masonry({ 
				itemSelector:'.shown',
				columnWidth: 40
				}); 
			
		}) */
	 
	});  
	</script>
			
</body>
</html>