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

	// 상세 페이지
	@GetMapping("/read")
	public void read(int userNo, Model model) throws Exception {

		// 직업코드 목록
		String groupCode = "A00";
		List<CodeLabelValue> jobList = codeService.getCodeList(groupCode);
		model.addAttribute("jobList", jobList);

		// 회원 상세
		model.addAttribute("member", service.read(userNo));
	}

	// 수정 페이지
	@GetMapping("/modify")
	public void modifyForm(int userNo, Model model) throws Exception {

		// 직업코드 목록
		String groupCode = "A00";
		List<CodeLabelValue> jobList = codeService.getCodeList(groupCode);
		model.addAttribute("jobList", jobList);

		// 회원 상세 (폼 바인딩 대상)
		model.addAttribute("member", service.read(userNo));
	}

	// 수정 처리
	@PostMapping("/modify")
	public String modify(Member member, RedirectAttributes rttr) throws Exception {
		int count = service.modify(member);
		if (count > 0) {
			rttr.addFlashAttribute("msg", "SUCCESS");

		} else {
			rttr.addFlashAttribute("msg", "FAILED");
		}
		return "redirect:/user/list";
	}

	// 삭제 처리
	@PostMapping("/remove")
	public String remove(int userNo, RedirectAttributes rttr) throws Exception {
		int count = service.remove(userNo);
		if (count > 0) {
			rttr.addFlashAttribute("msg", "SUCCESS");
		} else {
			rttr.addFlashAttribute("msg", "FAILED");
		}
		return "redirect:/user/list";
	}

	// 최초 관리자 생성
	@PostMapping("/setup")
	public String setupAdmin(Member member, RedirectAttributes rttr) throws Exception {
		// 1. 회원 테이블 전체 건수 확인
		int totalCount = service.countAll();

		// 2. 회원이 한 명도 없을 때만 최초 관리자 생성
		if (totalCount == 0) {

			// 3. 비밀번호 암호화
			String inputPassword = member.getUserPw();
			member.setUserPw(passwordEncoder.encode(inputPassword));

			// 4. 기본 직업 코드 설정
			member.setJob("00");

			// 5. 관리자 등록 처리
			int count = service.setupAdmin(member);

			// 6. 등록 성공 여부 판단
			if (count == 1) {
				rttr.addFlashAttribute("userName", member.getUserName());
				rttr.addFlashAttribute("msg", "SUCCESS");
			} else {
				rttr.addFlashAttribute("msg", "FAILED");
			}

			return "redirect:/user/registerSuccess";
		}

		// 이미 회원이 존재하는 경우
		return "redirect:/user/setupFailure";
	}

	// 최초 관리자를 생성하는 화면을 반환한다.
	@GetMapping("/setup")
	public String setupAdminForm(Member member, Model model) throws Exception {
		// 회원 테이블 데이터 건수를 확인하여 최초 관리자 등록 페이지를 표시한다.
		if (service.countAll() == 0) {
			return "user/setup";
		}
		return "user/setupFailure";
	}

	// 최초 관리자 생성 실패 페이지
	@GetMapping("/setupFailure")
	public void setupFailure() throws Exception {
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
