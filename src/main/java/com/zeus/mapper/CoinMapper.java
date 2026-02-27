package com.zeus.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zeus.domain.ChargeCoin;

public interface CoinMapper {

	List<ChargeCoin> list(@Param("userNo") int userNo) throws Exception;

	int charge(ChargeCoin chargeCoin) throws Exception;

	int register(ChargeCoin chargeCoin) throws Exception;
}
