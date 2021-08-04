package com.team.d.utils;

import com.team.d.dto.PageDTO;

public class PagingUtils {

	private static int beginPage;
	private static int endPage;
	private static int totalPage;

	private static int RecordPerPage = 5;
	private static int pagePerBlock = 3;	
	
	private static int beginRecord;
	private static int endRecord;
	
	// 어떤식으로 paging을 구성할지 PageDTO에 담아서 알려주는 함수
	public static PageDTO getPage(int totalRecord, int page) {
		
		// 현재 페이지에서의 시작 record 번호(맨 처음 record 번호: 1)
		beginRecord = (page - 1) * RecordPerPage  + 1;
		// 현재 페이지에서의 마지막 record 번호
		endRecord = beginRecord + RecordPerPage - 1 ;
		if(endRecord > totalRecord) {
			// endRecord의 최대값은 totalRecord
			endRecord = totalRecord;
		}	// if
		
		// 전체 페이지 수를 구한다.
		totalPage = (totalRecord / RecordPerPage);
		
		if(totalRecord % RecordPerPage != 0) {	
			totalPage++;	// 반올림과 같은 효과
		}	// if
		
		// 현재 페이지가 포함된 블록의 시작 page번호
		for(int i = page; page >= 1; i--) {
			if(i % pagePerBlock == 1) {
				beginPage = i;
				break;
			}
		}
		// beginPage = ((page - 1) / pagePerBlock) * pagePerBlock + 1;
		
		// 현재 페이지가 포함된 블록의 마지막 page번호
		endPage = beginPage + pagePerBlock - 1;
		// endPage의 최대값은 totalPage
		if(endPage > totalPage) {
			endPage = totalPage;
		}
		
		// PageDTO에 위에서 구한 데이터를 저장해서 반환
		return new PageDTO(page, totalRecord, 
				RecordPerPage, beginRecord, 
								      endRecord, totalPage, 
								      pagePerBlock, beginPage, endPage); 
		
	}
	
	// paging의 html을 string 형태로 반환해주는 함수
	public static String getPaging(String path, int page) {
		StringBuilder sb = new StringBuilder();	
		
		// 첫 블록이라면
		if (beginPage <= pagePerBlock) {	
			sb.append("◀&nbsp;");
		} else {	// 첫 블록이 아니라면
			if (path.indexOf("?") > 0) {	
				// get방식으로 parameter가 붙어있다면 &를 이용해서 파라미터를 연장해줌
				sb.append("<a href=\"" + path + "&page=" + (beginPage - 1) + "\">◀</a>&nbsp;");
			} else {	
				// parameter가 붙어있지 않다면 "?를 이용해서 파라미터 붙여줌"
				sb.append("<a href=\"" + path + "?page=" + (beginPage - 1) + "\">◀</a>&nbsp;");
			} 	// else of inner
		}	// else of outer
		
		for(int i = beginPage; i <= endPage; i++) {
			if(i == page) {	// 현재 보고 있는 페이지번호를 추가할 때는 단순 문자처리
				sb.append(i + "&nbsp;");
			} else {	// 다른 페이지에는 href를 붙여줘야한다.
				if(path.indexOf("?") > 0) {
					// get방식으로 parameter가 붙어있다면 &를 이용해서 파라미터를 연장해줌
					sb.append("<a href=\"" + path + "&page=" + i + "\">" + i + "</a>&nbsp;");
				} else {
					// parameter가 붙어있지 않다면 "?를 이용해서 파라미터 붙여줌"
					sb.append("<a href=\"" + path + "?page=" + i + "\">" + i + "</a>&nbsp;");					
				}	// else of inner
			}	// else of outer
		}
		
		// 현 블록의 endPage가 마지막 페이지라면 
		if (endPage == totalPage) {	
			//다음으로 넘어갈 필요가 없으므로 단순 문자 처리
			sb.append("▶");
		} else {	// 아직 남은 page가 더 있다면
			if (path.indexOf("?") > 0) {
				// get방식으로 parameter가 붙어있다면 &를 이용해서 파라미터를 연장해줌
				sb.append("<a href=\"" + path + "&page=" + (endPage + 1) + "\">▶</a>");
			} else {
				// parameter가 붙어있지 않다면 "?를 이용해서 파라미터 붙여줌"
				sb.append("<a href=\"" + path + "?page=" + (endPage + 1) + "\">▶</a>");
			}	// else of inner
		}	// else of outer
		
		return sb.toString();
	}
	
	// ajax 사용
	public static PageDTO getPageByAjax(int totalRecord, int page) {
		
		int recordPerPage = 5;
		int beginRecord = (page - 1) * recordPerPage + 1;
		int endRecord = beginRecord + recordPerPage - 1;
		endRecord = endRecord < totalRecord ? endRecord : totalRecord;
		
		int totalPage = (totalRecord / recordPerPage) + (totalRecord % recordPerPage > 0 ? 1 : 0);
		int pagePerBlock = 3;
		int beginPage = ((page - 1) / pagePerBlock) * pagePerBlock + 1;
		int endPage = beginPage + pagePerBlock - 1;
		endPage = endPage < totalPage ? endPage : totalPage;
		
		PageDTO paging = new PageDTO();
		paging.setPage(page);
		paging.setTotalRecord(totalRecord);
		paging.setRecordPerPage(recordPerPage);
		paging.setBeginRecord(beginRecord);
		paging.setEndRecord(endRecord);
		paging.setTotalPage(totalPage);
		paging.setPagePerBlock(pagePerBlock);
		paging.setBeginPage(beginPage);
		paging.setEndPage(endPage);
		
		return paging;
		
	}
	
}
