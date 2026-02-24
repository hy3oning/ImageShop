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
	@Transactional
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
	@Transactional(readOnly = true)
	public List<Member> list() throws Exception {
		return mapper.list();
	}

	@Override
	@Transactional(readOnly = true)
	public Member read(int userNo) throws Exception {
		return mapper.read(userNo);
	}

	@Override
	@Transactional
	public int modify(Member member) throws Exception {
		// 1)회원 기본정보 수정
		int count = mapper.modify(member);
		// 2) 권한 목록이 없으면 여기서 종료
		int userNo = member.getUserNo();
		// 3) 기존 권한 삭제
		mapper.deleteAuth(userNo);
		// 4) 새 권한 등록
		List<MemberAuth> authList = member.getAuthList();
		if (authList != null) {
			for (MemberAuth memberAuth : authList) {
				if (memberAuth == null)
					continue;
				String auth = memberAuth.getAuth();
				if (auth == null)
					continue;
				if (auth.trim().isEmpty())
					continue;
				memberAuth.setUserNo(userNo);
				mapper.modifyAuth(memberAuth);
			}
		}
		return count;
	}

	@Override
	@Transactional
	public int remove(int userNo) throws Exception {
		mapper.deleteAuth(userNo);
		int count = mapper.remove(userNo);
		return count;
	}

}
