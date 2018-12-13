package com.taskdoc.www.database.dto;

import org.apache.ibatis.type.Alias;

@Alias("chatcontents")
public class ChatContentsVO {
	private int cccode;
	private int crcode;
	private String uid;
	private String ccontents;
	private String cdate;
	private int dmcode;
	private int dscode;
	private int crcoderef;
	
	
	public int getCccode() {
		return cccode;
	}
	public void setCccode(int cccode) {
		this.cccode = cccode;
	}
	public int getCrcode() {
		return crcode;
	}
	public void setCrcode(int crcode) {
		this.crcode = crcode;
	}
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getCcontents() {
		return ccontents;
	}
	public void setCcontents(String ccontents) {
		this.ccontents = ccontents;
	}
	public String getCdate() {
		return cdate;
	}
	public void setCdate(String cdate) {
		this.cdate = cdate;
	}
	public int getDmcode() {
		return dmcode;
	}
	public void setDmcode(int dmcode) {
		this.dmcode = dmcode;
	}
	public int getDscode() {
		return dscode;
	}
	public void setDscode(int dscode) {
		this.dscode = dscode;
	}
	public int getCrcoderef() {
		return crcoderef;
	}
	public void setCrcoderef(int crcoderef) {
		this.crcoderef = crcoderef;
	}
}
