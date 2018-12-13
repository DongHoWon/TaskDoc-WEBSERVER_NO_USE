package com.taskdoc.www.database.dao.file;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.taskdoc.www.database.dto.FileVO;

@Repository
public class FileDAOImpl implements FileDAO {

	@Autowired
	SqlSession sql;

	private final String NAMESPACE = "file_SQL.";

	private final String LIST = "list";
	private final String VIEW = "view";
	private final String INSERT = "insert";
	private final String UPDATE = "update";
	private final String DELETE = "delete";

	@Override
	public List<FileVO> fileList(int dmcode) {
		// TODO Auto-generated method stub
		return sql.selectList(NAMESPACE + LIST, dmcode);
	}

	@Override
	public FileVO fileView(int fcode) {
		// TODO Auto-generated method stub
		return sql.selectOne(NAMESPACE + VIEW, fcode);
	}

	@Override
	public int fileInsert(FileVO fileVo) {
		// TODO Auto-generated method stub
		return sql.insert(NAMESPACE + INSERT, fileVo);
	}

	@Override
	public int fileUpdate(FileVO fileVo) {
		// TODO Auto-generated method stub
		return sql.update(NAMESPACE + UPDATE, fileVo);
	}

	@Override
	public int fileDelete(int fcode) {
		// TODO Auto-generated method stub
		return sql.delete(NAMESPACE + DELETE, fcode);
	}

}
