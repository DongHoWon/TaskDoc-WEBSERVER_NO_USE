package com.taskdoc.www.database.dto;

import org.apache.ibatis.type.Alias;

@Alias("notice")
public class NoticeVO {
	private int ncode;
	private int pcode;
	private String ntitle;
	private String ncontents;
	private String ndate;
	
	
	public int getNcode() {
		return ncode;
	}
	public void setNcode(int ncode) {
		this.ncode = ncode;
	}
	public int getPcode() {
		return pcode;
	}
	public void setPcode(int pcode) {
		this.pcode = pcode;
	}
	public String getNtitle() {
		return ntitle;
	}
	public void setNtitle(String ntitle) {
		this.ntitle = ntitle;
	}
	public String getNcontents() {
		return ncontents;
	}
	public void setNcontents(String ncontents) {
		this.ncontents = ncontents;
	}
	public String getNdate() {
		return ndate;
	}
	public void setNdate(String ndate) {
		this.ndate = ndate;
	}
}
