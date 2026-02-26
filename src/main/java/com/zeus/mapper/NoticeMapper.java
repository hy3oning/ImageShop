package com.zeus.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zeus.common.domain.PageRequest;
import com.zeus.domain.Notice;

public interface NoticeMapper {

	int register(Notice notice);

	List<Notice> list(PageRequest pageRequest);

	Notice read(@Param("noticeNo") int noticeNo);

	int modify(Notice notice);

	int remove(@Param("noticeNo") int noticeNo);

	int count(PageRequest pageRequest);

}
