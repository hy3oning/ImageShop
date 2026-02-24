package com.zeus.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.zeus.common.domain.CodeLabelValue;
import com.zeus.domain.Member;
import com.zeus.service.CodeService;
import com.zeus.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/user")
public class MemberController {

	@Autowired
	private MemberService service;
	@Autowired
	private CodeService codeService;
	@Autowired
	private PasswordEncoder passwordEncoder;

	// 등록 페이지
	@GetMapping("/register")
	public void registerForm(Member member, Model model) throws Exception {
		// 직업코드 목록을 조회하여 뷰에 전달
		String groupCode = "A00";
		List<CodeLabelValue> jobList = codeService.getCodeList(groupCode);
		model.addAttribute("jobList", jobList);
	}

	// 등록 처리
	@PostMapping("/register")
	public String register(@Validated Member member, BindingResult result, Model model, RedirectAttributes rttr)
			throws Exception {

		if (result.hasErrors()) {
			String groupCode = "A00";
			List<CodeLabelValue> jobList = codeService.getCodeList(groupCode);
			model.addAttribute("jobList", jobList);
			return "user/register";
		}

		// 비밀번호 암호화
		member.setUserPw(passwordEncoder.encode(member.getUserPw()));

		try {
			int count = service.register(member);

			if (count > 0) {
				rttr.addFlashAttribute("userName", member.getUserName());
				return "redirect:/user/registerSuccess";
			} else {
				rttr.addFlashAttribute("errorMsg", "회원가입 실패");
				return "redirect:/user/registerFailed";
			}

		} catch (DuplicateKeyException e) {
			rttr.addFlashAttribute("errorMsg", "이미 존재하는 아이디");
			return "redirect:/user/registerFailed";
		}
	}

	// 목록 페이지
	@GetMapping("/list")
	public void list(Model model) throws Exception {
		model.addAttribute("list", service.list());
	}

	// 등록 성공 페이지
	@GetMapping("/registerSuccess")
	public void registerSuccess(Model model) throws Exception {
	}

	// 등록 실패 페이지
	@GetMapping("/registerFailed")
	public void registerFailed(Model model) throws Exception {
	}

}
