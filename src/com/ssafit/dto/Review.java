package com.ssafit.dto;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class Review {
	private int no;
	private String content;
	private String writer;
	private String regTime;
	private String videoId;
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}	
	public String getVideoId() {
		return videoId;
	}
	public void setVideoId(String videoId) {
		this.videoId = videoId;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getTime() {
		return regTime;
	}
	public void setTime(String time) {
		this.regTime = time;
	}
	public Review(String content, String videoId) {
		this.content = content;
		this.writer = "익명";
		this.videoId = videoId;
	}
	public Review(int no, String content) {
		this.no = no;
		this.content = content;
	}
	public Review(String content, String writer, String videoId) {
		this.content = content;
		this.writer = writer;
		this.videoId = videoId;
	}
	public Review(int no, String content, String writer, String regTime, String videoId) {
		this.no = no;
		this.content = content;
		this.writer = writer;
		this.regTime = regTime;
		this.videoId = videoId;
	}
	
}
