package com.geekmovie.onelinereview.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.geekmovie.onelinereview.vo.OneLineReviewVo;

@Repository
public class OneLineReviewDao {
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public List<OneLineReviewVo> Select(String SearchMode,String query, int nowPageStart, int onePage) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchMode", SearchMode);
		map.put("query", query);
		map.put("nowPageStart", nowPageStart);
		map.put("Size", onePage);
		List<OneLineReviewVo> list = sqlSessionTemplate.selectList("oneLineReviewVo.Select", map);	
		return list;
	}
	
	public int Count(String SearchMode, String query) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("searchMode", SearchMode);
		map.put("query", query);
		return sqlSessionTemplate.selectOne("oneLineReviewVo.Count", map);
	}
	
	public int Delete(int oneLineReviewId) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("oneLineReviewId", oneLineReviewId);
		return sqlSessionTemplate.delete("oneLineReviewVo.Delete", map);
	}
	
	public int  Create(Map<String, Object> map) {
		return sqlSessionTemplate.insert("oneLineReviewVo.Create", map);
	};
	
	public int  Update(Map<String, Object> map) {
		return sqlSessionTemplate.update("oneLineReviewVo.Update", map);
	};
	
	public int  UpdateLike(Map<String, Object> map) {
		return sqlSessionTemplate.update("oneLineReviewVo.UpdateLike", map);
	};
	
	public String SelectAny(Map<String, Object> map) {		//#{oneLineReviewId}의 아무거나(#{query}) 가져감
		return sqlSessionTemplate.selectOne("oneLineReviewVo.SelectAny", map);
	};
	
	public List<OneLineReviewVo> SelectUser(String userId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		List<OneLineReviewVo> list = sqlSessionTemplate.selectList("oneLineReviewVo.SelectUser", map);	
		return list;
	}
	
	public int GetPage(int oneLineReviewId) {
		return 	sqlSessionTemplate.selectOne("oneLineReviewVo.GetPage", oneLineReviewId);	
	}
	
	public List<OneLineReviewVo> UserLike(Map<String, Object> map) {
		return 	sqlSessionTemplate.selectList("oneLineReviewVo.UserLike", map);	
	}
	
	public List<OneLineReviewVo> SelectMovie(Map<String, Object> map) {
		return 	sqlSessionTemplate.selectList("oneLineReviewVo.SelectMovie", map);	
	}

	public Map<String, Object> AverageScore(int movieId) {
		return sqlSessionTemplate.selectOne("oneLineReviewVo.score-average", movieId);
	}
}
