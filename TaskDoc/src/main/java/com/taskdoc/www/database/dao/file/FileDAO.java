package com.taskdoc.www.database.dao.file;

import java.util.List;

import com.taskdoc.www.database.dto.FileVO;

public interface FileDAO {
	public List<FileVO> fileList(int dmcode);
	public FileVO fileView(int fcode);
	public int fileInsert(FileVO fileVo);
	public int fileUpdate(FileVO fileVo);
	public int fileDelete(int fcode);
}
