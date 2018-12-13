package com.taskdoc.www.service.chatroom;

import java.util.List;

import com.taskdoc.www.database.dto.ChatRoomVO;
import com.taskdoc.www.database.dto.ProjectVO;
import com.taskdoc.www.database.dto.UserInfoVO;

public interface ChatRoomService {
	public List<ChatRoomVO> taskList(int tcode);
	public List<ChatRoomVO> roomList(int crcode);
	public ChatRoomVO chatRoomView(int crcode);
	public int chatRoomInsert(ChatRoomVO chatRoomVo, UserInfoVO userInfoVo, ProjectVO projectVo) throws Exception;
	public int chatRoomInsert(ChatRoomVO chatRoomVo, List<UserInfoVO> userInfoVo, ProjectVO projectVo) throws Exception;
	public ChatRoomVO multicreate(ChatRoomVO chatRoomVo, List<UserInfoVO> userInfoVo, ProjectVO projectVo) throws Exception;
	public int chatRoomUpdate(ChatRoomVO chatRoomVo);
	public int chatRoomDelete(int crcode);
}
