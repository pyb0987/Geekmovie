package com.geekmovie.onelinereview.vo;

import org.springframework.stereotype.Repository;

@Repository
public class OneLineReviewPageVo {
	private int onePage = 20;			//한 페이지에 표시되는 개수
	private int pageRange = 10;			//표시되는 페이지 너비(11~20페이지)
	private int endPage;			// 실제로 끝나는 페이지
	private int nowStartPage;			//표시 시작 페이지
	private int nowPage;			//현재 페이지
	private int nowEndPage;			//표시 끝 페이지
	private int cnt;
	private int nowPageStart;		//현재 페이지 시작 게시글 번호
	private int nowPageEnd;		//현재 페이지 끝 게시글 번호
	
	public OneLineReviewPageVo() {}
	public OneLineReviewPageVo(int cnt) {
		this.cnt = cnt;	
	}

	public void PageInfo(int cnt, int nowpage) {
		this.cnt = cnt;
		PageInfo(nowpage);	
	}
	
	public void PageInfo(int nowpage) {
		this.nowPage = nowpage;
		this.endPage = (int)Math.ceil(this.cnt/(float)this.onePage);
		this.nowStartPage = ((int)(this.nowPage-1)/this.pageRange)*this.pageRange+1;
		this.nowEndPage = (((int)(this.nowPage-1)/this.pageRange)+1)*this.pageRange;
		this.nowPageStart = (this.nowPage-1)*this.onePage;		//이전까지 제외해야할 게시글의 개수
		this.nowPageEnd = this.nowPage*this.onePage;
		if (this.nowPageStart>this.cnt) {
			this.nowPageStart= this.cnt;
		}
		if (this.nowPageEnd>this.cnt) {
			this.nowPageEnd= this.cnt;
		}
		if (this.nowStartPage>this.endPage) {
			this.nowStartPage = this.endPage;
		}
		if (this.nowEndPage>this.endPage) {
			this.nowEndPage = this.endPage;
		}		
	}
	public int getOnePage() {
		return onePage;
	}
	public void setOnePage(int onePage) {
		this.onePage = onePage;
	}
	public int getPageRange() {
		return pageRange;
	}
	public void setPageRange(int pageRange) {
		this.pageRange = pageRange;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	public int getNowStartPage() {
		return nowStartPage;
	}
	public void setNowStartPage(int nowStartPage) {
		this.nowStartPage = nowStartPage;
	}
	public int getNowPage() {
		return nowPage;
	}
	public void setNowPage(int nowPage) {
		this.nowPage = nowPage;
	}
	public int getNowEndPage() {
		return nowEndPage;
	}
	public void setNowEndPage(int nowEndPage) {
		this.nowEndPage = nowEndPage;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public int getNowPageStart() {
		return nowPageStart;
	}
	public void setNowPageStart(int nowPageStart) {
		this.nowPageStart = nowPageStart;
	}
	public int getNowPageEnd() {
		return nowPageEnd;
	}
	public void setNowPageEnd(int nowPageEnd) {
		this.nowPageEnd = nowPageEnd;
	}
	@Override
	public String toString() {
		return "OneLineReviewPageVo [onePage=" + onePage + ", pageRange=" + pageRange + ", endPage=" + endPage
				+ ", nowStartPage=" + nowStartPage + ", nowPage=" + nowPage + ", nowEndPage=" + nowEndPage + ", cnt="
				+ cnt + ", nowPageStart=" + nowPageStart + ", nowPageEnd=" + nowPageEnd + "]";
	}
	
	
	

	
	
}
