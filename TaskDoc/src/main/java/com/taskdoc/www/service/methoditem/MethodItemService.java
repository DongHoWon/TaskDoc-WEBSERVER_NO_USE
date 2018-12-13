package com.taskdoc.www.service.methoditem;

import java.util.List;

import com.taskdoc.www.database.dto.MethodItemVO;

public interface MethodItemService {
	public List<MethodItemVO> methodItemList(int mcode);

}
