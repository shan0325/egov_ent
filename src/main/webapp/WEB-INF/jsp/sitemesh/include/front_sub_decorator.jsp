<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<sec:authentication property="principal" var="user"/>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title><decorator:title default="traveler" /></title>
	
	<link rel="stylesheet" href="/bootstrap-4.4.1-dist/css/bootstrap.css">
	
	<!-- Custom fonts for this template -->
	<link href="/font/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
	<link href='https://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic' rel='stylesheet' type='text/css'>
	<link href='https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800' rel='stylesheet' type='text/css'>
	
	<!-- Custom styles for this template -->
	<link href="/front/css/clean-blog.css" rel="stylesheet">
	
	<script src="/js/jquery/jquery-3.0.0.js"></script>
	<script src="/bootstrap-4.4.1-dist/js/bootstrap.bundle.js"></script>
	
	<decorator:head />
</head>
<body>
	
	<!-- Navigation -->
	<nav class="navbar navbar-expand-lg navbar-light" id="mainNav">
	  <div class="container">
	    <a class="navbar-brand" href="<c:url value="/"/>">Start Bootstrap</a>
	    <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
	      Menu
	      <i class="fas fa-bars"></i>
	    </button>
	    <div class="collapse navbar-collapse" id="navbarResponsive">
	      <ul class="navbar-nav ml-auto">
	        <li class="nav-item">
	          <a class="nav-link" href="<c:url value="/"/>">Home</a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link" href="<c:url value="/front/eventprogram/list.do?pageUnit=6"/>">Event</a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link" href="<c:url value="/"/>">게시판</a>
	        </li>
	        <c:choose>
	        <c:when test="${user ne 'anonymousUser'}">
	        	<li class="nav-item">
		          <a class="nav-link" href="contact.html">${user.username}</a>
		        </li>
		        <li class="nav-item">
		          <a class="nav-link" href="<c:url value="/front/login/actionLogout.do"/>">로그아웃</a>
		        </li>
	        </c:when>
	        <c:otherwise>
		        <li class="nav-item">
		          <a class="nav-link" href="<c:url value="/front/login/loginView.do"/>">로그인</a>
		        </li>
	        </c:otherwise>
	        </c:choose>
	      </ul>
	    </div>
	  </div>
	</nav>
	
	<decorator:body />
	
	<hr>
	
	<!-- Footer -->
	<footer>
	  <div class="container">
	    <div class="row">
	      <div class="col-lg-8 col-md-10 mx-auto">
	        <ul class="list-inline text-center">
	          <li class="list-inline-item">
	            <a href="#">
	              <span class="fa-stack fa-lg">
	                <i class="fas fa-circle fa-stack-2x"></i>
	                <i class="fab fa-twitter fa-stack-1x fa-inverse"></i>
	              </span>
	            </a>
	          </li>
	          <li class="list-inline-item">
	            <a href="#">
	              <span class="fa-stack fa-lg">
	                <i class="fas fa-circle fa-stack-2x"></i>
	                <i class="fab fa-facebook-f fa-stack-1x fa-inverse"></i>
	              </span>
	            </a>
	          </li>
	          <li class="list-inline-item">
	            <a href="#">
	              <span class="fa-stack fa-lg">
	                <i class="fas fa-circle fa-stack-2x"></i>
	                <i class="fab fa-github fa-stack-1x fa-inverse"></i>
	              </span>
	            </a>
	          </li>
	        </ul>
	        <p class="copyright text-muted">Copyright &copy; Your Website 2019</p>
	      </div>
	    </div>
	  </div>
	</footer>
	
</body>
</html>