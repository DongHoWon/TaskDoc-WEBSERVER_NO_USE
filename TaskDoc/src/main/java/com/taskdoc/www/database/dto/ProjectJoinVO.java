package com.taskdoc.www.database.dto;

import org.apache.ibatis.type.Alias;

@Alias("projectjoin")
public class ProjectJoinVO {
	private int pcode;
	private String uid;
	private String ppermission;
	private int pinvite;

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

	public String getPpermission() {
		return ppermission;
	}

	public void setPpermission(String ppermission) {
		this.ppermission = ppermission;
	}

	public int getPinvite() {
		return pinvite;
	}

	public void setPinvite(int pinvite) {
		this.pinvite = pinvite;
	}
}
