package com.zeus.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/auth")
public class LoginController {

	// 로그인 페이지
	@GetMapping("/login")
	public String loginForm(String error, String logout, Model model) {
		if (error != null) {
			model.addAttribute("error", "로그인 에러!!!");
		}
		if (logout != null) {
			model.addAttribute("logout", "로그아웃!!!");
		}
		return "auth/loginForm";
	}

	@GetMapping("/logoutSuccess")
	public String logoutSuccess(RedirectAttributes rttr) {
		rttr.addFlashAttribute("logoutMsg", "로그아웃 되었습니다.");
		return "redirect:/";
	}
}
