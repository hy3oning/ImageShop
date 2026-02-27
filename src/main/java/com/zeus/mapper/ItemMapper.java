package com.zeus.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zeus.domain.Item;

public interface ItemMapper {

	int register(Item item) throws Exception;

	List<Item> list() throws Exception;

	Item read(@Param("itemId") int itemId) throws Exception;

	int modify(Item item) throws Exception;

	int remove(@Param("itemId") int itemId) throws Exception;

	String getPreview(@Param("itemId") int itemId);

	String getPicture(@Param("itemId") int itemId);

}
