package com.geekmovie.board;


import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.geekmovie.board.service.BoardService;
import com.geekmovie.board.vo.BoardVo;
import com.geekmovie.board.vo.PageVo;
import com.geekmovie.onelinereview.vo.OneLineReviewLikeVo;

@Controller
public class BoardController {
	
	@Autowired
	BoardService boardService;
	
	public BoardController() {
		System.out.println("@BoardController 생성");
	}

	@RequestMapping("/boardList")          //게시판
	public ModelAndView boardList(BoardVo boardVo,
			@RequestParam(required = false, defaultValue = "1") int curPage,
			@RequestParam(required = false, defaultValue = "1") int range,
			@RequestParam(required = false, defaultValue = "TC") String searchType,
			@RequestParam(required = false, defaultValue = "") String bKeyword) {
		System.out.println("board List");
		
		if(boardVo.getSearchType() == null) boardVo.setSearchType("TC");
		
		int listCnt = boardService.boardListCnt(boardVo);
		
		ModelAndView mav = new ModelAndView();
		PageVo pagevo = new PageVo();
		
		pagevo.pageInfo(curPage, range, listCnt);
		boardVo.setStartList(pagevo.getStartList());
		boardVo.setListSize(pagevo.getListSize());
		
		List<BoardVo> list = boardService.bList(boardVo);
		String sType = boardVo.getSearchType();
		String kWord = boardVo.getbKeyword();
		
		mav.addObject("pagination", pagevo);
		mav.addObject("data", list);
		mav.addObject("searchType",sType);
		mav.addObject("keyword", kWord);
		mav.addObject("curpage", curPage);
		mav.addObject("range", range);
		mav.setViewName("boardList");
		
		return mav;
	}
	
	@GetMapping("/boardCreate")
	public String boardCreate(HttpSession session) {
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
	public ModelAndView detail(BoardVo boardVo,
			@RequestParam(required = false, defaultValue = "1") int curPage,
			@RequestParam(required = false, defaultValue = "1") int range,
			@RequestParam(required = false, defaultValue = "TC") String searchType,
			@RequestParam(required = false, defaultValue = "") String bKeyword) {
		System.out.println("board detail");
		
		boardService.bCnt(boardVo);

		BoardVo detail = boardService.bDetail(boardVo);
		String sType = boardVo.getSearchType();
		String kWord = boardVo.getbKeyword();
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("data", detail);
		mav.addObject("searchType",sType);
		mav.addObject("keyword", kWord);
		mav.addObject("curpage", curPage);
		mav.addObject("range", range);
		mav.setViewName("boardDetail");
		
		return mav;
	}
	
	@GetMapping("/boardUpdate")
	public ModelAndView boardUpdate(BoardVo boardVo) {
		System.out.println("board update!");
		BoardVo detailBoard = boardService.bDetail(boardVo);
		
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
