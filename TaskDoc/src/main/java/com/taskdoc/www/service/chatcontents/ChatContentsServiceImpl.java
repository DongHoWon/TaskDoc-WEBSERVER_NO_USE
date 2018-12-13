package com.taskdoc.www.service.chatcontents;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.taskdoc.www.database.dao.chatcontents.ChatContentsDAO;
import com.taskdoc.www.database.dto.ChatContentsVO;

@Service("ChatContentsService")
public class ChatContentsServiceImpl implements ChatContentsService {

	@Autowired
	ChatContentsDAO dao;

	@Override
	public List<ChatContentsVO> chatContentsList(int crcode) {
		// TODO Auto-generated method stub
		return dao.chatContentsList(crcode);
	}

	@Override
	public ChatContentsVO chatContentsInsert(ChatContentsVO chatContentsVo) {
		// TODO Auto-generated method stub
		return dao.chatContentsInsert(chatContentsVo);
	}
}
