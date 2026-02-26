package com.zeus.service;

import java.util.List;

import com.zeus.common.domain.PageRequest;
import com.zeus.domain.Notice;

public interface NoticeService {

	int register(Notice notice);

	List<Notice> list(PageRequest pageRequest);

	int count(PageRequest pageRequest);

	Notice read(int noticeNo);

	int modify(Notice notice);

	int remove(int noticeNo);

}
