package com.taskdoc.www.controller.restful;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.taskdoc.www.database.dto.ChatContentsVO;
import com.taskdoc.www.service.chatcontents.ChatContentsService;

@RestController
@RequestMapping("/chatcontents")
public class ChatContentsRest {
	
	@Autowired
	ChatContentsService service;
	
	@RequestMapping(value="/{crcode}", method = RequestMethod.GET)
	public List<ChatContentsVO> list(@PathVariable int crcode) {
		return service.chatContentsList(crcode);
	}
	

	@RequestMapping(value="", method = RequestMethod.POST)
	public ChatContentsVO Insert(@RequestBody ChatContentsVO chatContentsVo) {
		return service.chatContentsInsert(chatContentsVo);
	}
}
