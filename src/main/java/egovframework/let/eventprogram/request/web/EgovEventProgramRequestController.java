package egovframework.let.eventprogram.request.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.com.cmm.ComDefaultVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.FileVO;
import egovframework.let.eventprogram.request.service.EgovEventProgramRequestMemberVO;
import egovframework.let.eventprogram.request.service.EgovEventProgramRequestService;
import egovframework.let.eventprogram.request.service.EgovEventProgramRequestVO;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class EgovEventProgramRequestController {
	
	@Resource(name = "egovEventProgramRequestService")
	private EgovEventProgramRequestService egovEventProgramRequestService;
	
	@Resource(name = "EgovFileMngUtil")
	private EgovFileMngUtil fileUtil;
	
	@Resource(name = "EgovFileMngService")
	private EgovFileMngService fileMngService;
	
	/** EgovMessageSource */
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;

	@RequestMapping("/let/eventprogram/request/listView.do")
	public String listView(@ModelAttribute(name="searchVO") ComDefaultVO searchVO, Model model) {
		
		// 페이징
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		int totCnt = egovEventProgramRequestService.getTotalListCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		model.addAttribute("list", egovEventProgramRequestService.getList(searchVO));
		return "eventprogram/request/list";
	}
	
	@RequestMapping("/let/eventprogram/request/updateView.do")
	public String updateView(@ModelAttribute(name="searchVO") ComDefaultVO searchVO,
			@ModelAttribute EgovEventProgramRequestVO egovEventProgramRequestVO, Model model) throws Exception {
		
		EgovMap detail = egovEventProgramRequestService.getOne(egovEventProgramRequestVO);
		model.addAttribute("detail", detail);
		
		String atchFileId = (String) detail.get("atchFileId");
		if(!EgovStringUtil.isEmpty(atchFileId)) {
			FileVO fileVO = new FileVO();
			fileVO.setAtchFileId(atchFileId);
			List<FileVO> atchFiles = fileMngService.selectFileInfs(fileVO);
			model.addAttribute("atchFiles", atchFiles);
		}
		
		List<?> eventRequestMemberList = egovEventProgramRequestService.getEventRequestMemberList(egovEventProgramRequestVO);
		model.addAttribute("eventRequestMemberList", eventRequestMemberList);
		
		return "eventprogram/request/requestView";
	}
	
	@RequestMapping(value="/let/eventprogram/request/addApi.do", method = RequestMethod.POST)
	public ResponseEntity<?> addApi(MultipartHttpServletRequest multipartRequest, 
			EgovEventProgramRequestVO egovEventProgramRequestVO, EgovEventProgramRequestMemberVO egovEventProgramRequestMemberVO) {
		
		Map<String, String> resultMap = new HashMap<String, String>();
		try {
						
			String atchFileId = egovEventProgramRequestVO.getAtchFileId();
			if(!EgovStringUtil.isEmpty(atchFileId)) {
				Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
				List<FileVO> fileInf = fileUtil.parseFileInf(fileMap, "EVENT_REQ_", 0, atchFileId, "Globals.eventFileStorePath");
				fileMngService.deleteFileInfs(fileInf);
				fileMngService.updateFileInfs(fileInf);
			} else {
				Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
				List<FileVO> fileInf = fileUtil.parseFileInf(fileMap, "EVENT_REQ_", 0, "", "Globals.eventFileStorePath");
				atchFileId = fileMngService.insertFileInfs(fileInf);
				egovEventProgramRequestVO.setAtchFileId(atchFileId);
			}
			
			egovEventProgramRequestService.mod(egovEventProgramRequestVO, egovEventProgramRequestMemberVO);
		} catch(Exception e) {
			e.printStackTrace();
			return new ResponseEntity<Object>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		resultMap.put("message", egovMessageSource.getMessage("success.common.insert"));
		return new ResponseEntity<Map<String, String>>(resultMap, HttpStatus.OK);
	}
}
