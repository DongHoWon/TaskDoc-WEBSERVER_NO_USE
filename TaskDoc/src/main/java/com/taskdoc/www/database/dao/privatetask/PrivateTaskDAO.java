package com.taskdoc.www.database.dao.privatetask;

import java.util.List;

import com.taskdoc.www.database.dto.PrivateTaskVO;

public interface PrivateTaskDAO {
	public List<PrivateTaskVO> privateTaskList(int tcode, String uid);
	public List<PrivateTaskVO> privateTaskList(String uid);
	public PrivateTaskVO privateTaskView(int ptcode);
	public int privateTaskInsert(PrivateTaskVO privateTaskVo);
	public int privateTaskUpdate(PrivateTaskVO privateTaskVo);
	public int privateTaskDelete(int ptcode);
	public Integer selfRefMax(int tcode);
	public Integer sameRefMax(int ptrefference);
	public List<PrivateTaskVO> privateDownTask(int ptrefference);
	public List<PrivateTaskVO> publicTaskList(String uid);
	public List<PrivateTaskVO> multiPrivateTaskList(PrivateTaskVO privateTaskVO);

}
