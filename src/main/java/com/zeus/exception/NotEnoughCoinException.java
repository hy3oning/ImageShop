package com.zeus.exception;

public class NotEnoughCoinException extends RuntimeException {
	private static final long serialVersionUID = 1L;

	public NotEnoughCoinException() {
		super("NOT_ENOUGH_COIN");
	}

	public NotEnoughCoinException(String message) {
		super(message);
	}

	public NotEnoughCoinException(String message, Throwable cause) {
		super(message, cause);
	}
}
