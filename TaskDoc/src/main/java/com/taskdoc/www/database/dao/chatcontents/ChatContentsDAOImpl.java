package com.taskdoc.www.database.dao.chatcontents;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.taskdoc.www.database.dto.ChatContentsVO;

@Repository
public class ChatContentsDAOImpl implements ChatContentsDAO {
	@Autowired
	SqlSession sql;
	
	private final String NAMESPACE = "chatcontents_SQL.";
	private final String VIEW = "view";
	private final String LIST = "list";
	private final String INSERT = "insert";

	@Override
	public List<ChatContentsVO> chatContentsList(int crcode) {
		// TODO Auto-generated method stub
		return sql.selectList(NAMESPACE + LIST, crcode);
	}

	@Override
	public ChatContentsVO chatContentsInsert(ChatContentsVO chatContentsVo) {
		// TODO Auto-generated method stub
		sql.insert(NAMESPACE + INSERT, chatContentsVo);
		return chatContentsView(chatContentsVo.getCccode());
	}

	@Override
	public ChatContentsVO chatContentsView(int cccode) {
		// TODO Auto-generated method stub
		return sql.selectOne(NAMESPACE + VIEW, cccode);
	}
}
