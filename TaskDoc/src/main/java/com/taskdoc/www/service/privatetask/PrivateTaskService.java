package com.taskdoc.www.service.privatetask;

import java.util.List;

import com.taskdoc.www.database.dto.PrivateTaskVO;

public interface PrivateTaskService {
	public List<PrivateTaskVO> privateTaskList(String uid);
	public PrivateTaskVO privateTaskView(int ptcode);
	public int privateTaskInsert(PrivateTaskVO privateTaskVo);
	public int privateTaskupdate(PrivateTaskVO privateTaskVo);
	public int privateTaskDelete(int ptcode);
	public List<PrivateTaskVO> privateDownTask(int ptrefference);
	public List<PrivateTaskVO> publicTaskList(String uid);
	public List<PrivateTaskVO> multiPrivateTaskList(PrivateTaskVO privateTaskVO);
}
