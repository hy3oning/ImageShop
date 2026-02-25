package com.zeus.mapper;

import java.util.List;

import com.zeus.domain.Board;

public interface BoardMapper {

	int register(Board board) throws Exception;

	List<Board> list() throws Exception;

}
