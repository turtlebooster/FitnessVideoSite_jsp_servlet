package com.ssafit.dao;

import java.util.ArrayList;
import java.util.List;

import com.ssafit.dto.Review;

public interface ReviewDAO {
	
	List<Review> selectReview(String videoId);
	void updateReview(Review review);
	void deleteReview(int no);
	void insertReview(Review review);
	
}
