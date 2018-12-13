package com.taskdoc.www.database.dao.mothodlist;

import java.util.List;

import com.taskdoc.www.database.dto.MethodListVO;

public interface MethodListDAO {
	public List<MethodListVO> methodListList(String uid);
	public int methodListInsert(MethodListVO methodListVo);
	public int methodListUpdate(MethodListVO methodListVo);
	public int methodListDelete(MethodListVO methodListVo);
}
