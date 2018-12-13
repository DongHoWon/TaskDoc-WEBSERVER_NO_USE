package com.taskdoc.www.service.publictask;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.taskdoc.www.database.dao.privatetask.PrivateTaskDAO;
import com.taskdoc.www.database.dao.publictask.PublicTaskDAO;
import com.taskdoc.www.database.dto.PrivateTaskVO;
import com.taskdoc.www.database.dto.PublicTaskVO;

@Service("PublicTaskService")
public class PublicTaskServiceImpl implements PublicTaskService{

	@Autowired
	PublicTaskDAO dao;
	
	@Autowired
	PrivateTaskDAO privateDao;

	@Override
	public List<PublicTaskVO> publicTaskList(int pcode) {
		return dao.publicTaskList(pcode);
	}
	
	@Override
	@Transactional
	public Map<String, Object> publicTaskAllList(int pcode, String uid) {
		Map<String, Object> map = new HashMap<>();
		
		List<PublicTaskVO> pVos = publicTaskList(pcode);
		List<List<PrivateTaskVO>> ptVos = new ArrayList<>();
		
		for(PublicTaskVO vo : pVos) {
			ptVos.add(privateDao.privateTaskList(vo.getTcode(), uid));
		}
		
		map.put("publicTaskList", pVos);
		map.put("privateTaskList", ptVos);
		return map;
	}

	@Override
	@Transactional
	public int publicTaskInsert(PublicTaskVO publicTaskVo) {
		// TODO Auto-generated method stub
		int tcode = 0;
	
		Integer sequenceMax = null;
		
		tcode = dao.publicTaskInsert(publicTaskVo);
		if(publicTaskVo.getTrefference() == 0) {
			// refference
			publicTaskVo.setTrefference(tcode);
			sequenceMax = dao.selfRefMax(publicTaskVo.getPcode());
		}else {
			// sequence
			sequenceMax = dao.sameRefMax(publicTaskVo.getTrefference());
		}
		
		publicTaskVo.setTsequence(sequenceMax == null ? 1 : sequenceMax + 1);
		
		dao.publicTaskUpdate(publicTaskVo);
		return tcode;
	}
	
	@Override
	@Transactional
	public List<PublicTaskVO> publicTaskInsertMulti(List<PublicTaskVO> vos){
		
		Map<Integer, Integer> maps = new HashMap<>();
		
		for(PublicTaskVO vo : vos) {
			
			// 폴더 (OUTPUT) 이라면 건너뛴다.
			if(vo.getTsdate() == null) continue;
			
			if(maps.containsKey(vo.getTrefference())) {
				vo.setTrefference(maps.get(vo.getTrefference()));
			} else {
				vo.setTrefference(0);
			}
			
			int tcode = vo.getTcode();
			maps.put(tcode, publicTaskInsert(vo));
		}
		
		return vos;
	}

	@Override
	public int publicTaskUpdate(PublicTaskVO publicTaskVo) {
		return dao.publicTaskUpdate(publicTaskVo);
	}

	@Override
	public int publicTaskDelete(int tcode) {
		return dao.publicTaskDelete(tcode);
	}

	@Override
	public List<PublicTaskVO> publicRootTask(int pcode) {
		return dao.publicRootTask(pcode);
	}

	@Override
	public List<PublicTaskVO> publicDownTask(int trefference) {
		return dao.publicDownTask(trefference);
	}

	@Override
	public PublicTaskVO publicTaskView(int tcode) {
		return dao.publicTaskView(tcode);
	}

}
