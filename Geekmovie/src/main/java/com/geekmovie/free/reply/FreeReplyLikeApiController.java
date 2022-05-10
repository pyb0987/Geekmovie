package com.geekmovie.free.reply;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.geekmovie.board.service.FreeBoardLikeService;
import com.geekmovie.board.service.FreeBoardService;
import com.geekmovie.free.reply.service.FreeReplyLikeService;
import com.geekmovie.free.reply.service.FreeReplyService;

@RestController
public class FreeReplyLikeApiController {

	@Autowired
	FreeReplyLikeService freeReplyLikeService;
	@Autowired
	FreeReplyService freeReplyService;
	
	@RequestMapping(value = "/freeboard/reply/{freereplyId}/like", method = RequestMethod.GET)
	public int likeCheck(@PathVariable("freereplyId") int freereplyId,			//해당하는 유저의 좋아요가 있는지 판별
			@RequestParam String userId){		//#{userId}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("freereplyId",  freereplyId);
		map.put("userId", userId);
		map.put("mode", 1);
		return freeReplyLikeService.likeCheck(map);
	}
	
	@RequestMapping(value = "/freeboard/reply/{freereplyId}/like", method = RequestMethod.POST)
	public int likeAdd(@PathVariable("freereplyId") int freereplyId,			//좋아요 insert
			@RequestBody Map<String, Object> map){		//#{userId}, #{mode}
		map.put("freereplyId",  freereplyId);
		return freeReplyLikeService.likeAdd(map);
	}
	
	@RequestMapping(value = "/freeboard/reply/{freereplyId}/replyCount", method = RequestMethod.GET)
	public int CountfreeLike(@PathVariable("freereplyId") int freereplyId){			//해당하는 댓글의 좋아요 개수
		Map<String, Object> map = new HashMap<String, Object>();			
		map.put("freereplyId",  freereplyId);
		map.put("mode", 1);
		int likeNum = freeReplyLikeService.CountfreeLike(map);  //좋아요 개수 구할때 freereply db에도 추가
			Map<String, Object> map2 = new HashMap<String, Object>();	
			map2.put("replyId",  freereplyId);
			map2.put("likes", likeNum);
			freeReplyService.likeUpdate(map2);
		return likeNum;
	}
	
	@RequestMapping(value = "/freeboard/reply{userId}/userCount", method = RequestMethod.GET)
	public int CountUserLike(@PathVariable("userId") int userId){			//해당하는 유저의 좋아요 개수
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId",  userId);
		map.put("mode", 1);
		return freeReplyLikeService.CountUserLike(map);
	}
}
