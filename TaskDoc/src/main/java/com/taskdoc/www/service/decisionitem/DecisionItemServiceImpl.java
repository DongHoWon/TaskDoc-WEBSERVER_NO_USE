package com.taskdoc.www.service.decisionitem;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.taskdoc.www.database.dao.decisionitem.DecisionItemDAO;
import com.taskdoc.www.database.dto.DecisionItemVO;

@Service("DecisionItemService")
public class DecisionItemServiceImpl implements DecisionItemService{

	@Autowired
	DecisionItemDAO dao;

	@Override
	public List<DecisionItemVO> decisionItemList(int dscode) {
		return dao.decisionItemList(dscode);
	}

	@Override
	public List<DecisionItemVO> decisionItemInsert(List<DecisionItemVO> itemList) {
		return dao.decisionItemInsert(itemList);
	}

	@Override
	public int decisionItemUpdate(DecisionItemVO decisionItemVo) {
		return dao.decisionItemUpdate(decisionItemVo);
	}

	@Override
	public int decisionItemDelete(int dsicode) {
		return dao.decisionItemDelete(dsicode);
	}

	@Override
	public Map<String, Object> decisionCountList(int dscode) {
		
		Map<String, Object> a=new HashMap<>();

		List<DecisionItemVO> list=dao.decisionItemList(dscode);
		a.put("list", list);
		
		List<Integer> count=dao.countList(dscode);
		a.put("count", count);
		
		return a;
	}
}
