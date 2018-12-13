package com.taskdoc.www.controller.restful;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.taskdoc.www.database.dto.VoterVO;
import com.taskdoc.www.service.voter.VoterService;
import com.taskdoc.www.system.JsonMapper;

@RestController
@RequestMapping("/voter")
public class VoterRest {
	
	@Autowired
	VoterService service;
	
	@RequestMapping(value="/{dsicode}", method = RequestMethod.GET)
	public List<VoterVO> list(@PathVariable int dsicode) {
		return service.voterList(dsicode);
	}

	@RequestMapping(value="/check/{dscode}", method = RequestMethod.GET)
	public List<String> check(@PathVariable int dscode) {
		return service.voterCheck(dscode);
	}
	
	@RequestMapping(value="", method = RequestMethod.POST)
	public int insert(@RequestBody VoterVO voterVo) {
		return service.voterInsert(voterVo);
	}
	
	@RequestMapping(value="", method = RequestMethod.PUT)
	public int update(@RequestBody Map<String, Object> map) {
		
		VoterVO oldVo = JsonMapper.mapToJson(map.get("oldVo"), VoterVO.class);
		VoterVO newVo = JsonMapper.mapToJson(map.get("newVo"), VoterVO.class);
		
		try {
			return service.voterUpdate(oldVo, newVo);
		}catch (Exception e) {
			e.printStackTrace();
			return -1;
		}
	}
	
}
