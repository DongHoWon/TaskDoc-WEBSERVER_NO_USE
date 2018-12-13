package com.taskdoc.www.service.memo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.taskdoc.www.database.dao.memo.MemoDAO;
import com.taskdoc.www.database.dto.MemoVO;

@Service("MemoService")
public class MemoServiceImpl implements MemoService {

	@Autowired
	MemoDAO dao;

	@Override
	public List<MemoVO> memoList(int ptcode) {
		// TODO Auto-generated method stub
		return dao.memoList(ptcode);
	}

	@Override
	public int memoInsert(MemoVO memoVo) {
		// TODO Auto-generated method stub
		try {
			return dao.memoInsert(memoVo);
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}
	}

	@Override
	public int memoUpdate(MemoVO memoVo) {
		// TODO Auto-generated method stub
		try {
			return dao.memoUpdate(memoVo);
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}
	}

	@Override
	public int memoDelete(int mcode) {
		// TODO Auto-generated method stub
		try {
			return dao.memoDelete(mcode);

		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}
	}
}
