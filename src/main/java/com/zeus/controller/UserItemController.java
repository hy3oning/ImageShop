package com.zeus.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zeus.common.security.domain.CustomUser;
import com.zeus.domain.UserItem;
import com.zeus.service.UserItemService;

@Controller
@RequestMapping("/useritem")
public class UserItemController {

	@Autowired
	private UserItemService service;

	@Value("${upload.path}")
	private String uploadPath;

	// 회원 구매 상품 목록
	@GetMapping("/list")
	@PreAuthorize("hasAnyRole('ADMIN','MEMBER')")
	public String list(Model model, @AuthenticationPrincipal CustomUser customUser) throws Exception {
		int userNo = customUser.getMember().getUserNo();
		model.addAttribute("list", service.list(userNo));
		return "useritem/list";
	}

	// 구매 상품 보기
	@GetMapping("/read")
	@PreAuthorize("hasAnyRole('ADMIN','MEMBER')")
	public String read(@RequestParam int userItemNo, Model model, @AuthenticationPrincipal CustomUser customUser)
			throws Exception {

		int loginUserNo = customUser.getMember().getUserNo();
		boolean isAdmin = customUser.getAuthorities().stream().anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"));

		UserItem userItem = service.read(userItemNo);
		if (userItem == null) {
			return "redirect:/useritem/list";
		}

		if (!isAdmin && userItem.getUserNo() != loginUserNo) {
			throw new AccessDeniedException("Forbidden");
		}

		model.addAttribute("userItem", userItem);
		return "useritem/read";
	}

	@ResponseBody
	@GetMapping("/download")
	@PreAuthorize("hasAnyRole('ADMIN','MEMBER')")
	public ResponseEntity<byte[]> download(@RequestParam int userItemNo, @AuthenticationPrincipal CustomUser customUser)
			throws Exception {

		int loginUserNo = customUser.getMember().getUserNo();
		boolean isAdmin = customUser.getAuthorities().stream().anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"));

		UserItem userItem = service.read(userItemNo);
		if (userItem == null) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}

		if (!isAdmin && userItem.getUserNo() != loginUserNo) {
			return new ResponseEntity<>(HttpStatus.FORBIDDEN);
		}

		String fullName = userItem.getPictureUrl();
		if (fullName == null || fullName.isBlank()) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}

		File file = new File(uploadPath, fullName);
		if (!file.exists()) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}

		String fileName = fullName.substring(fullName.indexOf("_") + 1);

		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
		headers.add("Content-Disposition",
				"attachment;filename=\"" + new String(fileName.getBytes("UTF-8"), "ISO-8859-1") + "\"");

		try (InputStream in = new FileInputStream(file)) {
			return new ResponseEntity<>(IOUtils.toByteArray(in), headers, HttpStatus.OK);
		}
	}

}
