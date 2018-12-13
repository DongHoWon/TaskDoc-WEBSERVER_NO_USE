package com.taskdoc.www.service.chatroomjoin;

import java.util.List;
import java.util.Map;

import com.taskdoc.www.database.dto.ChatRoomJoinVO;
import com.taskdoc.www.database.dto.ProjectJoinVO;
import com.taskdoc.www.database.dto.UserInfoVO;

public interface ChatRoomJoinService {
	public Map<String, Object> roomList(ChatRoomJoinVO chatRoomJoinVo);
	public List<UserInfoVO> userList(ChatRoomJoinVO chatRoomJoinVo);
	public int chatRoomJoinInsert(ChatRoomJoinVO chatRoomJoinVo);
	public List<ChatRoomJoinVO> WebchatRoomJoinInsert(List<ChatRoomJoinVO> chatRoomuser);
	public List<ChatRoomJoinVO> userlookup(ChatRoomJoinVO chatRoomJoinVo, ProjectJoinVO projectJoinVo);
	public int chatRoomJoinDelete(ChatRoomJoinVO chatRoomJoinVo);
}
