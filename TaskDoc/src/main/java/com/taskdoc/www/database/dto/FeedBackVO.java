package com.taskdoc.www.database.dto;

import org.apache.ibatis.type.Alias;

@Alias("feedback")
public class FeedBackVO {
	private int fbcode;
	private int dmcode;
	private String uid;
	private String fbcontents;
	private String fbdate;

	public int getFbcode() {
		return fbcode;
	}

	public void setFbcode(int fbcode) {
		this.fbcode = fbcode;
	}

	public int getDmcode() {
		return dmcode;
	}

	public void setDmcode(int dmcode) {
		this.dmcode = dmcode;
	}

	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}

	public String getFbcontents() {
		return fbcontents;
	}

	public void setFbcontents(String fbcontents) {
		this.fbcontents = fbcontents;
	}

	public String getFbdate() {
		return fbdate;
	}

	public void setFbdate(String fbdate) {
		this.fbdate = fbdate;
	}

}
