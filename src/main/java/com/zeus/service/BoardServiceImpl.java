package com.zeus.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zeus.domain.Board;
import com.zeus.mapper.BoardMapper;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardMapper mapper;

	@Override
	public int register(Board board) throws Exception {
		return mapper.register(board);
	}

	@Override
	public List<Board> list() throws Exception {
		return mapper.list();
	}

}
