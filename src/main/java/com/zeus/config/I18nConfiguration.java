package com.zeus.config;

import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;

@Configuration
public class I18nConfiguration {

	@Bean
	MessageSource messageSource() {
		ReloadableResourceBundleMessageSource ms = new ReloadableResourceBundleMessageSource();
		ms.setBasename("classpath:message/message");
		ms.setDefaultEncoding("UTF-8");
		ms.setUseCodeAsDefaultMessage(true);
		return ms;
	}

	@Bean
	LocaleResolver localeResolver() {
		return new SessionLocaleResolver();
	}
}