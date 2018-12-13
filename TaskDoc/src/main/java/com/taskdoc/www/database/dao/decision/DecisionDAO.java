package com.taskdoc.www.database.dao.decision;

import java.util.List;

import com.taskdoc.www.database.dto.DecisionVO;

public interface DecisionDAO {
	public List<DecisionVO> taskList(int tcode);
	public List<DecisionVO> roomList(int crcode);
	public DecisionVO view(int dscode);
	public int decisionInsert(DecisionVO decisionVo);
	public int decisionUpdate(DecisionVO decisionVo);
	public int decisionDelete(int dscode);
}
