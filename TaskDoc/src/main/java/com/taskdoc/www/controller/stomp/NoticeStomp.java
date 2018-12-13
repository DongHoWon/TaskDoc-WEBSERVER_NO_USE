package com.taskdoc.www.controller.stomp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import com.taskdoc.www.database.dto.NoticeVO;

@RestController
public class NoticeStomp {
	
	@Autowired
	RestTemplate rest;
	
	@MessageMapping("/notice/{pcode}")
	@SendTo("/notice/{pcode}")
	public NoticeVO test(@RequestBody NoticeVO noticeVo){
		return noticeVo;
	}

}
