package com.taskdoc.www.controller.stomp;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import com.taskdoc.www.database.dto.ChatContentsVO;
import com.taskdoc.www.system.JsonMapper;

@RestController
public class StompController {
	@Autowired
	RestTemplate rest;

	private final String chat = "http://localhost:8080/chatcontents";

	@MessageMapping("/project/{pcode}")
	@SendTo("/project/{pcode}")
	public Map<String, Object> test(Map<String, Object> map) throws URISyntaxException {
		return map;
	}
	
	
	//채팅 대화, 의사결정 생성, 회의록 생성, 자료 생성
	@MessageMapping("/webproject/{pcode}")
	@SendTo("/project/{pcode}")
	public Map<String, Object> web(Map<String, Object> map) throws URISyntaxException {
		Map<String, Object> test = new HashMap<>();

		if (map.get("type").equals("chatcontentsvo")) {
			URI uri = new URI(chat);
			ChatContentsVO chatcontentsvo = JsonMapper.mapToJson(map.get("object"), ChatContentsVO.class);
			try {
				chatcontentsvo = rest.postForObject(uri, chatcontentsvo, chatcontentsvo.getClass());
				test.put("object", chatcontentsvo);
				test.put("message", "insert");
				test.put("type", "chatcontentsvo");
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
			else if(map.get("type").equals("decisionvo")){
				return map;
			}
			else if(map.get("type").equals("chatroomvo")){
				return map;
			}
			else if(map.get("type").equals("documentvo")){
				return map;
			}
		return test;
	}
	
}
// message : insert, type : chatcontents, object : ChatContentsVO