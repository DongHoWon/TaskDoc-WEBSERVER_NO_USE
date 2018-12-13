package com.taskdoc.www.service.memo;

import java.util.List;

import com.taskdoc.www.database.dto.MemoVO;

public interface MemoService {
	public List<MemoVO> memoList(int ptcode);
	public int memoInsert(MemoVO memoVo);
	public int memoUpdate(MemoVO memoVo);
	public int memoDelete(int mcode);
}
