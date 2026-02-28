package com.zeus.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zeus.domain.ChargeCoin;
import com.zeus.domain.PayCoin;

public interface CoinMapper {

	List<ChargeCoin> list(@Param("userNo") int userNo) throws Exception;

	int charge(ChargeCoin chargeCoin) throws Exception;

	int register(ChargeCoin chargeCoin) throws Exception;

	public int pay(PayCoin payCoin) throws Exception;

	public void createPayHistory(PayCoin payCoin) throws Exception;

	public List<PayCoin> listPayHistory(int userNo) throws Exception;

}
