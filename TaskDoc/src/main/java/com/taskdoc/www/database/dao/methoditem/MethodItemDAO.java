package com.taskdoc.www.database.dao.methoditem;

import java.util.List;

import com.taskdoc.www.database.dto.MethodItemVO;

public interface MethodItemDAO {
	public List<MethodItemVO> methodItemList(int mcode);
}
