package com.zeus.mapper;

import java.util.List;

import com.zeus.domain.CodeGroup;

public interface CodeGroupMapper {
	public int create(CodeGroup codeGroup) throws Exception;

	public List<CodeGroup> list() throws Exception;

	public CodeGroup read(CodeGroup codeGroup) throws Exception;

	public int modify(CodeGroup codeGroup) throws Exception;

	public int remove(CodeGroup codeGroup);
}