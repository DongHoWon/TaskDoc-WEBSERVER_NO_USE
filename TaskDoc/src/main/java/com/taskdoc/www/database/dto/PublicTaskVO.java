package com.taskdoc.www.database.dto;

import org.apache.ibatis.type.Alias;

@Alias("publictask")
public class PublicTaskVO {
	private int tcode;
	private String ttitle;
	private String tcolor;
	private String tsdate;
	private String tedate;
	private int tpercent;
	private int tsequence;
	private int trefference;
	private int pcode;

	public int getTcode() {
		return tcode;
	}

	public void setTcode(int tcode) {
		this.tcode = tcode;
	}

	public String getTtitle() {
		return ttitle;
	}

	public void setTtitle(String ttitle) {
		this.ttitle = ttitle;
	}

	public String getTsdate() {
		return tsdate;
	}

	public void setTsdate(String tsdate) {
		this.tsdate = tsdate;
	}

	public String getTedate() {
		return tedate;
	}

	public void setTedate(String tedate) {
		this.tedate = tedate;
	}

	public String getTcolor() {
		return tcolor;
	}

	public void setTcolor(String tcolor) {
		this.tcolor = tcolor;
	}

	public int getTpercent() {
		return tpercent;
	}

	public void setTpercent(int tpercent) {
		this.tpercent = tpercent;
	}

	public int getTsequence() {
		return tsequence;
	}

	public void setTsequence(int tsequence) {
		this.tsequence = tsequence;
	}

	public int getTrefference() {
		return trefference;
	}

	public void setTrefference(int trefference) {
		this.trefference = trefference;
	}

	public int getPcode() {
		return pcode;
	}

	public void setPcode(int pcode) {
		this.pcode = pcode;
	}

}
