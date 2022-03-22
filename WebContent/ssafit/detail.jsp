<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${video.title}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" 
    integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <link rel="stylesheet" href="../css/main.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
</head>
<body class="d-flex flex-column">
 	<%@ include file="../include/header.jsp"%>
    <br>
    <main>
        <!-- 해당하는 유튜브 영상 보여주고 리뷰목록까지-->
        <div class="container">
            <h1>영상 보기</h1>
            <div style="position:relative; padding-bottom:56.25%; padding-top:30px; height:0; overflow:hidden;">
              <iframe style="position:absolute; top:0; left:0; width:100%; height:100%;" width="100%" height="315" src="https://www.youtube.com/embed/${video.id }" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
            </div>
            <br>
            <h1>리뷰목록</h1>
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal" data-bs-whatever="@mdo">리뷰 쓰기</button>
			
			<!-- 리뷰 작성 모달  -->
            <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
              <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                  <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">리뷰 작성</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                  </div>
                  <form action="main?action=insertReview&videoId=${video.id}" method="post">
	                  <div class="modal-body">
	                      <div class="mb-3">
	                        <label for="message-text" class="col-form-label">내용 입력</label>
	                        <input type="text" name="content" class="form-control" id="message-text"></input>
	                      </div>
	                  </div>
	                  <div class="modal-footer">
	                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
	                    <input type="submit" class="btn btn-primary" value="등록"></input>
	                  </div>
               	  </form>
                </div>
              </div>
            </div>
            <table class="table">
                <thead>
                  <tr>
                    <!-- <th scope="col">#</th> -->
                    <th scope="col" style="width: 90rem;">내용</th>
                    <th scope="col" style="width: 200px;">작성자</th>
                    <th scope="col" style="width: 280px;">작성시간</th>
                    <th scope="col" style="width: 200px;"></th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="r" items="${reviewList}">
                  <tr>
                    <td>${r.content}</td>
                    <td>${r.writer}</td>
                    <td>${r.time}</td>
                    <c:if test="${not empty userId && userId eq r.writer}">
	                    <td><i class="bi bi-pencil btn btn-outline-dark" data-bs-toggle="modal" data-bs-target="#replace-review-${r.no}" data-bs-whatever="@mdo"></i>
	                     / <a href="main?action=deleteReview&videoId=${video.id}&no=${r.no}"><i class="bi bi-x-lg btn btn-outline-dark"></i></a></td>
                    </c:if>
                  </tr>
                  </c:forEach>
                </tbody>                 

                  <!-- 리뷰 수정 Modal -->
                  <c:forEach var="r" items="${reviewList}">
	                  <div class="modal fade" id="replace-review-${r.no}" tabindex="-1" aria-labelledby="replace-reviewLabel" aria-hidden="true">
	                    <div class="modal-dialog modal-dialog-centered">
	                      <div class="modal-content">
	                        <div class="modal-header">
	                          <h5 class="modal-title" id="replace-reviewLabel">리뷰 수정</h5>
	                          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	                        </div>
	                        <form action="main?action=updateReview&videoId=${video.id}&no=${r.no}" method="post">
		                        <div class="modal-body">
		                            <div class="mb-3">
		                              <label for="message-text" class="col-form-label">내용 입력</label>
		                              <textarea name="content" class="form-control" id="message-text"></textarea>
		                            </div>
		                        </div>
		                        <div class="modal-footer">
		                          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
		                          <input type="hidden" name="action" value="updateReview">
		                          <input type="submit" class="btn btn-primary" value="수정"></input>
		                        </div>
	                        </form>
	                      </div>
	                    </div>
	                  </div>
                  </c:forEach>
            </table>

            <nav aria-label="Page navigation example">
              <ul class="pagination justify-content-center">
                <li class="page-item">
                  <a class="page-link" href="#" aria-label="Previous">
                    <span aria-hidden="true">&laquo;</span>
                  </a>
                </li>
                <li class="page-item"><a class="page-link" href="#">1</a></li>
                <li class="page-item"><a class="page-link" href="#">2</a></li>
                <li class="page-item"><a class="page-link" href="#">3</a></li>
                <li class="page-item">
                  <a class="page-link" href="#" aria-label="Next">
                    <span aria-hidden="true">&raquo;</span>
                  </a>
                </li>
              </ul>
            </nav>

        </div>
    </main>
    <%@ include file="../include/footer.jsp"%>
    <!-- JavaScript Bundle with Popper -->
    <script src="../js/join.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" 
    crossorigin="anonymous"></script>
</body>
</html>