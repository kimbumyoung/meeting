package org.meeting.service;

import java.util.List;

import javax.inject.Inject;

import org.meeting.dao.ReplyDAO;
import org.meeting.dao.UserDAO;
import org.meeting.domain.ReplyVO;
import org.meeting.domain.UserVO;
import org.springframework.stereotype.Service;

@Service
public class ReplyServiceimpl implements ReplyService {

	@Inject
	ReplyDAO replyDao;

	@Inject
	UserDAO userDAO;

	@Override
	public List<ReplyVO> getRepliesByBoardNo(int boardNo) {
		return replyDao.getRepliesByBoardNo(boardNo);
	}

	@Override
	public boolean isExistMyParentReply(int boardNo, String username) {
		return replyDao.isExistMyParentReply(boardNo, username);
	}

	@Override
	public int addReply(ReplyVO reply) throws Exception {

		// ������ ���� �߰�
		UserVO user = userDAO.read(reply.getUsername());
		reply.setProfileimage(user.getProfileimage());

		// �ڽ��� �θ� ����� ������ ��
		ReplyVO parentReply = replyDao.getReplyByParentno(reply.getParentno());

		// ����� ����� ���(�θ� �ִ� ���)
		if (parentReply != null) {
			// �θ�� ���� �׷����� ����
			reply.setGroupid(parentReply.getGroupid());
			// �θ𺸴� Depth�� 1���� ����
			reply.setDepth(parentReply.getDepth() + 1);

			int newReplySeq = replyDao.calcSeq(parentReply);

			// �׷��� �� �������� ���� ���
			if (newReplySeq == 0) {
				newReplySeq = replyDao.getLastSeqInGroup(parentReply.getGroupid());
				reply.setSeq(newReplySeq);
			}

			// �߰��� �����ϴ� ���
			else {
				replyDao.updateOtherRepliesSeq(parentReply, newReplySeq);
				reply.setSeq(newReplySeq);
			}

			// �Խñ��� ����� ��� (�θ� ���� ���)
		} else {
			reply.setSeq(0);
			reply.setDepth(0);
			reply.setGroupid(replyDao.getGroupId());
		}

		return replyDao.addReply(reply);

	}

	@Override
	public int deleteReplyByReplyNo(int replyno) {
		return replyDao.deleteReplyByReplyNo(replyno);
	}

	@Override
	public int updateReply(ReplyVO reply) {
		return replyDao.updateRply(reply);
	}

	@Override
	public ReplyVO getReplyById(int replyno) {
		return replyDao.getReplyById(replyno);
	}
}
