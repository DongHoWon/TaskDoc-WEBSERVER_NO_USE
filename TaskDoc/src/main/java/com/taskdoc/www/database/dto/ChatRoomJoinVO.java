package com.taskdoc.www.database.dto;

import org.apache.ibatis.type.Alias;

@Alias("chatroomjoin")
public class ChatRoomJoinVO {
	private int crcode;
	private String uid;
	private int pcode;
	
	public int getPcode() {
		return pcode;
	}
	public void setPcode(int pcode) {
		this.pcode = pcode;
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
}
