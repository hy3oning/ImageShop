package com.zeus.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.zeus.common.domain.PageRequest;
import com.zeus.common.domain.Pagination;
import com.zeus.domain.Notice;
import com.zeus.service.NoticeService;

@Controller
@RequestMapping("/notice")
public class NoticeController {
	@Autowired
	private NoticeService service;

	@GetMapping("/register")
	@PreAuthorize("hasRole('ADMIN')")
	public void registerForm(Model model) throws Exception {
		Notice notice = new Notice();
		model.addAttribute(notice);
	}

	@PostMapping("/register")
	@PreAuthorize("hasRole('ADMIN')")
	public String register(Notice notice, RedirectAttributes rttr) throws Exception {
		int count = service.register(notice);
		rttr.addFlashAttribute("msg", (count > 0) ? "SUCCESS" : "FAILED");
		return "redirect:/notice/list";
	}

	@GetMapping("/list")
	public void list(@ModelAttribute("pgrq") PageRequest pageRequest, Model model) throws Exception {
		model.addAttribute("list", service.list(pageRequest));
		Pagination pagination = new Pagination();
		pagination.setPageRequest(pageRequest);
		pagination.setTotalCount(service.count(pageRequest));
		model.addAttribute("pagination", pagination);
	}

	@GetMapping("/read")
	public void read(@RequestParam int noticeNo, @ModelAttribute("pgrq") PageRequest pageRequest, Model model) {
		model.addAttribute("notice", service.read(noticeNo));
	}

	@GetMapping("/modify")
	@PreAuthorize("hasRole('ADMIN')")
	public void modifyForm(@RequestParam int noticeNo, @ModelAttribute("pgrq") PageRequest pageRequest, Model model) {
		Notice notice = service.read(noticeNo);
		model.addAttribute("notice", notice);
	}

	@PostMapping("/modify")
	@PreAuthorize("hasRole('ADMIN')")
	public String modify(PageRequest pageRequest, Notice notice, RedirectAttributes rttr) throws Exception {
		int count = service.modify(notice);
		rttr.addFlashAttribute("msg", (count > 0) ? "SUCCESS" : "FAILED");

		return "redirect:/notice/list" + pageRequest.toUriString();
	}

	@PostMapping("/remove")
	@PreAuthorize("hasRole('ADMIN')")
	public String remove(@RequestParam int noticeNo, PageRequest pageRequest, RedirectAttributes rttr)
			throws Exception {
		int count = service.remove(noticeNo);
		rttr.addFlashAttribute("msg", (count > 0) ? "SUCCESS" : "FAILED");
		return "redirect:/notice/list" + pageRequest.toUriString();
	}

}
