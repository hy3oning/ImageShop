package com.zeus.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

import jakarta.servlet.DispatcherType;
import lombok.extern.slf4j.Slf4j;

@Configuration
@EnableWebSecurity
@Slf4j
public class SecurityConfig {

	@Bean
	SecurityFilterChain filterChain(HttpSecurity http) throws Exception {

		http
				// 1) CSRF 토큰 비활성화
				.csrf(csrf -> csrf.disable())

				// 2) 인가(Authorization) 설정
				.authorizeHttpRequests(
						auth -> auth.dispatcherTypeMatchers(DispatcherType.FORWARD, DispatcherType.ERROR).permitAll()
								// 로그인, 에러, 정적 리소스는 모두 허용
								.requestMatchers("/accessError", "/login", "/logout", "/css/**", "/js/**", "/error")
								.permitAll().requestMatchers("/board/**").authenticated() // 게시판: 인증(로그인)
								.requestMatchers("/manager/**").hasRole("MANAGER") // 매니저기능 : 인가
								.requestMatchers("/admin/**").hasRole("ADMIN") // 관리자기능 : 인가

								.anyRequest().permitAll())

//				 3) 로그인 설정 (기본 폼 로그인 사용)
				.formLogin(form -> form.loginPage("/login") // 커스텀 로그인 페이지 사용
						.permitAll())

				// 4) 로그아웃 설정
				.logout(logout -> logout.logoutUrl("/logout").permitAll());

		return http.build();
	}

	@Bean
	PasswordEncoder createPasswordEncoder() {
		return new BCryptPasswordEncoder();
	}
}
