package com.taskdoc.www.service.method;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.taskdoc.www.database.dao.method.MethodDAO;
import com.taskdoc.www.database.dao.methoditem.MethodItemDAO;
import com.taskdoc.www.database.dto.MethodItemVO;
import com.taskdoc.www.database.dto.MethodVO;

@Service("MethodService")
public class MethodServiceImpl implements MethodService{

	@Autowired
	MethodDAO methodDao;
	
	@Autowired
	MethodItemDAO itemDao;

	@Override
	public List<MethodVO> methodList() {
		return methodDao.methodList();
	}

	@Override
	public Map<String, Object> methodView(int mcode) {
		MethodVO methodVo = methodDao.methodView(mcode);
		List<MethodItemVO> itemList = itemDao.methodItemList(mcode);
		
		Map<String, Object> map = new HashMap<>();
		map.put("method", methodVo);
		map.put("methodItemList", itemList);
		
		return map;
	}
}
