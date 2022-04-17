package com.geekmovie.movie.json;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import org.springframework.stereotype.Repository;

@Repository
public class MovieUrlGetter  {





	// 실제로는 내부 DB에 접근하지 않고 외부 DB와 연결함

	String api_key = "6d6ae24db915704490db7ae6eaa554ce";

	public String getMovieData(int movieId, String language) {
		String url = "https://api.themoviedb.org/3/movie/";
		url += movieId;
		url += "?api_key=";
		url += api_key;
		url += "&language=";
		url += language;
		return url;
	}


	public String getImage(String inputUrl, String size) { // "backdrop_sizes":[	"w300", "w780", "w1280", "original"], 
		String url = "https://image.tmdb.org/t/p/";		// "logo_sizes":["w45","w92","w154", "w185", "w300", "w500","original"],
		url+=size;										// "poster_sizes":["w92","w154","w185","w342","w500","w780","original"],
		url+="/";										// "profile_sizes":["w45","w185","h632","original"],
		url+="inputUrl";									// "still_sizes":["w92","w185","w300","original"]
		return url;
	}

	public String getCompanyInfo(int companyId) {				
		String url = "https://api.themoviedb.org/3/company/";
		url += companyId;
		url += "?api_key=";
		url += api_key;
		return url;
	}

	public String getGenreList(String language) {				//장르의 전체적인 구분을 리턴
		String url = "https://api.themoviedb.org/3/genre/movie/list?api_key=";
		url += api_key;
		url += "&language=";
		url += language;
		return url;
	}

	public String getMovieCredit(int movieId, String language) {			//특정 영화에 출연한 배우 목록을 리턴
		String url = "https://api.themoviedb.org/3/movie/";
		url += movieId;
		url += "/credits?api_key=";
		url += api_key;
		url += "&language=";
		url += language;
		return url;
	}

	public String getRecommendMovieList(int movieId, String language, int page) {		//특정 영화에 관련된 영화목록 리턴
		String url = "https://api.themoviedb.org/3/movie/";
		url += movieId;
		url += "/recommendations?api_key=";
		url += api_key;
		url += "&language=";
		url	+= language;
		url	+= "&page=";
		url += page;
		return url;		

	}

	public String getSimilarMovieList(int movieId, String language, int page) {			//특정 영화와 비슷한 영화목록 리턴
		String url = "https://api.themoviedb.org/3/movie/";
		url += movieId;
		url	+= "/similar?api_key=";
		url += api_key;
		url += "&language=";
		url += language;
		url += "&page=";
		url	+= page;
		return url;
	}


	public String getNowPlayingMovieList(String language, int page) {			//현재 상영중인 영화목록 리턴
		String url = "https://api.themoviedb.org/3/movie/now_playing?api_key=";
		url += api_key;
		url += "&language=";
		url += language;
		url += "&page=";
		url += page;
		return url;
	}

	public String getPopularMovieList(int page, String language) {				//langauge='ko-KR', 20개씩, 게시글이 많이 생성되는 순으로 만드는 방향으로 바꿀것
		String url = "https://api.themoviedb.org/3/movie/popular?api_key=";
		url += api_key;
		url += "&language=";
		url += language;
		url += "&page=";
		url += page;
		return url;
	}

	public String getTopRatedMovieList(int page, String language) {
		String url = "https://api.themoviedb.org/3/movie/top_rated?api_key=";
		url += api_key;
		url += "&language=";
		url += language;
		url += "&page=";
		url += page;
		return url;
	}

	public String getTrendingMovieList(String timewindow) {		// timewindow : day, week
		String url = "https://api.themoviedb.org/3/trending/movie/";
		url += timewindow;
		url += "?api_key=";
		url += api_key;
		return url;
	}

	public String SearchMovieList(String language, String query, int page) {
		String url = "https://api.themoviedb.org/3/search/movie?api_key=";
		url += api_key;
		url += "&language=";
		url += language;
		url += "&query=";

		String encodeResult = query;
		try {
			encodeResult = URLEncoder.encode(query, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();		
		} finally {
			url += encodeResult;
			url += "&page=";
			url += page;
		}
		return url;
	}

}


