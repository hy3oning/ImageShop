package com.zeus.mapper;

import java.util.List;

import com.zeus.domain.Member;
import com.zeus.domain.MemberAuth;

public interface MemberMapper {

	// 등록 처리
	public Integer register(Member member) throws Exception;

	// 권한 생성
	public Integer createAuth(MemberAuth memberAuth) throws Exception;

	// 목록 페이지
	public List<Member> list() throws Exception;

}
