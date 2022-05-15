package com.geekmovie.board;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.geekmovie.board.service.BoardReplyService;
import com.geekmovie.board.vo.ReplyVo;

@Controller
public class BoardReplyController {
	
	
	@Autowired
	private BoardReplyService replyService;
	
	public BoardReplyController() {
		System.out.println("@reply controller");
	}
	
	
	@RequestMapping(value="/write", method = RequestMethod.POST)
	public String postWrite(ReplyVo vo) {
		System.out.println("댓글 작성");
		replyService.rCreate(vo);
		
		return "redirect:/boardDetail?seq=" + vo.getSeq();
	}
	
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public String postDelete(ReplyVo vo) {
		System.out.println("댓글 삭제");
		
		replyService.rDelete(vo.getRno());
		
		System.out.println(vo);
		
		return "redirect:/boardDetail?seq=" + vo.getSeq();
	}
	
	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public String postModify(ReplyVo vo) {
		System.out.println("댓글 수정");
		
		replyService.rUpdate(vo);
		
		System.out.println(vo);
		
		return "redirect:/boardDetail?seq=" + vo.getSeq();
	}

	
}

