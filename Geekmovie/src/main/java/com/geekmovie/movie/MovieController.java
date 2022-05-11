package com.geekmovie.movie;



import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.geekmovie.board.service.BoardService;
import com.geekmovie.board.vo.BoardVo;
import com.geekmovie.board.vo.PageVo;
import com.geekmovie.movie.dao.MovieDao;


/**
 * Handles requests for the application home page.
 */
@Controller
public class MovieController {
	
	
	@Autowired
	MovieDao movieDao;
	@Autowired
	BoardService boardService;
	
	
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
		mav.addObject("query", map.get("query"));
		if(searchMode.contains("movie")) {
		
			mav.setViewName("movieSearch");
			return mav;
		}
		else{
			int curPage = 1;
			int range = 1;
			String searchType = "TC";
			BoardVo boardVo = new BoardVo();
			boardVo.setbKeyword(map.get("query"));
			boardVo.setSearchType(searchType);
			int listCnt = boardService.boardListCnt(boardVo);
			
			ModelAndView mav2 = new ModelAndView();
			PageVo pagevo = new PageVo();
			pagevo.pageInfo(1, 1, listCnt);
			
			boardVo.setStartList(pagevo.getStartList());
			boardVo.setListSize(pagevo.getListSize());
			
			List<BoardVo> list = boardService.bList(boardVo);
			String sType = boardVo.getSearchType();
			String kWord = boardVo.getbKeyword();
			
			mav2.addObject("pagination", pagevo);
			mav2.addObject("data", list);
			mav2.addObject("searchType",sType);
			mav2.addObject("keyword", kWord);
			mav2.addObject("query", kWord);
			mav2.addObject("curpage", curPage);
			mav2.addObject("range", range); 
			mav2.addObject("searchMode", searchMode);
			if(searchMode.contains("review")) {
				mav2.setViewName("boardList");				
			}else {
				mav2.addObject("curPage", curPage);
				mav2.addObject("pagevo", pagevo);
				mav2.setViewName("freeboardList");								
			}
			return mav2;
			
		}
	}
	




}
