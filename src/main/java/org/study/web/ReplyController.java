package org.study.web;

import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.meeting.domain.ReplyRelationVO;
import org.meeting.domain.ReplyVO;
import org.meeting.service.ReplyService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import net.sf.json.JSONObject;

@RestController
@RequestMapping("/rest/reply")
public class ReplyController {

	@Inject
	ReplyService replyService;

	// AJAX�� ����� �ҷ����� ����
	@RequestMapping(value = "/{boardno}", method = RequestMethod.GET)
	public ResponseEntity<List<ReplyVO>> getRepliesByBoardNo(@PathVariable(value = "boardno") int boardNo) {

		List<ReplyVO> replies = replyService.getRepliesByBoardNo(boardNo);
		return new ResponseEntity<List<ReplyVO>>(replies, HttpStatus.OK);
	}

	// AJAX�� ����� ��� �� �ٽ� �����ִ� �Լ��� �����̷�Ʈ�ϴ� ����
	// http://blog.naver.com/brilliantjay/220959677882 ����
	@RequestMapping(value = "/{boardno}", method = RequestMethod.POST)
	public String addReplies(@PathVariable(value = "boardno") int boardNo, @RequestBody Map<String, Object> data) {
		System.out.println("data.toString() : "+data.toString());
		
		ReplyVO reply = new ReplyVO();
		JSONObject replyJsonObject = (JSONObject) JSONObject.fromObject(data).get("reply");
		
		reply.setBoardno(replyJsonObject.getInt("boardno"));
		reply.setContent(replyJsonObject.getString("content"));
		reply.setUsername(replyJsonObject.getString("username"));
		Calendar calendar = Calendar.getInstance();
		reply.setReplydate(calendar.getTime());
		System.out.println("reply.toString() : " + reply.toString());
		
		
		// �θ��ִ� ���
		if (data.get("parentno") != null) {
			// �θ�-�ڽ� ���� ���� �� ����
			int parentno = JSONObject.fromObject(data).getInt("parentno");
			ReplyRelationVO replyRelation = new ReplyRelationVO();
			
			replyRelation.setParentno(parentno);
			replyRelation.setChildno(reply.getReplyno());
			replyService.addReplyRelation(replyRelation);
			
		}
		
		// ���� ����
		replyService.addReply(reply);

		String redirectPath = "redirect:/rest/reply/" + boardNo;
		return redirectPath;
	}
}