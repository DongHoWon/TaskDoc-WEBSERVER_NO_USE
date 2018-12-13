package com.taskdoc.www.database.dao.voter;

import java.util.List;

import com.taskdoc.www.database.dto.VoterVO;

public interface VoterDAO {
	public List<VoterVO> voterList(int dsicode);
	public int voterInsert(VoterVO voterVo);
	public int voterDelete(VoterVO voterVo);
	public List<String> voterCheck(int dscode);
	

}
