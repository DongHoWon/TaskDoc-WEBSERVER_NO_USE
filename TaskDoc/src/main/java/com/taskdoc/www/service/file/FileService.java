package com.taskdoc.www.service.file;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.taskdoc.www.database.dto.FileVO;

public interface FileService {
	public List<FileVO> fileList(int dmcode);
	public FileVO fileView(int fcode);
	public int fileInsert(MultipartFile f, String url, int dmcode) throws IllegalStateException, IOException;
	public Map<String, Object> fileDownload(int fcode);
	public int fileMove(FileVO fileVo, String url);
	public int fileCopy(FileVO fileVo, String url);
	public int fileUpdate(FileVO fileVo);
	public int fileDelete(int fcode);
}
