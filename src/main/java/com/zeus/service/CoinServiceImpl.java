package com.zeus.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zeus.domain.ChargeCoin;
import com.zeus.domain.PayCoin;
import com.zeus.mapper.CoinMapper;

@Service
public class CoinServiceImpl implements CoinService {
	@Autowired
	private CoinMapper mapper;

	@Override
	@Transactional
	public void charge(ChargeCoin chargeCoin) throws Exception {
		int updateCount = mapper.charge(chargeCoin);
		int insertCount = mapper.register(chargeCoin);
		if (updateCount != 1 || insertCount != 1) {
			throw new RuntimeException("coin charge failed");
		}

	}

	@Override
	public List<ChargeCoin> list(int userNo) throws Exception {
		return mapper.list(userNo);
	}

	@Override
	public List<PayCoin> listPayHistory(int userNo) throws Exception {
		return mapper.listPayHistory(userNo);
	}
}
