package com.zeus.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.AccessDeniedException;
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
		Reply rp = mapper.read(reply.getReplyNo());
		if (rp == null) {
			throw new RuntimeException("댓글이 존재하지 않습니다.");
		}
		if (rp.getWriter() == null || loginId == null || !rp.getWriter().equals(loginId)) {
			throw new AccessDeniedException("본인 댓글만 수정할 수 있습니다.");
		}
		// content 방어
		if (reply.getContent() != null) {
			reply.setContent(reply.getContent().trim());
		}
	}
}