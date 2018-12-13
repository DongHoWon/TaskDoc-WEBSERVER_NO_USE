package com.taskdoc.www.service.methodlist;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.taskdoc.www.database.dao.mothodlist.MethodListDAO;
import com.taskdoc.www.database.dto.MethodListVO;

@Service("MethodListService")

public class MethodListServiceImpl implements MethodListService{

	@Autowired
	MethodListDAO dao;

	@Override
	public List<MethodListVO> methodListList(String uid) {
		return dao.methodListList(uid);
	}

	@Override
	public int methodListInsert(MethodListVO methodListVo) {
		return dao.methodListInsert(methodListVo);
	}

	@Override
	public int methodListUpdate(MethodListVO methodListVo) {
		return dao.methodListUpdate(methodListVo);
	}

	@Override
	public int methodListDelete(MethodListVO methodListVo) {
		return dao.methodListDelete(methodListVo);
	}
}
