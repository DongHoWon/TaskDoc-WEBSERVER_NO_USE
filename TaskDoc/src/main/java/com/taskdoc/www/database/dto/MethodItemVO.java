package com.taskdoc.www.database.dto;

import org.apache.ibatis.type.Alias;

@Alias("methoditem")
public class MethodItemVO {
	private String mititle;
	private int misequence;
	private int mcode;
	
	public int getMcode() {
		return mcode;
	}
	public void setMcode(int micode) {
		this.mcode = micode;
	}
	public String getMititle() {
		return mititle;
	}
	public void setMititle(String mititle) {
		this.mititle = mititle;
	}
	public int getMisequence() {
		return misequence;
	}
	public void setMisequence(int misequence) {
		this.misequence = misequence;
	}
}
