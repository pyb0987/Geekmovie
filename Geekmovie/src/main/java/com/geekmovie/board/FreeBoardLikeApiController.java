package com.geekmovie.board;

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

@RestController
public class FreeBoardLikeApiController {

	@Autowired
	FreeBoardLikeService freeBoardLikeService;
	@Autowired
	FreeBoardService freeBoardService;
	
	@RequestMapping(value = "/freeboard/like/{freeId}", method = RequestMethod.GET)
	public int likeCheck(@PathVariable("freeId") int freeId,			//해당하는 유저의 좋아요가 있는지 판별
			@RequestParam String userId, 
			@RequestParam int mode ){		//#{userId}, #{mode}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("freeId",  freeId);
		map.put("userId", userId);
		map.put("mode", mode);
		return freeBoardLikeService.likeCheck(map);
	}
	
	@RequestMapping(value = "/freeboard/like/{freeId}", method = RequestMethod.POST)
	public int likeAdd(@PathVariable("freeId") int freeId,			//좋아요 insert
			@RequestBody Map<String, Object> map){		//#{userId}, #{mode}
		map.put("freeId",  freeId);
		return freeBoardLikeService.likeAdd(map);
	}
	
	@RequestMapping(value = "/freeboard/freeCount/{freeId}", method = RequestMethod.GET)
	public int CountfreeLike(@PathVariable("freeId") int freeId,			//해당하는 보드의 좋아요 개수
			@RequestParam int mode ){		//#{mode}
		Map<String, Object> map = new HashMap<String, Object>();			
		map.put("freeId",  freeId);
		map.put("mode", mode);
		int likeNum = freeBoardLikeService.CountfreeLike(map);  //좋아요 개수 구할때 freeboard db에도 추가
		if(mode==1) {
			Map<String, Object> map2 = new HashMap<String, Object>();	
			map2.put("seq",  freeId);
			map2.put("likes", likeNum);
			freeBoardService.likeUpdate(map2);
		}
		return likeNum;
	}
	
	@RequestMapping(value = "/freeboard/userCount/{userId}", method = RequestMethod.GET)
	public int CountUserLike(@PathVariable("userId") int userId,			//해당하는 유저의 좋아요 개수
			@RequestParam int mode ){		//#{mode}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId",  userId);
		map.put("mode", mode);
		return freeBoardLikeService.CountUserLike(map);
	}
}
