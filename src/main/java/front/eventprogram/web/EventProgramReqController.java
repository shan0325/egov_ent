package front.eventprogram.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import front.eventprogram.service.EventProgramVO;

@Controller
public class EventProgramReqController {

	
	@RequestMapping(value="/front/eventprogram/request/requestView.do")
	public String requestView(@ModelAttribute EventProgramVO eventProgramVO) {
		
		return "front/eventprogram/request/requestView";
	}
	
	
}
