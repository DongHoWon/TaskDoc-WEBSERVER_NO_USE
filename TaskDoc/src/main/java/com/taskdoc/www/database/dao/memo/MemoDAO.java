package com.taskdoc.www.database.dao.memo;

import java.util.List;

import com.taskdoc.www.database.dto.MemoVO;

public interface MemoDAO {
	public List<MemoVO> memoList(int ptcode);
	public int memoInsert(MemoVO memo);
	public int memoUpdate(MemoVO memo);
	public int memoDelete(int mcode);
}
