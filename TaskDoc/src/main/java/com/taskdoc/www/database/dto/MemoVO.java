package com.taskdoc.www.database.dto;

import org.apache.ibatis.type.Alias;

@Alias("memo")
public class MemoVO {
	private int mcode;
	private int ptcode;
	private String mcontents;
	private String mdate;
	public int getMcode() {
		return mcode;
	}
	public void setMcode(int mcode) {
		this.mcode = mcode;
	}
	public int getPtcode() {
		return ptcode;
	}
	public void setPtcode(int ptcode) {
		this.ptcode = ptcode;
	}
	public String getMcontents() {
		return mcontents;
	}
	public void setMcontents(String mcontents) {
		this.mcontents = mcontents;
	}
	public String getMdate() {
		return mdate;
	}
	public void setMdate(String mdate) {
		this.mdate = mdate;
	}
}
