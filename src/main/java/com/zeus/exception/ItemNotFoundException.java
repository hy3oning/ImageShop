package com.zeus.exception;

public class ItemNotFoundException extends RuntimeException {

	private static final long serialVersionUID = 1L;

	public ItemNotFoundException(int itemNo) {
		super("Item not found. itemNo=" + itemNo);
	}

}
