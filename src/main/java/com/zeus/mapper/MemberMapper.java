package com.zeus.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zeus.domain.Member;
import com.zeus.domain.MemberAuth;

public interface MemberMapper {

	// 등록 처리
	int register(Member member) throws Exception;

	// 권한 생성
	int createAuth(MemberAuth memberAuth) throws Exception;

	// 목록 페이지
	List<Member> list() throws Exception;

	// 상세 페이지(수정)
	Member read(int userNo) throws Exception;

	// 수정 처리
	int modify(Member member) throws Exception;

	// 권한 추가 처리
	int modifyAuth(MemberAuth memberAuth) throws Exception;

	// 권한 삭체 처리
	int deleteAuth(@Param("userNo") int userNo) throws Exception;

	int remove(int userNo) throws Exception;

	int countAll() throws Exception;

}
