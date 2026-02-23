package com.zeus.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.zeus.service.CodeGroupService;
import com.zeus.service.MemberService;

@Controller
@RequestMapping("/user")
public class MemberController {

	@Autowired
	private MemberService service;
	@Autowired
	private CodeGroupService codeService;
	@Autowired
	private PasswordEncoder passwordEncoder;

}
