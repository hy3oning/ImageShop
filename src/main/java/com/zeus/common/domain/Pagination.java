package com.zeus.common.domain;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

public class Pagination {

	private int totalCount; // 전체 게시글
	private int startPage; // 현재 페이지 블록의 시작 번호
	private int endPage; // 현재 페이지 블록의 끝 번호
	private boolean prev; // 이전 페이지 블록 존재 여부
	private boolean next; // 다음 페이지 블록 존재 여부
	private int displayPageNum = 10; // 화면에 보여줄 페이지 번호 개수
	private PageRequest pageRequest; // 현재 페이지 번호 + 페이지당 게시글 수

	// PageRequest 설정 (현재 페이지 정보 주입)
	public void setPageRequest(PageRequest pageRequest) {
		this.pageRequest = pageRequest;

	}

	// 전체 게시글 수 설정 후 페이지 계산 실행
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		calcData();
	}

	// 페이지 블록 및 prev/next 계산
	private void calcData() {
		// 현재 페이지가 속한 블록의 끝 번호 계산
		endPage = (int) (Math.ceil(pageRequest.getPage() / (double) displayPageNum) * displayPageNum);
		// 현재 블록의 시작 번호 계산
		startPage = (endPage - displayPageNum) + 1;
		// 실제 마지막 페이지 번호 계산
		int tempEndPage = (int) (Math.ceil(totalCount / (double) pageRequest.getSizePerPage()));
		// 계산된 끝 페이지가 실제 마지막 페이지보다 크면 보정
		if (endPage > tempEndPage) {
			endPage = tempEndPage;
		}
		// 이전 블록 존재 여부
		prev = startPage != 1;
		// 다음 블록 존재 여부
		next = endPage * pageRequest.getSizePerPage() < totalCount;
	}

	// 전체 게시글 수 반환
	public int getTotalCount() {
		return totalCount;
	}

	// 현재 블록 시작 페이지 반환
	public int getStartPage() {
		return startPage;
	}

	// 현재 블록 끝 페이지 반환
	public int getEndPage() {
		return endPage;
	}

	// 이전 블록 존재 여부 반환
	public boolean isPrev() {
		return prev;
	}

	// 다음 블록 존재 여부 반환
	public boolean isNext() {
		return next;
	}

	// 화면에 표시할 페이지 번호 개수 반환
	public int getDisplayPageNum() {
		return displayPageNum;
	}

	// PageRequest 반환
	public PageRequest getPageRequest() {
		return pageRequest;
	}

	// 페이지 이동용 쿼리 문자열 생성
	public String makeQuery(int page) {
		UriComponents uriComponents = UriComponentsBuilder.newInstance().queryParam("page", page)
				.queryParam("sizePerPage", pageRequest.getSizePerPage()).build();
		return uriComponents.toUriString();
	}
}
