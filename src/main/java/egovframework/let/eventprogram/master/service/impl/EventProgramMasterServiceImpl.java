package egovframework.let.eventprogram.master.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.cmm.ComDefaultVO;
import egovframework.let.eventprogram.master.service.EventProgramMasterService;
import egovframework.let.eventprogram.master.service.EventProgramMasterVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service("eventProgramMasterService")
public class EventProgramMasterServiceImpl extends EgovAbstractServiceImpl implements EventProgramMasterService {

	@Resource(name="eventProgramMasterDAO")
	private EventProgramMasterDAO eventProgramMasterDAO;
	
	@Override
	public List<?> getList(ComDefaultVO searchVO) {
		return eventProgramMasterDAO.getList(searchVO);
	}

	@Override
	public int getTotalListCnt(ComDefaultVO searchVO) {
		return eventProgramMasterDAO.getTotalListCnt(searchVO);
	}

	@Override
	public void add(EventProgramMasterVO eventProgramMasterVO) {
		eventProgramMasterDAO.add(eventProgramMasterVO);
	}

	@Override
	public int mod(EventProgramMasterVO eventProgramMasterVO) {
		return eventProgramMasterDAO.mod(eventProgramMasterVO);
	}

	@Override
	public int del(EventProgramMasterVO eventProgramMasterVO) {
		return eventProgramMasterDAO.del(eventProgramMasterVO);
	}

	@Override
	public EgovMap getOne(EventProgramMasterVO eventProgramMasterVO) {
		return eventProgramMasterDAO.getOne(eventProgramMasterVO);
	}

}
