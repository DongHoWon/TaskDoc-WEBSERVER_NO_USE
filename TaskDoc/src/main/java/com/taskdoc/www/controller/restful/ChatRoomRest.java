package com.taskdoc.www.controller.restful;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.taskdoc.www.database.dto.ChatRoomVO;
import com.taskdoc.www.database.dto.ProjectVO;
import com.taskdoc.www.database.dto.UserInfoVO;
import com.taskdoc.www.service.chatroom.ChatRoomService;
import com.taskdoc.www.system.JsonMapper;

@RestController
@RequestMapping("/chatroom")
public class ChatRoomRest {

	@Autowired
	ChatRoomService service;
	
	//업무에 대한 포커스 모드 리스트를 가져오기
	@RequestMapping(value = "/task/{tcode}", method = RequestMethod.GET)
	public List<ChatRoomVO> taskList(@PathVariable int tcode) {
		return service.taskList(tcode);
	}

	//채팅방 코드로 모든  포커스 모드리스트 가져오기
	@RequestMapping(value = "/room/{crcode}", method = RequestMethod.GET)
	public List<ChatRoomVO> roomList(@PathVariable int crcode) {
		return service.roomList(crcode);
	}
	
	@RequestMapping(value = "/{crcode}", method = RequestMethod.GET)
	public ChatRoomVO view(@PathVariable("crcode") int crcode) {
		return service.chatRoomView(crcode);
	}

	//채팅방 생성
	@RequestMapping(value = "", method = RequestMethod.POST)
	public int insert(@RequestBody Map<String, Object> map) {
		ChatRoomVO chatRoomVo = JsonMapper.mapToJson(map.get("chatRoom"), ChatRoomVO.class);
		UserInfoVO userInfoVo = JsonMapper.mapToJson(map.get("userInfo"), UserInfoVO.class);
		ProjectVO projectVo = JsonMapper.mapToJson(map.get("project"), ProjectVO.class);
		
		try {
			return service.chatRoomInsert(chatRoomVo, userInfoVo, projectVo);
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}
	}
	
	
	@RequestMapping(value = "/multicreate", method = RequestMethod.POST)
	public ChatRoomVO multicreate(@RequestBody Map<String, Object> map) {
		
		ObjectMapper mapper = new ObjectMapper();
		
		List<UserInfoVO> userInfoVo = null;
		try {
			String json = mapper.writeValueAsString(map.get("userInfo"));
			userInfoVo = mapper.readValue(json, new TypeReference<List<UserInfoVO>>() {});
		} catch(IOException e){
			e.printStackTrace();
			return null;
		}
		
		ChatRoomVO chatRoomVo = JsonMapper.mapToJson(map.get("chatRoom"), ChatRoomVO.class);
		ProjectVO projectVo = JsonMapper.mapToJson(map.get("project"), ProjectVO.class);
		
		try {
			return service.multicreate(chatRoomVo, userInfoVo, projectVo);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	@RequestMapping(value = "", method = RequestMethod.PUT)
	public int update(@RequestBody ChatRoomVO chatRoomVo) {
		return service.chatRoomUpdate(chatRoomVo);
	}
	
	@RequestMapping(value = "/{crcode}", method = RequestMethod.DELETE)
	public int delete(@PathVariable int crcode) {
		return service.chatRoomDelete(crcode);
	}
}
