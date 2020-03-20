package egovframework.let.eventprogram.master.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.com.cmm.ComDefaultVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.let.eventprogram.master.service.EventProgramMasterService;
import egovframework.let.eventprogram.master.service.EventProgramMasterVO;
import egovframework.let.sym.ccm.cde.service.CmmnDetailCodeVO;
import egovframework.let.sym.ccm.cde.service.EgovCcmCmmnDetailCodeManageService;
import egovframework.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class EgovEventProgramMasterController {

	@Resource(name="eventProgramMasterService")
	private EventProgramMasterService eventProgramMasterService;
	
	@Resource(name = "CmmnDetailCodeManageService")
    private EgovCcmCmmnDetailCodeManageService cmmnDetailCodeManageService;
	
	/** EgovMessageSource */
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;
	
	@RequestMapping(value="/let/eventprogram/master/listView.do")
	public String listView(@ModelAttribute("searchVO") ComDefaultVO searchVO, ModelMap model) {
		
		// 페이징
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		int totCnt = eventProgramMasterService.getTotalListCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		model.addAttribute("list", eventProgramMasterService.getList(searchVO));
		return "eventprogram/master/list";
	}
	
	@RequestMapping(value="/let/eventprogram/master/createView.do")
	public String createView(ModelMap model) throws Exception {
		
		CmmnDetailCodeVO cmmnDetailCodeVO = new CmmnDetailCodeVO();
		cmmnDetailCodeVO.setSearchCondition("1");
		cmmnDetailCodeVO.setSearchKeyword("COM030");
		List<?> codeList = cmmnDetailCodeManageService.selectCmmnDetailCodes(cmmnDetailCodeVO);
		
		model.addAttribute("gubunCodeList", codeList);
		
		return "eventprogram/master/createView";
	}
	
	@RequestMapping(value="/let/eventprogram/master/createApi.do")
	public ResponseEntity<?> create(@ModelAttribute EventProgramMasterVO eventProgramMasterVO) {
		
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		eventProgramMasterVO.setRegUserId(loginVO.getId());
		
		eventProgramMasterService.add(eventProgramMasterVO);
		
		Map<String, String> resultMap = new HashMap<String, String>();
		resultMap.put("message", egovMessageSource.getMessage("success.common.insert"));
		
		return new ResponseEntity<Map<String, String>>(resultMap, HttpStatus.OK);
	}
	
	@RequestMapping(value="/let/eventprogram/master/updateView.do")
	public String updateView(@ModelAttribute EventProgramMasterVO eventProgramMasterVO, ModelMap model) {
		
		CmmnDetailCodeVO cmmnDetailCodeVO = new CmmnDetailCodeVO();
		cmmnDetailCodeVO.setSearchCondition("1");
		cmmnDetailCodeVO.setSearchKeyword("COM030");
		List<?> codeList = cmmnDetailCodeManageService.selectCmmnDetailCodes(cmmnDetailCodeVO);
		
		model.addAttribute("gubunCodeList", codeList);
		model.addAttribute("detail", eventProgramMasterService.getOne(eventProgramMasterVO));
		return "eventprogram/master/createView";
	}
	
	@RequestMapping(value="/let/eventprogram/master/updateApi.do")
	public ResponseEntity<?> update(@ModelAttribute EventProgramMasterVO eventProgramMasterVO) {
		
		int upCnt = eventProgramMasterService.mod(eventProgramMasterVO);
		
		Map<String, String> resultMap = new HashMap<String, String>();
		resultMap.put("message", egovMessageSource.getMessage("success.common.update"));
		
		return new ResponseEntity<Map<String, String>>(resultMap, HttpStatus.OK);
	}
	
	@RequestMapping(value="/let/eventprogram/master/delete.do")
	public String delete(@RequestParam EventProgramMasterVO eventProgramMasterVO) {
		
		int delCnt = eventProgramMasterService.del(eventProgramMasterVO);
		
		return "redirect:/let/eventprogram/master/listView.do";
	}
	
	
}
