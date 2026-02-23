package com.zeus.mapper;

import java.util.List;

import com.zeus.domain.CodeGroup;

public interface CodeGroupMapper {
	public int create(CodeGroup codeGroup) throws Exception;

	public List<CodeGroup> list() throws Exception;
}