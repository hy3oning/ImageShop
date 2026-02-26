package com.zeus.service;

import java.util.List;

import com.zeus.common.domain.PageRequest;
import com.zeus.domain.Board;

public interface BoardService {

	int register(Board board) throws Exception;

	List<Board> list(PageRequest pageRequest) throws Exception;

	Board read(int boardNo) throws Exception;

	int modify(Board board) throws Exception;

	int remove(Board board)throws Exception;

	int modifyByAdmin(Board board) throws Exception;

	int removeByAdmin(int boardNo)throws Exception;
	
	int count(PageRequest pageRequest) throws Exception;

}
