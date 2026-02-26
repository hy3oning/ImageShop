package com.zeus.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zeus.domain.Board;
import com.zeus.mapper.BoardMapper;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardMapper mapper;

	@Override
	@Transactional
	public int register(Board board) throws Exception {
		return mapper.register(board);
	}

	@Override
	public List<Board> list() throws Exception {
		return mapper.list();
	}

	@Override
	public Board read(int boardNo) throws Exception {
		return mapper.read(boardNo);
	}

	@Override
	@Transactional
	public int modify(Board board) throws Exception {
		return mapper.modify(board);
	}

	@Override
	@Transactional
	public int remove(Board board) throws Exception {
		return mapper.remove(board);
	}


	@Override
	@Transactional
	public int modifyByAdmin(Board board) throws Exception {
		return mapper.modifyByAdmin(board);
	}

	@Override
	@Transactional
	public int removeByAdmin(int boardNo) throws Exception {
		return mapper.removeByAdmin(boardNo);
	}

	@Override
	public int count() throws Exception {
		return mapper.count();
	}

}
