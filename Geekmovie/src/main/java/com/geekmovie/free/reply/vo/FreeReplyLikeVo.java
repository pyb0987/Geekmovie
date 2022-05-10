package com.geekmovie.free.reply.vo;

public class FreeReplyLikeVo {
	  private String userId;
	  private int freereplyId;
	  private int mode;		/*좋아요 1 아무것도 아님 0*/
	  private int seq;
	public FreeReplyLikeVo() {
		super();
	}
	public FreeReplyLikeVo(String userId, int freereplyId, int mode, int seq) {
		super();
		this.userId = userId;
		this.freereplyId = freereplyId;
		this.mode = mode;
		this.seq = seq;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public int getFreereplyId() {
		return freereplyId;
	}
	public void setFreereplyId(int freereplyId) {
		this.freereplyId = freereplyId;
	}
	public int getMode() {
		return mode;
	}
	public void setMode(int mode) {
		this.mode = mode;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	@Override
	public String toString() {
		return "FreeReplyLikeVo [userId=" + userId + ", freereplyId=" + freereplyId + ", mode=" + mode + ", seq=" + seq
				+ "]";
	}
	  
	  
}
