package com.zeus.service;

import java.util.List;

import com.zeus.domain.ChargeCoin;
import com.zeus.domain.PayCoin;

public interface CoinService {

	void charge(ChargeCoin chargeCoin) throws Exception;

	List<ChargeCoin> list(int userNo) throws Exception;

	List<PayCoin> listPayHistory(int userNo) throws Exception;

}
