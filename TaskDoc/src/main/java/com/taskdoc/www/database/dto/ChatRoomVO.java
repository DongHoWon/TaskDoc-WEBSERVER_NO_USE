package com.taskdoc.www.database.dto;

import org.apache.ibatis.type.Alias;

@Alias("chatroom")
public class ChatRoomVO {
	private int crcode;
	private String crdate;
	private int crmode;
	private int crclose;
	private int tcode;
	private int crcoderef;
	private String fctitle;
	
	public int getCrcode() {
		return crcode;
	}
	public void setCrcode(int crcode) {
		this.crcode = crcode;
	}
	public String getCrdate() {
		return crdate;
	}
	public void setCrdate(String crdate) {
		this.crdate = crdate;
	}
	public int getCrmode() {
		return crmode;
	}
	public void setCrmode(int crmode) {
		this.crmode = crmode;
	}
	public int getCrclose() {
		return crclose;
	}
	public void setCrclose(int crclose) {
		this.crclose = crclose;
	}
	public int getTcode() {
		return tcode;
	}
	public void setTcode(int tcode) {
		this.tcode = tcode;
	}
	public int getCrcoderef() {
		return crcoderef;
	}
	public void setCrcoderef(int crcoderef) {
		this.crcoderef = crcoderef;
	}
	public String getFctitle() {
		return fctitle;
	}
	public void setFctitle(String fctitle) {
		this.fctitle = fctitle;
	}
	
}
