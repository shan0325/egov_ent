package front.eventprogram.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.cmm.ComDefaultVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import front.eventprogram.service.EventProgramService;
import front.eventprogram.service.EventProgramVO;

@Service("eventProgramService")
public class EventProgramServiceImpl extends EgovAbstractServiceImpl implements EventProgramService {
	
	@Resource(name = "eventProgramDAO")
	private EventProgramDAO eventProgramDAO;

	@Override
	public int getTotalListCnt(ComDefaultVO searchVO) {
		return eventProgramDAO.getTotalListCnt(searchVO);
	}

	@Override
	public List<?> getList(ComDefaultVO searchVO) {
		return eventProgramDAO.getList(searchVO);
	}

	@Override
	public EgovMap getOne(EventProgramVO eventProgramVO) {
		return eventProgramDAO.getOne(eventProgramVO);
	}

}
