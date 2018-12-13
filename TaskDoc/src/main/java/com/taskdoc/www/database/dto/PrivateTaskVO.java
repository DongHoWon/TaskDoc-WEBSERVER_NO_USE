package com.taskdoc.www.database.dto;

import org.apache.ibatis.type.Alias;

@Alias("privatetask")
public class PrivateTaskVO {
	private int ptcode;
	private String pttitle;
	private String ptcolor;
	private String ptsdate;
	private String ptedate;
	private int ptpercent;
	private int ptsequence;
	private int ptrefference;
	private int tcode;
	private String uid;
	public int getPtcode() {
		return ptcode;
	}
	public void setPtcode(int ptcode) {
		this.ptcode = ptcode;
	}
	public String getPttitle() {
		return pttitle;
	}
	public void setPttitle(String pttitle) {
		this.pttitle = pttitle;
	}
	
	public String getPtcolor() {
		return ptcolor;
	}
	public void setPtcolor(String ptcolor) {
		this.ptcolor = ptcolor;
	}
	public String getPtsdate() {
		return ptsdate;
	}
	public void setPtsdate(String ptsdate) {
		this.ptsdate = ptsdate;
	}
	public String getPtedate() {
		return ptedate;
	}
	public void setPtedate(String ptedate) {
		this.ptedate = ptedate;
	}
	public int getPtpercent() {
		return ptpercent;
	}
	public void setPtpercent(int ptpercent) {
		this.ptpercent = ptpercent;
	}
	public int getPtsequence() {
		return ptsequence;
	}
	public void setPtsequence(int ptsequence) {
		this.ptsequence = ptsequence;
	}
	public int getPtrefference() {
		return ptrefference;
	}
	public void setPtrefference(int ptrefference) {
		this.ptrefference = ptrefference;
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
