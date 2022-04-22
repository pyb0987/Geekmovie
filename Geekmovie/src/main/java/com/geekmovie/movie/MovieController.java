package com.geekmovie.movie;



import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;


import com.geekmovie.movie.dao.MovieDao;


/**
 * Handles requests for the application home page.
 */
@Controller
public class MovieController {
	
	
	@Autowired
	MovieDao movieDao;
	
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
	
	
	@GetMapping("/search")     //home
	public ModelAndView search(@RequestParam Map<String, String> map) {
		ModelAndView mav = new ModelAndView();	
		String searchMode = map.get("searchMode"); 
		mav.addObject("data", map); // request.setAttribute  searchMode, query, language, page


		if(searchMode.contains("movie")) {
		
			mav.setViewName("movieSearch");
			return mav;
		}
		else {
			mav.setViewName("boardSearch");
			return mav;
			
		}
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
