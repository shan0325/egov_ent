package front.main.web;

import java.security.Principal;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {

	
	@RequestMapping("/front/main.do")
	public String main() {
		
		return "front/main/main";
	}
	
	@RequestMapping("/member/main.do")
	public String memberMain(Principal principal) {
		System.out.println("name : " + principal.getName());
		
		return "front/main/main";
	}
}
