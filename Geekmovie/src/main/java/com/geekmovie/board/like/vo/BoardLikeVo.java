package com.geekmovie.board.like.vo;

public class BoardLikeVo {
	// 좋아요 번호 
	private String likeno;
	// 게시판 seq
	private int boardno;
	// users id
	private String mno;
	// 좋아요 체크
	private String like_check;
	
	public BoardLikeVo() {
		
	}

	public BoardLikeVo(String likeno, int boardno, String mno, String like_check) {
		super();
		this.likeno = likeno;
		this.boardno = boardno;
		this.mno = mno;
		this.like_check = like_check;
	}

	public String getLikeno() {
		return likeno;
	}

	public void setLikeno(String likeno) {
		this.likeno = likeno;
	}

	public int getBoardno() {
		return boardno;
	}

	public void setBoardno(int boardno) {
		this.boardno = boardno;
	}

	public String getMno() {
		return mno;
	}

	public void setMno(String mno) {
		this.mno = mno;
	}

	public String getLike_check() {
		return like_check;
	}

	public void setLike_check(String like_check) {
		this.like_check = like_check;
	}

	@Override
	public String toString() {
		return "BoardLikeVo [likeno=" + likeno + ", boardno=" + boardno + ", mno=" + mno + ", like_check=" + like_check
				+ "]";
	}

	
	
}
