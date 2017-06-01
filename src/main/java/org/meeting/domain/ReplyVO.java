package org.meeting.domain;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ReplyVO implements Serializable {

	private static final long serialVersionUID = 8145216904213739681L;
	private int replyno; // ���ù�ȣ �⺻Ű
	private int boardno; // �Խù���ȣ �ܷ�Ű
	private int userno; // ������ȣ �ܷ�Ű
	private String content; // ��� ����
	
}