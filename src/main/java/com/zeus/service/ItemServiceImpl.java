package com.zeus.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zeus.domain.Item;
import com.zeus.mapper.ItemMapper;

@Service
public class ItemServiceImpl implements ItemService {
	@Autowired
	private ItemMapper mapper;

	@Override
	@Transactional
	public int register(Item item) throws Exception {
		return mapper.register(item);
	}

	@Override
	public List<Item> list() throws Exception {
		return mapper.list();
	}

	@Override
	public Item read(int itemId) throws Exception {
		return mapper.read(itemId);
	}

	@Override
	@Transactional
	public int modify(Item item) throws Exception {
		return mapper.modify(item);
	}

	@Override
	@Transactional
	public int remove(int itemId) throws Exception {
		return mapper.remove(itemId);
	}

	@Override
	public String getPreview(int itemId) throws Exception {
		return mapper.getPreview(itemId);
	}

	@Override
	public String getPicture(int itemId) throws Exception {
		return mapper.getPicture(itemId);
	}
}
