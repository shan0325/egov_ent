package front.eventprogram.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.ComDefaultVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import front.eventprogram.service.EventProgramVO;

@Repository
public class EventProgramDAO extends EgovAbstractDAO {

	public int getTotalListCnt(ComDefaultVO searchVO) {
		return (int) select("eventProgramDAO.getTotalListCnt", searchVO);
	}

	public List<?> getList(ComDefaultVO searchVO) {
		return list("eventProgramDAO.getList", searchVO);
	}

	public EgovMap getOne(EventProgramVO eventProgramVO) {
		return (EgovMap) select("eventProgramDAO.getOne", eventProgramVO);
	}

}
