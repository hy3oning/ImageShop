package com.zeus.service;

import java.util.List;

import com.zeus.domain.Item;
import com.zeus.domain.Member;
import com.zeus.domain.UserItem;

public interface UserItemService {

	void register(Member member, Item item) throws Exception;

	List<UserItem> list(int userNo) throws Exception;

	UserItem read(int userItemNo) throws Exception;

}
