package org.meeting.domain;

import java.io.Serializable;
import java.util.Date;

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
	private String username; // �����̸�
	private String content; // ��� ����
	private Date replydate;
	
}