package egovframework.let.eventprogram.request.service;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class EgovEventProgramRequestMemberVO {
	private Long requestId;
	private String name;
	private String age;
	private String gender;
	private String etc;
	List<EgovEventProgramRequestMemberVO> memberVOList;
}
