package com.geekmovie.movie;

import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.geekmovie.board.service.BoardService;
import com.geekmovie.movie.dao.MovieDao;
import com.geekmovie.movie.json.MovieUrlGetter;
import com.geekmovie.movie.json.UrlRead;
import com.geekmovie.onelinereview.service.OneLineReviewService;

@RestController
public class MovieControllerApi {
	
	@Autowired
	MovieDao movieDao;
	@Autowired
	MovieUrlGetter movieUrlGetter;
	@Autowired
	BoardService boardService;
	@Autowired
	OneLineReviewService oneLineReviewService;
	
	@GetMapping("/getMovieData")
	public String getMovieData(HttpServletRequest request){						//1개영화의 디테일 반환
		int movieId = 1;
		String language = "";
		String rs = "";	
		try {
			movieId = Integer.parseInt((String)request.getParameter("movieId"));
			language = (String)request.getParameter("language");
			rs = UrlRead.readStringFromUrl(movieUrlGetter.getMovieData(movieId, language));
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		  return rs;
	}

	
	@GetMapping("/getPopularMovieList")
	public String getPopularMovieList(HttpServletRequest request){						//인기있는 영화 20개의 목록반환
		int page = 1;
		String language = "";
		String rs = "";
		
		try {
			page = Integer.parseInt((String)request.getParameter("page"));
			language = (String)request.getParameter("language");
			rs = UrlRead.readStringFromUrl(movieUrlGetter.getPopularMovieList(page, language));
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		  return rs;
	}
	
	
	@GetMapping("/getTrendingMovieList")																//트렌딩 영화 20개의 목록반환
	public String getTrendingMovieList(HttpServletRequest request){
		String timewindow = "";
		String rs = "";
		
		try {
			timewindow = (String)request.getParameter("timewindow");
			rs = UrlRead.readStringFromUrl(movieUrlGetter.getTrendingMovieList(timewindow));
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		  return rs;
	}
	
	
	@GetMapping("/getNowPlayingMovieList")																//현재 상영중인 영화 20개의 목록반환
	public String getNowPlayingMovieList(HttpServletRequest request){
		int page = 1;
		String language = "";
		String rs = "";
		
		try {
			page = Integer.parseInt((String)request.getParameter("page"));
			language = (String)request.getParameter("language");
			rs = UrlRead.readStringFromUrl(movieUrlGetter.getNowPlayingMovieList(language, page));
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		  return rs;
	}
	
	
	@GetMapping("/getTopRatedMovieList")																//평점이 높은 영화 20개의 목록반환
	public String getTopRatedMovieList(HttpServletRequest request){
		int page = 1;
		String language = "";
		String rs = "";
		
		try {
			page = Integer.parseInt((String)request.getParameter("page"));
			language = (String)request.getParameter("language");
			rs = UrlRead.readStringFromUrl(movieUrlGetter.getTopRatedMovieList(page, language));
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		  return rs;
	}
	

	
	@GetMapping("/searchMovieList")														//특정 키워드로 검색한 영화 목록 반환
	public String searchMovieList(HttpServletRequest request){
		String rs = "";
		String language = ""; 
		String query = ""; 
		int page = 1;
		try {
			language = (String)request.getParameter("language");
			query = (String)request.getParameter("query");
			page = Integer.parseInt(request.getParameter("page"));
			rs = UrlRead.readStringFromUrl(movieUrlGetter.SearchMovieList(language, query, page));
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		  return rs;
	}

	
	@GetMapping("/getMovieCredit")
	public String getMovieCredit(HttpServletRequest request){										//특정 영화의 credit 반환
		String rs = "";
		int movieId = 0; 
		String language = ""; 
		try {
			movieId = Integer.parseInt(request.getParameter("movieId"));
			language = (String)request.getParameter("language");
			rs = UrlRead.readStringFromUrl(movieUrlGetter.getMovieCredit(movieId ,language));
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		  return rs;
	}

	
	
	
	
	@GetMapping("/getSimilarMovieList")
	public String getSimilarMovieList(HttpServletRequest request){											//특정 영화와 비슷한 영화 목록 반환
		String rs = "";
		int movieId = 0; 
		String language = "";
		int page = 1; 
		try {
			movieId = Integer.parseInt(request.getParameter("movieId"));
			language = (String)request.getParameter("language");
			page = Integer.parseInt(request.getParameter("page"));
			rs = UrlRead.readStringFromUrl(movieUrlGetter.getSimilarMovieList(movieId, language, page));
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		  return rs;
	}
	
	
	@GetMapping("/getRecommendMovieList")
	public String getRecommendMovieList(HttpServletRequest request){											//특정 영화를 기반으로한 추천 영화 목록 반환
		String rs = "";
		int movieId = 0; 
		String language = "";
		int page = 1; 
		try {
			movieId = Integer.parseInt(request.getParameter("movieId"));
			language = (String)request.getParameter("language");
			page = Integer.parseInt(request.getParameter("page"));
			rs = UrlRead.readStringFromUrl(movieUrlGetter.getRecommendMovieList(movieId, language, page));
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		  return rs;
	}
	
	@GetMapping("/getLastestMovie")
	public String getLastestMovie(HttpServletRequest request){											//특정 영화를 기반으로한 추천 영화 목록 반환

		String language = "ko-KR";
		String rs = "";
		try {
			language = (String)request.getParameter("language");
			rs = UrlRead.readStringFromUrl(movieUrlGetter.GetLastestMovie(language));
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		  return rs;
	}
	
	@GetMapping("/score")
	public double[] getAverageScore(HttpServletRequest request) {
		int movieId = Integer.parseInt(request.getParameter("movieId"));
		Map<String, Object> boardMap = boardService.AverageScore(movieId);
		Map<String, Object> olrMap = oneLineReviewService.AverageScore(movieId);
		
		Double boardScore = 0.0;
		Double olrScore = 0.0;
		Double boardCnt = 0.0;
		Double olrCnt = 0.0;
		try {
			boardScore = Double.parseDouble(boardMap.get("score").toString());			
		}catch (Exception e) {
			boardScore = 0.0;
		}
		try {
			olrScore = Double.parseDouble(olrMap.get("score").toString());		
		}catch (Exception e) {
			olrScore = 0.0;
		}
		try {
			boardCnt = Double.parseDouble(boardMap.get("cnt").toString());	
		}catch (Exception e) {
			boardCnt = 0.0;
		}
		try {
			olrCnt = Double.parseDouble(olrMap.get("cnt").toString());	
		}catch (Exception e) {
			olrCnt = 0.0;
		}
		double[] rs = {(boardScore+olrScore),(boardCnt+olrCnt)};
		return rs;
	}
}
