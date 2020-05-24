package egovframework.let.eventprogram.request.service;

import java.util.List;

import egovframework.com.cmm.ComDefaultVO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface EgovEventProgramRequestService {

	int getTotalListCnt(ComDefaultVO searchVO);

	List<?> getList(ComDefaultVO searchVO);

	EgovMap getOne(EgovEventProgramRequestVO egovEventProgramRequestVO);

	List<?> getEventRequestMemberList(EgovEventProgramRequestVO egovEventProgramRequestVO);

	void mod(EgovEventProgramRequestVO egovEventProgramRequestVO, EgovEventProgramRequestMemberVO egovEventProgramRequestMemberVO);

}
