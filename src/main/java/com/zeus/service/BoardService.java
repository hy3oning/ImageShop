package com.zeus.service;

import java.util.List;

import com.zeus.domain.Board;

public interface BoardService {

	int register(Board board) throws Exception;

	List<Board> list() throws Exception;

}
