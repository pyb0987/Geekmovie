package com.geekmovie.board;


import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import com.geekmovie.board.service.BoardService;
import com.geekmovie.board.vo.BoardVo;
import com.geekmovie.movie.dao.MovieDao;
import com.geekmovie.movie.json.MovieUrlGetter;
import com.geekmovie.movie.json.UrlRead;
import com.geekmovie.movie.service.MovieService;

@Controller
public class BoardController {
	
	@Autowired
	BoardService boardService;
	
	public BoardController() {
		System.out.println("@BoardController 생성");
	}

	@GetMapping("/boardList")          //게시판
	public ModelAndView boardList(BoardVo boardVo) {
		List<BoardVo> list = boardService.bList(boardVo);
		System.out.println("list"); 
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("data", list);
		mav.setViewName("boardList");
		return mav;
	}
	
	@GetMapping("/boardCreate")
	public String boardCreate() {
		System.out.println("board create!");
		return "boardCreate";
	}
	
	@PostMapping("/boardCreate")
	public ModelAndView createPost(BoardVo boardVo) {
		System.out.println("board post success");
		
		int rs = boardService.bCreate(boardVo);
		
		ModelAndView mav = new ModelAndView();
		if(rs==1) {
			mav.setViewName("redirect:/boardList");
		} else {
			mav.setViewName("redirect:/boardCreate");
		}
		
		return mav;
	}
	
	
}
