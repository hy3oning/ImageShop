package com.zeus.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.zeus.common.domain.CodeLabelValue;
import com.zeus.common.domain.PageRequest;
import com.zeus.common.domain.Pagination;
import com.zeus.common.security.domain.CustomUser;
import com.zeus.domain.Board;
import com.zeus.domain.Member;
import com.zeus.service.BoardService;
import com.zeus.service.ReplyService;

@Controller
@RequestMapping("/board")
public class BoardController {

	@Autowired
	private BoardService service;
	@Autowired
	private ReplyService replyService;

	// 게시글 등록 페이지
	@GetMapping("/register")
	@PreAuthorize("hasRole('MEMBER')")
	public void registerForm(Model model, Authentication authentication) throws Exception {

		// 로그인한 사용자 정보 획득
		CustomUser customUser = (CustomUser) authentication.getPrincipal();
		Member member = customUser.getMember();

		Board board = new Board();

		// 로그인한 사용자 아이디를 등록 페이지에 표시
		board.setWriter(member.getUserId());

		model.addAttribute(board);
	}

	// 게시글 등록 처리
	@PostMapping("/register")
	@PreAuthorize("hasRole('MEMBER')")
	public String register(Board board, RedirectAttributes rttr, @AuthenticationPrincipal CustomUser customUser)
			throws Exception {
		board.setWriter(customUser.getMember().getUserId());
		int count = service.register(board);
		rttr.addFlashAttribute("msg", (count > 0) ? "SUCCESS" : "FAILED");
		return "redirect:/board/list";
	}

	// 페이징 요청 정보를 매개 변수로 받고 다시 뷰에 전달한다.
	@GetMapping("/list")
	public void list(@ModelAttribute("pgrq") PageRequest pageRequest, Model model) throws Exception {
		// 뷰에 페이징 처리를 한 게시글 목록을 전달한다.
		model.addAttribute("list", service.list(pageRequest));
		// 페이징 네비게이션 정보를 뷰에 전달한다.
		Pagination pagination = new Pagination();
		pagination.setPageRequest(pageRequest);// 페이지 네비게이션 정보에 검색 처리된 게시글 건수를 저장한다(변경).
		pagination.setTotalCount(service.count(pageRequest));
		model.addAttribute("pagination", pagination);
		// 검색 유형의 코드명과 코드값을 정의한다.
		List<CodeLabelValue> searchTypeCodeValueList = new ArrayList<CodeLabelValue>();
		searchTypeCodeValueList.add(new CodeLabelValue("n", "---"));
		searchTypeCodeValueList.add(new CodeLabelValue("t", "Title"));
		searchTypeCodeValueList.add(new CodeLabelValue("c", "Content"));
		searchTypeCodeValueList.add(new CodeLabelValue("w", "Writer"));
		searchTypeCodeValueList.add(new CodeLabelValue("tc", "Title OR	Content"));
		searchTypeCodeValueList.add(new CodeLabelValue("cw", "Content OR Writer"));
		searchTypeCodeValueList.add(new CodeLabelValue("tcw", "Title OR Content OR Writer"));
		model.addAttribute("searchTypeCodeValueList", searchTypeCodeValueList);
	}

	// 게시글 상세 페이지
	@GetMapping("/read")
	public String read(@RequestParam int boardNo, @ModelAttribute("pgrq") PageRequest pageRequest, Model model)
			throws Exception {

		model.addAttribute("board", service.read(boardNo));
		model.addAttribute("replyList", replyService.list(boardNo));
		return "board/read";
	}

	// 게시글 수정 페이지
	@GetMapping("/modify")
	@PreAuthorize("hasAnyRole('ADMIN','MEMBER')")
	public void modifyForm(@RequestParam int boardNo, @ModelAttribute("pgrq") PageRequest pageRequest,
			@AuthenticationPrincipal CustomUser customUser, Model model) throws Exception {

		Board board = service.read(boardNo);

		boolean isAdmin = customUser.getAuthorities().stream().anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"));

		String loginId = customUser.getMember().getUserId();

		if (!isAdmin && !loginId.equals(board.getWriter())) {
			throw new AccessDeniedException("본인 글만 수정할 수 있습니다.");
		}

		model.addAttribute("board", board);
	}

	// 게시글 수정 처리
	@PostMapping("/modify")
	@PreAuthorize("hasAnyRole('ADMIN','MEMBER')")
	public String modify(@ModelAttribute("pgrq") PageRequest pageRequest, Board board,
			@AuthenticationPrincipal CustomUser customUser, RedirectAttributes rttr) throws Exception {

		boolean isAdmin = customUser.getAuthorities().stream().anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"));

		String loginId = customUser.getMember().getUserId();

		int count;
		if (isAdmin) {
			count = service.modifyByAdmin(board);
		} else {
			board.setWriter(loginId); // writer 조건 통일
			count = service.modify(board);
		}

		rttr.addFlashAttribute("msg", (count > 0) ? "SUCCESS" : "FAILED");
		return "redirect:/board/list" + pageRequest.toUriString();
	}

	// 게시글 삭제 처리
	@PostMapping("/remove")
	@PreAuthorize("hasAnyRole('ADMIN','MEMBER')")
	public String remove(@RequestParam int boardNo, @ModelAttribute("pgrq") PageRequest pageRequest,
			@AuthenticationPrincipal CustomUser customUser, RedirectAttributes rttr) throws Exception {

		boolean isAdmin = customUser.getAuthorities().stream().anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"));

		String loginId = customUser.getMember().getUserId();

		int count;
		if (isAdmin) {
			count = service.removeByAdmin(boardNo);
		} else {
			Board board = new Board();
			board.setBoardNo(boardNo);
			board.setWriter(loginId); // writer 조건 통일
			count = service.remove(board);
		}

		rttr.addFlashAttribute("msg", (count > 0) ? "SUCCESS" : "FAILED");
		return "redirect:/board/list" + pageRequest.toUriString();
	}

}
