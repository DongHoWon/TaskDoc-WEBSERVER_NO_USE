package com.taskdoc.www.database.dto;

import org.apache.ibatis.type.Alias;

@Alias("project")
public class ProjectVO {
	private int pcode;
	private String ptitle;
	private String psubtitle;
	private String psdate;
	private String pedate;

	public int getPcode() {
		return pcode;
	}

	public void setPcode(int pcode) {
		this.pcode = pcode;
	}

	public String getPtitle() {
		return ptitle;
	}

	public void setPtitle(String ptitle) {
		this.ptitle = ptitle;
	}

	public String getPsubtitle() {
		return psubtitle;
	}

	public void setPsubtitle(String psubtitle) {
		this.psubtitle = psubtitle;
	}

	public String getPsdate() {
		return psdate;
	}

	public void setPsdate(String psdate) {
		this.psdate = psdate;
	}

	public String getPedate() {
		return pedate;
	}

	public void setPedate(String pedate) {
		this.pedate = pedate;
	}
}
