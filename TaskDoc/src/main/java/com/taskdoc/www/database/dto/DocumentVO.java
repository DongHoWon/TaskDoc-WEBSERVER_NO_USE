package com.taskdoc.www.database.dto;

import org.apache.ibatis.type.Alias;

@Alias("document")
public class DocumentVO {
	private int dmcode;
	private String dmtitle;
	private String dmcontents;
	private String dmdate;
	private int crcode;
	private int tcode;
	private String uid;
	
	public int getDmcode() {
		return dmcode;
	}
	public void setDmcode(int dmcode) {
		this.dmcode = dmcode;
	}
	public String getDmtitle() {
		return dmtitle;
	}
	public void setDmtitle(String dmtitle) {
		this.dmtitle = dmtitle;
	}
	public String getDmcontents() {
		return dmcontents;
	}
	public void setDmcontents(String dmcontents) {
		this.dmcontents = dmcontents;
	}
	public String getDmdate() {
		return dmdate;
	}
	public void setDmdate(String dmdate) {
		this.dmdate = dmdate;
	}
	public int getCrcode() {
		return crcode;
	}
	public void setCrcode(int crcode) {
		this.crcode = crcode;
	}
	public int getTcode() {
		return tcode;
	}
	public void setTcode(int tcode) {
		this.tcode = tcode;
	}
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	
	
}
