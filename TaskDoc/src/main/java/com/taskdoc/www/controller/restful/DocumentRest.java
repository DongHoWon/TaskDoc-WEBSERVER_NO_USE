package com.taskdoc.www.controller.restful;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.taskdoc.www.database.dto.DocumentVO;
import com.taskdoc.www.service.document.DocumentService;

@RestController
@RequestMapping("/document")
public class DocumentRest {

	@Autowired
	DocumentService service;

	@RequestMapping(value = "/task/{tcode}", method = RequestMethod.GET)
	public List<DocumentVO> taskList(@PathVariable int tcode) {
		return service.taskList(tcode);
	}
	
	//tcode 로 documentVO랑, fileVo 정보가져오기
	@RequestMapping(value = "/taskView/{tcode}", method = RequestMethod.GET)
	public Map<String,Object> taskView(@PathVariable int tcode) {
		return service.taskView(tcode);
	}
	
	//dmcode로 documentVO랑, fileVo 정보 가져오기
	@RequestMapping(value = "/{dmcode}", method = RequestMethod.GET)
	public Map<String,Object> fileView(@PathVariable int dmcode) {
		return service.fileView(dmcode);
	}
	
	
	
	@RequestMapping(value = "/room/{crcode}", method = RequestMethod.GET)
	public List<DocumentVO> roomList(@PathVariable int crcode) {
		return service.roomList(crcode);
	}
	

	@RequestMapping(value = "/user/{uid}", method = RequestMethod.GET)
	public List<DocumentVO> userList(@PathVariable String uid) {
		return service.userList(uid);
	}

	@RequestMapping(value = "/upload", method = RequestMethod.POST)
	public int upload(@RequestParam("file") MultipartFile[] multipartFile, DocumentVO documentVo) {
		return service.fileUpload(multipartFile, documentVo);
	}
	
	@RequestMapping(value = "/upload/doc", method = RequestMethod.POST)
	public DocumentVO uploadDoc(@RequestParam("file") MultipartFile[] multipartFile, DocumentVO documentVo) {
		return service.fileUploadDoc(multipartFile, documentVo);
	}
	
	@RequestMapping(value = "/move", method = RequestMethod.PUT)
	public int move(@RequestBody DocumentVO documentVo) {
		return service.documentMove(documentVo);
	}
	
	@RequestMapping(value = "/copy", method = RequestMethod.PUT)
	public DocumentVO copy(@RequestBody DocumentVO documentVo) {
		return service.documentCopy(documentVo);
	}
	
	@RequestMapping(value = "", method = RequestMethod.PUT)
	public int update(@RequestBody DocumentVO documentVo) {
		return service.documentUpdate(documentVo);
	}

	@RequestMapping(value = "/{dmcode}", method = RequestMethod.DELETE)
	public int delete(@PathVariable int dmcode) {
		return service.documentDelete(dmcode);
	}


}
