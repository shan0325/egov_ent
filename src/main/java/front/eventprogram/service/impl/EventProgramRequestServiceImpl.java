package front.eventprogram.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import front.eventprogram.service.EventProgramRequestMemberVO;
import front.eventprogram.service.EventProgramRequestService;
import front.eventprogram.service.EventProgramRequestVO;
import front.eventprogram.service.EventProgramService;
import front.eventprogram.service.EventProgramVO;

@Service("eventProgramRequestService")
public class EventProgramRequestServiceImpl implements EventProgramRequestService {

	@Resource(name = "eventProgramRequestDAO")
	private EventProgramRequestDAO eventProgramRequestDAO;
	
	@Resource(name = "eventProgramService")
	private EventProgramService eventProgramService;

	@Override
	public Long add(EventProgramRequestVO eventRequestVO, EventProgramRequestMemberVO eventProgramRequestMemberVO) {
		Long requestId = eventProgramRequestDAO.add(eventRequestVO);
		
		List<EventProgramRequestMemberVO> members = eventProgramRequestMemberVO.getMemberVOList();
		if(members != null && members.size() > 0) {
			for(EventProgramRequestMemberVO member : members) {
				if(member!= null && !EgovStringUtil.isEmpty(member.getName()) && !EgovStringUtil.isEmpty(member.getAge())) {
					member.setRequestId(requestId);
					eventProgramRequestDAO.addRequestMember(member);
				}
			}
		}
		
		return requestId;
	}

	@Override
	public List<EgovMap> getSaveRequestMemberList(EventProgramRequestVO eventRequestVO) {
		return eventProgramRequestDAO.getSaveRequestMemberList(eventRequestVO);
	}

	@Override
	public void mod(EventProgramRequestVO eventRequestVO, EventProgramRequestMemberVO eventProgramRequestMemberVO) {
		eventProgramRequestDAO.mod(eventRequestVO);

		eventProgramRequestDAO.deleteRequestMember(eventRequestVO);
		List<EventProgramRequestMemberVO> members = eventProgramRequestMemberVO.getMemberVOList();
		if(members != null && members.size() > 0) {
			for(EventProgramRequestMemberVO member : members) {
				if(member!= null && !EgovStringUtil.isEmpty(member.getName()) && !EgovStringUtil.isEmpty(member.getAge())) {
					member.setRequestId(eventRequestVO.getId());
					eventProgramRequestDAO.addRequestMember(member);
				}
			}
		}
	}

	@Override
	public int getReqCountByUserId(EventProgramRequestVO eventRequestVO) {
		return eventProgramRequestDAO.getReqCountByUserId(eventRequestVO);
	}

	@Override
	public EgovMap getRequestByUserId(EventProgramRequestVO eventRequestVO) {
		return eventProgramRequestDAO.getRequestByUserId(eventRequestVO);
	}

	/**
	 * 참여가능한 인원수 확인
	 */
	@Override
	public long getNumberOfApplicablePeople(EventProgramVO eventProgramVO) {
		EgovMap eventProgramMap = eventProgramService.getOne(eventProgramVO);
		String firstComeYn = (String) eventProgramMap.get("firstComeYn");
		long reqMaxPersonNumber = (long) eventProgramMap.get("reqMaxPersonNumber"); // 신청최대인원수
		long reqtimeMaxPersonNumber = (long) eventProgramMap.get("reqtimeMaxPersonNumber"); // 신청시받을최대인원수
		
		// 선착순이 아닌경우
		if(!"Y".equals(firstComeYn)) {
			return reqtimeMaxPersonNumber;
		}
		
		EventProgramRequestVO eventProgramRequestVO = new EventProgramRequestVO();
		eventProgramRequestVO.setMasterId(eventProgramVO.getId());
		eventProgramRequestVO.setSaveState("1");
		long requestMemberTotalCount = eventProgramRequestDAO.getRequestMemberTotalCount(eventProgramRequestVO); // 현재까지신청한인원수
		
		long numberOfApplicablePeople = reqMaxPersonNumber - requestMemberTotalCount;
		if(numberOfApplicablePeople > reqtimeMaxPersonNumber) {
			numberOfApplicablePeople = reqtimeMaxPersonNumber;
		}
		return numberOfApplicablePeople;
	}
	
	
}
