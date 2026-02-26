package com.zeus.common.domain;

import org.springframework.web.util.UriComponentsBuilder;

public class PageRequest {

	private int page; // 현재 페이지 번호
	private int sizePerPage; // 페이지당 게시글 수
	private String searchType;
	private String keyword;

	// 기본값 설정 (1페이지,10개씩)
	public PageRequest() {
		this.page = 1;
		this.sizePerPage = 10;
	}

	// 페이지 번호 설정 (0 이하 방어)
	public void setPage(int page) {
		if (page <= 0) {
			this.page = 1;
			return;
		}
		this.page = page;
	}

	// 페이지당 게시글 수 설정 (비정상 값 방어)
	public void setSizePerPage(int size) {
		if (size <= 0 || size > 100) {
			this.sizePerPage = 10;
			return;
		}
		this.sizePerPage = size;
	}

	// 현재 페이지 번호 반환
	public int getPage() {
		return page;
	}

	// DB 조회용 시작 위치 계산
	public int getPageStart() {
		return (this.page - 1) * sizePerPage;
	}

	// 페이지당 게시글 수 반환
	public int getSizePerPage() {
		return sizePerPage;
	}

	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		if (searchType == null) {
			this.searchType = null;
			return;
		}
		String st = searchType.trim();
		this.searchType = st.isEmpty() ? null : st;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		if (keyword == null) {
			this.keyword = null;
			return;
		}
		String kw = keyword.trim();
		this.keyword = kw.isEmpty() ? null : kw;
	}

	// 내부 공용: 기본 파라미터 + (옵션) 검색 파라미터를 안전하게 붙인다.
	private UriComponentsBuilder baseBuilder(int page, boolean includeSearch) {
		UriComponentsBuilder builder = UriComponentsBuilder.newInstance().queryParam("page", page)
				.queryParam("sizePerPage", this.sizePerPage);

		if (includeSearch) {
			if (this.searchType != null) {
				builder.queryParam("searchType", this.searchType);
			}
			if (this.keyword != null) {
				builder.queryParam("keyword", this.keyword);
			}
		}
		return builder;
	}

	// 현재 상태 그대로 (page 포함) + 검색 포함
	public String toUriString() {
		return baseBuilder(this.page, true).build().toUriString();
	}

	// 특정 page로 + 검색 포함
	public String toUriString(int page) {
		return baseBuilder(page, true).build().toUriString();
	}

	// 특정 page로 + 검색 제외(페이징만)
	public String toUriStringByPage(int page) {
		return baseBuilder(page, false).build().toUriString();
	}
}
