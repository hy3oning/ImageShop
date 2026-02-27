package com.zeus.service;

import java.util.List;

import com.zeus.domain.Item;

public interface ItemService {

	int register(Item item) throws Exception;

	List<Item> list() throws Exception;

	Item read(int itemId) throws Exception;

	int modify(Item item) throws Exception;

	int remove(int itemId) throws Exception;

	String getPreview(int itemId) throws Exception;

	String getPicture(int itemId) throws Exception;
}
