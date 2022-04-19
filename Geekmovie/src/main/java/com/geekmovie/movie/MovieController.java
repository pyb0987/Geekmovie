package com.geekmovie.movie;


import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.geekmovie.board.service.BoardService;
import com.geekmovie.board.vo.BoardVo;
import com.geekmovie.movie.dao.MovieDao;
import com.geekmovie.movie.json.MovieUrlGetter;
import com.geekmovie.movie.json.UrlRead;
import com.geekmovie.movie.service.MovieService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class MovieController {
	
	
	@Autowired
	MovieDao movieDao;
	//BoardDao boardDao;
	
	@Autowired
	MovieService MovieService;
	
	@GetMapping("/")            //home
	public String index() {
		 return "index";
	}
	
	@GetMapping("/movieDetail")     //home
	public ModelAndView movieDetail(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();	
		
		int movieId=0;
		String language="ko-KR";
		movieId = Integer.parseInt(request.getParameter("movieId"));
		language = request.getParameter("language");

		mav.addObject("movieId", movieId); // request.setAttribute
		mav.addObject("language", language);

		
		mav.setViewName("movieDetail");
		return mav;
	}

//	@GetMapping("/boardList")          //게시판
//	public ModelAndView boardList(BoardVo boardVo) {
//		System.out.println("list : " + boardVo); 
//		List<BoardVo> list = boardService.bList(boardVo);
//		
//		ModelAndView mav = new ModelAndView();
//		mav.addObject("data", list);
//		mav.setViewName("boardList");
//		return mav;
//	}
	
	
}
