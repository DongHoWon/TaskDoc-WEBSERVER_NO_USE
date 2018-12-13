package com.taskdoc.www.database.dao.document;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.taskdoc.www.database.dto.DocumentVO;

@Repository
public class DocumentDAOImpl implements DocumentDAO {
	
	@Autowired
	SqlSession sql;
	
	private final String NAMESPACE = "document_SQL.";
	private final String TASKLIST = "tasklist";
	private final String ROOMLIST = "roomlist";
	private final String USERLIST = "userlist";
	private final String VIEW = "view";
	private final String INSERT = "insert";
	private final String UPDATE = "update";
	private final String DELETE = "delete";
	
	@Override
	public List<DocumentVO> taskList(int tcode) {
		// TODO Auto-generated method stub
		return sql.selectList(NAMESPACE + TASKLIST, tcode);
	}
	
	@Override
	public List<DocumentVO> roomList(int crcode) {
		// TODO Auto-generated method stub
		return sql.selectList(NAMESPACE + ROOMLIST, crcode);
	}
	

	@Override
	public List<DocumentVO> userList(String uid) {
		// TODO Auto-generated method stub
		return sql.selectList(NAMESPACE + USERLIST, uid);
	}

	@Override
	public int documentInsert(DocumentVO documentVo) {
		// TODO Auto-generated method stub
		sql.insert(NAMESPACE + INSERT, documentVo);
		return documentVo.getDmcode();
	}
	

	@Override
	public int documentUpdate(DocumentVO documentVo) {
		// TODO Auto-generated method stub
		return sql.update(NAMESPACE + UPDATE, documentVo);
	}

	@Override
	public int documentDelete(int dmcode) {
		// TODO Auto-generated method stub
		return sql.delete(NAMESPACE + DELETE, dmcode);
	}

	@Override
	public DocumentVO documentView(int dmcode) {
		// TODO Auto-generated method stub
		return sql.selectOne(NAMESPACE + VIEW, dmcode);
	}

}
