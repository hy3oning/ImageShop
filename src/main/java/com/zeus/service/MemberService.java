package com.zeus.service;

import java.util.List;

import com.zeus.domain.Member;

public interface MemberService {

	public int register(Member member) throws Exception;

	public List<Member> list() throws Exception;

	public Member read(int userNo) throws Exception;

	public int modify(Member member) throws Exception;

	public int remove(int userNo) throws Exception;

}
