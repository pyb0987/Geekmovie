package com.geekmovie.movie;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.geekmovie.movie.common.UrlRead;
import com.geekmovie.movie.dao.MovieDao;

@RestController
public class MovieControllerApi {
	
	@Autowired
	MovieDao movieDao;
	
	@GetMapping("/test2")
	public String test2() {
	String url = movieDao.getPopularMovieInfo(1, "ko-KR");
		JSONObject rs = new JSONObject();
		try {
			rs = UrlRead.readJsonFromUrl(url);
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rs.toString();
	}
	

	
	@GetMapping("/popularMovie")
	public String popularMovie(HttpServletRequest request){
		int page = (Integer)request.getAttribute("page");
		String language = (String)request.getAttribute("language");
		String rs = movieDao.getPopularMovieInfo(page, language);
		return rs;
	}
	
}
