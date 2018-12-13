package com.taskdoc.www.service.voter;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.taskdoc.www.database.dao.voter.VoterDAO;
import com.taskdoc.www.database.dto.VoterVO;

@Service("VoterService")
public class VoterServiceImpl implements VoterService{

	@Autowired
	VoterDAO dao;

	@Override
	public List<VoterVO> voterList(int dsicode) {
		return dao.voterList(dsicode);
	}

	@Override
	public int voterInsert(VoterVO voterVo) {
		return dao.voterInsert(voterVo);
	}
	
	@Override
	@Transactional
	public int voterUpdate(VoterVO oldVo, VoterVO newVo) throws Exception{
		dao.voterDelete(oldVo);
		dao.voterInsert(newVo);
		return 1;
		
	}

	@Override
	public int voterDelete(VoterVO voterVo) {
		return dao.voterDelete(voterVo);
	}

	@Override
	public List<String> voterCheck(int dscode) {
		return dao.voterCheck(dscode);
	}


}
