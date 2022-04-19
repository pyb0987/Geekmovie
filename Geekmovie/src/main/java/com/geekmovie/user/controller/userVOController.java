package com.geekmovie.user.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.geekmovie.user.service.userVOService;

@Controller
public class userVOController {
	
	@Autowired
	userVOService userService;
	
	public userVOController() {
		System.out.println("@User-Controller 자동 생성");
	}
	
	@GetMapping("/createUser")
	public String createGET() {
		System.out.println("@Create GET 호출");
		return "createUser";
	}
	@PostMapping("/createUser")
	public String createPOST() {
		System.out.println("@Create POST 호출");
		return "index";
	}

}
