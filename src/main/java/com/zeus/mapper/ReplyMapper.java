package com.zeus.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zeus.domain.Reply;

public interface ReplyMapper {
	void register(Reply reply);

	List<Reply> listByBoardNo(@Param("boardNo") Integer boardNo);

	int remove(@Param("replyNo") Integer replyNo);

	Reply read(@Param("replyNo") Integer replyNo);

	void modify(Reply reply);
}
