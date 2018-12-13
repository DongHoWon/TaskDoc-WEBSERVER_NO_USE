package com.taskdoc.www.system;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.taskdoc.www.database.dao.publictask.PublicTaskDAO;
import com.taskdoc.www.database.dto.PublicTaskVO;

public class FileUploadBaseUrl {
	private String URL;
	@Autowired 
	PublicTaskDAO dao;

	public String getURL() {
		String[] split = URL.split("/");
		String url = "";
		
		for(String s : split) {
			url += s + File.separator ;
		}
		System.out.println(url);
		return url;
	}

	public void setURL(String uRL) {
		URL = uRL;
	}
	
	public String getTaskPath(int tcode) {
		String url = "";
		
		if (tcode == 0) {
			// 채팅방에서 탐색
			url += "TEMP" + File.separator;
		} else {
			// 업무코드에서 탐색
			List<PublicTaskVO> vos = new ArrayList<>();
			while (true) {
				PublicTaskVO vo = dao.publicTaskView(tcode);

				vos.add(vo);

				if (vo.getTcode() == vo.getTrefference()) {
					break;
				} else {
					tcode = vo.getTrefference();
				}
			}
			
			for(int i=vos.size()-1;i>=0;i--) {
				PublicTaskVO vo = vos.get(i);
				url += vo.getTcode() + "_" + vo.getTtitle();
				url += File.separator;
			}
			
		}
		return url;
	}
}
