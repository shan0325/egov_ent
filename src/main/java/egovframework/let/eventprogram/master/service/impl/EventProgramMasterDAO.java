package egovframework.let.eventprogram.master.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.ComDefaultVO;
import egovframework.let.eventprogram.master.service.EventProgramMasterVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository("eventProgramMasterDAO")
public class EventProgramMasterDAO extends EgovAbstractDAO {

	public List<?> getList(ComDefaultVO searchVO) {
		return list("eventProgramMasterDAO.getList", searchVO);
	}

	public int getTotalListCnt(ComDefaultVO searchVO) {
		return (int) select("eventProgramMasterDAO.getTotalListCnt", searchVO);
	}

	public void add(EventProgramMasterVO eventProgramMasterVO) {
		insert("eventProgramMasterDAO.add", eventProgramMasterVO);
	}

	public int mod(EventProgramMasterVO eventProgramMasterVO) {
		return update("eventProgramMasterDAO.mod", eventProgramMasterVO);
	}

	public int del(EventProgramMasterVO eventProgramMasterVO) {
		return delete("eventProgramMasterDAO.del", eventProgramMasterVO);
	}

	public EgovMap getOne(EventProgramMasterVO eventProgramMasterVO) {
		return (EgovMap) select("eventProgramMasterDAO.getOne", eventProgramMasterVO);
	}

	
}
