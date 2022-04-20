package com.geekmovie.user.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import com.geekmovie.user.service.userVOService;
import com.geekmovie.user.vo.userVO;

@Controller
public class userVOController {
	
	@Autowired
	userVOService userService;
	
	public userVOController() {
		System.out.println("@User-Controller 자동 생성");
	}
	@GetMapping("/join")
	public String joinGet() {
		System.out.println("@join GET 호출");
		return "join";
	}
	
	
	
	@GetMapping("/createUser")
	public String createGET() {
		System.out.println("@Create GET 호출");
		return "createUser";
	}

	@PostMapping("/createUser")
	public ModelAndView createPost(userVO userVO) {
		System.out.println("@Create POST 호출");
		System.out.println(userVO);
		
		int rs = userService.create(userVO);
		
		ModelAndView mav = new ModelAndView();
		if(rs ==1 ) {
			mav.setViewName("join");
		}else {
			mav.setViewName("redircet/createUser");
		}
		return mav;
	}
	

}









