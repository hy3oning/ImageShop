package com.zeus.common.exception;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.context.request.WebRequest;

import com.zeus.exception.ItemNotFoundException;
import com.zeus.exception.NotEnoughCoinException;
import com.zeus.exception.NotMyItemException;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@ControllerAdvice
public class CommonExceptionHandler {

	// 코인 부족 예외 처리
	@ExceptionHandler(NotEnoughCoinException.class)
	public String handleNotEnoughCoinException(NotEnoughCoinException ex, WebRequest request) {
		log.warn("Not enough coin", ex);
		return "redirect:/coin/notEnoughCoin";
	}

	// 본인 상품 예외 처리
	@ExceptionHandler(NotMyItemException.class)
	public String handleNotMyItemException(NotMyItemException ex, WebRequest request) {
		log.warn("Not my Item", ex);
		return "redirect:/useritem/notMyItem";
	}

	// 접근 거부 예외 처리
	@ExceptionHandler(AccessDeniedException.class)
	public void handleAccessDeniedException(AccessDeniedException ex, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		if (isAjax(request)) {
			// 403 상태코드, 클라이언트가 인증되지 않았거나 권한이 없는곳을 접근하고 있음을 표시함.
			response.setStatus(HttpServletResponse.SC_FORBIDDEN);
		} else {
			throw ex;
		}
	}

	// 없는 아이템 번호
	@ExceptionHandler(ItemNotFoundException.class)
	public String handleItemNotFound(ItemNotFoundException ex) {
		log.warn("Item not found", ex);
		return "redirect:/item/notFound";
	}

	// 일반 예외 처리
	@ExceptionHandler(Exception.class)
	public String handle(Exception ex) {
		log.warn("handle ex " + ex.toString());
		return "error/errorCommon";
	}

	public static boolean isAjax(HttpServletRequest request) {
		// 클라이언트가 AJAX 요청으로 해당 요청을 보냈는지를 확인함 아니면, 일반적인 폼 submit 등의 요청인 경우
		return "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
	}
}
