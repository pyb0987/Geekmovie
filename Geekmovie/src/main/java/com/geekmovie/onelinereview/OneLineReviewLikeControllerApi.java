package com.geekmovie.onelinereview;

import java.util.HashMap;
import java.util.Map;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.geekmovie.onelinereview.service.OneLineReviewLikeService;
import com.geekmovie.onelinereview.service.OneLineReviewService;



@RestController
public class OneLineReviewLikeControllerApi {

	@Autowired
	OneLineReviewLikeService oneLineReviewLikeService;
	@Autowired
	OneLineReviewService oneLineReviewService;
	
	@RequestMapping(value = "/oneLineReview/Like/{olrid}", method = RequestMethod.POST)
	@ResponseBody
	public int oneLineReviewLikePOST(@RequestBody Map<String, Object> map, @PathVariable("olrid") int olrid) {		//좋아요 버튼 누르면 반영  #{userId}, #{mode}
		map.put("oneLineReviewId", olrid);
		int rs = oneLineReviewLikeService.Add(map);		//input #{userId}, #{oneLineReviewId}, #{mode}
		oneLineReviewService.UpdateLike(map);		//한줄평 db 좋아요 수 업데이트
		return rs;
	}
	
	@RequestMapping(value = "/oneLineReview/Like/{olrid}", method = RequestMethod.GET)
	public int oneLineReviewLikeGET(@PathVariable("olrid") int olrid,			//해당하는 유저의 좋아요가 있는지 판별
			@RequestParam String userId, 
			@RequestParam int mode ) {		//#{userId}, #{mode}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("oneLineReviewId", olrid);
		map.put("userId", userId);
		map.put("mode", mode);
		return oneLineReviewLikeService.Check(map);
	}
	
}
