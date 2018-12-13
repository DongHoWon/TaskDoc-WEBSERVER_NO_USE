package com.taskdoc.www.database.dao.chatcontents;

import java.util.List;

import com.taskdoc.www.database.dto.ChatContentsVO;

public interface ChatContentsDAO {
	
	public ChatContentsVO chatContentsView(int cccode);
	public List<ChatContentsVO> chatContentsList(int crcode);
	public ChatContentsVO chatContentsInsert(ChatContentsVO chatContentsVo);
}
