package com.taskdoc.www.database.dto;

import org.apache.ibatis.type.Alias;

@Alias("file")
public class FileVO {
	
	private int fcode;
	private String fname;
	private String fposition;
	private String fstname;
	private int dmcode;
	public int getFcode() {
		return fcode;
	}
	public void setFcode(int fcode) {
		this.fcode = fcode;
	}
	public String getFname() {
		return fname;
	}
	public void setFname(String fname) {
		this.fname = fname;
	}
	public String getFposition() {
		return fposition;
	}
	public void setFposition(String fposition) {
		this.fposition = fposition;
	}
	public String getFstname() {
		return fstname;
	}
	public void setFstname(String fstname) {
		this.fstname = fstname;
	}
	public int getDmcode() {
		return dmcode;
	}
	public void setDmcode(int dmcode) {
		this.dmcode = dmcode;
	}
	
	
}
