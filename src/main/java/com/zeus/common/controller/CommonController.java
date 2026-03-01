package com.zeus.common.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class CommonController {
	@GetMapping("/error/errorCommon")
	public void handleCommonError(@RequestParam String param) {
		log.info("errorCommon");
	}

	@GetMapping("/accessDenied")
	public String accessDenied(Authentication auth, Model model) {
		log.info("accessDenied: {}", auth);
		model.addAttribute("msg", "Access Denied(접근 불가)");
		return "error/accessDenied"; 
	}

}
