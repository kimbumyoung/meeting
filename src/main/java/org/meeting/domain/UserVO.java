package org.meeting.domain;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class UserVO {

	@NotNull
	@Size(min = 4, max = 20)
	@Pattern(regexp = "^[a-zA-Z0-9]*$", message = "���̵�� 4~20��,���ҹ���,�빮��,���ڸ� �Է��ϼ���")
	private String username;
	
	@NotNull
	@Size(min = 6, max = 20)
	@Pattern(regexp = "^[a-zA-Z0-9]*$", message = "password�ȹٷ��ض�")
	private String password;
	
	@NotNull
	private String displayname;
	
	@NotNull
	@Pattern(regexp = "^[a-zA-Z0-9]*$", message = "kakaoid�ȹٷ��ض�")
	private String kakaoid;

	private String profileimage;

}
