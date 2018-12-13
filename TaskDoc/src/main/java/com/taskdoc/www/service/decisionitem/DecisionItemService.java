package com.taskdoc.www.service.decisionitem;

import java.util.List;
import java.util.Map;

import com.taskdoc.www.database.dto.DecisionItemVO;

public interface DecisionItemService {
	public List<DecisionItemVO> decisionItemList(int dscode);
	public List<DecisionItemVO> decisionItemInsert(List<DecisionItemVO> itemList);
	public int decisionItemUpdate(DecisionItemVO decisionItemVo);
	public int decisionItemDelete(int dsicode);
	public Map<String, Object> decisionCountList(int dscode);
}
