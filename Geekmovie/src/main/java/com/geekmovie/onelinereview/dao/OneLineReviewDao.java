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
	
	public List<OneLineReviewVo> SelectAll(int nowPageStart, int nowPageEnd) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("nowPageStart", nowPageStart-1);
		map.put("Size", nowPageEnd-nowPageStart+1);
		List<OneLineReviewVo> list = sqlSessionTemplate.selectList("oneLineReviewVo.Select", map);	
		return list;
	}
	
	public int Count() {
		return sqlSessionTemplate.selectOne("oneLineReviewVo.Count");
	}
	
}
