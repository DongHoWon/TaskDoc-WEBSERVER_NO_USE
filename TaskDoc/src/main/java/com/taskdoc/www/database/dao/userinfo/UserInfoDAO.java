package com.taskdoc.www.database.dao.userinfo;

import com.taskdoc.www.database.dto.UserInfoVO;

public interface UserInfoDAO {
	public UserInfoVO userInfoView(String userId);
	public int insertUserInfo(UserInfoVO userInfoVo);
	public int updateUserInfo(UserInfoVO userInfoVo);
	public int deleteUserInfo(String userId);
}
