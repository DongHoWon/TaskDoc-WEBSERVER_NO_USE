package com.taskdoc.www.database.dao.chatroomjoin;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.taskdoc.www.database.dto.ChatRoomJoinVO;

@Repository
public class ChatRoomJoinDAOImpl implements ChatRoomJoinDAO {

	@Autowired
	SqlSession sql;

	private final String NAMESPACE = "chatroomjoin_SQL.";
	private final String ROOMLIST = "roomlist";
	private final String USERLIST = "userlist";
	private final String VIEW = "view";
	private final String CRCODEMIN = "crcodemin";
	private final String INSERT = "insert";
	private final String DELETE = "delete";
	private final String USERLOOKUP="userlookup";

	@Override
	public List<Integer> roomList(ChatRoomJoinVO chatRoomJoinVo) {
		// TODO Auto-generated method stub
		return sql.selectList(NAMESPACE + ROOMLIST, chatRoomJoinVo);
	}

	@Override
	public List<String> userList(ChatRoomJoinVO chatRoomJoinVo) {
		// TODO Auto-generated method stub
		return sql.selectList(NAMESPACE + USERLIST, chatRoomJoinVo);
	}
	
	@Override
	public int chatRoomJoinInsert(ChatRoomJoinVO chatRoomJoinVo) {
		try {
			return sql.insert(NAMESPACE + INSERT, chatRoomJoinVo);
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}
	}

	@Override
	public int chatRoomJoinDelete(ChatRoomJoinVO chatRoomJoinVo) {
		// TODO Auto-generated method stub
		return sql.delete(NAMESPACE + DELETE, chatRoomJoinVo);
	}

	@Override
	public int crcodeMin(int pcode) {
		// TODO Auto-generated method stub
		return sql.selectOne(NAMESPACE + CRCODEMIN, pcode);
	}

	@Override
	public int chatRoomJoinView(int crcode) {
		// TODO Auto-generated method stub
		int pcode = 0;
		List<Integer> list = sql.selectList(NAMESPACE + VIEW, crcode);
		pcode = list.get(0);
		return pcode;
	}
	
	@Override
	public List<ChatRoomJoinVO> WebchatRoomJoinInsert(List<ChatRoomJoinVO> chatRoomuser) {
		for (ChatRoomJoinVO vo : chatRoomuser) {
			sql.insert(NAMESPACE + INSERT, vo);
		}
		return chatRoomuser;
	}

	@Override
	public List<ChatRoomJoinVO> userlookup(ChatRoomJoinVO chatRoomJoinVo) {
		return sql.selectList(NAMESPACE + USERLOOKUP, chatRoomJoinVo);
	}

}
