package com.zeus.service;

import java.util.List;

import com.zeus.domain.CodeGroup;

public interface CodeGroupService {
	// 등록 처리
	public int register(CodeGroup codeGroup) throws Exception;

	// 목록 페이지
	public List<CodeGroup> list() throws Exception;

	// 상세 페이지
	public CodeGroup read(CodeGroup codeGroup) throws Exception;
}
