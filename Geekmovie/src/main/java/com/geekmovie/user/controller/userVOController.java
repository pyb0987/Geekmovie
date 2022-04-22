
package com.geekmovie.user.controller;

import java.io.Console;
import java.lang.System.Logger;

import org.mybatis.logging.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.geekmovie.user.service.userVOService;
import com.geekmovie.user.vo.userVO;

@Controller
public class userVOController {
	
	// 04-22 수정구문
	
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
	
	// 회원가입 
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
	// 아이디 체크
	@PostMapping("/idCheck")
	@ResponseBody
	public int idCheck(@RequestParam("id") String id) {
		System.out.println("userIdCheck 진입");
		System.out.println("전달받은 id값 : "+id);
		int cnt = userService.idCheck(id);
		System.out.println("확인결과 : "+cnt);
		return cnt;
	}
}







