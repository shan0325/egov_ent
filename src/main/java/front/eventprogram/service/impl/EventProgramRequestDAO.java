package front.eventprogram.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import front.eventprogram.service.EventProgramRequestMemberVO;
import front.eventprogram.service.EventProgramRequestVO;
import front.eventprogram.service.EventProgramVO;

@Repository
public class EventProgramRequestDAO extends EgovAbstractDAO {

	public Long add(EventProgramRequestVO eventRequestVO) {
		return (Long) insert("eventProgramRequestDAO.add", eventRequestVO);
	}

	public void addRequestMember(EventProgramRequestMemberVO memberVO) {
		insert("eventProgramRequestDAO.addRequestMember", memberVO);
	}

	public int getReqCountByUserId(EventProgramRequestVO eventRequestVO) {
		return (int) select("eventProgramRequestDAO.getReqCountByUserId", eventRequestVO);
	}
	
	public EgovMap getRequestByUserId(EventProgramRequestVO eventRequestVO) {
		return (EgovMap) select("eventProgramRequestDAO.getRequestByUserId", eventRequestVO);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> getSaveRequestMemberList(EventProgramRequestVO eventRequestVO) {
		return (List<EgovMap>) list("eventProgramRequestDAO.getSaveRequestMemberList", eventRequestVO);
	}

	public void mod(EventProgramRequestVO eventRequestVO) {
		update("eventProgramRequestDAO.mod", eventRequestVO);
	}

	public void deleteRequestMember(EventProgramRequestVO eventRequestVO) {
		delete("eventProgramRequestDAO.deleteRequestMember", eventRequestVO);
	}

	public long getRequestMemberTotalCount(EventProgramRequestVO eventProgramRequestVO) {
		return (long) select("eventProgramRequestDAO.getRequestMemberTotalCount", eventProgramRequestVO);
	}

}
