package front.login.web;

import java.util.Collection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cmm.LoginVO;

@Controller
public class MemberLoginController {
	
	Logger logger = LoggerFactory.getLogger(MemberLoginController.class);
	
	@RequestMapping(value = "/member/login/loginView.do")
	public String loginUsrView() throws Exception {
		
		// 세션이 있는 상태이면 메인으로 보내고 아니면 로그인으로 ..
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		logger.info("auth 정보:{}" , auth.toString());
		logger.info("auth getAuthorities 정보:{}" , auth.getAuthorities());
		logger.info("auth getPrincipal 정보:{}" , auth.getPrincipal());
		
		// 생성된 인증정보에 맞게 화면 이동
		Collection<? extends GrantedAuthority>  auths = auth.getAuthorities(); 
		if ( auths.stream().filter(o -> o.getAuthority().equals("ROLE_USER_MEMBER")).findAny().isPresent() )
		{
			logger.info("메인화면으로 이동");
			return "redirect:/member/main.do";
		}
				
		return "front/login/loginView";
	}
	
	@RequestMapping(value = "/member/login/actionSecurityLogin.do")
	public String actionSecurityLogin(@ModelAttribute("loginVO") LoginVO loginVO, HttpServletResponse response, HttpServletRequest request, ModelMap model) throws Exception {

		return null;
	}
	
	@RequestMapping(value = "/member/login/actionLogout.do")
	public String actionLogout(HttpServletRequest request, ModelMap model) throws Exception {
		//request.getSession().setAttribute("fLoginVO", null);
		request.getSession().invalidate();
		
		return "redirect:/member/main.do";
	}

}
