package com.taskdoc.www.database.dao.notice;

import java.util.List;

import com.taskdoc.www.database.dto.NoticeVO;

public interface NoticeDAO {
	public List<NoticeVO> noticeList(int pcode);
	public NoticeVO noticeView(int ncode);
	public NoticeVO noticeInsert(NoticeVO noticeVo);
	public int noticeUpdate(NoticeVO noticeVo);
	public int noticeDelete(int ncode);
}
