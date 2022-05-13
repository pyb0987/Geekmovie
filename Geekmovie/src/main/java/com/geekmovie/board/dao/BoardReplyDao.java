package com.geekmovie.board.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.geekmovie.board.vo.ReplyVo;

@Repository
public class BoardReplyDao {
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public BoardReplyDao() {
		System.out.println("@Repository BoardReplyDao 스프링 자동 생성");
	}
	
	public List<ReplyVo> replyList(int seq) {
		return sqlSessionTemplate.selectList("replyVo.reply_list", seq);
	}
	
	public int replyCreate(ReplyVo replyVo) {
		return sqlSessionTemplate.insert("replyVo.reply_create", replyVo);
	}
	
	public int replyUpdate(ReplyVo replyVo) {
		return sqlSessionTemplate.update("replyVo.reply_update", replyVo);
	}
	
	public int replyDelete(int rno) {
		System.out.println("삭제 DAO");
		return sqlSessionTemplate.delete("replyVo.reply_delete", rno);
	}

}
