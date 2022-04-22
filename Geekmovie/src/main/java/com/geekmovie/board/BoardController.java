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
	
	@GetMapping("/boardDetail")
	public ModelAndView detail(BoardVo boardVo) {
		System.out.println(boardVo);
		
		BoardVo detail = boardService.bDetail(boardVo);
		
		System.out.println(detail);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("data", detail);
		mav.setViewName("boardDetail");
		
		return mav;
	}
	
	@GetMapping("/boardUpdate")
	public ModelAndView boardUpdate(BoardVo boardVo) {
		System.out.println("board update!");
		BoardVo detailBoard = boardService.bDetail(boardVo);
		System.out.println(boardVo);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("data", detailBoard);	
		mav.setViewName("boardUpdate");
		
		return mav;
	}
	
	@PostMapping("/boardUpdate")
	public ModelAndView boardUpdatePost(BoardVo boardVo) {
		
		ModelAndView mav = new ModelAndView();
		
		int rs = boardService.bUpdate(boardVo);
		if(rs == 1) {
			int useq = boardVo.getSeq();
			System.out.println("수정완료");
			mav.setViewName("redirect:/boardDetail?seq="+useq);
		} else {
			System.out.println("재입력");
			int useq = boardVo.getSeq();
			mav.setViewName("redirect:/boardUpdate?seq="+useq);
		}
		return mav;
	}
	
	@PostMapping("/boardDelete")
	public ModelAndView boardDelete(BoardVo boardVo) {
		
		ModelAndView mav = new ModelAndView();
		
		int rs = boardService.bDelete(boardVo);
		if(rs == 1) {
			System.out.println("삭제완료");
			mav.setViewName("redirect:/boardList");
		} else {
			System.out.println("삭제실패");
			int useq = boardVo.getSeq();
			mav.setViewName("redirect:/boardDetail?seq="+useq);
		}
		return mav;
	}
}
