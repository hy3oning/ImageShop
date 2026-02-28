package com.zeus.mapper;

import java.util.List;

import com.zeus.domain.UserItem;

public interface UserItemMapper {

	void register(UserItem userItem);

	UserItem read(int userItemNo);

	List<UserItem> list(int userNo);

}
