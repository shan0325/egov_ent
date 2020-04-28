package front.eventprogram.web;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cmm.ComDefaultVO;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.FileVO;
import egovframework.let.sym.ccm.cde.service.CmmnDetailCodeVO;
import egovframework.let.sym.ccm.cde.service.EgovCcmCmmnDetailCodeManageService;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import front.eventprogram.service.EventProgramService;
import front.eventprogram.service.EventProgramVO;

@Controller
public class EventProgramController {

	@Resource(name = "eventProgramService")
	private EventProgramService eventProgramService;
	
	@Resource(name = "CmmnDetailCodeManageService")
    private EgovCcmCmmnDetailCodeManageService cmmnDetailCodeManageService;
	
	@Resource(name = "EgovFileMngService")
	private EgovFileMngService fileMngService;
	
	
	@RequestMapping(value="/front/eventprogram/list.do")
	public String listView(@ModelAttribute("searchVO") ComDefaultVO searchVO, ModelMap model) {
		
		// 페이징
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		int totCnt = eventProgramService.getTotalListCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		List<?> list = eventProgramService.getList(searchVO);
		
		model.addAttribute("list", list);
		
		return "front/eventprogram/list";
	}
	
	@RequestMapping(value="/front/eventprogram/detailView.do")
	public String detailView(@ModelAttribute EventProgramVO eventProgramVO, ModelMap model) throws Exception {
		
		CmmnDetailCodeVO cmmnDetailCodeVO = new CmmnDetailCodeVO();
		cmmnDetailCodeVO.setSearchCondition("1");
		cmmnDetailCodeVO.setSearchKeyword("COM030");
		List<?> codeList = cmmnDetailCodeManageService.selectCmmnDetailCodes(cmmnDetailCodeVO);
		model.addAttribute("gubunCodeList", codeList);
		
		EgovMap detail = eventProgramService.getOne(eventProgramVO);
		model.addAttribute("detail", detail);
		
		String atchFileId = (String) detail.get("atchFileId");
		if(!EgovStringUtil.isEmpty(atchFileId)) {
			FileVO fileVO = new FileVO();
			fileVO.setAtchFileId(atchFileId);
			List<FileVO> atchFiles = fileMngService.selectFileInfs(fileVO);
			model.addAttribute("atchFiles", atchFiles);
		}
		
		return "front/eventprogram/detailView";
	}
	
}
