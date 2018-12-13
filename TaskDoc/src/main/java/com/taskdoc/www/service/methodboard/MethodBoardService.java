package com.taskdoc.www.service.methodboard;

import java.util.List;

import com.taskdoc.www.database.dto.MethodBoardVO;

public interface MethodBoardService {
	public List<MethodBoardVO> methodBoardList();
	public List<MethodBoardVO> methodBoardMyList(String uid);
	public MethodBoardVO methodBoardView(int mbcode);
	public int methodBoardInsert(MethodBoardVO methodBoard);
	public int methodBoardUpdate(MethodBoardVO methodBoard);
	public int methodBoardDelete(int mbcode);
}
