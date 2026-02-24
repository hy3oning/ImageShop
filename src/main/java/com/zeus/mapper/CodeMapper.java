package com.zeus.mapper;

import java.util.List;

import com.zeus.common.domain.CodeLabelValue;

public interface CodeMapper {

	public List<CodeLabelValue> getCodeGruopList() throws Exception;

	public List<CodeLabelValue> getCodeList(String groupCode) throws Exception;

}
