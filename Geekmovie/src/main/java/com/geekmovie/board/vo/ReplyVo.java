package com.geekmovie.board.vo;

import java.sql.Timestamp;

public class ReplyVo {

	private int reply_seq;
	private int seq;
	private String id;
	private String reply_text;
	private Timestamp regdate;
	private Timestamp upd_date;
	
	public ReplyVo() {
	}
	
	public int getReply_seq() {
		return reply_seq;
	}
	
	public void setReply_seq(int reply_seq) {
		this.reply_seq = reply_seq;
	}
	
	public int getSeq() {
		return seq;
	}
	
	public void setSeq(int seq) {
		this.seq = seq;
	}
	
	public String getId() {
		return id;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	
	public String getReply_text() {
		return reply_text;
	}
	
	public void setReply_text(String reply_text) {
		this.reply_text = reply_text;
	}
	
	public Timestamp getRegdate() {
		return regdate;
	}
	
	public void setRegdate(Timestamp regdate) {
		this.regdate = regdate;
	}
	
	public Timestamp getUpd_date() {
		return upd_date;
	}
	
	public void setUpd_date(Timestamp upd_date) {
		this.upd_date = upd_date;
	}

	@Override
	public String toString() {
		return "ReplyVo [reply_seq=" + reply_seq + ", seq=" + seq + ", id=" + id + ", reply_text=" + reply_text
				+ ", regdate=" + regdate + ", upd_date=" + upd_date + "]";
	}
	
}
