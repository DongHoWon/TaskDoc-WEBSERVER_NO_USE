package com.taskdoc.www.database.dto;

import org.apache.ibatis.type.Alias;

@Alias("methodlist")
public class MethodListVO {
	private String uid;
	private int mbcode;
	private String mltitle;

	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}

	public int getMbcode() {
		return mbcode;
	}

	public void setMbcode(int mbcode) {
		this.mbcode = mbcode;
	}

	public String getMltitle() {
		return mltitle;
	}

	public void setMltitle(String mltitle) {
		this.mltitle = mltitle;
	}
}
