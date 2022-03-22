package com.ssafit.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.ssafit.common.db.MyAppSqlConfig;
import com.ssafit.dao.ReviewDAO;
import com.ssafit.dao.UserDAO;
import com.ssafit.dao.VideoDAO;
import com.ssafit.dto.Review;
import com.ssafit.dto.User;
import com.ssafit.dto.Video;

@WebServlet("/ssafit/main")
public class MainServlet extends HttpServlet {

	/**
	 * get 방식의 요청에 대해 응답하는 메서드이다. front controller pattern을 적용하기 위해 내부적으로 process를
	 * 호출한다.
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		process(request, response);
	}

	/**
	 * post 방식의 요청에 대해 응답하는 메서드이다. front controller pattern을 적용하기 위해 내부적으로 process를
	 * 호출한다.
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// post 요청 시 한글 파라미터의 처리를 위해 encoding을 처리한다.
		request.setCharacterEncoding("utf-8");
		process(request, response);
	}

	/**
	 * request 객체에서 action 파라미터를 추출해서 실제 비지니스 로직 메서드(ex: doRegist) 호출해준다.
	 */
	private void process(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");
//		System.out.println(action);
		switch (action) {
		case "list":
			doList(request, response);
			break;
		case "detail":
			doDetail(request, response);
			break;
		case "idCheck":
			doIdCheck(request, response);
			break;
		case "join":
			doJoin(request, response);
			break;
		case "login":
			doLogin(request, response);
			break;
		case "updateReview":
			doUpdateReview(request, response);
			break;
		case "deleteReview":
			doDeleteReview(request, response);
			break;
		case "insertReview":
			doInsertReview(request, response);
			break;
		}
	}

	// ajax 연동
	// 메인 페이지에 필요한 비디오 리스트 넘겨주기
	public void doList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 비디오 아이디에 해당하는 영상데이터(video객체)를 가져오기 -> findVideo
		List<Video> list = MyAppSqlConfig.getSqlSessionInstance().getMapper(VideoDAO.class).selectVideo();

		// 공유영역에 데이터 올려주기
		response.setContentType("application/json; charset=utf-8");
		response.getWriter().println(new Gson().toJson(list));

	}
	
	// 비디오 눌렀을때 영상 재생화면으로 이동
	public void doDetail(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 비디오 아이디에 해당하는 영상데이터(video객체)를 가져오기 -> findVideo
		Video video = MyAppSqlConfig.getSqlSessionInstance().getMapper(VideoDAO.class).selectVideoById(request.getParameter("videoId"));

		// 조회수 하나 늘리기
		video.setViewCnt(video.getViewCnt() + 1);
		MyAppSqlConfig.getSqlSessionInstance().getMapper(VideoDAO.class).updateViewCnt(video);
		// 리뷰 내용 가져오기

		// 공유영역에 데이터 올려주기
		request.setAttribute("video", video);
		request.setAttribute("reviewList", MyAppSqlConfig.getSqlSessionInstance().getMapper(ReviewDAO.class).selectReview(video.getId()));

		// 영상 상세보기 페이지로 이동하기
		RequestDispatcher rd = request.getRequestDispatcher("detail.jsp");
		rd.forward(request, response);
	}

	// 회원가입 모달에서 아이디 중복 체크(유효성검사) - ajax
	public void doIdCheck(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String id = request.getParameter("joinId");
		String msg = "success";
		if (MyAppSqlConfig.getSqlSessionInstance().getMapper(UserDAO.class).idCheckSame(id) != 0) {
			msg = "fail";
		}
		response.setContentType("text/plain; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.print(msg);
		out.close();
	}

	// 회원가입
	public void doJoin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		MyAppSqlConfig.getSqlSessionInstance().getMapper(UserDAO.class).insertUser(new User(request.getParameter("joinId"), request.getParameter("joinPass"),
				request.getParameter("joinEmail")));

		response.sendRedirect("main.jsp");
	}

	// 로그인
	public void doLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 로그인
		if (request.getParameter("status").equals("in")) {
			String userId = MyAppSqlConfig.getSqlSessionInstance().getMapper(UserDAO.class).selectUserByIdAndPassword(
					new User(request.getParameter("userId"), request.getParameter("userPass")));
			System.out.println(userId);
			if (userId != null) {
				request.getSession().setAttribute("userId", userId);
			}
		} else { // 로그아웃
			request.getSession().invalidate();
		}
		response.sendRedirect("main.jsp");
	}

	// 리뷰 수정
	public void doUpdateReview(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");

//		Video video = MyAppSqlConfig.getSqlSessionInstance().getMapper(VideoDAO.class).selectVideoById(request.getParameter("videoId"));

		// 리뷰 목록에 리뷰 수정
		MyAppSqlConfig.getSqlSessionInstance().getMapper(ReviewDAO.class).updateReview(
				new Review(Integer.parseInt(request.getParameter("no")) 
				,request.getParameter("content")));

		// 공유영역에 데이터 올려주기
		Video video = MyAppSqlConfig.getSqlSessionInstance().getMapper(VideoDAO.class).selectVideoById(request.getParameter("videoId"));
		request.setAttribute("video", video);
		request.setAttribute("reviewList", MyAppSqlConfig.getSqlSessionInstance().getMapper(ReviewDAO.class).selectReview(video.getId()));
		// 영상 상세보기 페이지로 이동하기
		RequestDispatcher rd = request.getRequestDispatcher("detail.jsp");
		rd.forward(request, response);
	}
	
	// 리뷰 삭제
	public void doDeleteReview(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

//		Video video = VideoDAO.getInstance().findVideo(request.getParameter("videoId"));

		// 리뷰 목록에 리뷰 삭제
		MyAppSqlConfig.getSqlSessionInstance().getMapper(ReviewDAO.class)
			.deleteReview(Integer.parseInt(request.getParameter("no")));

		// 공유영역에 데이터 올려주기
		Video video = MyAppSqlConfig.getSqlSessionInstance().getMapper(VideoDAO.class).selectVideoById(request.getParameter("videoId"));
		request.setAttribute("video", video);
		request.setAttribute("reviewList", MyAppSqlConfig.getSqlSessionInstance().getMapper(ReviewDAO.class).selectReview(video.getId()));

		// 영상 상세보기 페이지로 이동하기
		RequestDispatcher rd = request.getRequestDispatcher("detail.jsp");
		rd.forward(request, response);
	}

	// 리뷰 등록
	public void doInsertReview(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		request.setCharacterEncoding("utf-8");
		
		
//		Video video = VideoDAO.getInstance().findVideo(request.getParameter("videoId"));
		
		// 리뷰 목록에 리뷰 추가
		System.out.println(request.getParameter("videoId"));
		if (request.getSession().getAttribute("userId") == null) {
			MyAppSqlConfig.getSqlSessionInstance().getMapper(ReviewDAO.class).insertReview(
					new Review(request.getParameter("content"), request.getParameter("videoId"))
					);			
		} else {
			MyAppSqlConfig.getSqlSessionInstance().getMapper(ReviewDAO.class).insertReview(
					new Review(request.getParameter("content"), (String)request.getSession().getAttribute("userId"), request.getParameter("videoId"))
					);
		}
		
		// 공유영역에 데이터 올려주기
		Video video = MyAppSqlConfig.getSqlSessionInstance().getMapper(VideoDAO.class).selectVideoById(request.getParameter("videoId"));
		request.setAttribute("video", video);
		request.setAttribute("reviewList", MyAppSqlConfig.getSqlSessionInstance().getMapper(ReviewDAO.class).selectReview(video.getId()));
		
		// 영상 상세보기 페이지로 이동하기
		RequestDispatcher rd = request.getRequestDispatcher("detail.jsp");
		rd.forward(request, response);

	}
}
