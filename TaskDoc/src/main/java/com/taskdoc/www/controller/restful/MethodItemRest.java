package com.taskdoc.www.controller.restful;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import com.taskdoc.www.database.dto.MethodItemVO;
import com.taskdoc.www.service.methoditem.MethodItemService;

@RestController
@RequestMapping("/methoditem")
public class MethodItemRest {

	@Autowired
	MethodItemService service;
	
	@RequestMapping(value = "/{mcode}", method = RequestMethod.GET)
	public List<MethodItemVO> list(@PathVariable int mcode){
		return service.methodItemList(mcode);
	}
	
}
