package com.geekmovie.board.vo;

public class FreeLikeVo {
	  private String userId;
	  private int freeId;
	  private int mod;		/*좋아요 1 싫어요 0 아무것도 아님 -1*/
	  private int seq;
	
	  
	  public FreeLikeVo() {
		super();
	}


	public FreeLikeVo(String userId, int freeId, int mod, int seq) {
		super();
		this.userId = userId;
		this.freeId = freeId;
		this.mod = mod;
		this.seq = seq;
	}


	public String getUserId() {
		return userId;
	}


	public void setUserId(String userId) {
		this.userId = userId;
	}


	public int getFreeId() {
		return freeId;
	}


	public void setFreeId(int freeId) {
		this.freeId = freeId;
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
		return "FreeLikeVo [userId=" + userId + ", freeId=" + freeId + ", mod=" + mod + ", seq=" + seq + "]";
	}
	  
}
