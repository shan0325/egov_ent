package front.eventprogram.service;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class EventProgramRequestVO {

	private Long id;
	private Long masterId;
	private String reqUserId;
	private String reqName;
	private String reqPhone;
	private String regDate;
	private String modDate;
	private String requestState;
	private String reqEmail;
	private String reqIntroduction;
	private String saveState;
	private String atchFileId;
}
