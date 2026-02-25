package com.zeus.mapper;

import java.util.List;

import com.zeus.domain.Board;

public interface BoardMapper {

	int register(Board board) throws Exception;

	List<Board> list() throws Exception;

	Board read(int boardNo) throws Exception;

	int modify(Board board) throws Exception;

	int modifyByAdmin(Board board) throws Exception;

}
