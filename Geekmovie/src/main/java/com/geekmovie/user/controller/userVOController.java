package com.geekmovie.user.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
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

	// 로그인
	@GetMapping("/join")
	public String joinGet() {
		System.out.println("@join GET 호출");
		return "join";
	}

	// 로그인 처리
	@PostMapping("/join")
	public ModelAndView joinPost(@ModelAttribute userVO userVO, HttpSession session) {
		System.out.println("@join Post 호출");
		boolean result = userService.loginCheck(userVO, session);
		ModelAndView mav = new ModelAndView();
		if (result == true) { // 로그인 성공
			mav.setViewName("redirect:/");
		} else { // 로그인 실패
			mav.setViewName("join");
			mav.addObject("msg", "failure");
		}
		return mav;
	}

	// 회원가입
	@GetMapping("/createUser")
	public String createGET() {
		System.out.println("@CreateUser GET 호출");
		return "createUser";
	}

	// 가입처리
	@PostMapping("/createUser")
	public ModelAndView createPost(userVO userVO) {

		System.out.println("@Create POST 호출");
		System.out.println(userVO);

		int rs = userService.create(userVO);

		ModelAndView mav = new ModelAndView();
		if (rs == 1) {
			mav.setViewName("redirect:/join");
		} else {
			mav.setViewName("redircet/createUser");
		}
		return mav;
	}

	// 아이디 중복체크
	@PostMapping("/idCheck")
	@ResponseBody
	public int idCheck(@RequestParam("id") String id) {
		System.out.println("idCheck실행");
		System.out.println(id);
		int cnt = userService.idCheck(id);
		System.out.println("확인결과 : " + cnt);
		return cnt;
	}

	// 로그아웃 처리
	@GetMapping("/logout")
	public ModelAndView logout(HttpSession session) {
		System.out.println("@logout 실행");
		userService.logout(session);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("index");
		return mav;
	}

	// 마이페이지
	@GetMapping("/mypage")
	public String mypage(HttpSession session, Model model) {
		System.out.println("@mypage 실행");

		return "test";
	}
}
