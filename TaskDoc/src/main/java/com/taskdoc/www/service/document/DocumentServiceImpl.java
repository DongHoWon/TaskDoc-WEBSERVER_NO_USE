package com.taskdoc.www.service.document;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.taskdoc.www.database.dao.chatroomjoin.ChatRoomJoinDAO;
import com.taskdoc.www.database.dao.document.DocumentDAO;
import com.taskdoc.www.database.dao.file.FileDAO;
import com.taskdoc.www.database.dao.project.ProjectDAO;
import com.taskdoc.www.database.dao.publictask.PublicTaskDAO;
import com.taskdoc.www.database.dto.DocumentVO;
import com.taskdoc.www.database.dto.FileVO;
import com.taskdoc.www.database.dto.ProjectVO;
import com.taskdoc.www.service.file.FileService;
import com.taskdoc.www.system.FileUploadBaseUrl;

@Service("DocumentService")
public class DocumentServiceImpl implements DocumentService {

	@Autowired
	DocumentDAO dao;

	@Autowired
	FileUploadBaseUrl url;

	@Autowired
	ChatRoomJoinDAO chatRoomDao;

	@Autowired
	PublicTaskDAO publicTaskDao;

	@Autowired
	ProjectDAO projectDao;
	
	@Autowired
	FileDAO fileDao;
	
	@Autowired
	DocumentDAO documentDao;

	@Autowired
	FileService fileService;

	@Override
	public List<DocumentVO> taskList(int tcode) {
		// TODO Auto-generated method stub
		return dao.taskList(tcode);
	}

	@Override
	public List<DocumentVO> roomList(int crcode) {
		// TODO Auto-generated method stub
		return dao.roomList(crcode);
	}
	

	@Override
	public List<DocumentVO> userList(String uid) {
		// TODO Auto-generated method stub
		return dao.userList(uid);
	}

	@Override
	@Transactional
	public int fileUpload(MultipartFile[] multipartFile, DocumentVO documentVo) {
		// TODO Auto-generated method stub

		int dmcode = dao.documentInsert(documentVo);
		
		String url = getPath(documentVo);
		System.out.println(url);
		for (MultipartFile f : multipartFile) {

			try {
				fileService.fileInsert(f, url, dmcode);
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}
		return dmcode;
	}
	
	@Override
	@Transactional
	public DocumentVO fileUploadDoc(MultipartFile[] multipartFile, DocumentVO documentVo) {
		// TODO Auto-generated method stub

		int dmcode = dao.documentInsert(documentVo);
		
		DocumentVO vo = dao.documentView(dmcode);

		String url = getPath(documentVo);

		for (MultipartFile f : multipartFile) {

			try {
				fileService.fileInsert(f, url, dmcode);
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}
		return vo;
	}

	@Override
	@Transactional
	public int documentMove(DocumentVO documentVo) {
		// TODO Auto-generated method stub
		String url = getPath(documentVo);
		List<FileVO> vos = fileService.fileList(documentVo.getDmcode());
		for (FileVO vo : vos) {
			fileService.fileMove(vo, url);
		}
		return dao.documentUpdate(documentVo);
	}

	@Override
	@Transactional
	public DocumentVO documentCopy(DocumentVO documentVo) {
		// TODO Auto-generated method stub
		int targetDmcode = documentVo.getDmcode();
		
		documentVo.setDmcode(0);
		documentVo.setDmdate(null);
		documentVo.setDmtitle(documentVo.getDmtitle() + "- OUTPUT");
		
		int dmcode = dao.documentInsert(documentVo);
		
		String url = getPath(documentVo);
		List<FileVO> vos = fileService.fileList(targetDmcode);
		for (FileVO vo : vos) {
			vo.setDmcode(dmcode);
			fileService.fileCopy(vo, url);
		}
		return dao.documentView(dmcode);
	}


	@Override
	@Transactional
	public int documentDelete(int dmcode) {
		// TODO Auto-generated method stub
		List<FileVO> vos = fileService.fileList(dmcode);

		for (FileVO vo : vos) {
			fileService.fileDelete(vo.getFcode());
		}

		return dao.documentDelete(dmcode);
	}

	
	
	
	public String getPath(DocumentVO documentVo) {

		String url = this.url.getURL();

		int pcode = chatRoomDao.chatRoomJoinView(documentVo.getCrcode());
		ProjectVO p = projectDao.projectView(pcode);

		url += pcode + "_" + p.getPtitle() + File.separator;

		url += this.url.getTaskPath(documentVo.getTcode());

		return url;
	}

	@Override
	public int documentUpdate(DocumentVO documentVo) {
		// TODO Auto-generated method stub
		return dao.documentUpdate(documentVo);
	}

	@Override
	@Transactional
	public Map<String, Object> taskView(int tcode) {
		List<DocumentVO> dvo = documentDao.taskList(tcode);
		List<FileVO> fvo=new ArrayList<>();
		
		for(int i=0;i<dvo.size();i++){
			fvo.addAll(fileDao.fileList(dvo.get(i).getDmcode()));
		}
		
		Map<String, Object> a=new HashMap<>();
		a.put("document", dvo);
		a.put("file", fvo);
		
		return a;
	}

	@Override
	public Map<String, Object> fileView(int dmcode) {
		DocumentVO dvo= documentDao.documentView(dmcode);
		List<FileVO> fvo=new ArrayList<>();
		
		fvo.addAll(fileDao.fileList(dvo.getDmcode()));
		
		Map<String, Object> a=new HashMap<>();
		a.put("document", dvo);
		a.put("file", fvo);
		
		return a;
	}

}
