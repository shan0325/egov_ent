package front.eventprogram.web;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import egovframework.com.cmm.ComDefaultVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.FileVO;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import front.eventprogram.service.EventProgramRequestMemberVO;
import front.eventprogram.service.EventProgramRequestService;
import front.eventprogram.service.EventProgramRequestVO;
import front.eventprogram.service.EventProgramService;
import front.eventprogram.service.EventProgramVO;


@Controller
public class EventProgramReqController {
	
	@Resource(name = "eventProgramService")
	private EventProgramService eventProgramService;
	
	@Resource(name = "eventProgramRequestService")
	private EventProgramRequestService eventProgramRequestService;
	
	@Resource(name = "EgovFileMngUtil")
	private EgovFileMngUtil fileUtil;
	
	@Resource(name = "EgovFileMngService")
	private EgovFileMngService fileMngService;
	
	/** EgovMessageSource */
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;

	/**
	 * 신청페이지 이동
	 * @param eventProgramVO
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/front/eventprogram/request/requestView.do")
	public String requestView(@ModelAttribute("searchVO") ComDefaultVO searchVO, @ModelAttribute EventProgramVO eventProgramVO, 
			EventProgramRequestVO eventRequestVO, Model model, RedirectAttributes redirectAttributes) throws Exception {
		
		redirectAttributes.addAttribute("id", eventProgramVO.getId());
		redirectAttributes.addAttribute("pageIndex", searchVO.getPageIndex());
		
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		eventRequestVO.setReqUserId(loginVO.getId());
		eventRequestVO.setMasterId(eventProgramVO.getId());
		
		EgovMap detail = eventProgramService.getOne(eventProgramVO);
		model.addAttribute("detail", detail);
		
		int status = (int) detail.get("status");
		if(status == 0) {
			redirectAttributes.addFlashAttribute("error", "1");
			return "redirect:/front/eventprogram/detailView.do";
		} else if(status == 2 || status == 3) {
			redirectAttributes.addFlashAttribute("error", "2");
			return "redirect:/front/eventprogram/detailView.do";
		}
		
		long numberOfApplicablePeople = eventProgramRequestService.getNumberOfApplicablePeople(eventProgramVO);
		model.addAttribute("numberOfApplicablePeople", numberOfApplicablePeople);
		
		// 신청 확인
		int reqCount = eventProgramRequestService.getReqCountByUserId(eventRequestVO);
		if(reqCount > 1) {
			redirectAttributes.addFlashAttribute("error", "3");
			return "redirect:/front/eventprogram/detailView.do";
		} else if(reqCount == 1) {
			EgovMap saveEventRequest = eventProgramRequestService.getRequestByUserId(eventRequestVO);
			String saveState = (String) saveEventRequest.get("saveState");
			if("1".equals(saveState)) { // 신청 완료
				redirectAttributes.addFlashAttribute("error", "4");
				return "redirect:/front/eventprogram/detailView.do";
			}
			
			// 임시 저장
			model.addAttribute("saveEventRequest", saveEventRequest);
			
			eventRequestVO.setId((Long) saveEventRequest.get("id"));
			List<EgovMap> saveEventRequestMemberList = eventProgramRequestService.getSaveRequestMemberList(eventRequestVO);
			model.addAttribute("saveEventRequestMemberList", saveEventRequestMemberList);
			
			String atchFileId = (String) saveEventRequest.get("atchFileId");
			if(!EgovStringUtil.isEmpty(atchFileId)) {
				FileVO fileVO = new FileVO();
				fileVO.setAtchFileId(atchFileId);
				List<FileVO> atchFiles = fileMngService.selectFileInfs(fileVO);
				model.addAttribute("atchFiles", atchFiles);
			}
		}
		
		return "front/eventprogram/request/requestView";
	}
	
	/**
	 * 등록 처리
	 * @param multipartRequest
	 * @param eventRequestVO
	 * @return
	 */
	@RequestMapping(value="/front/eventprogram/request/addApi.do", method = RequestMethod.POST)
	public ResponseEntity<?> addApi(MultipartHttpServletRequest multipartRequest,
			EventProgramRequestVO eventRequestVO, EventProgramRequestMemberVO eventProgramRequestMemberVO) {
		
		Map<String, String> resultMap = new HashMap<String, String>();
		String atchFileId = null;
		EgovMap saveEventRequest = null;
		try {
			LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
			eventRequestVO.setReqUserId(loginVO.getId());
			
			EventProgramVO eventProgramVO = new EventProgramVO();
			eventProgramVO.setId(eventRequestVO.getMasterId());
			EgovMap detail = eventProgramService.getOne(eventProgramVO);
			
			int status = (int) detail.get("status");
			if(status == 0) {
				resultMap.put("message", "접수기간이 아닙니다.");
				return new ResponseEntity<Map<String, String>>(resultMap, HttpStatus.OK);
			} else if(status == 2 || status == 3) {
				resultMap.put("message", "접수가 마감되었습니다.");
				return new ResponseEntity<Map<String, String>>(resultMap, HttpStatus.OK);
			}
			
			// 신청 확인
			int reqCount = eventProgramRequestService.getReqCountByUserId(eventRequestVO);
			if(reqCount > 1) {
				resultMap.put("message", "여러건이 신청되어 오류가 발생하였습니다. 담당자에게 확인해주세요");
				return new ResponseEntity<Map<String, String>>(resultMap, HttpStatus.OK);
			} else if(reqCount == 1) {
				saveEventRequest = eventProgramRequestService.getRequestByUserId(eventRequestVO);
				String saveState = (String) saveEventRequest.get("saveState");
				if("1".equals(saveState)) { // 신청 완료
					resultMap.put("message", "이미 신청하였습니다.");
					return new ResponseEntity<Map<String, String>>(resultMap, HttpStatus.OK);
				}
				atchFileId = (String) saveEventRequest.get("atchFileId");
			}
						
			if(!EgovStringUtil.isEmpty(atchFileId)) {
				Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
				List<FileVO> fileInf = fileUtil.parseFileInf(fileMap, "EVENT_REQ_", 0, atchFileId, "Globals.eventFileStorePath");
				fileMngService.deleteFileInfs(fileInf);
				fileMngService.updateFileInfs(fileInf);
			} else {
				Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
				List<FileVO> fileInf = fileUtil.parseFileInf(fileMap, "EVENT_REQ_", 0, "", "Globals.eventFileStorePath");
				atchFileId = fileMngService.insertFileInfs(fileInf);
				eventRequestVO.setAtchFileId(atchFileId);
			}
			
			if(saveEventRequest != null) {
				// 수정
				eventRequestVO.setId((Long) saveEventRequest.get("id"));
				eventProgramRequestService.mod(eventRequestVO, eventProgramRequestMemberVO);
			} else {
				// 처음 등록
				eventProgramRequestService.add(eventRequestVO, eventProgramRequestMemberVO);
			}
		} catch(Exception e) {
			e.printStackTrace();
			return new ResponseEntity<Object>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		resultMap.put("message", egovMessageSource.getMessage("success.common.insert"));
		return new ResponseEntity<Map<String, String>>(resultMap, HttpStatus.OK);
	}
	
	/**
	 * 참여가능한 인원수 확인
	 * @param eventProgramVO
	 * @return
	 */
	@RequestMapping("/front/eventprogram/request/getNumberOfRequestableMemberApi.do")
	public ResponseEntity<?> getNumberOfApplicablePeopleApi(EventProgramVO eventProgramVO) {
		
		long numberOfApplicablePeople = eventProgramRequestService.getNumberOfApplicablePeople(eventProgramVO);
		
		return new ResponseEntity<Long>(numberOfApplicablePeople, HttpStatus.OK);
	}
}
