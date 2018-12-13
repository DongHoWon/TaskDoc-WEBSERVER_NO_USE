package com.taskdoc.www.service.decision;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.taskdoc.www.database.dao.decision.DecisionDAO;
import com.taskdoc.www.database.dto.DecisionVO;

@Service("DecisionService")
public class DecisionServiceImpl implements DecisionService{

	@Autowired
	DecisionDAO dao;

	@Override
	public List<DecisionVO> taskList(int tcode) {
		return dao.taskList(tcode);
	}

	@Override
	public List<DecisionVO> roomList(int crcode) {
		return dao.roomList(crcode);
	}
	
	@Override
	public int decisionInsert(DecisionVO decisionVo) {
		return dao.decisionInsert(decisionVo);
	}
	
	@Override
	public DecisionVO decisionInsertDec(DecisionVO decisionVo) {
		dao.decisionInsert(decisionVo);
		
		return dao.view(decisionVo.getDscode());
	}

	@Override
	public int decisionUpdate(DecisionVO decisionVo) {
		return dao.decisionUpdate(decisionVo);
	}

	@Override
	public int decisionDelete(int dscode) {
		return dao.decisionDelete(dscode);
	}

	@Override
	public DecisionVO view(int dscode) {
		return dao.view(dscode);
	}

}
