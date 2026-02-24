package com.zeus.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zeus.domain.Member;
import com.zeus.domain.MemberAuth;
import com.zeus.mapper.MemberMapper;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberMapper mapper;

	@Override
	@Transactional(rollbackFor = Exception.class)
	public int register(Member member) throws Exception {
		int count = mapper.register(member);
		if (count == 1) {
			MemberAuth memberAuth = new MemberAuth();
			memberAuth.setUserNo(member.getUserNo());
			memberAuth.setAuth("ROLE_MEMBER");
			mapper.createAuth(memberAuth);
		}
		return count;

	}

	@Override
	public List<Member> list() throws Exception {
		return mapper.list();
	}

}
