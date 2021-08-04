package com.team.d.utils;

import java.io.File;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

public class FileUtils {
	
	public static String fileUpload(MultipartHttpServletRequest multipartRequest, MultipartFile file, int seq) {
		if (file != null && !file.isEmpty()) {

			// 올릴 때 파일명
			String originalFilename = file.getOriginalFilename();
			
			// 서버에 저장할 파일명
			// 파일명의 중복 방지 대책이 필요
			// 파일명_올린시간.확장자
			String extension = originalFilename.substring( originalFilename.lastIndexOf(".") + 1 );
			String filename = originalFilename.substring( 0, originalFilename.lastIndexOf(".") );
			String uploadFilename = filename + "_" + System.currentTimeMillis() + "." + extension;
			
			// 첨부파일을 저장할 서버 위치
			String realPath = multipartRequest.getServletContext().getRealPath("resources/archive/board");  // archive 디렉터리는 없으므로 생성이 필요
			
			// archive 디렉터리 생성
			File archive = new File(realPath);
			if ( !archive.exists() ) {
				archive.mkdirs();
			}
			
			// 서버에 첨부파일 저장
			File attach = new File(archive, uploadFilename);
			try {
				file.transferTo(attach);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			switch(seq) {
			case 1:
				return uploadFilename;
			case 2:
				return uploadFilename;	
			case 3:
				return uploadFilename;
			}
		}	// if문
		return "null";
		
	}
	
	public static void deleteFile(MultipartHttpServletRequest multipartRequest, String filename, String folder) {
		if(filename != "null" && filename != "") {
			String realPath = multipartRequest.getServletContext().getRealPath("resources/archive/" + folder);
			File file = new File(realPath, filename);
			if(file != null && file.exists()) {
				file.delete();
			}
		}	
		
	}
}
