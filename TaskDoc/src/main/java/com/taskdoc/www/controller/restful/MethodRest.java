package com.taskdoc.www.controller.restful;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.taskdoc.www.database.dto.MethodVO;
import com.taskdoc.www.service.method.MethodService;

@RestController
@RequestMapping("/method")
public class MethodRest {

	@Autowired
	MethodService service;
	
	@RequestMapping(value = "/all", method = RequestMethod.GET)
	public List<MethodVO> list(){
		return service.methodList();
	}
	
	@RequestMapping(value = "/{mcode}", method = RequestMethod.GET)
	public Map<String, Object> view(@PathVariable int mcode){
		return service.methodView(mcode);
	}
}
