package com.geekmovie.movie;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import com.geekmovie.movie.dao.MovieDao;
import com.geekmovie.movie.service.MovieService;
import com.geekmovie.movie.vo.userVO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class MovieController {
	
	
	@Autowired
	MovieDao movieDao;
	
	@Autowired
	MovieService MovieService;
	
	@GetMapping("/")            //home
	public String index() {
		 return "index";
	}
	
	@GetMapping("/create")		// 회원가입 (GET) 초기가입
	public String create() {
		System.out.println("회원가입 @GET 호출");
		return "create";
	}
	
	@PostMapping("/create")
	public String createPost(userVO userVO) {	// 회원가입 (post) 두번째 가입 페이지
		System.out.println("회원가입 @POST 호출");
		System.out.println(userVO);
		return "index";
	}
	
	
}
