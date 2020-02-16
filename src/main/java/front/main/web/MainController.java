package front.main.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {

	
	@RequestMapping("/front/main.do")
	public String main() {
		
		return "front/main/main";
	}
}
