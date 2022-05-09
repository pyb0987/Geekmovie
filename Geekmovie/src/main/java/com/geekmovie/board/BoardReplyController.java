package com.geekmovie.board;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.geekmovie.board.service.BoardReplyService;
import com.geekmovie.board.vo.ReplyVo;

@Controller
//@RequestMapping("/reply/*")
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

	
}

