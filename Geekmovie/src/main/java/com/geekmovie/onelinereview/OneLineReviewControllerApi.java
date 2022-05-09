package com.geekmovie.onelinereview;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.geekmovie.onelinereview.service.OneLineReviewService;
import com.geekmovie.onelinereview.vo.OneLineReviewPageVo;
import com.geekmovie.onelinereview.vo.OneLineReviewVo;



@RestController
public class OneLineReviewControllerApi {

	@Autowired
	OneLineReviewService oneLineReviewService;
	@Autowired
	OneLineReviewPageVo olrpv;
	
	
	
	@RequestMapping(value = "/oneLineReview/{olrid}", method = RequestMethod.DELETE)
	public int oneLineReviewDelete(@PathVariable("olrid") int olrid) {
		int rs = oneLineReviewService.Delete(olrid);			//rest api
		return 	rs;
	}

	@RequestMapping(value = "/oneLineReview", method = RequestMethod.POST)
	@ResponseBody
	public int oneLineReviewPost(@RequestBody Map<String, Object> map) {
		return 	oneLineReviewService.Create(map);
	}
	
	@RequestMapping(value = "/oneLineReview/{olrid}", method = RequestMethod.GET)	//임의의 query로부터 정보가져오기
	public String oneLineReviewGET(HttpServletRequest request, @PathVariable("olrid") int olrid) {//input#{query}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("oneLineReviewId", olrid);
		map.put("query", (String)request.getParameter("query"));
		
		return 	oneLineReviewService.SelectAny(map);
	}
	
	@RequestMapping(value = "/oneLineReview/{olrid}", method = RequestMethod.PUT)
	@ResponseBody
	public int oneLineReviewPut(@RequestBody Map<String, Object> map) {
		return 	oneLineReviewService.Update(map);
	}

	@RequestMapping(value = "/oneLineReview/user/{userId}", method = RequestMethod.GET)
	@ResponseBody
	public List<OneLineReviewVo> oneLineReviewUserGET( @PathVariable("userId") String userId) {
		List<OneLineReviewVo> list = oneLineReviewService.SelectUser(userId);
		return list; 
	}
	
	@RequestMapping(value = "/oneLineReview/page/{olrId}", method = RequestMethod.GET)
	@ResponseBody
	public int oneLineReviewUserGET( @PathVariable("olrId") int olrId) {
		return oneLineReviewService.GetPage(olrId);
	}
	

	@RequestMapping(value = "/oneLineReview/user/{userId}/like", method = RequestMethod.GET)
	@ResponseBody
	public List<OneLineReviewVo> oneLineReviewUserGET(HttpServletRequest request, @PathVariable("userId") String userId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		map.put("nowPageStart", Integer.parseInt(request.getParameter("nowPageStart")));
		map.put("Size", Integer.parseInt(request.getParameter("Size")));
		return oneLineReviewService.UserLike(map);
	}
	
	@RequestMapping(value = "/oneLineReview/movie/{movieId}", method = RequestMethod.GET)
	@ResponseBody
	public List<OneLineReviewVo> oneLineReviewMovieGET(@PathVariable("movieId") String movieId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("movieId", movieId);
		map.put("nowPageStart", 0);
		map.put("Size", 6);
		return oneLineReviewService.SelectMovie(map);
	}
}
