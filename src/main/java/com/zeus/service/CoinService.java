package com.zeus.service;

import java.util.List;

import com.zeus.domain.ChargeCoin;

public interface CoinService {

	void charge(ChargeCoin chargeCoin) throws Exception;

	List<ChargeCoin> list(int userNo) throws Exception;

}
