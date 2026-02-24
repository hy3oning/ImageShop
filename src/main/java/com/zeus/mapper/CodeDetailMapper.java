package com.zeus.mapper;

import java.util.List;

import com.zeus.domain.CodeDetail;

public interface CodeDetailMapper {

	public Integer getMaxSortSeq(String groupCode) throws Exception;

	public Integer register(CodeDetail codeDetail) throws Exception;

	public List<CodeDetail> list() throws Exception;

	public CodeDetail read(CodeDetail codeDetail) throws Exception;

	public Integer remove(CodeDetail codeDetail) throws Exception;

	public Integer modify(CodeDetail codeDetail);
}
