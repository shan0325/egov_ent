<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>로그인</title>
	<link rel="stylesheet" href="<c:url value="/front/css/login.css"/>">
</head>
<body>
	
	<div class="wrapper fadeInDown">
	  <div id="formContent">
	    <!-- Tabs Titles -->
		
	    <!-- Icon -->
	    <div class="fadeIn first">
	      <!-- <img src="http://danielzawadzki.com/codepen/01/icon.svg" id="icon" alt="User Icon" /> -->
	      <h3 class="pt-5 pb-3">로그인</h3>
	    </div>
	
	    <!-- Login Form -->
	    <form name="loginForm" method="post">
	    	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	    	<input type="hidden" name="userSe" value="USR"/>
	      	<input type="text" title="아이디를 입력하세요." id="id" name="id" maxlength="10" placeholder="아이디"/>
	      	<input type="password" maxlength="25" title="비밀번호를 입력하세요." id="password" name="password" placeholder="비밀번호" onkeydown="javascript:if (event.keyCode == 13) { actionLogin(); }"/>
	      	<input type="button" class="fadeIn fourth" value="Log In" onclick="actionLogin();">
	    </form>
	
	    <!-- Remind Passowrd -->
	    <div id="formFooter">
	      <a class="underlineHover" href="#">Forgot Password?</a>
	    </div>
	
	  </div>
	</div>
	
	<script type="text/javascript">
		$(function() {
			
		});
	
		function actionLogin() {
		    if (document.loginForm.id.value =="") {
		        alert("아이디를 입력하세요");
		        return false;
		    } else if (document.loginForm.password.value =="") {
		        alert("비밀번호를 입력하세요");
		        return false;
		    } else {
		        document.loginForm.action="<c:url value='/front/login/actionSecurityLogin.do'/>";
		        //document.loginForm.j_username.value = document.loginForm.userSe.value + document.loginForm.username.value;
		        //document.loginForm.action="<c:url value='/j_spring_security_check'/>";
		        document.loginForm.submit();
		    }
		}
	</script>

</body>
</html>