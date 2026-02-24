package com.zeus.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zeus.common.domain.CodeLabelValue;
import com.zeus.mapper.CodeMapper;

@Service
public class CodeServiceImpl implements CodeService {
	@Autowired
	private CodeMapper mapper;

	@Override
	public List<CodeLabelValue> getCodeGroupList() throws Exception {
		return mapper.getCodeGruopList();
	}
}
