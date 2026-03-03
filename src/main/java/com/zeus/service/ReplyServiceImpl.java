package com.zeus.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zeus.domain.Reply;
import com.zeus.mapper.ReplyMapper;

@Service
public class ReplyServiceImpl implements ReplyService {

	@Autowired
	private ReplyMapper mapper;

	@Override
	public void register(Reply reply) throws Exception {
		mapper.register(reply);
	}

	@Override
	public List<Reply> list(Integer boardNo) throws Exception {
		return mapper.listByBoardNo(boardNo);
	}

	@Override
	public void remove(Integer replyNo) throws Exception {
		mapper.remove(replyNo);
	}

	@Override
	public Reply read(Integer replyNo) throws Exception {
		return mapper.read(replyNo);
	}

	@Override
	public void modify(Reply reply, String loginId) throws Exception {
		mapper.modify(reply);
	}
}