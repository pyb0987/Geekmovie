package com.geekmovie.board.like.vo;

public class BoardLikeVo {
	
	private String userId;
	private int likeCheck;
	private int mod;
	private int seq;
	
	public BoardLikeVo() {
		
	}

	public BoardLikeVo(String userId, int likeCheck, int mod, int seq) {
		super();
		this.userId = userId;
		this.likeCheck = likeCheck;
		this.mod = mod;
		this.seq = seq;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public int getLikeCheck() {
		return likeCheck;
	}

	public void setLikeCheck(int likeCheck) {
		this.likeCheck = likeCheck;
	}

	public int getMod() {
		return mod;
	}

	public void setMod(int mod) {
		this.mod = mod;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	@Override
	public String toString() {
		return "BoardLikeVo [userId=" + userId + ", likeCheck=" + likeCheck + ", mod=" + mod + ", seq=" + seq + "]";
	}
	
	
	
}
