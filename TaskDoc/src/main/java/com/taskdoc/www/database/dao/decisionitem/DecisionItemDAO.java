package com.taskdoc.www.database.dao.decisionitem;

import java.util.List;

import com.taskdoc.www.database.dto.DecisionItemVO;

public interface DecisionItemDAO {
	public List<DecisionItemVO> decisionItemList(int dscode);
	public List<DecisionItemVO> decisionItemInsert(List<DecisionItemVO> itemList);
	public List<Integer> countList(int dscode);
	public int decisionItemUpdate(DecisionItemVO decisionItemVo);
	public int decisionItemDelete(int dsicode);
}
