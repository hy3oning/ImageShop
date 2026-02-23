package com.zeus.mapper;

import com.zeus.domain.MemberAuth;

public interface MemberMapper {
	public void createAuth(MemberAuth memberAuth) throws Exception;

	public void deleteAuth(int userNo) throws Exception;

}
