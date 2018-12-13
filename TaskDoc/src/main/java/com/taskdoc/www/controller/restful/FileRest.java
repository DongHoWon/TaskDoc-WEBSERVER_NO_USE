package com.taskdoc.www.controller.restful;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.taskdoc.www.database.dto.FileVO;
import com.taskdoc.www.service.file.FileService;

@RestController
@RequestMapping("/file")
public class FileRest {

	@Autowired
	FileService service;
	
	@RequestMapping(value="/{dmcode}", method = RequestMethod.GET)
	public List<FileVO> fileList(@PathVariable int dmcode){
		return service.fileList(dmcode);
	}
	
	@RequestMapping(value="/{fcode}", method = RequestMethod.DELETE)
	public int delete(@PathVariable int fcode) {
		return service.fileDelete(fcode);
	}
	
	@RequestMapping(value = "/download/{fcode}", method = RequestMethod.POST)
	public void download(@PathVariable("fcode") int fcode, HttpServletResponse response) {
		
		Map<String, Object> map = service.fileDownload(fcode);
		byte[] data = (byte[]) map.get("data");
		String fileName = (String) map.get("name");

		response.setContentType("application/octet-stream");
		response.setContentLength(data.length);
		try {
			response.setHeader("Content-Disposition",
					"attachment; fileName=\"" + URLEncoder.encode(fileName, "UTF-8") + "\";");

			response.setHeader("Content-Transfer-Encoding", "binary");
			response.getOutputStream().write(data);

			response.getOutputStream().flush();
			response.getOutputStream().close();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
	
}
