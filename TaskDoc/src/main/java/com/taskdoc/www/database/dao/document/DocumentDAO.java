package com.taskdoc.www.database.dao.document;

import java.util.List;

import com.taskdoc.www.database.dto.DocumentVO;

public interface DocumentDAO {
	public List<DocumentVO> taskList(int tcode);
	public List<DocumentVO> roomList(int crcode);
	public List<DocumentVO> userList(String uid);
	public DocumentVO documentView(int dmcode);
	public int documentInsert(DocumentVO documentVo);
	public int documentUpdate(DocumentVO documentVo);
	public int documentDelete(int dmcode);
}
