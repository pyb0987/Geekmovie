package com.geekmovie.board.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.geekmovie.board.dao.BoardDao;
import com.geekmovie.board.vo.BoardVo;

@Service
public class BoardServiceImpl implements BoardService{
	
	@Autowired
	BoardDao dao;
	
	public BoardServiceImpl() {
		System.out.println("@Service 스프링 자동 생성");
	}
	
	@Override
	public int create(BoardVo boardVo) {
		return dao.insert(boardVo);
	}

}
