package com.geekmovie.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.geekmovie.board.service.FreeBoardLikeService;
import com.geekmovie.board.service.FreeBoardService;
import com.geekmovie.board.vo.FreeVo;
import com.geekmovie.board.vo.PageVo;
import com.geekmovie.onelinereview.vo.OneLineReviewVo;

@Controller
public class FreeBoardController {
	
	@Autowired
	FreeBoardService fBoardService;
	
	@Autowired
	FreeBoardLikeService freeBoardLikeService; 
	
	public FreeBoardController() {
		System.out.println("@FreeBoardController active");
	}
	
	@RequestMapping("/freeboardList")
	public ModelAndView fBoardList(FreeVo freeVo,
			@RequestParam(required = false, defaultValue = "1") int curPage,
			@RequestParam(required = false, defaultValue = "1") int range,
			@RequestParam(required = false, defaultValue = "TC") String searchType,
			@RequestParam(required = false, defaultValue = "") String bKeyword,
			@RequestParam(required = false, defaultValue = "false") String recommend) {
		System.out.println("FBL");
		
		if(freeVo.getSearchType() == null) freeVo.setSearchType("TC");
		
		int listCnt = fBoardService.fListCnt(freeVo);
		
		ModelAndView mav = new ModelAndView();
		PageVo pagevo = new PageVo();
		
		pagevo.pageInfo(curPage, range, listCnt);
		freeVo.setStartList(pagevo.getStartList());
		freeVo.setListSize(pagevo.getListSize());
		
		List<FreeVo> list = fBoardService.fList(freeVo);
		String sType = freeVo.getSearchType();
		String kWord = freeVo.getbKeyword();
		
		mav.addObject("data", list);
		mav.addObject("pagevo", pagevo);
		mav.addObject("searchType", sType);
		mav.addObject("keyword", kWord);
		mav.addObject("curPage", curPage);
		mav.addObject("range", range);
		mav.addObject("recommend", recommend);
		mav.setViewName("freeboardList");
		
		return mav;
	}
	@RequestMapping("/freeboardRecommendList")
	public ModelAndView fBoardRecommendList(FreeVo freeVo,
			@RequestParam(required = false, defaultValue = "1") int curPage,
			@RequestParam(required = false, defaultValue = "1") int range,
			@RequestParam(required = false, defaultValue = "TC") String searchType,
			@RequestParam(required = false, defaultValue = "") String bKeyword) {
		
		if(freeVo.getSearchType() == null) freeVo.setSearchType("TC");
		
		int listCnt = fBoardService.freeRecommendCnt(freeVo);
		
		ModelAndView mav = new ModelAndView();
		PageVo pagevo = new PageVo();
		
		pagevo.pageInfo(curPage, range, listCnt);
		freeVo.setStartList(pagevo.getStartList());
		freeVo.setListSize(pagevo.getListSize());
		
		List<FreeVo> list = fBoardService.freeRecommend(freeVo);
		String sType = freeVo.getSearchType();
		String kWord = freeVo.getbKeyword();
		
		mav.addObject("data", list);
		mav.addObject("pagevo", pagevo);
		mav.addObject("searchType", sType);
		mav.addObject("keyword", kWord);
		mav.addObject("curPage", curPage);
		mav.addObject("range", range);
		mav.setViewName("freeboardRecommendList");
		
		return mav;
	}
	
	
	@GetMapping("/freeboardDetail")
	public ModelAndView fBoardDetail(FreeVo freeVo,
			@RequestParam(required = false, defaultValue = "1") int curPage,
			@RequestParam(required = false, defaultValue = "1") int range,
			@RequestParam(required = false, defaultValue = "TC") String searchType,
			@RequestParam(required = false, defaultValue = "") String bKeyword,
			@RequestParam(required = false, defaultValue = "") String focus) {
		System.out.println("FBD");
		
		fBoardService.fCnt(freeVo);
		
		FreeVo detail = fBoardService.fDetail(freeVo);
		String sType = freeVo.getSearchType();
		String kWord = freeVo.getbKeyword();
		
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("data", detail);
		mav.addObject("searchType",sType);
		mav.addObject("keyword", kWord);
		mav.addObject("curpage", curPage);
		mav.addObject("range", range);
		mav.addObject("focus", focus);
		mav.setViewName("freeboardDetail");
		
		return mav;
	}
	
	@GetMapping("/freeboardCreate")
	public String fBoardCreate(HttpSession session) {
		System.out.println("board create!");
		return "freeboardCreate";
	}
	
	@PostMapping("/freeboardCreate")
	public ModelAndView postCreate(FreeVo freeVo) {
		System.out.println("create success");
		
		int rs = fBoardService.fCreate(freeVo);
		ModelAndView mav = new ModelAndView();
		
		if(rs == 1) {
			mav.setViewName("redirect:/freeboardList");
		} else {
			mav.setViewName("redirect:/freeboardCreate");
		}
		
		return mav;
	}
	
	@GetMapping("/freeboardUpdate")
	public ModelAndView fBoardUpdate(FreeVo freeVo) {
		System.out.println("FBU");
		
		FreeVo fbd = fBoardService.fDetail(freeVo);
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("data", fbd);
		mav.setViewName("freeboardUpdate");
		
		
		return mav;
	}
	
	@PostMapping("/freeboardUpdate")
	public ModelAndView FBUPost(FreeVo freeVo) {
		System.out.println("update success");
		
		ModelAndView mav = new ModelAndView();
		int rs = fBoardService.fUpdate(freeVo);
		if(rs == 1) {
			System.out.println("수정완료");
			int fseq = freeVo.getSeq();
			mav.setViewName("redirect:/freeboardDetail?seq="+fseq);
		} else {
			System.out.println("수정 실패!");
			int fseq = freeVo.getSeq();
			mav.setViewName("redirect:/freeboardUpdate?seq="+fseq);
		}
		
		return mav;
	}
	
	@PostMapping("/freeboardDelete")
	public ModelAndView FBUDelete(FreeVo freeVo) {
		System.out.println("삭제");
		
		ModelAndView mav = new ModelAndView();
		
		int rs = fBoardService.fDelete(freeVo);
		if(rs == 1) {
			System.out.println("삭제완료");
			mav.setViewName("redirect:/freeboardList");
		} else {
			System.out.println("삭제실패");
			int fseq = freeVo.getSeq();
			mav.setViewName("redirect:/freeboardDetail?seq="+fseq);
		}
		
		return mav;
	}
	
	@RequestMapping(value = "/freeboardList/like/{userId}", method = RequestMethod.GET)//특정 유저가 좋아하는 자유게시글
	public ModelAndView freeBoardLike(HttpSession session, @PathVariable("userId") String userId,
			@RequestParam(required = false, defaultValue = "1") int curPage,  
			@RequestParam(required = false, defaultValue = "ko-KR") String language) {
		String sessionId = (String)session.getAttribute("id");

		ModelAndView mav = new ModelAndView();
		if(!sessionId.equals(userId)) {
			mav.setViewName("redirect:/");
			return mav;
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		map.put("mode", 1);
		int cnt = freeBoardLikeService.CountUserLike(map);	
		PageVo pagevo = new PageVo();
		int range= (curPage+9)/10;
		pagevo.pageInfo(curPage, range, cnt);
		Map<String, Object> map2 = new HashMap<String, Object>();
		map2.put("userId", userId);
		map2.put("nowPageStart", pagevo.getStartList());
		map2.put("Size", pagevo.getListSize());
		
		List<FreeVo> list = fBoardService.UserLike(map2);
		String sType = "TC";
		String kWord = "";
		
		mav.addObject("data", list);
		mav.addObject("pagevo", pagevo);
		mav.addObject("searchType", sType);
		mav.addObject("keyword", kWord);
		mav.addObject("curPage", curPage);
		mav.addObject("range", range);
		mav.setViewName("freeboardListLike");
		
		return mav;
		
		
	}
	
	
}
