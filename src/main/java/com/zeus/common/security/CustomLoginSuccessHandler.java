package com.zeus.common.security;

import java.io.IOException;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

import com.zeus.common.security.domain.CustomUser;
import com.zeus.domain.Member;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomLoginSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler {

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {

		Object principal = authentication.getPrincipal();

		// ✅ principal이 CustomUser인 경우 (네 프로젝트의 정상 케이스)
		if (principal instanceof CustomUser customUser) {
			Member member = customUser.getMember();

			if (member != null) {
				log.info("Login success. userId={}", member.getUserId());
				log.info("Authorities={}", customUser.getAuthorities());
			} else {
				// CustomUser를 썼는데 member가 비어있으면 설계/생성자 사용 흐름 점검 포인트
				log.warn("Login success but member is null in CustomUser. username={}", customUser.getUsername());
			}

			// ✅ 혹시 설정 꼬여서 기본 UserDetails가 들어오는 경우 대비
		} else if (principal instanceof UserDetails userDetails) {
			log.info("Login success. username={}", userDetails.getUsername());
			log.info("Authorities={}", userDetails.getAuthorities());

		} else {
			// ✅ 정말 예외 케이스
			log.info("Login success. principalType={}", principal.getClass().getName());
		}

		// ✅ 원래 가려던 URL(SavedRequest)이 있으면 그쪽으로 보내는 기본 동작 유지
		super.onAuthenticationSuccess(request, response, authentication);
	}
}