package com.taskdoc.www.service.privatetask;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.taskdoc.www.database.dao.privatetask.PrivateTaskDAO;
import com.taskdoc.www.database.dto.PrivateTaskVO;

@Service("PrivateTaskService")

public class PrivateTaskServiceImpl implements PrivateTaskService{

	@Autowired
	PrivateTaskDAO dao;

	@Override
	public List<PrivateTaskVO> privateTaskList(String uid) {
		// TODO Auto-generated method stub
		return dao.privateTaskList(uid);
	}

	@Override
	@Transactional
	public int privateTaskInsert(PrivateTaskVO privateTaskVo) {
		// TODO Auto-generated method stub
		
		// TODO Auto-generated method stub
		int ptcode = 0;
		Integer sequenceMax = null;
		
		ptcode = dao.privateTaskInsert(privateTaskVo);
		if(privateTaskVo.getPtrefference() == 0) {
			// referrence
			privateTaskVo.setPtrefference(ptcode);
			sequenceMax = dao.selfRefMax(privateTaskVo.getTcode());
		}else {
			// sequence
			sequenceMax = dao.sameRefMax(privateTaskVo.getPtrefference());
		}
		
		privateTaskVo.setPtsequence(sequenceMax == null ? 1 : sequenceMax + 1);
		
		dao.privateTaskUpdate(privateTaskVo);
		return ptcode;
	}

	@Override
	public int privateTaskupdate(PrivateTaskVO privateTaskVo) {
		// TODO Auto-generated method stub
		return dao.privateTaskUpdate(privateTaskVo);
	}

	@Override
	public int privateTaskDelete(int ptcode) {
		// TODO Auto-generated method stub
		return dao.privateTaskDelete(ptcode);
	}

	@Override
	public PrivateTaskVO privateTaskView(int ptcode) {
		return dao.privateTaskView(ptcode);
	}

	@Override
	public List<PrivateTaskVO> privateDownTask(int ptrefference) {
		return dao.privateDownTask(ptrefference);
	}

	@Override
	public List<PrivateTaskVO> publicTaskList(String uid) {
		return dao.publicTaskList(uid);
	}

	@Override
	public List<PrivateTaskVO> multiPrivateTaskList(PrivateTaskVO privateTaskVO) {
		return dao.multiPrivateTaskList(privateTaskVO);
	}




}
