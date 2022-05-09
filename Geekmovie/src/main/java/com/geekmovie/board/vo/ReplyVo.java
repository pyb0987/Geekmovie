package com.geekmovie.board.vo;

import java.sql.Timestamp;

public class ReplyVo {
	
	// mysql 테이블 생성문
	/*
	 * create table b_reply( 
	 * rno int not null auto_increment, 
	 * seq int not null,
	 * writer varchar(50) not null, 
	 * regDate timestamp not null default now(),
	 * content text not null, 
	 * primary key(rno, seq), 
	 * foreign key(seq) references review_board(seq) );
	 */
	
	private int rno;
	private int seq;
	private String writer;
	private String content;
	private Timestamp regDate;
	
	public ReplyVo() {
		super();
	}

	public int getRno() {
		return rno;
	}
	
	public void setRno(int rno) {
		this.rno = rno;
	}
	
	public int getSeq() {
		return seq;
	}
	
	public void setSeq(int seq) {
		this.seq = seq;
	}
	
	public String getWriter() {
		return writer;
	}
	
	public void setWriter(String writer) {
		this.writer = writer;
	}
	
	public String getContent() {
		return content;
	}
	
	public void setContent(String content) {
		this.content = content;
	}
	
	public Timestamp getRegDate() {
		return regDate;
	}
	
	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}
	
	@Override
	public String toString() {
		return "ReplyVo [rno=" + rno + ", seq=" + seq + ", writer=" + writer + ", content=" + content + ", regDate="
				+ regDate + "]";
	}
	
	public ReplyVo(int rno, int seq, String writer, String content, Timestamp regDate) {
		super();
		this.rno = rno;
		this.seq = seq;
		this.writer = writer;
		this.content = content;
		this.regDate = regDate;
	}
	
	
	
}
