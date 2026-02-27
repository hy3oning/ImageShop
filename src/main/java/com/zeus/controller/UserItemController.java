package com.zeus.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.zeus.service.UserItemService;

@Controller
@RequestMapping("/useritem")
public class UserItemController {

	@Autowired
	private UserItemService service;

	@Value("${upload.path}")
	private String uploadPath;
}
