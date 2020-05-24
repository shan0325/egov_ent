package front.eventprogram.service;

import java.util.List;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface EventProgramRequestService {

	Long add(EventProgramRequestVO eventRequestVO, EventProgramRequestMemberVO eventProgramRequestMemberVO);

	List<EgovMap> getSaveRequestMemberList(EventProgramRequestVO eventRequestVO);

	void mod(EventProgramRequestVO eventRequestVO, EventProgramRequestMemberVO eventProgramRequestMemberVO);

	int getReqCountByUserId(EventProgramRequestVO eventRequestVO);

	EgovMap getRequestByUserId(EventProgramRequestVO eventRequestVO);

	long getNumberOfApplicablePeople(EventProgramVO eventProgramVO);


}
