package egovframework.let.eventprogram.master.web;

import java.util.ArrayList;
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
import org.springframework.web.multipart.MultipartFile;

import egovframework.com.cmm.ComDefaultVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.FileVO;
import egovframework.let.eventprogram.master.service.EventProgramMasterService;
import egovframework.let.eventprogram.master.service.EventProgramMasterVO;
import egovframework.let.sym.ccm.cde.service.CmmnDetailCodeVO;
import egovframework.let.sym.ccm.cde.service.EgovCcmCmmnDetailCodeManageService;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class EgovEventProgramMasterController {

	@Resource(name="eventProgramMasterService")
	private EventProgramMasterService eventProgramMasterService;
	
	@Resource(name = "CmmnDetailCodeManageService")
    private EgovCcmCmmnDetailCodeManageService cmmnDetailCodeManageService;
	
	@Resource(name = "EgovFileMngUtil")
	private EgovFileMngUtil fileUtil;
	
	@Resource(name = "EgovFileMngService")
	private EgovFileMngService fileMngService;
	
	@Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;
	
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
	public ResponseEntity<?> create(@ModelAttribute EventProgramMasterVO eventProgramMasterVO,
			@RequestParam(required=false) List<MultipartFile> mainImg, @RequestParam(required=false) List<MultipartFile> attachFile) throws Exception {
		
		// 메인 이미지
		if(mainImg != null && mainImg.size() > 0) {
			List<FileVO> mainImgResult = fileUtil.parseFileInfByMultipartFiles(mainImg, "EVENT_", 0, "", "Globals.eventFileStorePath");
			String mainImgAtchFileId = fileMngService.insertFileInfs(mainImgResult);
			eventProgramMasterVO.setMainImgAtchFileId(mainImgAtchFileId);
		}
		
		// 첨부파일
		if(attachFile != null && attachFile.size() > 0) {
			List<FileVO> attachFileResult = fileUtil.parseFileInfByMultipartFiles(attachFile, "EVENT_", 0, "", "Globals.eventFileStorePath");
			String atchFileId = fileMngService.insertFileInfs(attachFileResult);
			eventProgramMasterVO.setAtchFileId(atchFileId);
		}
		
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		eventProgramMasterVO.setRegUserId(loginVO.getId());
		
		eventProgramMasterService.add(eventProgramMasterVO);
		
		Map<String, String> resultMap = new HashMap<String, String>();
		resultMap.put("message", egovMessageSource.getMessage("success.common.insert"));
		
		return new ResponseEntity<Map<String, String>>(resultMap, HttpStatus.OK);
	}
	
	@RequestMapping(value="/let/eventprogram/master/updateView.do")
	public String updateView(@ModelAttribute EventProgramMasterVO eventProgramMasterVO, ModelMap model) throws Exception {
		
		CmmnDetailCodeVO cmmnDetailCodeVO = new CmmnDetailCodeVO();
		cmmnDetailCodeVO.setSearchCondition("1");
		cmmnDetailCodeVO.setSearchKeyword("COM030");
		List<?> codeList = cmmnDetailCodeManageService.selectCmmnDetailCodes(cmmnDetailCodeVO);
		model.addAttribute("gubunCodeList", codeList);
		
		EgovMap detail = eventProgramMasterService.getOne(eventProgramMasterVO);
		model.addAttribute("detail", detail);
		
		String mainImgAtchFileId = (String) detail.get("mainImgAtchFileId");
		if(!EgovStringUtil.isEmpty(mainImgAtchFileId)) {
			FileVO fileVO = new FileVO();
			fileVO.setAtchFileId(mainImgAtchFileId);
			List<FileVO> mainImgs = fileMngService.selectImageFileList(fileVO);
			model.addAttribute("mainImgs", mainImgs);
		}
		
		String atchFileId = (String) detail.get("atchFileId");
		if(!EgovStringUtil.isEmpty(atchFileId)) {
			FileVO fileVO = new FileVO();
			fileVO.setAtchFileId(atchFileId);
			List<FileVO> atchFiles = fileMngService.selectFileInfs(fileVO);
			model.addAttribute("atchFiles", atchFiles);
		}
		
		return "eventprogram/master/createView";
	}
	
	@RequestMapping(value="/let/eventprogram/master/updateApi.do")
	public ResponseEntity<?> update(@ModelAttribute EventProgramMasterVO eventProgramMasterVO,
			@RequestParam(required=false) String[] delMainImgFileSn, @RequestParam(required=false) String[] delAtchFileFileSn,
			@RequestParam(required=false) List<MultipartFile> mainImg, @RequestParam(required=false) List<MultipartFile> attachFile) {
		
		try {
			// 파일 삭제 처리
			List<FileVO> delFileList = new ArrayList<FileVO>();
			if(delMainImgFileSn != null && delMainImgFileSn.length > 0) {
				for(int i = 0; i < delMainImgFileSn.length; i++) {
					FileVO fileVO = new FileVO();
					fileVO.setAtchFileId(eventProgramMasterVO.getMainImgAtchFileId());
					fileVO.setFileSn(delMainImgFileSn[i]);
					delFileList.add(fileVO);
				}
			}
			if(delAtchFileFileSn != null && delAtchFileFileSn.length > 0) {
				for(int i = 0; i < delAtchFileFileSn.length; i++) {
					FileVO fileVO = new FileVO();
					fileVO.setAtchFileId(eventProgramMasterVO.getAtchFileId());
					fileVO.setFileSn(delAtchFileFileSn[i]);
					delFileList.add(fileVO);
				}
			}
			fileMngService.deleteFileInfs(delFileList);
			
			// 메인 이미지
			if(mainImg != null && mainImg.size() > 0) {
				String mainImgAtchFileId = eventProgramMasterVO.getMainImgAtchFileId();
				if(!EgovStringUtil.isEmpty(mainImgAtchFileId)) {
					FileVO fileVO = new FileVO();
					fileVO.setAtchFileId(mainImgAtchFileId);
					int maxFileSN = fileMngService.getMaxFileSN(fileVO);
					List<FileVO> mainImgResult = fileUtil.parseFileInfByMultipartFiles(mainImg, "EVENT_", maxFileSN, mainImgAtchFileId, "Globals.eventFileStorePath");
					fileMngService.updateFileInfs(mainImgResult);
				} else {
					List<FileVO> mainImgResult = fileUtil.parseFileInfByMultipartFiles(mainImg, "EVENT_", 0, mainImgAtchFileId, "Globals.eventFileStorePath");
					mainImgAtchFileId = fileMngService.insertFileInfs(mainImgResult);
					eventProgramMasterVO.setMainImgAtchFileId(mainImgAtchFileId);
				}
			}
			
			// 첨부파일
			if(attachFile != null && attachFile.size() > 0) {
				String atchFileId = eventProgramMasterVO.getAtchFileId();
				if(!EgovStringUtil.isEmpty(atchFileId)) {
					FileVO fileVO = new FileVO();
					fileVO.setAtchFileId(atchFileId);
					int maxFileSN = fileMngService.getMaxFileSN(fileVO);
					List<FileVO> attachFileResult = fileUtil.parseFileInfByMultipartFiles(attachFile, "EVENT_", maxFileSN, atchFileId, "Globals.eventFileStorePath");
					fileMngService.updateFileInfs(attachFileResult);
				} else {
					List<FileVO> attachFileResult = fileUtil.parseFileInfByMultipartFiles(attachFile, "EVENT_", 0, atchFileId, "Globals.eventFileStorePath");
					atchFileId = fileMngService.insertFileInfs(attachFileResult);
					eventProgramMasterVO.setAtchFileId(atchFileId);
				}
			}
			
			int upCnt = eventProgramMasterService.mod(eventProgramMasterVO);
			
		} catch(Exception e) {
			Map<String, String> resultMap = new HashMap<String, String>();
			resultMap.put("message", egovMessageSource.getMessage("fail.common.update"));
			return new ResponseEntity<Map<String, String>>(resultMap, HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
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
