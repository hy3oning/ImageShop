package com.zeus.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zeus.domain.Member;
import com.zeus.domain.MemberAuth;
import com.zeus.mapper.MemberMapper;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberMapper mapper;

	@Override
	public void register(Member member) throws Exception{
		mapper.create(member);
		MemberAuth memberAuth = new MemberAuth();
		memberAuth.setAuth("ROLE_MEMBER");
		mapper.createAuth(memberAuth);
		
	}

}
