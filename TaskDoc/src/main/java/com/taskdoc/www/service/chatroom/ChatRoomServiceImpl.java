package com.taskdoc.www.service.chatroom;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.taskdoc.www.database.dao.chatroom.ChatRoomDAO;
import com.taskdoc.www.database.dao.chatroomjoin.ChatRoomJoinDAO;
import com.taskdoc.www.database.dto.ChatRoomJoinVO;
import com.taskdoc.www.database.dto.ChatRoomVO;
import com.taskdoc.www.database.dto.ProjectVO;
import com.taskdoc.www.database.dto.UserInfoVO;

@Service("ChatRoomService")
public class ChatRoomServiceImpl implements ChatRoomService {

	@Autowired
	ChatRoomDAO roomDao;

	@Autowired
	ChatRoomJoinDAO joinDao;

	@Override
	public List<ChatRoomVO> taskList(int tcode) {
		List<ChatRoomVO> focusList = new ArrayList<>();
		List<ChatRoomVO> roomList = roomDao.taskList(tcode);

		for (ChatRoomVO vo : roomList) {
			if (vo.getCrmode() == 3) {
				focusList.add(vo);
			}
		}
		return focusList;
	}

	@Override
	public List<ChatRoomVO> roomList(int crcode) {
		return roomDao.roomList(crcode);
	}

	@Override
	public ChatRoomVO chatRoomView(int crcode) {
		// TODO Auto-generated method stub
		return roomDao.chatRoomView(crcode);
	}

	// 채팅방생성
	@Override
	@Transactional
	public int chatRoomInsert(ChatRoomVO chatRoomVo, UserInfoVO userInfoVo, ProjectVO projectVo) throws Exception {
		roomDao.chatRoomInsert(chatRoomVo);

		ChatRoomJoinVO chatRoomJoinVo = new ChatRoomJoinVO();

		chatRoomJoinVo.setPcode(projectVo.getPcode());
		chatRoomJoinVo.setCrcode(chatRoomVo.getCrcode());
		chatRoomJoinVo.setUid(userInfoVo.getUid());
		return joinDao.chatRoomJoinInsert(chatRoomJoinVo);
	}

	@Override
	public int chatRoomInsert(ChatRoomVO chatRoomVo, List<UserInfoVO> userInfoVo, ProjectVO projectVo)
			throws Exception {
		// TODO Auto-generated method stub
		roomDao.chatRoomInsert(chatRoomVo);

		for (UserInfoVO vo : userInfoVo) {
			ChatRoomJoinVO chatRoomJoinVo = new ChatRoomJoinVO();
			chatRoomJoinVo.setPcode(projectVo.getPcode());
			chatRoomJoinVo.setCrcode(chatRoomVo.getCrcode());
			chatRoomJoinVo.setUid(vo.getUid());

			joinDao.chatRoomJoinInsert(chatRoomJoinVo);
		}

		return chatRoomVo.getCrcode();
	}

	// 포커스
	@Override
	@Transactional
	public ChatRoomVO multicreate(ChatRoomVO chatRoomVo, List<UserInfoVO> userInfoVo, ProjectVO projectVo)
			throws Exception {

		roomDao.chatRoomInsert(chatRoomVo);

		for (UserInfoVO vo : userInfoVo) {
			ChatRoomJoinVO chatRoomJoinVo = new ChatRoomJoinVO();
			chatRoomJoinVo.setPcode(projectVo.getPcode());
			chatRoomJoinVo.setCrcode(chatRoomVo.getCrcode());
			chatRoomJoinVo.setUid(vo.getUid());

			joinDao.chatRoomJoinInsert(chatRoomJoinVo);
		}

		return roomDao.chatRoomView(chatRoomVo.getCrcode());

	}

	@Override
	public int chatRoomUpdate(ChatRoomVO chatRoomVo) {
		return roomDao.chatRoomUpdate(chatRoomVo);
	}

	@Override
	public int chatRoomDelete(int crcode) {
		// TODO Auto-generated method stub
		return roomDao.chatRoomDelete(crcode);
	}

}
