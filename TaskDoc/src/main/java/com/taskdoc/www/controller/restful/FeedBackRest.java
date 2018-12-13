package com.taskdoc.www.controller.restful;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.taskdoc.www.database.dto.FeedBackVO;
import com.taskdoc.www.service.feedback.FeedBackService;

@RestController
@RequestMapping("/feedback")
public class FeedBackRest {

	@Autowired
	FeedBackService service;
	
	@RequestMapping(value = "/{dmcode}", method = RequestMethod.GET)
	public List<FeedBackVO> list(@PathVariable int dmcode){
		return service.feedBackList(dmcode);
	}
	
	@RequestMapping(value = "", method = RequestMethod.POST)
	public FeedBackVO insert(@RequestBody FeedBackVO feedBackVo){
		return service.feedBackInsert(feedBackVo);
	}
	
	@RequestMapping(value = "", method = RequestMethod.PUT)
	public int update(@RequestBody FeedBackVO feedBackVo){
		return service.feedBackUpdate(feedBackVo);
	}
	
	@RequestMapping(value = "/{fbcode}", method = RequestMethod.DELETE)
	public int delete(@PathVariable int fbcode){
		return service.feedBackDelete(fbcode);
	}
	
}
