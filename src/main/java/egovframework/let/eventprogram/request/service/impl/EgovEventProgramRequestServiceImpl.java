package egovframework.let.eventprogram.request.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.cmm.ComDefaultVO;
import egovframework.let.eventprogram.request.service.EgovEventProgramRequestMemberVO;
import egovframework.let.eventprogram.request.service.EgovEventProgramRequestService;
import egovframework.let.eventprogram.request.service.EgovEventProgramRequestVO;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import front.eventprogram.service.EventProgramRequestMemberVO;

@Service("egovEventProgramRequestService")
public class EgovEventProgramRequestServiceImpl implements EgovEventProgramRequestService {
	
	@Resource(name = "egovEventProgramRequestDAO")
	private EgovEventProgramRequestDAO egovEventProgramRequestDAO;

	@Override
	public int getTotalListCnt(ComDefaultVO searchVO) {
		return egovEventProgramRequestDAO.getTotalListCnt(searchVO);
	}

	@Override
	public List<?> getList(ComDefaultVO searchVO) {
		return egovEventProgramRequestDAO.getList(searchVO);
	}

	@Override
	public EgovMap getOne(EgovEventProgramRequestVO egovEventProgramRequestVO) {
		return egovEventProgramRequestDAO.getOne(egovEventProgramRequestVO);
	}

	@Override
	public List<?> getEventRequestMemberList(EgovEventProgramRequestVO egovEventProgramRequestVO) {
		return egovEventProgramRequestDAO.getEventRequestMemberList(egovEventProgramRequestVO);
	}

	@Override
	public void mod(EgovEventProgramRequestVO egovEventProgramRequestVO, EgovEventProgramRequestMemberVO egovEventProgramRequestMemberVO) {
		egovEventProgramRequestDAO.mod(egovEventProgramRequestVO);
		
		egovEventProgramRequestDAO.deleteRequestMember(egovEventProgramRequestVO);
		List<EgovEventProgramRequestMemberVO> members = egovEventProgramRequestMemberVO.getMemberVOList();
		if(members != null && members.size() > 0) {
			for(EgovEventProgramRequestMemberVO member : members) {
				if(member!= null && !EgovStringUtil.isEmpty(member.getName()) && !EgovStringUtil.isEmpty(member.getAge())) {
					member.setRequestId(egovEventProgramRequestVO.getId());
					egovEventProgramRequestDAO.addRequestMember(member);
				}
			}
		}
	}
	
	
	

}
