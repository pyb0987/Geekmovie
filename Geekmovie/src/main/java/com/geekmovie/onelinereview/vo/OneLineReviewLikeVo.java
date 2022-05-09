package com.geekmovie.onelinereview.vo;

public class OneLineReviewLikeVo {
	private String userId;
	private int oneLineReviewId;
	private int mode;
	public OneLineReviewLikeVo() {
	}
	public OneLineReviewLikeVo(String userId, int oneLineReviewId, int mode) {
		super();
		this.userId = userId;
		this.oneLineReviewId = oneLineReviewId;
		this.mode = mode;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public int getOneLineReviewId() {
		return oneLineReviewId;
	}
	public void setOneLineReviewId(int oneLineReviewId) {
		this.oneLineReviewId = oneLineReviewId;
	}
	public int getMode() {
		return mode;
	}
	public void setMode(int mode) {
		this.mode = mode;
	}
	@Override
	public String toString() {
		return "OneLineReviewLikeVo [userId=" + userId + ", oneLineReviewId=" + oneLineReviewId + ", mode=" + mode
				+ "]";
	}
	
	
}
