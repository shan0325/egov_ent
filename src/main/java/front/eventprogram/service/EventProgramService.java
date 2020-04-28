package front.eventprogram.service;

import java.util.List;

import egovframework.com.cmm.ComDefaultVO;
import egovframework.let.eventprogram.master.service.EventProgramMasterVO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface EventProgramService {

	int getTotalListCnt(ComDefaultVO searchVO);

	List<?> getList(ComDefaultVO searchVO);

	EgovMap getOne(EventProgramVO eventProgramVO);

}
