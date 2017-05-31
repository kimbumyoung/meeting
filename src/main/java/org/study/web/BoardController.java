package org.study.web;


import javax.inject.Inject;
import org.meeting.domain.BoardVO;
import org.meeting.service.BoardService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/board/*")
public class BoardController {
	
	@Inject
	private BoardService service;
	
	@RequestMapping(value="/read", method = RequestMethod.GET )
	public void boardRead(Model model,int boardno){
		System.out.println("boardRead get..");
		model.addAttribute(service.boardRead(boardno));
	}
	
	@RequestMapping(value="/register", method = RequestMethod.GET)
	public void boardRegisterGet(Model model){
		System.out.println("boardRegister get..");
		
	}
	
	@RequestMapping(value="/register", method= RequestMethod.POST)
	public String boardRegisterPost(BoardVO vo){
		
		System.out.println("boardRegister post..");
		System.out.println(vo);
		service.boardRegister(vo);
		return "redirect:/";
	}
	
	@RequestMapping(value="/modify", method= RequestMethod.POST)
	public void boardModify(int boardno,Model model){
		model.addAttribute(service.boardRead(boardno));
	}
	
	@RequestMapping(value="/modifyComplete", method= RequestMethod.POST)
	public String boardModifyComplete(BoardVO vo){
		service.boardModify(vo);
		return "redirect:/";
	}
	
	@RequestMapping(value="/delete", method= RequestMethod.POST)
	public String boardDelete(int boardno){
		service.boardDelete(boardno);
		return "redirect:/";
	}
	
	

}
