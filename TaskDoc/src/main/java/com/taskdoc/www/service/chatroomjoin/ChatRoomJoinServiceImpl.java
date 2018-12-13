package com.taskdoc.www.service.chatroomjoin;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.taskdoc.www.database.dao.chatroom.ChatRoomDAO;
import com.taskdoc.www.database.dao.chatroomjoin.ChatRoomJoinDAO;
import com.taskdoc.www.database.dao.userinfo.UserInfoDAO;
import com.taskdoc.www.database.dto.ChatRoomJoinVO;
import com.taskdoc.www.database.dto.ChatRoomVO;
import com.taskdoc.www.database.dto.ProjectJoinVO;
import com.taskdoc.www.database.dto.UserInfoVO;

@Service("ChatRoomJoinService")
public class ChatRoomJoinServiceImpl implements ChatRoomJoinService{

	@Autowired
	ChatRoomJoinDAO joinDao;
	
	@Autowired
	ChatRoomDAO chatDao;
	
	@Autowired
	UserInfoDAO userDao;

	@Override
	@Transactional
	public Map<String, Object> roomList(ChatRoomJoinVO chatRoomJoinVo) {
		
		List<ChatRoomVO> roomList = new ArrayList<>();
		List<List<UserInfoVO>> userList = new ArrayList<>();
		
		List<Integer> roomCodeList = joinDao.roomList(chatRoomJoinVo);

		for(int i : roomCodeList) {
			
			ChatRoomVO chatRoom = chatDao.chatRoomView(i);

			if(chatRoom.getCrmode() != 3) {
				roomList.add(chatRoom);
				
				chatRoomJoinVo.setCrcode(i);
				List<UserInfoVO> users = userList(chatRoomJoinVo);
				userList.add(users);
			}
		
		}
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("chatRoomList", roomList);
		map.put("userInfoList", userList);
		
		return map;
	}

	@Override
	public List<UserInfoVO> userList(ChatRoomJoinVO chatRoomJoinVo) {
		List<String> list = joinDao.userList(chatRoomJoinVo);
		
		List<UserInfoVO> userInfos = new ArrayList<>();
		
		for(String id : list) {
			userInfos.add(userDao.userInfoView(id));
		}
		
		return userInfos;
	}

	@Override
	public int chatRoomJoinInsert(ChatRoomJoinVO chatRoomJoinVo) {
		return joinDao.chatRoomJoinInsert(chatRoomJoinVo);
	}

	@Override
	public int chatRoomJoinDelete(ChatRoomJoinVO chatRoomJoinVo) {
		return joinDao.chatRoomJoinDelete(chatRoomJoinVo);
	}

	@Override
	public List<ChatRoomJoinVO> WebchatRoomJoinInsert(List<ChatRoomJoinVO> chatRoomuser) {
		return joinDao.WebchatRoomJoinInsert(chatRoomuser);
	}

	@Override
	public List<ChatRoomJoinVO> userlookup(ChatRoomJoinVO chatRoomJoinVo, ProjectJoinVO projectJoinVo) {
		chatRoomJoinVo.setPcode(projectJoinVo.getPcode());
		return joinDao.userlookup(chatRoomJoinVo);
	}


}
