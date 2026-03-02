package com.zeus.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.zeus.common.security.domain.CustomUser;
import com.zeus.domain.Reply;
import com.zeus.service.ReplyService;

@Controller
@RequestMapping("/reply")
public class ReplyController {
	@Autowired
	private ReplyService replyService;

	// 댓글 등록
	@PostMapping("/register")
	@PreAuthorize("hasRole('MEMBER')")
	public String register(Reply reply, Authentication authentication, RedirectAttributes rttr) throws Exception {
		if (reply.getContent() == null || reply.getContent().trim().isEmpty()) {
			rttr.addFlashAttribute("msg", "댓글 내용을 입력하세요.");
			return "redirect:/board/read?boardNo=" + reply.getBoardNo();
		}
		CustomUser customUser = (CustomUser) authentication.getPrincipal();
		String userId = customUser.getUsername();

		reply.setWriter(userId);
		replyService.register(reply);

		rttr.addFlashAttribute("msg", "댓글 등록 완료");
		return "redirect:/board/read?boardNo=" + reply.getBoardNo();
	}

	// 댓글 삭제 (작성자만 삭제 가능)
	@PostMapping("/remove")
	@PreAuthorize("hasRole('MEMBER')")
	public String remove(Integer replyNo, Integer boardNo, Authentication authentication, RedirectAttributes rttr)
			throws Exception {

		CustomUser customUser = (CustomUser) authentication.getPrincipal();
		String userId = customUser.getUsername();

		Reply dbReply = replyService.read(replyNo);
		if (dbReply == null) {
			rttr.addFlashAttribute("msg", "댓글이 존재하지 않습니다.");
			return "redirect:/board/read?boardNo=" + boardNo;
		}

		// 작성자 체크
		if (!userId.equals(dbReply.getWriter())) {
			throw new AccessDeniedException("본인 댓글만 삭제할 수 있습니다.");
		}

		replyService.remove(replyNo);

		rttr.addFlashAttribute("msg", "댓글 삭제 완료");
		return "redirect:/board/read?boardNo=" + boardNo;
	}

	@PostMapping("/modify")
	@PreAuthorize("isAuthenticated()")
	public String modify(@RequestParam int replyNo, @RequestParam int boardNo, @RequestParam String content,
			Authentication authentication, RedirectAttributes rttr) throws Exception{

		String loginId = authentication.getName();

		Reply reply = new Reply();
		reply.setReplyNo(replyNo);
		reply.setBoardNo(boardNo);
		reply.setContent(content);

		replyService.modify(reply, loginId);

		rttr.addFlashAttribute("msg", "댓글이 수정되었습니다.");
		return "redirect:/board/read?boardNo=" + boardNo;
	}
}
