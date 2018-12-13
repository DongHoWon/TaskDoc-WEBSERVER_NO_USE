package com.taskdoc.www.service.publictask;

import java.util.List;
import java.util.Map;

import com.taskdoc.www.database.dto.PublicTaskVO;

public interface PublicTaskService {
	public List<PublicTaskVO> publicTaskList(int pcode);
	public Map<String, Object> publicTaskAllList(int pcode, String uid);
	public int publicTaskInsert(PublicTaskVO publicTaskVo);
	public List<PublicTaskVO> publicTaskInsertMulti(List<PublicTaskVO> vos);
	public int publicTaskUpdate(PublicTaskVO publicTaskVo);
	public int publicTaskDelete(int tcode);
	public List<PublicTaskVO> publicRootTask(int pcode);
	public List<PublicTaskVO> publicDownTask(int trefference);
	public PublicTaskVO publicTaskView(int tcode);
}
