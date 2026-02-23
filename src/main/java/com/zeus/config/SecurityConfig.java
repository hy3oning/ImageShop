package com.zeus.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

//	@Bean
//	SecurityFilterChain filterChain(HttpSecurity http, DaoAuthenticationProvider provider) throws Exception {
//
//		http.authenticationProvider(provider).csrf(csrf -> csrf.disable())
//
//				.authorizeHttpRequests(auth -> auth
//						// JSP forward / error 디스패치 허용
//						.dispatcherTypeMatchers(DispatcherType.FORWARD, DispatcherType.ERROR).permitAll()
//
//						// 정적 리소스 + 기본 경로 허용
//						.requestMatchers("/", "/login", "/logout", "/error", "/accessError").permitAll()
//						.requestMatchers("/css/**", "/js/**", "/images/**").permitAll()
//
//						// 🔥 여기부터 네가 요청한 권한 정책
//						.requestMatchers("/board/**").authenticated().requestMatchers("/manager/**").hasRole("MANAGER")
//						.requestMatchers("/admin/**").hasRole("ADMIN")
//
//						// 그 외는 모두 허용
//						.anyRequest().permitAll());
//
//				.formLogin(form -> form.loginPage("/login").loginProcessingUrl("/login")
//						.successHandler(authenticationSuccessHandler()).failureUrl("/login?error=true").permitAll())
//
//				.logout(logout -> logout.logoutUrl("/logout").logoutSuccessUrl("/").invalidateHttpSession(true)
//						.deleteCookies("JSESSIONID").permitAll())
//
//				.rememberMe(
//						rm -> rm.key("zeus").tokenRepository(createJDBCRepository()).tokenValiditySeconds(60 * 60 * 24))
//
//				.exceptionHandling(ex -> ex.accessDeniedHandler(accessDeniedHandler()));
//
//		return http.build();
//	}
//
//	@Bean
//	PasswordEncoder createPasswordEncoder() {
//		return new BCryptPasswordEncoder();
//	}
}
