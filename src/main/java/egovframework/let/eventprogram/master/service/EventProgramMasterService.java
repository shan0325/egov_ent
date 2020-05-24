package egovframework.let.eventprogram.master.service;

import java.util.List;

import egovframework.com.cmm.ComDefaultVO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface EventProgramMasterService {

	public List<?> getList(ComDefaultVO searchVO);

	public int getTotalListCnt(ComDefaultVO searchVO);
	
	public void add(EventProgramMasterVO eventProgramMasterVO);

	public int mod(EventProgramMasterVO eventProgramMasterVO);

	public int del(EventProgramMasterVO eventProgramMasterVO);

	public EgovMap getOne(EventProgramMasterVO eventProgramMasterVO);

}
