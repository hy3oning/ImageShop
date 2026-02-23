package com.zeus.controller;

import org.springframework.beans.factory.annotation.Autowired;
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
public class CodeGroupController {

	@Autowired
	private CodeGroupService service;

	/**
	 * 코드 그룹 등록 화면을 요청(GET)하면 호출되는 메서드.
	 * 
	 * - 빈 CodeGroup 객체를 생성하여 Model에 담는다.
	 * - View(JSP/Thymeleaf)에서 form 바인딩용 객체로 사용된다.
	 * - 반환 타입이 void이므로 요청 URL(/register)에 해당하는
	 * 뷰 이름이 자동으로 매핑된다.
	 *
	 * @param model View에 전달할 데이터를 저장하는 Model 객체
	 * @throws Exception 예외 발생 시 상위로 전달
	 */
	@GetMapping("/register")
	public void registerForm(Model model) throws Exception {
		CodeGroup codeGroup = new CodeGroup();
		model.addAttribute(codeGroup);
	}

	/**
	 * 코드그룹 등록 처리
	 *
	 * [처리 흐름]
	 * 1. 사용자가 등록 폼에서 POST 요청 전송
	 * 2. 요청 파라미터가 CodeGroup 객체에 자동 바인딩
	 * 3. Service 계층에서 DB insert 수행
	 * 4. 성공 시 PRG 패턴 적용하여 목록 페이지로 redirect
	 * 5. 실패 시 다시 등록 페이지로 redirect
	 *
	 * [PRG 패턴]
	 * - Post → Redirect → Get 구조
	 * - 새로고침(F5) 시 중복 insert 방지
	 *
	 * [RedirectAttributes]
	 * - addFlashAttribute() 사용
	 * - URL에 노출되지 않음
	 * - Session에 임시 저장
	 * - redirect 이후 한 번만 사용되고 자동 삭제
	 * - 성공/실패 메시지 전달 목적
	 *
	 * @param codeGroup 폼에서 전달된 데이터 객체
	 * @param rttr redirect 시 데이터 전달 객체
	 * @return redirect 경로
	 * @throws Exception
	 */
	@PostMapping("/register")
	public String register(CodeGroup codeGroup, RedirectAttributes rttr) throws Exception {

		int count = service.register(codeGroup);
		log.info("codeGroup/register = {}", count);

		if (count != 0) {
			rttr.addFlashAttribute("msg", "SUCCESS");
			return "redirect:/codegroup/list";
		}

		return "redirect:/codegroup/register";
	}

	/**
	 * 코드그룹 목록 조회
	 *
	 * [처리 흐름]
	 * 1. GET /codegroup/list 요청
	 * 2. Service 계층에서 전체 목록 조회
	 * 3. 조회 결과를 Model 객체에 저장
	 * 4. 요청 URL 기반 View 자동 매핑
	 * → /codegroup/list 요청 시
	 * → /WEB-INF/views/codegroup/list.jsp 로 이동
	 *
	 * @param model View로 데이터를 전달하는 객체
	 * @throws Exception
	 */
	@GetMapping("/list")
	public void list(Model model) throws Exception {
		model.addAttribute("list", service.list());
	}

	@GetMapping("/read")
	public void read(CodeGroup codeGroup, Model model) throws Exception {
		model.addAttribute(service.read(codeGroup));
	}

}
