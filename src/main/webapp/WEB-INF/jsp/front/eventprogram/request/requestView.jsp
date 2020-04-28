<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<sec:authentication property="principal" var="user"/>

<!DOCTYPE html>
<html>
<head>
	<title>메인 > 행사</title>
</head>
<body>
	<!-- Page Header -->
	<header class="masthead" style="background-image: url('/front/img/home-bg.jpg')">
		<div class="overlay"></div>
		<div class="container">
			<div class="row">
				<div class="col-lg-8 col-md-10 mx-auto">
					<div class="site-heading">
						<h1>EVENT</h1>
						<span class="subheading">A Blog Theme by Start Bootstrap</span>
					</div>
				</div>
			</div>
		</div>
	</header>
	
	<div class="container">
		${user.authorities}
		<br/>
		${eventProgramVO }
	</div>
	
	<script type="text/javascript">
		$(function() {
			
		});
	</script>
</body>
</html>