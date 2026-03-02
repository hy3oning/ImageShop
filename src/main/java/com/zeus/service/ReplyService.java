package com.zeus.service;

import java.util.List;

import com.zeus.domain.Reply;

public interface ReplyService {
	void register(Reply reply) throws Exception;

	List<Reply> list(Integer boardNo) throws Exception;

	void remove(Integer replyNo) throws Exception;

	Reply read(Integer replyNo) throws Exception;

	void modify(Reply reply, String loginId) throws Exception;
}
