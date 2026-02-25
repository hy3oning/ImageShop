package com.zeus.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.zeus.domain.CodeGroup;
import com.zeus.service.CodeGroupService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/codegroup")
@Slf4j
//관리자 권한을 가진 사용자만 접근이 가능하다.
@PreAuthorize("hasRole('ADMIN')")
public class CodeGroupController {

	@Autowired
	private CodeGroupService service;

	/**
	 * 등록 화면 요청 처리.
	 * 빈 CodeGroup 객체를 Model 에 담아 form 바인딩에 사용한다.
	 *
	 * @param model View 전달 객체
	 * @throws Exception
	 */
	@GetMapping("/register")
	public void registerForm(Model model) throws Exception {
		model.addAttribute(new CodeGroup());
	}

	/**
	 * 코드 그룹 등록 처리.
	 * - 요청 파라미터를 CodeGroup에 바인딩
	 * - DB 저장 수행
	 * - PRG 패턴 적용하여 목록으로 redirect
	 *
	 * @param codeGroup 등록 데이터
	 * @param rttr redirect 시 flash 데이터 전달 객체
	 * @return redirect 경로
	 * @throws Exception
	 */
	@PostMapping("/register")
	public String register(CodeGroup codeGroup, RedirectAttributes rttr) throws Exception {

		int count = service.register(codeGroup);

		if (count > 0) {
			rttr.addFlashAttribute("msg", "SUCCESS");
			return "redirect:/codegroup/list";
		}

		return "redirect:/codegroup/register";
	}

	/**
	 * 코드 그룹 목록 조회.
	 * 전체 데이터를 조회하여 Model 에 담는다.
	 *
	 * @param model View 전달 객체
	 * @throws Exception
	 */
	@GetMapping("/list")
	public void list(Model model) throws Exception {
		model.addAttribute("list", service.list());
	}

	/**
	 * 코드 그룹 상세 조회 화면 요청 처리.
	 * 전달받은 코드 그룹 정보를 조회하여 Model 에 담는다.
	 *
	 * @param codeGroup 조회할 코드 그룹 정보
	 * @param model View 에 전달할 데이터 저장 객체
	 * @throws Exception 조회 중 예외 발생 시
	 */
	@GetMapping("/read")
	public void read(CodeGroup codeGroup, Model model) throws Exception {
		model.addAttribute(service.read(codeGroup));
	}

	/**
	 * 코드 그룹 수정 화면 요청 처리.
	 * 전달받은 식별자로 기존 데이터를 조회하여 Model에 담는다.
	 *
	 * @param codeGroup 조회할 코드 그룹 식별 정보
	 * @param model View에 전달할 데이터 객체
	 * @throws Exception 조회 중 예외 발생 시
	 */
	@GetMapping("/modify")
	public void modifyForm(CodeGroup codeGroup, Model model) throws Exception {
		model.addAttribute(service.read(codeGroup));
	}

	/**
	 * 코드 그룹 수정 처리.
	 * 전달받은 데이터를 기반으로 수정 후 목록 페이지로 redirect 한다.
	 *
	 * @param codeGroup 수정할 데이터 객체
	 * @param rttr redirect 시 flash 메시지 전달 객체
	 * @return 목록 페이지 redirect 경로
	 * @throws Exception 수정 중 예외 발생 시
	 */
	@PostMapping("/modify")
	public String modify(CodeGroup codeGroup, RedirectAttributes rttr) throws Exception {
		int count = service.modify(codeGroup);
		if (count > 0) {
			rttr.addFlashAttribute("msg", "SUCCESS");
		} else {
			rttr.addFlashAttribute("msg", "FAIL");
		}
		return "redirect:/codegroup/list";
	}

	/**
	 * 코드 그룹 삭제 처리.
	 * 삭제 결과에 따라 flash 메시지를 설정하고 목록으로 redirect 한다.
	 *
	 * @param codeGroup 삭제할 데이터 객체
	 * @param rttr redirect 시 flash 메시지 전달 객체
	 * @return 목록 페이지 redirect 경로
	 * @throws Exception 삭제 중 예외 발생 시
	 */
	@PostMapping("/remove")
	public String remove(CodeGroup codeGroup, RedirectAttributes rttr) throws Exception {

		int count = service.remove(codeGroup);

		if (count > 0) {
			rttr.addFlashAttribute("msg", "SUCCESS");
		} else {
			rttr.addFlashAttribute("msg", "FAIL");
		}

		return "redirect:/codegroup/list";
	}
}
