package com.zeus.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zeus.domain.Item;
import com.zeus.domain.Member;
import com.zeus.domain.PayCoin;
import com.zeus.domain.UserItem;
import com.zeus.exception.NotEnoughCoinException;
import com.zeus.mapper.CoinMapper;
import com.zeus.mapper.UserItemMapper;

@Service
public class UserItemServiceImpl implements UserItemService {

	@Autowired
	private UserItemMapper mapper;

	@Autowired
	private CoinMapper coinMapper;

	@Transactional
	public void register(Member member, Item item) throws Exception {
		int userNo = member.getUserNo();
		int itemId = item.getItemId();
		int price = item.getPrice();

		PayCoin payCoin = new PayCoin();
		payCoin.setUserNo(userNo);
		payCoin.setItemId(itemId);
		payCoin.setAmount(price);

		int updated = coinMapper.pay(payCoin);
		if (updated == 0)
			throw new NotEnoughCoinException("코인이 부족합니다.");

		coinMapper.createPayHistory(payCoin);

		UserItem userItem = new UserItem();
		userItem.setUserNo(userNo);
		userItem.setItemId(itemId);
		mapper.register(userItem);
	}

	@Override
	public UserItem read(int userItemNo) throws Exception {
		return mapper.read(userItemNo);
	}

	@Override
	public List<UserItem> list(int userNo) throws Exception {
		return mapper.list(userNo);
	}

}
