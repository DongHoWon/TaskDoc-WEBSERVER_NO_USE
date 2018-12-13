package com.taskdoc.www.service.userinfo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.taskdoc.www.database.dao.userinfo.UserInfoDAO;
import com.taskdoc.www.database.dto.UserInfoVO;

@Service("UserInfoService")
public class UserInfoServiceImpl implements UserInfoService {

	@Autowired
	UserInfoDAO dao;

	@Override
	public UserInfoVO userInfoView(String userId) {
		// TODO Auto-generated method stub
		return dao.userInfoView(userId);
	}

	@Override
	public int loginUser(UserInfoVO userInfoVo) {
		// TODO Auto-generated method stub

		UserInfoVO storageUserInfo = dao.userInfoView(userInfoVo.getUid());

		if (storageUserInfo == null) {
			// ID is Null
			return -1;
		} else if (!storageUserInfo.getUpasswd().equals(userInfoVo.getUpasswd())) {
			// PW check Fail
			return -2;
		}

		return 1;
	}

	@Override
	public int insertUserInfo(UserInfoVO userInfoVo) {
		// TODO Auto-generated method stub
		return dao.insertUserInfo(userInfoVo);
	}

	@Override
	public int updateUserInfo(UserInfoVO userInfoVo) {
		// TODO Auto-generated method stub
		return dao.updateUserInfo(userInfoVo);
	}

	@Override
	public int deleteUserInfo(String userId) {
		// TODO Auto-generated method stub
		return dao.deleteUserInfo(userId);
	}

}
