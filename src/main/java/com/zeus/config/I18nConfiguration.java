package com.zeus.config;

import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;

@Configuration
public class I18nConfiguration {

	@Bean
	MessageSource messageSource() {
		ResourceBundleMessageSource messageSource = new ResourceBundleMessageSource();
		messageSource.setBasename("message.message");

		// ✅ UTF-8 강제 지정 (핵심)
		messageSource.setDefaultEncoding("UTF-8");

		// (선택) 메시지 못 찾을 때 키 그대로 출력
		messageSource.setUseCodeAsDefaultMessage(true);

		return messageSource;
	}

	@Bean
	LocaleResolver localeResolver() {
		return new SessionLocaleResolver();
	}
}