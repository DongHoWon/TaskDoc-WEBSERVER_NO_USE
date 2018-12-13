package com.taskdoc.www.service.method;

import java.util.List;
import java.util.Map;

import com.taskdoc.www.database.dto.MethodVO;

public interface MethodService {
	public List<MethodVO> methodList();
	public Map<String, Object> methodView(int mcode);
}
