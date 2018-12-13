package com.taskdoc.www.database.dto;

import org.apache.ibatis.type.Alias;

@Alias("voter")
public class VoterVO {
	private int dsicode;
	private String uid;
	
	
	public int getDsicode() {
		return dsicode;
	}
	public void setDsicode(int dsicode) {
		this.dsicode = dsicode;
	}
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
}
