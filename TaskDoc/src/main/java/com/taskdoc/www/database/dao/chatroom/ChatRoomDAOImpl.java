package com.taskdoc.www.database.dao.chatroom;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.taskdoc.www.database.dto.ChatRoomVO;

@Repository
public class ChatRoomDAOImpl implements ChatRoomDAO {
	@Autowired
	SqlSession sql;

	private final String NAMESPACE = "chatroom_SQL.";
	private final String TASKLIST = "tasklist";
	private final String ROOMLIST = "roomlist";
	private final String VIEW = "view";
	private final String INSERT = "insert";
	private final String UPDATE = "update";
	private final String DELETE = "delete";
	
	@Override
	public List<ChatRoomVO> taskList(int tcode) {
		// TODO Auto-generated method stub
		return sql.selectList(NAMESPACE + TASKLIST, tcode);
	}
	

	@Override
	public List<ChatRoomVO> roomList(int crcode) {
		// TODO Auto-generated method stub
		return sql.selectList(NAMESPACE + ROOMLIST, crcode);
	}

	@Override
	public ChatRoomVO chatRoomView(int crcode) {
		// TODO Auto-generated method stub
		return sql.selectOne(NAMESPACE + VIEW, crcode);
	}
	
	@Override
	public int chatRoomInsert(ChatRoomVO chatRoomVo) {
		// TODO Auto-generated method stub
		sql.insert(NAMESPACE + INSERT, chatRoomVo);
		return chatRoomVo.getCrcode();
	}
	@Override
	public int chatRoomUpdate(ChatRoomVO chatRoomVo) {
		// TODO Auto-generated method stub
		return sql.update(NAMESPACE + UPDATE, chatRoomVo);
	}
	@Override
	public int chatRoomDelete(int crcode) {
		// TODO Auto-generated method stub
		return sql.delete(NAMESPACE + DELETE, crcode);
	}

}
