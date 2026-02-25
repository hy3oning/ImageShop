package com.zeus.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.zeus.domain.CodeDetail;
import com.zeus.service.CodeDetailService;
import com.zeus.service.CodeService;

/**
 * 코드 상세(CODE_DETAIL) CRUD 처리 컨트롤러
 * - 복합키(GROUP_CODE, CODE_VALUE) 기반 동작
 */
@Controller
@RequestMapping("/codedetail")
@PreAuthorize("hasRole('ADMIN')")
public class CodeDetailController {

	@Autowired
	private CodeDetailService codeDetailService;

	@Autowired
	private CodeService codeService;

	/**
	 * 등록 화면 요청
	 * - 빈 CodeDetail 객체 바인딩
	 * - 그룹코드 목록 조회 후 화면 전달
	 */
	@GetMapping("/register")
	public void registerForm(Model model) throws Exception {
		model.addAttribute(new CodeDetail());
		model.addAttribute("groupCodeList", codeService.getCodeGroupList());
	}

	/**
	 * 등록 처리
	 * - 입력 데이터 저장 후 목록 페이지로 리다이렉트
	 */
	@PostMapping("/register")
	public String register(CodeDetail codeDetail, RedirectAttributes rttr) throws Exception {
		int count = codeDetailService.register(codeDetail);
		rttr.addFlashAttribute("msg", count > 0 ? "SUCCESS" : "FAIL");
		return "redirect:/codedetail/list";
	}

	/**
	 * 목록 조회
	 * - 전체 코드 상세 목록 조회
	 */
	@GetMapping("/list")
	public void list(Model model) throws Exception {
		model.addAttribute("list", codeDetailService.list());
	}

	/**
	 * 상세 조회
	 * - 복합키 기준 단건 조회
	 * - 그룹코드 목록 함께 전달 (select 출력용)
	 */
	@GetMapping("/read")
	public void read(CodeDetail codeDetail, Model model) throws Exception {
		model.addAttribute("codeDetail", codeDetailService.read(codeDetail));
		model.addAttribute("groupCodeList", codeService.getCodeGroupList());
	}

	/**
	 * 수정 화면 요청
	 * - 기존 데이터 조회 후 화면 전달
	 */
	@GetMapping("/modify")
	public void modifyForm(CodeDetail codeDetail, Model model) throws Exception {
		model.addAttribute("codeDetail", codeDetailService.read(codeDetail));
		model.addAttribute("groupCodeList", codeService.getCodeGroupList());
	}

	/**
	 * 수정 처리
	 * - 복합키 기준 데이터 업데이트
	 * - 처리 결과 메시지 후 목록 이동
	 */
	@PostMapping("/modify")
	public String modify(CodeDetail codeDetail, RedirectAttributes rttr) throws Exception {
		int count = codeDetailService.modify(codeDetail);
		rttr.addFlashAttribute("msg", count > 0 ? "SUCCESS" : "FAIL");
		return "redirect:/codedetail/list";
	}

	/**
	 * 삭제 처리
	 * - 복합키 기준 데이터 삭제
	 * - 처리 결과 메시지 후 목록 이동
	 */
	@PostMapping("/remove")
	public String remove(CodeDetail codeDetail, RedirectAttributes rttr) throws Exception {
		int count = codeDetailService.remove(codeDetail);
		rttr.addFlashAttribute("msg", count > 0 ? "SUCCESS" : "FAIL");
		return "redirect:/codedetail/list";
	}
}