package egovframework.let.eventprogram.request.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.ComDefaultVO;
import egovframework.let.eventprogram.request.service.EgovEventProgramRequestMemberVO;
import egovframework.let.eventprogram.request.service.EgovEventProgramRequestVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class EgovEventProgramRequestDAO extends EgovAbstractDAO {
	
	public int getTotalListCnt(ComDefaultVO searchVO) {
		return (int) select("egovEventProgramRequestDAO.getTotalListCnt", searchVO);
	}

	public List<?> getList(ComDefaultVO searchVO) {
		return list("egovEventProgramRequestDAO.getList", searchVO);
	}

	public EgovMap getOne(EgovEventProgramRequestVO egovEventProgramRequestVO) {
		return (EgovMap) select("egovEventProgramRequestDAO.getOne", egovEventProgramRequestVO);
	}

	public List<?> getEventRequestMemberList(EgovEventProgramRequestVO egovEventProgramRequestVO) {
		return list("egovEventProgramRequestDAO.getEventRequestMemberList", egovEventProgramRequestVO);
	}

	public void mod(EgovEventProgramRequestVO egovEventProgramRequestVO) {
		update("egovEventProgramRequestDAO.mod", egovEventProgramRequestVO);
	}

	public void deleteRequestMember(EgovEventProgramRequestVO egovEventProgramRequestVO) {
		delete("egovEventProgramRequestDAO.deleteRequestMember", egovEventProgramRequestVO);
	}

	public void addRequestMember(EgovEventProgramRequestMemberVO member) {
		insert("egovEventProgramRequestDAO.addRequestMember", member);
	}

}
