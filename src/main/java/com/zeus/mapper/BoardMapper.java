package com.zeus.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zeus.common.domain.PageRequest;
import com.zeus.domain.Board;

public interface BoardMapper {

	int register(Board board) throws Exception;

	List<Board> list(PageRequest pageRequest) throws Exception;

	Board read(@Param("boardNo") int boardNo) throws Exception;

	int modify(Board board) throws Exception;

	int remove(Board board) throws Exception;

	int modifyByAdmin(Board board) throws Exception;

	int removeByAdmin(@Param("boardNo") int boardNo) throws Exception;

	int count(PageRequest pageRequest) throws Exception;
}
