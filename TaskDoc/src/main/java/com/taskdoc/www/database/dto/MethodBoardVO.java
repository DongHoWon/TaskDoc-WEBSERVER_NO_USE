package com.taskdoc.www.database.dto;

import org.apache.ibatis.type.Alias;

@Alias("methodboard")
public class MethodBoardVO {
	private int mbcode;
	private String mbtitle;
	private String mbcontents;
	private String mbdate;
	private int pcode;
	private String uid;

	public int getMbcode() {
		return mbcode;
	}

	public void setMbcode(int mbcode) {
		this.mbcode = mbcode;
	}

	public String getMbtitle() {
		return mbtitle;
	}

	public void setMbtitle(String mbtitle) {
		this.mbtitle = mbtitle;
	}

	public String getMbcontents() {
		return mbcontents;
	}

	public void setMbcontents(String mbcontents) {
		this.mbcontents = mbcontents;
	}

	public String getMbdate() {
		return mbdate;
	}

	public void setMbdate(String mbdate) {
		this.mbdate = mbdate;
	}

	public int getPcode() {
		return pcode;
	}

	public void setPcode(int pcode) {
		this.pcode = pcode;
	}

	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}

}
