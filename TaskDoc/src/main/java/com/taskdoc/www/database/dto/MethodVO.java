package com.taskdoc.www.database.dto;

import org.apache.ibatis.type.Alias;

@Alias("method")
public class MethodVO {
	private int mcode;
	private String method;
	private String mcontents;
	
	
	public int getMcode() {
		return mcode;
	}
	public void setMcode(int mcode) {
		this.mcode = mcode;
	}
	public String getMethod() {
		return method;
	}
	public void setMethod(String method) {
		this.method = method;
	}
	public String getMcontents() {
		return mcontents;
	}
	public void setMcontents(String mcontents) {
		this.mcontents = mcontents;
	}
	
}
