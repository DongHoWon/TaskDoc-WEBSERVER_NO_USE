package com.taskdoc.www.controller.http;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/user")
public class User {
	private static final Logger logger = LoggerFactory.getLogger(User.class);

	/*
	 * 1.로그인 , 로그아웃, 회원가입, 회원정보수정
	 *
	 */

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String userLogin() {
		return "/user/login";
	}

	@RequestMapping(value = "/loginComplete", method = RequestMethod.GET)
	public String loginComplete(HttpServletRequest req, HttpSession session) {
		String id = req.getParameter("uid");
		session.setAttribute("loginid", id);
		logger.info("세션은 : {}", session.getAttribute("loginid"));
		System.out.println(session.getAttribute("loginid"));
		return "redirect:/project/main";
	}

	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String userLogout(HttpSession session) {
		logger.info("세션 제거 전:{} ", session.getAttribute("loginid"));
		session.removeAttribute("loginid");
		logger.info("세션 제거 후:{} ", session.getAttribute("loginid"));
		return "redirect:/";
	}

	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public String join() {
		return "/user/join";
	}

	@RequestMapping(value = "/infoEdit", method = RequestMethod.GET)
	public String infoEdit() {
		return "/user/infoEdit";
	}

	@RequestMapping(value = "/setting", method = RequestMethod.GET)
	public String setting() {
		return "/user/setting";
	}
	
	@RequestMapping(value = "/downloadForm", method = RequestMethod.GET)
	public String downloadForm() {
		return "/user/downloadForm";
	}
	@RequestMapping(value = "/methodlist", method = RequestMethod.GET)
	public String methodlist() {
		return "/user/methodlist";
	}
	
	@RequestMapping(value = "/gantt/view", method = RequestMethod.GET)
	public String gantt() {
		return "/user/gantt";
	}
	

}
