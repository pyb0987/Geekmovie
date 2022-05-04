package com.geekmovie.user.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
	@GetMapping("/user_join")
	public String joinGet() {
		System.out.println("@join GET 호출");
		return "user_join";
	}

	// 로그인 처리
	@PostMapping("/user_join")
	public ModelAndView joinPost(@ModelAttribute userVO userVO, HttpSession session) {
		System.out.println("@join Post 호출");
		boolean result = userService.loginCheck(userVO, session);
		ModelAndView mav = new ModelAndView();
		if (result == true) { // 로그인 성공
			mav.setViewName("redirect:/");
		} else { // 로그인 실패
			mav.setViewName("user_join");
			mav.addObject("msg", "failure");
		}
		
		return mav;
	}

	// 회원가입
	@GetMapping("/user_createUser")
	public String createGET() {
		System.out.println("@CreateUser GET 호출");
		return "user_createUser";
	}

	// 가입처리
	@PostMapping("/user_createUser")
	public ModelAndView createPost(userVO userVO) {

		System.out.println("@Create POST 호출");
		System.out.println(userVO);

		int rs = userService.create(userVO);

		ModelAndView mav = new ModelAndView();
		if (rs == 1) {
			mav.setViewName("redirect:/user_join");
		} else {
			mav.setViewName("redirect:/user_createUser");
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
	@GetMapping("/user_logout")
	public String logout(HttpSession session){
		System.out.println("@logout 실행");
		//session.removeAttribute("id");
		session.invalidate();
		return "redirect:/";
	}

	// 마이페이지
	@GetMapping("/user_mypage")
	public String mypageGet() {
		System.out.println("@mypage 실행");

		return "user_mypage";
	}
	
	// 마이페이지 수정하기
	@GetMapping("/user_update_mypage")
	public String update_mypageGet() {
		System.out.println("@update_mypage Get 실행");
		return "user_update_mypage";
	}
	
	// 마이페이지 수정하기2
	@PostMapping("/user_update_mypage")
	public ModelAndView update_mypagePost(userVO userVO,HttpSession session) {
		System.out.println("@update_mypage POST 호출");
		System.out.println(userVO);
	
		int rs = userService.update(userVO, session);
		
		ModelAndView mav = new ModelAndView();
		if (rs == 1) {
			mav.setViewName("redirect:/user_join");
			//mav.addObject("msg", "success");
		} else {
			mav.setViewName("redirect:/user_createUser");
		}
		return mav;
		
	}
	
	// 회원 탈퇴
	@GetMapping("/user_delete_mypage")
	public String delete_mypageGet(userVO userVO, HttpSession session) {
		System.out.println("@delete_mypageGet 실행");
		return "user_delete_mypage";
	}
	
	//회원 탈퇴2
	@PostMapping("/user_delete_mypage")
	public ModelAndView delete_mypagePost(userVO userVO, HttpSession session) {
		System.out.println("@delete_mypagePost 실행");
		
		int rs = userService.delete(userVO,session);
		
		ModelAndView mav = new ModelAndView();
		
		if (rs == 1) {
			//세션값 초기화
			session.invalidate();
			mav.setViewName("redirect:/");
			//mav.addObject("msg", "success");
		} else {
			mav.setViewName("user_delete_mypage");
			mav.addObject("msg", "failure");
		}
		return mav;	
	}
		
}
