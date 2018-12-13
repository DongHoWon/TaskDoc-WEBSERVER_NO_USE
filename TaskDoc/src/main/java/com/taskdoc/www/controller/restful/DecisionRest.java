package com.taskdoc.www.controller.restful;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.taskdoc.www.database.dto.DecisionVO;
import com.taskdoc.www.service.decision.DecisionService;

@RestController
@RequestMapping("/decision")
public class DecisionRest {
	
	@Autowired
	DecisionService service;
	
	//공용업무에서 불러올 의사결정 리스트들.
	@RequestMapping(value="/task/{tcode}", method = RequestMethod.GET)
	public List<DecisionVO> taskList(@PathVariable int tcode) {
		return service.taskList(tcode);
	}
	
	//채팅방에서 불러올 의사결정 리스트들
	@RequestMapping(value="/room/{crcode}", method = RequestMethod.GET)
	public List<DecisionVO> roomList(@PathVariable int crcode) {
		return service.roomList(crcode);
	}
	
	//web용 의사결정 정보 조회
	@RequestMapping(value="/{dscode}",method =RequestMethod.GET)
	public DecisionVO info(@PathVariable int dscode){
		return service.view(dscode);
	}
	
	
	//의사결정 생성
	@RequestMapping(value="", method = RequestMethod.POST)
	public int insert(@RequestBody DecisionVO decisionVo) {
		return service.decisionInsert(decisionVo);
	}
	
	@RequestMapping(value="/dec", method = RequestMethod.POST)
	public DecisionVO insertDec(@RequestBody DecisionVO decisionVo) {
		return service.decisionInsertDec(decisionVo);
	}
	
	//의사결정 수정
	@RequestMapping(value="", method = RequestMethod.PUT)
	public int update(@RequestBody DecisionVO decision) {
		return service.decisionUpdate(decision);
	}
	
	//의사결정 삭제
	@RequestMapping(value="/{dscode}", method = RequestMethod.DELETE)
	public int delete(@PathVariable int dscode) {
		return service.decisionDelete(dscode);
	}
}
