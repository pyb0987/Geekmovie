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
	
	@GetMapping("/movieDetail")  
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
	
	@GetMapping("/randomMovieDetail")   
	public ModelAndView movieDetailRandom(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();	
		
		String language="ko-KR";
		language = request.getParameter("language");
		String nextMovie = request.getParameter("nextMovie");
		String nowMovie = request.getParameter("nowMovie");
		String beforeMovie = request.getParameter("beforeMovie");

		mav.addObject("language", language);	// request.setAttribute
		mav.addObject("nextMovie", nextMovie);	// request.setAttribute
		mav.addObject("nowMovie", nowMovie);	// request.setAttribute
		mav.addObject("beforeMovie", beforeMovie);	// request.setAttribute

		
		mav.setViewName("movieDetailRandom");
		return mav;
	}	
	
	
	@GetMapping("/search")     //home
	public ModelAndView search(@RequestParam Map<String, String> map) {
		ModelAndView mav = new ModelAndView();	
		String searchMode = map.get("searchMode"); 
		mav.addObject("data", map); // request.setAttribute  search기능 -> searchMode, query, language, page / seeMore -> searchMode, language, page  [movieId]


		if(searchMode.contains("movie")) {
		
			mav.setViewName("movieSearch");
			return mav;
		}
		else {
			mav.setViewName("boardSearch");
			return mav;
			
		}
	}
	




}
