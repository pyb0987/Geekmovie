package com.geekmovie.movie;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.geekmovie.board.dao.BoardDao;
import com.geekmovie.movie.dao.MovieDao;
import com.geekmovie.movie.service.MovieService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class MovieController {
	
	
	@Autowired
	MovieDao movieDao;
	BoardDao boardDao;
	
	@Autowired
	MovieService MovieService;
	
	@GetMapping("/")            //home
	public String index() {
		 return "index";
	}
	
	@GetMapping("/boardList")            //게시판
	public String boardList() {
		 return "boardList";
	}
	

	
	
}
