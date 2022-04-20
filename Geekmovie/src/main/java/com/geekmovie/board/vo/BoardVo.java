package com.geekmovie.board.vo;

import java.util.Date;

public class BoardVo {
	private int seq; // 게시글 고유넘버
	private String title;
	private String writer;
	private String contents;
	private String reply; // 댓글
	private Date regdate;
	private int cnt; // 조회수
	private int likes; // 추천수
	private String movie_id;
	
	public BoardVo() {

	}

	public BoardVo(int seq, String title, String writer, String contents, String reply, Date regdate, int cnt, int likes, String movie_id) {
		super();
		this.seq = seq;
		this.title = title;
		this.writer = writer;
		this.contents = contents;
		this.reply = reply;
		this.regdate = regdate;
		this.cnt = cnt;
		this.likes = likes;
		this.movie_id = movie_id;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public String getReply() {
		return reply;
	}

	public void setReply(String reply) {
		this.reply = reply;
	}

	public Date getRegdate() {
		return regdate;
	}

	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}

	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	
	public int getLikes() {
		return likes;
	}

	public void setLikes(int likes) {
		this.likes = likes;
	}
	
	public String getMovie_id() {
		return movie_id;
	}

	public void setMovie_id(String movie_id) {
		this.movie_id = movie_id;
	}

	@Override
	public String toString() {
		return "BoardVo [seq=" + seq + ", title=" + title + ", writer=" + writer + ", contents=" + contents + ", reply="
				+ reply + ", regdate=" + regdate + ", cnt=" + cnt + ", likes=" + likes + ", movie_id=" + movie_id + "]";
	}
	
}
