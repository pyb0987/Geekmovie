package com.geekmovie.board;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ReplyTestController {
	
	@GetMapping("/test")
	public String replyAjaxTest() {
		return "test";
	}
}
