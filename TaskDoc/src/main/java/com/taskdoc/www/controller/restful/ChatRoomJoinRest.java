package com.taskdoc.www.controller.restful;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.taskdoc.www.database.dto.ChatRoomJoinVO;
import com.taskdoc.www.database.dto.ProjectJoinVO;
import com.taskdoc.www.database.dto.UserInfoVO;
import com.taskdoc.www.service.chatroomjoin.ChatRoomJoinService;
import com.taskdoc.www.system.JsonMapper;

@RestController
@RequestMapping("/chatroomjoin")
public class ChatRoomJoinRest {

	@Autowired
	ChatRoomJoinService service;
	
	@RequestMapping(value = "/room", method = RequestMethod.POST)
	public Map<String, Object> projectList(@RequestBody ChatRoomJoinVO chatRoomJoinVo) {
		return service.roomList(chatRoomJoinVo);
	}
	
	@RequestMapping(value = "/user", method = RequestMethod.POST)
	public List<UserInfoVO> userList(@RequestBody ChatRoomJoinVO chatRoomJoinVo) {
		return service.userList(chatRoomJoinVo);
	}
	
	@RequestMapping(value = "", method = RequestMethod.POST)
	public int insert(@RequestBody ChatRoomJoinVO chatRoomJoinVo) {
		return service.chatRoomJoinInsert(chatRoomJoinVo);
	}

	//web용 채팅방에 유저추가하는것
	@RequestMapping(value = "/multiple", method = RequestMethod.POST)
	public List<ChatRoomJoinVO> insert(@RequestBody List<ChatRoomJoinVO> chatRoomuser) {
		return service.WebchatRoomJoinInsert(chatRoomuser);
	}
	
	//채팅방 인원 초대시 해당 채팅방의 회원을 조회해서 포함되어있으면 안불러옴
	@RequestMapping(value="/userlookup", method=RequestMethod.POST)
	public List<ChatRoomJoinVO> userlookup(@RequestBody Map<String,Object> map) {
		ProjectJoinVO projectJoinVo = JsonMapper.mapToJson(map.get("project"), ProjectJoinVO.class);
		ChatRoomJoinVO chatRoomJoinVo = JsonMapper.mapToJson(map.get("chatRoom"), ChatRoomJoinVO.class);
		try{
			return service.userlookup(chatRoomJoinVo,projectJoinVo);
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}
	}
	
	
	@RequestMapping(value = "", method = RequestMethod.DELETE)
	public int delete(@RequestBody ChatRoomJoinVO chatRoomJoinVo) {
		return service.chatRoomJoinDelete(chatRoomJoinVo);
	}
}
