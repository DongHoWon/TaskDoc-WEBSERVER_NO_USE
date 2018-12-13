package com.taskdoc.www.database.dto;

import org.apache.ibatis.type.Alias;

@Alias("decisionitem")
public class DecisionItemVO {
	private int dsicode;
	private String dsilist;
	private int dsisequence;
	private int dscode;
	
	
	public int getDsicode() {
		return dsicode;
	}
	public void setDsicode(int dsicode) {
		this.dsicode = dsicode;
	}
	public String getDsilist() {
		return dsilist;
	}
	public void setDsilist(String dsilist) {
		this.dsilist = dsilist;
	}
	public int getDsisequence() {
		return dsisequence;
	}
	public void setDsisequence(int dsisequence) {
		this.dsisequence = dsisequence;
	}
	public int getDscode() {
		return dscode;
	}
	public void setDscode(int dscode) {
		this.dscode = dscode;
	}
}
