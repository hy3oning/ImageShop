package com.zeus.service;

import java.util.List;

import com.zeus.domain.Member;

public interface MemberService {

	public int register(Member member) throws Exception;

	public List<Member> list() throws Exception;

}
