<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>SSAFIT</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<link rel="stylesheet" href="../css/main.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
</head>
<body>
	<%@ include file="../include/header.jsp"%>
	<br>
	<main>
	<div class="container">
		<div class="d-flex">
			<!-- 검색 -->
			<input type="text" class="form-control" name="titleMovie"
				placeholder="제목을 입력하세요"> <input type="button"
				class="btn btn-outline-dark" value="검색"></input>
		</div>
		<br>
		<div>
			<h1>추천 영상</h1>
			<div class="d-flex flex-wrap">
				<div id="recommend-video-area" class="d-flex flex-wrap"></div>
			</div>
		</div>
		<br>
		<br>
		<h1>부위별 영상</h1>
		<div>
			<!-- 전체 영상을 보여 주고 부위 태그 클릭시 해당 관련 영상만 나열 -->
			<input style="border-radius: 20px;" class="part btn btn-outline-dark active"
				type="button" value="전체" data-bs-toggle="button" aria-pressed="true"> 
			<input style="border-radius: 20px;" class="part btn btn-outline-dark"
				type="button" value="전신" data-bs-toggle="button"> 
			<input style="border-radius: 20px;" class="part btn btn-outline-dark"
				type="button" value="상체" data-bs-toggle="button"> 
			<input	style="border-radius: 20px;" class="part btn btn-outline-dark"
				type="button" value="하체" data-bs-toggle="button"> 
			<input	style="border-radius: 20px;" class="part btn btn-outline-dark"
				type="button" value="복부" data-bs-toggle="button">
			<div class="d-flex flex-wrap">
				<!-- Test -->			
				<div id="video-area" class="d-flex flex-wrap"></div>
			</div>
		</div>
	</main>
	<%@ include file="../include/footer.jsp"%>
	<!-- JavaScript Bundle with Popper -->
	<script src="../js/main.js"></script>
	<script src="../js/join.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous"></script>
</body>
</html>