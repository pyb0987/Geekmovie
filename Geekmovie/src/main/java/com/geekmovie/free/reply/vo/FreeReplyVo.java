package com.geekmovie.free.reply.vo;

import java.sql.Timestamp;

public class FreeReplyVo {
	private int replyId;
	private int boardId;
	private int ancestorId;
	private int depth;
    private String orderserial;
    private String content;
    private String writer;
    private char deleted;
    private Timestamp create_date;
    private Timestamp update_date;
    private int likes;
	public FreeReplyVo() {
		super();
	}
	public FreeReplyVo(int replyId, int boardId, int ancestorId, int depth, String orderserial, String content,
			String writer, char deleted, Timestamp create_date, Timestamp update_date, int likes) {
		super();
		this.replyId = replyId;
		this.boardId = boardId;
		this.ancestorId = ancestorId;
		this.depth = depth;
		this.orderserial = orderserial;
		this.content = content;
		this.writer = writer;
		this.deleted = deleted;
		this.create_date = create_date;
		this.update_date = update_date;
		this.likes = likes;
	}
	public int getReplyId() {
		return replyId;
	}
	public void setReplyId(int replyId) {
		this.replyId = replyId;
	}
	public int getBoardId() {
		return boardId;
	}
	public void setBoardId(int boardId) {
		this.boardId = boardId;
	}
	public int getAncestorId() {
		return ancestorId;
	}
	public void setAncestorId(int ancestorId) {
		this.ancestorId = ancestorId;
	}
	public int getDepth() {
		return depth;
	}
	public void setDepth(int depth) {
		this.depth = depth;
	}
	public String getOrderserial() {
		return orderserial;
	}
	public void setOrderserial(String orderserial) {
		this.orderserial = orderserial;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public char getDeleted() {
		return deleted;
	}
	public void setDeleted(char deleted) {
		this.deleted = deleted;
	}
	public Timestamp getCreate_date() {
		return create_date;
	}
	public void setCreate_date(Timestamp create_date) {
		this.create_date = create_date;
	}
	public Timestamp getUpdate_date() {
		return update_date;
	}
	public void setUpdate_date(Timestamp update_date) {
		this.update_date = update_date;
	}
	public int getLikes() {
		return likes;
	}
	public void setLikes(int likes) {
		this.likes = likes;
	}
	@Override
	public String toString() {
		return "FreeReplyVo [replyId=" + replyId + ", boardId=" + boardId + ", ancestorId=" + ancestorId + ", depth="
				+ depth + ", orderserial=" + orderserial + ", content=" + content + ", writer=" + writer + ", deleted="
				+ deleted + ", create_date=" + create_date + ", update_date=" + update_date + ", likes=" + likes + "]";
	}
	
	
}