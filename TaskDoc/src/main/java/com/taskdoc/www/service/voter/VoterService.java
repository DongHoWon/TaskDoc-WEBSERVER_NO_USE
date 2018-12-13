package com.taskdoc.www.service.voter;

import java.util.List;

import com.taskdoc.www.database.dto.VoterVO;

public interface VoterService {
	public List<VoterVO> voterList(int dsicode);
	public int voterInsert(VoterVO voterVo);
	public int voterUpdate(VoterVO oldVo, VoterVO newVo)  throws Exception;
	public int voterDelete(VoterVO voterVo);
	public List<String> voterCheck(int dscode);
	
	
}
