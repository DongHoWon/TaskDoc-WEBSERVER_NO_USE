package com.taskdoc.www.service.file;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.LinkOption;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.taskdoc.www.database.dao.file.FileDAO;
import com.taskdoc.www.database.dto.FileVO;

@Service
public class FileServiceImpl implements FileService {

	@Autowired
	FileDAO dao;

	@Override
	public List<FileVO> fileList(int dmcode) {
		// TODO Auto-generated method stub
		return dao.fileList(dmcode);
	}

	@Override
	public int fileInsert(MultipartFile f, String url, int dmcode) throws IllegalStateException, IOException {
		// TODO Auto-generated method stub

		File file = new File(url);
		if (!file.exists()) {
			file.mkdirs();
		}

		String orgname = f.getOriginalFilename(); // ( Class Type = MultipartFile )
		String exc = orgname.substring(orgname.lastIndexOf(".") + 1, orgname.length());

		String storedFileName = UUID.randomUUID().toString();

		String imsiFile = storedFileName + "." + exc;

		f.transferTo(new File(url + imsiFile));

		FileVO vo = new FileVO();

		vo.setFname(orgname);
		vo.setFstname(imsiFile);
		vo.setFposition(url);
		vo.setDmcode(dmcode);

		return dao.fileInsert(vo);
	}

	@Override
	public Map<String, Object> fileDownload(int fcode) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<>();

		FileVO vo = fileView(fcode);
		byte data[] = null;
		
		String position = vo.getFposition();
		String stname = vo.getFstname();
		
		File source = new File(position + stname);
		
		if(!source.exists()) {
			return null;
		}

		try {
			data = FileUtils.readFileToByteArray(source);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		map.put("data", data);
		map.put("name", vo.getFname());

		return map;
	}

	@Override
	public int fileMove(FileVO fileVo, String url) {
		// TODO Auto-generated method stub
		File file = new File(url);
		if (!file.exists()) {
			file.mkdirs();
		}

		String stName = fileVo.getFstname();

		String s = fileVo.getFposition() + stName;
		String t = url + stName;

		Path source = Paths.get(s);
		Path target = Paths.get(t);

		if (!Files.exists(source, new LinkOption[] {})) {
			return -1;
		}

		try {
			Files.move(source, target, StandardCopyOption.REPLACE_EXISTING);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		File folder = new File(fileVo.getFposition());

		if (folder.exists()) {
			folder.delete();
		}

		fileVo.setFposition(url);

		return dao.fileUpdate(fileVo);
	}

	@Override
	public int fileCopy(FileVO fileVo, String url) {
		// TODO Auto-generated method stub
		File file = new File(url);
		if (!file.exists()) {
			file.mkdirs();
		}

		String orgname = fileVo.getFname();
		String exc = orgname.substring(orgname.lastIndexOf(".") + 1, orgname.length());

		String fstName = UUID.randomUUID().toString() + "." + exc;

		String s = fileVo.getFposition() + fileVo.getFstname();
		String t = url + fstName;

		Path source = Paths.get(s);
		Path target = Paths.get(t);

		if (!Files.exists(source, new LinkOption[] {})) {
			return -1;
		}
		try {
			Files.copy(source, target, StandardCopyOption.REPLACE_EXISTING);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		fileVo.setFposition(url);
		fileVo.setFstname(fstName);

		return dao.fileInsert(fileVo);
	}

	@Override
	@Transactional
	public int fileUpdate(FileVO fileVo) {
		// TODO Auto-generated method stub
		return dao.fileUpdate(fileVo);
	}

	@Override
	public int fileDelete(int fcode) {
		// TODO Auto-generated method stub
		FileVO vo = dao.fileView(fcode);

		File file = new File(vo.getFposition() + vo.getFstname());
		File folder = new File(vo.getFposition());

		if (file.exists()) {
			file.delete();
		}

		if (folder.exists()) {
			folder.delete();
		}

		return dao.fileDelete(fcode);
	}

	@Override
	public FileVO fileView(int fcode) {
		// TODO Auto-generated method stub
		return dao.fileView(fcode);
	}

}
