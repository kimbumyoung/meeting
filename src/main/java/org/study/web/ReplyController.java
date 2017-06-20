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
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
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

	// AJAX���� ��û�� ��۸�� ��ȯ
	@RequestMapping(value = "/{boardno}", method = RequestMethod.GET)
	public ResponseEntity<JSONObject> getRepliesByBoardNo(@PathVariable(value = "boardno") int boardNo) {
		System.out.println("GET ȣ��");
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();

		System.out.println("username(�α��������̸�) :" + username);
		System.out.println("boardNo(�Խ��ǹ�ȣ) :" + boardNo);
		
		// �Խ��ǹ�ȣ, username���� 1�� ��� ��ȣ�� ����
		int parentno = replyService.getParentNoByBoardNo(boardNo, username);
		System.out.println("parentno(1����۹�ȣ) :" + parentno);

		// 1�� ��� ��ȣ�� ���⿡ ���� �ڽĴ��(N��) + �θ���(1��)���ؿ�
		List<ReplyVO> allReplies = replyService.getAllRepliesByParentNo(parentno);
		System.out.println("childReplies(�ڽĴ�۵�) :" + allReplies.toString());

		// �Խù��� �ִ� 1�� ����� �� ����
		int parentRepliesCount = replyService.getRepliesCountByBoardNo(boardNo, username);
		System.out.println("parentsRepliesCount(1����� �� ����) :" + parentRepliesCount);

		JSONObject response = new JSONObject();
		response.put("secretReplyCount", parentRepliesCount-1);
		response.put("replies", allReplies);
		System.out.println("response(ajax�� ������ ���� ���) :" + response.toString());
		
		return new ResponseEntity<JSONObject>(response, HttpStatus.OK);
	}

	// AJAX���� ��û�� ��۵�� ó��
	@RequestMapping(value = "/{boardno}", method = RequestMethod.POST)
	public ResponseEntity<Void> addReply(@RequestBody Map<String, Object> data, @PathVariable(value = "boardno") int boardNo) throws Exception {
		System.out.println("POST ȣ��");
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		
		JSONObject replyJSON = JSONObject.fromObject(data.get("reply"));

		// �̹� ���� �� 1�� ����� �ִ� ��� �̹� �����Ƿ� ����
		if( replyService.isExistMyParentReply(boardNo, username) ){
			System.out.println("�ƾ� �̹� �����Ѵ�");
			return new ResponseEntity<Void>(HttpStatus.CONFLICT);
		}
		System.out.println("�ƾ� �������� �ʴ�");
		ReplyVO reply = new ReplyVO();
		reply.setBoardno(replyJSON.getInt("boardno"));
		reply.setContent(replyJSON.getString("content"));
		reply.setUsername(replyJSON.getString("username"));

		replyService.addReply(reply);

		return new ResponseEntity<Void>(HttpStatus.OK);
	}
}