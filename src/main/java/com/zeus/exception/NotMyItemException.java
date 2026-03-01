package com.zeus.exception;

public class NotMyItemException extends RuntimeException {
	private static final long serialVersionUID = 1L;

	public NotMyItemException(String message) {
		super(message);
	}

	public NotMyItemException(String message, Throwable cause) {
		super(message, cause);
	}

	public NotMyItemException() {
		super("NOT_MY_ITEM");
	}
}
