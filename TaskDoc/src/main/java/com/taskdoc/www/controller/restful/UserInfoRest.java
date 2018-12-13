package com.taskdoc.www.controller.restful;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.taskdoc.www.database.dto.UserInfoVO;
import com.taskdoc.www.service.userinfo.UserInfoService;

@RestController
@RequestMapping("/userinfo")
public class UserInfoRest {

	@Autowired
	UserInfoService service;
	
	//중복검사 , 유저정보 수정시 보여줄 정보
	@RequestMapping(value = "/{uid}", method = RequestMethod.GET)
	public UserInfoVO view(@PathVariable String uid) {
		return service.userInfoView(uid);
	}
	
	//로그인
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public int loginUser(@RequestBody UserInfoVO userInfoVo) {
		return service.loginUser(userInfoVo);
	}
	
	//회원가입
	@RequestMapping(value = "", method = RequestMethod.POST)
	public int insert(@RequestBody UserInfoVO userInfoVo) {
		return service.insertUserInfo(userInfoVo);
	}
	
	//유저정보 수정
	@RequestMapping(value = "", method = RequestMethod.PUT)
	public int update(@RequestBody UserInfoVO userInfoVo) {
		return service.updateUserInfo(userInfoVo);
	}
	
	//회원 탈퇴
	@RequestMapping(value = "/{uid}", method = RequestMethod.DELETE)
	public int delete(@PathVariable String uid) {
		return service.deleteUserInfo(uid);
	}
}
