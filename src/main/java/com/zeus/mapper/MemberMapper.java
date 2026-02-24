package com.zeus.mapper;

import com.zeus.domain.Member;
import com.zeus.domain.MemberAuth;

public interface MemberMapper {

	public Integer createAuth(MemberAuth memberAuth);

	public Integer create(Member member);

	
}
