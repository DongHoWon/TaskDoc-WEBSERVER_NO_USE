package com.taskdoc.www.service.document;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.taskdoc.www.database.dto.DocumentVO;

public interface DocumentService {
	public List<DocumentVO> taskList(int tcode);
	
	public Map<String,Object> taskView(int tcode);
	public Map<String, Object> fileView(int dmcode);

	public List<DocumentVO> roomList(int crcode);
	public List<DocumentVO> userList(String uid);
	public int fileUpload(MultipartFile[] multipartFile, DocumentVO documentVo);
	public DocumentVO fileUploadDoc(MultipartFile[] multipartFile, DocumentVO documentVo);
	public int documentMove(DocumentVO documentVo);
	public DocumentVO documentCopy(DocumentVO documentVo);
	public int documentUpdate(DocumentVO documentVo);
	public int documentDelete(int dmcode);
}
