package com.geekmovie.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.geekmovie.board.dao.FreeBoardDao;
import com.geekmovie.board.vo.FreeVo;

@Service
public class FreeBoardServiceImpl implements FreeBoardService{
	
	@Autowired
	FreeBoardDao dao;
	
	public FreeBoardServiceImpl() {
		System.out.println("@FBService 스프링 자동 생성");
	}
	
	@Override
	public List<FreeVo> fList(FreeVo freeVo) {
		return dao.freeList(freeVo);
	}
	
	@Override
	public int fListCnt(FreeVo freeVo) {
		return dao.freeListCnt(freeVo);
	}

	@Override
	public FreeVo fDetail(FreeVo freeVo) {
		return dao.freeboardDetail(freeVo);
	}
	
	@Override
	public int fCreate(FreeVo freeVo) {
		return dao.freeInsert(freeVo);
	}
	
	@Override
	public int fUpdate(FreeVo freeVo) {
		return dao.freeUpdate(freeVo);
	}
	
	@Override
	public int fDelete(FreeVo freeVo) {
		return dao.freeDelete(freeVo);
	}
	
	@Override
	public int fCnt(FreeVo freeVo) {
		return dao.freeCnt(freeVo);
	}
}
