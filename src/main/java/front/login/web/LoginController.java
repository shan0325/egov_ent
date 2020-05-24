package front.login.web;

import java.util.Collection;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.support.WebApplicationContextUtils;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.let.uat.uap.service.EgovLoginPolicyService;
import egovframework.let.uat.uap.service.LoginPolicyVO;
import egovframework.let.uat.uia.service.EgovLoginService;
import egovframework.let.utl.sim.service.EgovClntInfo;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;

@Controller
public class LoginController {
	
	Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	/** EgovLoginService */
	@Resource(name = "loginService")
	private EgovLoginService loginService;

	/** EgovMessageSource */
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;

	/** EgovLoginPolicyService */
	@Resource(name = "egovLoginPolicyService")
	EgovLoginPolicyService egovLoginPolicyService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	
	/**
	 * 로그인 화면으로 들어간다
	 */
	@RequestMapping(value = "/front/login/loginView.do")
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
			return "redirect:/front/main.do";
		}
		
		return "front/login/loginView";
	}
	
	
	/**
	 * 일반(스프링 시큐리티) 로그인을 처리한다
	 * @param vo - 아이디, 비밀번호가 담긴 LoginVO
	 * @param request - 세션처리를 위한 HttpServletRequest
	 * @return result - 로그인결과(세션정보)
	 * @exception Exception
	 */
	@RequestMapping(value = "/front/login/actionSecurityLogin.do")
	public String actionSecurityLogin(@ModelAttribute("loginVO") LoginVO loginVO, HttpServletResponse response, HttpServletRequest request, ModelMap model) throws Exception {

		// 접속IP
		String userIp = EgovClntInfo.getClntIP(request);
		
		// 1. 일반 로그인 처리
		LoginVO resultVO = loginService.actionLogin(loginVO);

		boolean loginPolicyYn = true;

		LoginPolicyVO loginPolicyVO = new LoginPolicyVO();
		loginPolicyVO.setEmplyrId(resultVO.getId());
		loginPolicyVO = egovLoginPolicyService.selectLoginPolicy(loginPolicyVO);

		if (loginPolicyVO == null) {
			loginPolicyYn = true;
		} else {
			if (loginPolicyVO.getLmttAt().equals("Y")) {
				if (!userIp.equals(loginPolicyVO.getIpInfo())) {
					loginPolicyYn = false;
				}
			}
		}
		if (resultVO != null && resultVO.getId() != null && !resultVO.getId().equals("") && loginPolicyYn) {

			// 2. spring security 연동
			request.getSession().setAttribute("fLoginVO", resultVO);
			
			logger.debug("front login SesionId : " + request.getSession().getId());

			UsernamePasswordAuthenticationFilter springSecurity = null;

			ApplicationContext act = WebApplicationContextUtils.getRequiredWebApplicationContext(request.getSession().getServletContext());
						
			Map<String, UsernamePasswordAuthenticationFilter> beans = act.getBeansOfType(UsernamePasswordAuthenticationFilter.class);
			
			if (beans.size() > 0) {
				
				springSecurity = (UsernamePasswordAuthenticationFilter) beans.values().toArray()[0];
				springSecurity.setUsernameParameter("front_security_username");
				springSecurity.setPasswordParameter("front_security_password");
				springSecurity.setRequiresAuthenticationRequestMatcher(new AntPathRequestMatcher(request.getServletContext().getContextPath() +"/front_security_login", "POST"));
				
			} else {
				throw new IllegalStateException("No AuthenticationProcessingFilter");
			}
						
			springSecurity.doFilter(new RequestWrapperForSecurity(request, resultVO.getUserSe()+ resultVO.getId(), resultVO.getUniqId()), response, null);
						
			return "forward:/front/main.do"; // 성공 시 페이지.. (redirect 불가)

		} else {

			model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
			return "uat/uia/EgovLoginUsr";
		}
	}
	
	@RequestMapping(value = "/front/login/actionMain.do")
	public String actionMain(HttpServletResponse response, HttpServletRequest request, ModelMap model) throws Exception {
				
		// 1. Spring Security 사용자권한 처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if (!isAuthenticated) {
			model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
			return "uat/uia/EgovLoginUsr";
		}

		// 2. 메인 페이지 이동
		return "forward:/front/main.do";
	}
	
	@RequestMapping(value = "/front/login/actionLogout.do")
	public String actionLogout(HttpServletRequest request, ModelMap model) throws Exception {
		//request.getSession().setAttribute("fLoginVO", null);
		request.getSession().invalidate();
		
		return "redirect:/front/main.do";
	}
}

class RequestWrapperForSecurity extends HttpServletRequestWrapper {
	private String username = null;
	private String password = null;

	public RequestWrapperForSecurity(HttpServletRequest request, String username, String password) {
		super(request);

		this.username = username;
		this.password = password;
	}
	
	@Override
	public String getServletPath() {		
		return ((HttpServletRequest) super.getRequest()).getContextPath() + "/front_security_login";
	}

	@Override
	public String getRequestURI() {		
		return ((HttpServletRequest) super.getRequest()).getContextPath() + "/front_security_login";
	}

	@Override
	public String getParameter(String name) {
		if (name.equals("front_security_username")) {
			return username;
		}

		if (name.equals("front_security_password")) {
			return password;
		}

		return super.getParameter(name);
	}
}
