package org.study.web;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.meeting.domain.ReplyVO;
import org.meeting.service.BoardService;
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

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@RestController
@RequestMapping("/rest/reply")
public class ReplyController {

	@Inject
	ReplyService replyService;

	@Inject
	BoardService boardService;

	// AJAX���� ��û�� ��۸�� ��ȯ
	@RequestMapping(value = "/{boardno}", method = RequestMethod.GET)
	public ResponseEntity<JSONObject> getRepliesByBoardNo(@PathVariable(value = "boardno") int boardNo,
			String boardHolder) {

		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String loginName = authentication.getName();

		// �ش� �Խù��� �޸� ��� 1�� ����� ����
		List<ReplyVO> parentReplies = replyService.getParentReplies(boardNo);

		// �ش� �Խù��� ����� 1���� ������ NO_CONTENT(204)
		if (parentReplies.size() == 0)
			return new ResponseEntity<JSONObject>(HttpStatus.NO_CONTENT);

		// �ش� �Խù��� ����� 1�� �̻� ������ �Ʒ� ����
		JSONArray replies = new JSONArray();
		int secretReplyCount = 0;
		
		// ��� 1�� ����� ���鼭
		for (ReplyVO reply : parentReplies) {
			System.out.println("parentReplies������ : " + parentReplies.size());
			JSONObject jsonParentReply = new JSONObject();

			// 2�� ��� �����̳�
			List<ReplyVO> childReplies = new ArrayList<ReplyVO>();
			// �α����� ����(�� 1��)�� �� ���� �ƴϸ�
			if (!loginName.equals(boardHolder)) {
				
				// �α����� ������ �� ����� �ƴϸ� (�� 3��)
				if (!loginName.equals(reply.getUsername())) {
					// ��� ��� �� ����, ���� ��۷� �Ѿ
					secretReplyCount++;
					continue;
				} else { // �α����� ������ �� ����̸�(�� 2��)
					// �ڽ��� ��ۿ� ���� ��� �ڽ� ����� ������
					childReplies = replyService.getChildRepliesByParentNo(reply.getReplyno());
				}

			} else {// �α����� ����(�� 1��)�� �����̶��
				// �ش� 1�� reply�� ���� ��� �ڽ� ����� ������
				childReplies = replyService.getChildRepliesByParentNo(reply.getReplyno());
			}

			jsonParentReply.put("parentReply", reply);
			jsonParentReply.put("childReplies", childReplies);

			replies.add(jsonParentReply);
		}

		JSONObject response = new JSONObject();
		response.put("replies", replies);
		System.out.println("jsp�� ������ replies : " + replies);
		response.put("secretReplyCount", secretReplyCount);
		System.out.println("jsp�� ������ response : " + response);
		return new ResponseEntity<JSONObject>(response, HttpStatus.OK);

	}

	// AJAX���� ��û�� ��۵�� ó��
	@RequestMapping(value = "/{boardno}", method = RequestMethod.POST)
	public ResponseEntity<Void> addReply(@RequestBody Map<String, Object> data,
			@PathVariable(value = "boardno") int boardNo) throws Exception {

		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();

		if (username == null)
			return new ResponseEntity<Void>(HttpStatus.BAD_REQUEST);

		System.out.println("jsp���� �� data : " + data);
		
		JSONObject replyJSON = JSONObject.fromObject(data.get("reply"));

		ReplyVO reply = new ReplyVO();

		int parentno = (int) data.get("parentno");

		// boardNo, username���� �� �Խù��� ���� ���� ����� �ִ��� Ȯ��
		if (replyService.isExistMyParentReply(boardNo, username)) {
			
			// ���� ���� ����� �ְ� ���� ��û�Ѱ� 1�� ����̶�� ����� �� �� ����.
			if (parentno == 0) {
				System.out.println("1�� ����� �̹� �����Ѵ�.");
				return new ResponseEntity<Void>(HttpStatus.CONFLICT);
			}
				
		}
		System.out.println("����� ����� �� �ִ�.");
		
		reply.setParentno(parentno);
		reply.setBoardno(replyJSON.getInt("boardno"));
		reply.setContent(replyJSON.getString("content"));
		reply.setUsername(replyJSON.getString("username"));
		reply.setReplydate(new Date());

		replyService.addReply(reply);

		return new ResponseEntity<Void>(HttpStatus.OK);
	}
}