package com.zeus.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zeus.mapper.CoinMapper;
import com.zeus.mapper.UserItemMapper;

@Service
public class UserItemServiceImpl implements UserItemService {
	@Autowired
	private UserItemMapper mapper;

	@Autowired
	private CoinMapper coinMapper;
}
