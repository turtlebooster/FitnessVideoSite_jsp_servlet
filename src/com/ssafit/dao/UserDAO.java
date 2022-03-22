package com.ssafit.dao;

import java.util.ArrayList;
import java.util.List;

import com.ssafit.dto.User;

public interface UserDAO {
	int idCheckSame(String id);
	void insertUser(User user);
	String selectUserByIdAndPassword(User user);
}
