package com.taskdoc.www.service.methoditem;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.taskdoc.www.database.dao.methoditem.MethodItemDAO;
import com.taskdoc.www.database.dto.MethodItemVO;

@Service("MethodItemService")
public class MethodItemServiceImpl implements MethodItemService{

	@Autowired
	MethodItemDAO dao;

	@Override
	public List<MethodItemVO> methodItemList(int mcode) {
		return dao.methodItemList(mcode);
	}


}
