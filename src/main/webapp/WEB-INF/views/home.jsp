<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<html>
<head>
	<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/latest/css/bootstrap.min.css">
	<script src="http://code.jquery.com/jquery-1.10.2.js"></script> 
	<script src="//maxcdn.bootstrapcdn.com/bootstrap/latest/js/bootstrap.min.js"></script>
	<script src="/resource/masonry.pkgd.min.js"></script>
<style type="text/css">

@import url(//fonts.googleapis.com/css?family=Lato:300,400,700);

@font-face {
	font-family: 'codropsicons';
	src:url('../fonts/codropsicons/codropsicons.eot');
	src:url('../fonts/codropsicons/codropsicons.eot?#iefix') format('embedded-opentype'),
		url('../fonts/codropsicons/codropsicons.woff') format('woff'),
		url('../fonts/codropsicons/codropsicons.ttf') format('truetype'),
		url('../fonts/codropsicons/codropsicons.svg#codropsicons') format('svg');
	font-weight: normal;
	font-style: normal;
}

*, *:after, *:before { -webkit-box-sizing: border-box; -moz-box-sizing: border-box; box-sizing: border-box; }
body, html { font-size: 100%; padding: 0; margin: 0;}

/* Clearfix hack by Nicolas Gallagher: http://nicolasgallagher.com/micro-clearfix-hack/ */
.clearfix:before, .clearfix:after { content: " "; display: table; }
.clearfix:after { clear: both; }

body {
	font-family: 'Lato', Calibri, Arial, sans-serif;
	color: #6b7381;
	background: #f2f2f2;
}

a {
	color: #aaa;
	text-decoration: none;
}

a:hover,
a:active {
	color: #333;
}

/* Header Style */
.container > header {
	margin: 0 auto;
	padding: 2em;
}

.container > header {
	text-align: center;
	background: rgba(0,0,0,0.01);
}

.container > header h1 {
	font-size: 2.625em;
	line-height: 1.3;
	margin: 0;
	font-weight: 300;
}

.container > header span {
	display: block;
	font-size: 60%;
	opacity: 0.8;
	padding: 0 0 0.6em 0.1em;
}

/* To Navigation Style */
.codrops-top {
	background: #fff;
	background: rgba(255, 255, 255, 0.8);
	text-transform: uppercase;
	width: 100%;
	font-size: 0.69em;
	line-height: 2.2;
}

.codrops-top a {
	padding: 0 1em;
	letter-spacing: 0.1em;
	color: #6b7381;
	display: inline-block;
}

.codrops-top a:hover {
	color: #424b5a;
	background: rgba(255,255,255,1);
}

.codrops-top span.right {
	float: right;
}

.codrops-top span.right a {
	float: left;
	display: block;
}

.codrops-icon:before {
	font-family: 'codropsicons';
	margin: 0 4px;
	speak: none;
	font-style: normal;
	font-weight: normal;
	font-variant: normal;
	text-transform: none;
	line-height: 1;
	-webkit-font-smoothing: antialiased;
}

.codrops-icon-drop:before {
	content: "\e001";
}

.codrops-icon-prev:before {
	content: "\e004";
}

/* Demo Buttons Style */
.codrops-demos {
	padding-top: 1em;
	font-size: 0.9em;
}

.codrops-demos a {
	display: inline-block;
	margin: 0.5em;
	padding: 0.7em 1.1em;
	border: 3px solid #6b7381;
	color: #6b7381;
	font-weight: 700;
}

.codrops-demos a:hover,
.codrops-demos a.current-demo,
.codrops-demos a.current-demo:hover {
	opacity: 0.6;
}

@media screen and (max-width: 25em) {

	.codrops-icon span {
		display: none;
	}

}

.grid {
	max-width: 69em;
	list-style: none;
	margin: 30px auto;
	padding: 0;
}

.grid li {
	display: block;
	float: left;
	padding: 7px;
	width: 30%;
	opacity: 0;
}

.grid li.shown,
.no-js .grid li,
.no-cssanimations .grid li {
	opacity: 1;
}

.grid li a,
.grid li img {
	outline: none;
	border: none;
	display: block;
	max-width: 100%;
}

/* Effect 1: opacity */
.grid.effect-1 li.animate {
	-webkit-animation: fadeIn 0.65s ease forwards;
	animation: fadeIn 0.65s ease forwards;
}

@-webkit-keyframes fadeIn {
	0% { }
	100% { opacity: 1; }
}

@keyframes fadeIn {
	0% { }
	100% { opacity: 1; }
}

/* Effect 2: Move Up */
.grid.effect-2 li.animate {
	-webkit-transform: translateY(200px);
	transform: translateY(200px);
	-webkit-animation: moveUp 0.65s ease forwards;
	animation: moveUp 0.65s ease forwards;
}

@-webkit-keyframes moveUp {
	0% { }
	100% { -webkit-transform: translateY(0); opacity: 1; }
}

@keyframes moveUp {
	0% { }
	100% { -webkit-transform: translateY(0); transform: translateY(0); opacity: 1; }
}

/* Effect 3: Scale up */
.grid.effect-3 li.animate {
	-webkit-transform: scale(0.6);
	transform: scale(0.6);
	-webkit-animation: scaleUp 0.65s ease-in-out forwards;
	animation: scaleUp 0.65s ease-in-out forwards;
}

@-webkit-keyframes scaleUp {
	0% { }
	100% { -webkit-transform: scale(1); opacity: 1; }
}

@keyframes scaleUp {
	0% { }
	100% { -webkit-transform: scale(1); transform: scale(1); opacity: 1; }
}

/* Effect 4: fall perspective */
.grid.effect-4 {
	-webkit-perspective: 1300px;
	perspective: 1300px;
}

.grid.effect-4 li.animate {
	-webkit-transform-style: preserve-3d;
	transform-style: preserve-3d;
	-webkit-transform: translateZ(400px) translateY(300px) rotateX(-90deg);
	transform: translateZ(400px) translateY(300px) rotateX(-90deg);
	-webkit-animation: fallPerspective .8s ease-in-out forwards;
	animation: fallPerspective .8s ease-in-out forwards;
}

@-webkit-keyframes fallPerspective {
	0% { }
	100% { -webkit-transform: translateZ(0px) translateY(0px) rotateX(0deg); opacity: 1; }
}

@keyframes fallPerspective {
	0% { }
	100% { -webkit-transform: translateZ(0px) translateY(0px) rotateX(0deg); transform: translateZ(0px) translateY(0px) rotateX(0deg); opacity: 1; }
}

/* Effect 5: fly (based on http://lab.hakim.se/scroll-effects/ by @hakimel) */
.grid.effect-5 {
	-webkit-perspective: 1300px;
	perspective: 1300px;
}

.grid.effect-5 li.animate {
	-webkit-transform-style: preserve-3d;
	transform-style: preserve-3d;
	-webkit-transform-origin: 50% 50% -300px;
	transform-origin: 50% 50% -300px;
	-webkit-transform: rotateX(-180deg);
	transform: rotateX(-180deg);
	-webkit-animation: fly .8s ease-in-out forwards;
	animation: fly .8s ease-in-out forwards;
}

@-webkit-keyframes fly {
	0% { }
	100% { -webkit-transform: rotateX(0deg); opacity: 1; }
}

@keyframes fly {
	0% { }
	100% { -webkit-transform: rotateX(0deg); transform: rotateX(0deg); opacity: 1; }
}

/* Effect 6: flip (based on http://lab.hakim.se/scroll-effects/ by @hakimel) */
.grid.effect-6 {
	-webkit-perspective: 1300px;
	perspective: 1300px;
}

.grid.effect-6 li.animate {
	-webkit-transform-style: preserve-3d;
	transform-style: preserve-3d;
	-webkit-transform-origin: 0% 0%;
	transform-origin: 0% 0%;
	-webkit-transform: rotateX(-80deg);
	transform: rotateX(-80deg);
	-webkit-animation: flip .8s ease-in-out forwards;
	animation: flip .8s ease-in-out forwards;
}

@-webkit-keyframes flip {
	0% { }
	100% { -webkit-transform: rotateX(0deg); opacity: 1; }
}

@keyframes flip {
	0% { }
	100% { -webkit-transform: rotateX(0deg); transform: rotateX(0deg); opacity: 1; }
}

/* Effect 7: helix (based on http://lab.hakim.se/scroll-effects/ by @hakimel) */
.grid.effect-7 {
	-webkit-perspective: 1300px;
	perspective: 1300px;
}

.grid.effect-7 li.animate {
	-webkit-transform-style: preserve-3d;
	transform-style: preserve-3d;
	-webkit-transform: rotateY(-180deg);
	transform: rotateY(-180deg);
	-webkit-animation: helix .8s ease-in-out forwards;
	animation: helix .8s ease-in-out forwards;
}

@-webkit-keyframes helix {
	0% { }
	100% { -webkit-transform: rotateY(0deg); opacity: 1; }
}

@keyframes helix {
	0% { }
	100% { -webkit-transform: rotateY(0deg); transform: rotateY(0deg); opacity: 1; }
}

/* Effect 8:  */
.grid.effect-8 {
	-webkit-perspective: 1300px;
	perspective: 1300px;
}

.grid.effect-8 li.animate {
	-webkit-transform-style: preserve-3d;
	transform-style: preserve-3d;
	-webkit-transform: scale(0.4);
	transform: scale(0.4);
	-webkit-animation: popUp .8s ease-in forwards;
	animation: popUp .8s ease-in forwards;
}

@-webkit-keyframes popUp {
	0% { }
	70% { -webkit-transform: scale(1.1); opacity: .8; -webkit-animation-timing-function: ease-out; }
	100% { -webkit-transform: scale(1); opacity: 1; }
}

@keyframes popUp {
	0% { }
	70% { -webkit-transform: scale(1.1); transform: scale(1.1); opacity: .8; -webkit-animation-timing-function: ease-out; animation-timing-function: ease-out; }
	100% { -webkit-transform: scale(1); transform: scale(1); opacity: 1; }
}

@media screen and (max-width: 900px) {
	.grid li {
		width: 50%;
	}
}


@media screen and (max-width: 400px) {
	.grid li {
		width: 100%;
	}
}


</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

</head>
<body>

	<%-- <div class="container">
		<c:forEach items="${boardList}" var="board" > 
		  <div class="item"><a href="/board/read?boardno=${board.boardno}" style="width: 100%; height: 100%"><img src='/displayFile?fileName=${board.photo}' width="100%" height="100%"></a></div>
      <div class="item">
      <a href="/board/read?boardno=${board.boardno}" style="width: 100%; height: 100%"><img src='/displayFile?fileName=${board.photo}' width="100%" height="100%"></a>
      </div>
      <div class="item thumbnail">
      <a href="/board/read?boardno=${board.boardno}" style="width: 100%; height: 100%"><img src='/displayFile?fileName=${board.photo}' width="100%" height="100%"></a>
      </div>
      <div class="item medium">
      <a href="/board/read?boardno=${board.boardno}" style="width: 100%; height: 100%"><img src='/displayFile?fileName=${board.photo}' width="100%" height="100%"></a>
      </div>
      <div class="item">
      <a href="/board/read?boardno=${board.boardno}" style="width: 100%; height: 100%"><img src='/displayFile?fileName=${board.photo}' width="100%" height="100%"></a>
      </div>
      <div class="item large">
      <a href="/board/read?boardno=${board.boardno}" style="width: 100%; height: 100%"><img src='/displayFile?fileName=${board.photo}' width="100%" height="100%"></a>
      </div>
      <div class="item">
      <a href="/board/read?boardno=${board.boardno}" style="width: 100%; height: 100%"><img src='/displayFile?fileName=${board.photo}' width="100%" height="100%"></a>
      </div>
      <div class="item medium">
      <a href="/board/read?boardno=${board.boardno}" style="width: 100%; height: 100%"><img src='/displayFile?fileName=${board.photo}' width="100%" height="100%"></a>
      </div>
		
		</c:forEach> 
	</div> --%>
	
	<ul  id="grid" class="grid effect-8">
	<c:forEach items="${boardList}" var="board" > 
		<li class="shown"><a href="/board/read?boardno=${board.boardno}"><img src='/displayFile?fileName=${board.photo}'></a></li>
	</c:forEach> 
	
	</ul>
	
	<a href="/board/register">글쓰기</a>
	
	<!-- <script src="http://code.jquery.com/jquery-1.10.2.js"></script>  -->
	<script type="text/javascript">
	 $(document).ready(function () {  
		$(".grid").masonry({ 
		itemSelector:'.shown',
		columnWidth: 40
		}); 
	});  
	</script>
			
</body>
</html>