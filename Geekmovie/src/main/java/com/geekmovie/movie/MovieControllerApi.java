package com.geekmovie.movie;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.geekmovie.movie.dao.MovieDao;
import com.geekmovie.movie.json.MovieUrlGetter;
import com.geekmovie.movie.json.UrlRead;

@RestController
public class MovieControllerApi {
	
	@Autowired
	MovieDao movieDao;
	@Autowired
	MovieUrlGetter movieUrlGetter;
	@Autowired
	ObjectMapper mapper;
	
	@GetMapping("/getMovieData")
	public String getMovieData(HttpServletRequest request){
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
	public String getPopularMovieList(HttpServletRequest request){
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
	
	
	@GetMapping("/getTrendingMovieList")
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
	
	@GetMapping("/searchMovieList")
	public String searchMovieList(HttpServletRequest request){
		String rs = "";
		String language = ""; 
		String query = ""; 
		int page = 1;
		try {
			language = (String)request.getParameter("language");
			query = (String)request.getParameter("query");
			page = Integer.parseInt(request.getParameter("query"));
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
}
