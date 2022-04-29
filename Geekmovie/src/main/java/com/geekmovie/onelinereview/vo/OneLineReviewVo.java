package com.geekmovie.onelinereview.vo;

import java.sql.Date;

public class OneLineReviewVo {
	private int oneLineReviewId;
	private String userId;
	private int movieId;
	private int score;
	private String comment;			//300자 제한
	private int likes;
	private Date gendate;
	private Date moddate;
	
	public OneLineReviewVo(int oneLineReviewId, String userId, int movieId, int score, String comment, int likes,
			Date gendate, Date moddate) {
		super();
		this.oneLineReviewId = oneLineReviewId;
		this.userId = userId;
		this.movieId = movieId;
		this.score = score;
		this.comment = comment;
		this.likes = likes;
		this.gendate = gendate;
		this.moddate = moddate;
	}

	public int getOneLineReviewId() {
		return oneLineReviewId;
	}

	public void setOneLineReviewId(int oneLineReviewId) {
		this.oneLineReviewId = oneLineReviewId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public int getMovieId() {
		return movieId;
	}

	public void setMovieId(int movieId) {
		this.movieId = movieId;
	}

	public int getScore() {
		return score;
	}

	public void setScore(int score) {
		this.score = score;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public int getLikes() {
		return likes;
	}

	public void setLikes(int likes) {
		this.likes = likes;
	}

	public Date getGendate() {
		return gendate;
	}

	public void setGendate(Date gendate) {
		this.gendate = gendate;
	}
	

	public Date getModdate() {
		return moddate;
	}

	public void setModdate(Date moddate) {
		this.moddate = moddate;
	}

	@Override
	public String toString() {
		return "OneLineReviewVo [oneLineReviewId=" + oneLineReviewId + ", userId=" + userId + ", movieId=" + movieId
				+ ", score=" + score + ", comment=" + comment + ", likes=" + likes + ", gendate=" + gendate
				+ ", moddate=" + moddate + "]";
	}

	
}
