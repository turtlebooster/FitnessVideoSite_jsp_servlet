package com.ssafit.dao;

import java.util.ArrayList;
import java.util.List;

import com.ssafit.dto.Video;

public interface VideoDAO {
	List<Video> selectVideo();
	Video selectVideoById(String videoId);
	void updateViewCnt(Video video);
}
