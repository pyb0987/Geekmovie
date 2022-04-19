package com.geekmovie.board;


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
public class BoardController {
	
	
	
	@Autowired
	BoardService boardService;
	

	@GetMapping("/boardList")          //게시판
	public ModelAndView boardList(BoardVo boardVo) {
		List<BoardVo> list = boardService.bList(boardVo);
		System.out.println("list : " + boardVo); 
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("data", list);
		mav.setViewName("boardList");
		return mav;
	}
	
	
}
