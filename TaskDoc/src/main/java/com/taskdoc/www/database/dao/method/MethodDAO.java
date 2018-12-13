package com.taskdoc.www.database.dao.method;

import java.util.List;

import com.taskdoc.www.database.dto.MethodVO;

public interface MethodDAO {
	public List<MethodVO> methodList();
	public MethodVO methodView(int mcode);
}
