<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<header>
		<!-- 상단 메뉴 -->
		<nav class="navbar navbar-expand-lg navbar-light bg-light">
			<div class="container-fluid">
				<a href="../ssafit/main.jsp" class="navbar-brand" style="font-size: 2rem;">SSAFIT</a>
				<button class="navbar-toggler" type="button"
					data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
					aria-controls="navbarSupportedContent" aria-expanded="false"
					aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div>
					<ul class="nav justify-content-end">
						<li class="nav-item"><a href="../ssafit/main.jsp" class="nav-link active"
							aria-current="page"><i class="bi bi-house-door"></i></a>
						</li>
						
						<c:choose>
							<c:when test="${empty userId}">
								<!-- 회원가입 -->
								<li class="nav-item"><a class="nav-link"
									data-bs-toggle="modal" data-bs-target="#joinModal"
									data-bs-whatever="@mdo" href="#">JOIN</a></li>
								<!-- 로그인 -->
								<li class="nav-item"><a class="nav-link"
									data-bs-toggle="modal" data-bs-target="#loginModal"
									data-bs-whatever="@mdo" href="#"><i
										class="bi bi-box-arrow-in-right"></i></a></li>
							</c:when>
							<c:otherwise>
								<li class="nav-item">
									<form action="main" method="post" >
										<input type="hidden" name="action" value="login">
										<button name="status" value="out" class="btn btn-outline-danger" type="submit">LogOut</button>
									</form>
								</li>
							</c:otherwise>
						</c:choose>
					</ul>
				</div>
			</div>
		</nav>
		
		<form method="post" action="main" >
			<!-- 회원가입 모달 -->
			<div class="modal fade" id="joinModal" data-bs-backdrop="static"
				tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel">회원가입</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<div class="input-group flex-nowrap">
								<span class="input-group-text" id="addon-wrapping"><i
									class="bi bi-vector-pen"></i></span> <input id="joinId" name="joinId" type="text"
									class="form-control" placeholder="아이디를 입력하세요"
									aria-label="Username" aria-describedby="addon-wrapping">
							</div>
							<div id="idCheckMsg"></div>
							<br>
							<div class="input-group flex-nowrap">
								<span class="input-group-text" id="addon-wrapping"><i
									class="bi bi-envelope"></i></span> <input name="joinEmail" type="text"
									class="form-control" placeholder="이메일을 입력하세요"
									aria-label="Username" aria-describedby="addon-wrapping">
							</div>
							<br>
							<div class="input-group flex-nowrap">
								<span class="input-group-text" id="addon-wrapping"><i
									class="bi bi-key"></i></span> <input name="joinPass" type="text" class="form-control"
									placeholder="비밀번호를 입력하세요" aria-label="Username"
									aria-describedby="addon-wrapping">
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-primary"
									data-bs-toggle="modal" data-bs-target="#finishModal"
									data-bs-whatever="@mdo">가입</button>
							<input type="hidden" name="action" value="join">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">닫기</button>
						</div>						
					</div>
				</div>
			</div>
	
			<!-- finish 모달-->
			<div class="modal fade" id="finishModal" data-bs-backdrop="static" tabindex="-1"
				aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel"></h5>
						</div>
						<div class="modal-body">회원가입이 완료되었습니다!</div>
						<div class="modal-footer">
							<button type="submit" class="btn btn-primary"
								data-bs-dismiss="modal">닫기</button>
						</div>
					</div>
				</div>
			</div>
		</form>
		
		<!-- 로그인 모달 -->
		<div class="modal fade" id="loginModal" data-bs-backdrop="static"
			tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">로그인</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<form method="post" action="main">
						<div class="modal-body">
								<div class="input-group flex-nowrap">
									<span class="input-group-text" id="addon-wrapping"><i
										class="bi bi-vector-pen"></i></span> <input name="userId" type="text"
										class="form-control" placeholder="아이디를 입력하세요"
										aria-label="UserId" aria-describedby="addon-wrapping">
								</div>
								<br>
								<div class="input-group flex-nowrap">
									<span class="input-group-text" id="addon-wrapping"><i
										class="bi bi-key"></i></span> <input name="userPass" type="text" class="form-control"
										placeholder="비밀번호를 입력하세요" aria-label="UserPass"
										aria-describedby="addon-wrapping">
								</div>
						</div>
						<div class="modal-footer">
							<input type="hidden" name="action" value="login">
							<button name="status" value="in" type="submit" class="btn btn-primary">로그인</button>
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">닫기</button>
						</div>
					</form>
				</div>
			</div>
		</div>

		<!-- header부분 이미지 슬라이드-->
		<div id="carouselExampleControls" class="carousel slide"
			data-bs-ride="carousel">
			<div class="carousel-inner">
				<div class="carousel-item">
					<img src="../data/main.jpg" class="d-block w-100" alt="..."
						height="300px">
				</div>
				<div class="carousel-item active">
					<img src="../data/health.jpg" class="d-block w-100" alt="..."
						height="300px">
				</div>
				<div class="carousel-item">
					<img src="../data/yoga.jpg" class="d-block w-100" alt="..."
						height="300px">
				</div>
				<div class="carousel-item">
					<img src="../data/machine.jpg" class="d-block w-100" alt="..."
						height="300px">
				</div>
			</div>
			<button class="carousel-control-prev" type="button"
				data-bs-target="#carouselExampleControls" data-bs-slide="prev">
				<span class="carousel-control-prev-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Previous</span>
			</button>
			<button class="carousel-control-next" type="button"
				data-bs-target="#carouselExampleControls" data-bs-slide="next">
				<span class="carousel-control-next-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Next</span>
			</button>
		</div>
	</header>