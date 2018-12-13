package com.taskdoc.www.service.userinfo;

import com.taskdoc.www.database.dto.UserInfoVO;

public interface UserInfoService {
	public UserInfoVO userInfoView(String userId);
	public int loginUser(UserInfoVO userInfoVo);
	public int insertUserInfo(UserInfoVO userInfoVo);
	public int updateUserInfo(UserInfoVO userInfoVo);
	public int deleteUserInfo(String userId);
}
