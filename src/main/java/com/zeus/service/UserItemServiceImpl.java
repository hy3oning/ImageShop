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
		// 사용자 정보번호
		int userNo = member.getUserNo();
		// 구입한 물건 정보
		int itemId = item.getItemId();
		int price = item.getPrice();

		// 구입한 물건에 대한 코인지급
		PayCoin payCoin = new PayCoin();
		payCoin.setUserNo(userNo);
		payCoin.setItemId(itemId);
		payCoin.setAmount(price);

		int updated = coinMapper.pay(payCoin);
		if (updated == 0)
			throw new NotEnoughCoinException("코인이 부족합니다.");

		coinMapper.createPayHistory(payCoin);

		// 장바구니 등록(구입한사용자정보, 구입한 물건정보)
		UserItem userItem = new UserItem();
		userItem.setUserNo(userNo);
		userItem.setItemId(itemId);

		// 장바구니 생성
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
