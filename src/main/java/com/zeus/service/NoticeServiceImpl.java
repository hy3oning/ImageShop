package com.zeus.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zeus.common.domain.PageRequest;
import com.zeus.domain.Notice;
import com.zeus.mapper.NoticeMapper;

@Service
public class NoticeServiceImpl implements NoticeService {
	@Autowired
	private NoticeMapper mapper;

	@Override
	@Transactional
	public int register(Notice notice) {
		return mapper.register(notice);
	}

	@Override
	public List<Notice> list(PageRequest pageRequest) {
		return mapper.list(pageRequest);
	}

	@Override
	public Notice read(int noticeNo) {
		return mapper.read(noticeNo);
	}

	@Override
	@Transactional
	public int modify(Notice notice) {
		return mapper.modify(notice);
	}

	@Override
	@Transactional
	public int remove(int noticeNo) {
		return mapper.remove(noticeNo);
	}

	@Override
	public int count(PageRequest pageRequest) {
		return mapper.count(pageRequest);
	}
}
