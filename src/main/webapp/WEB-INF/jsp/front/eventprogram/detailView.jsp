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
		<div class="card mb-3">
			<div class="row no-gutters">
				<div class="col-md-4">
					<img src="/cmm/fms/getImage.do?atchFileId=${detail.mainImgAtchFileId}&amp;fileSn=${detail.fileSn}" height="400" class="card-img" alt="메인 이미지">
				</div>
				<div class="col-md-8">
					<div class="card-body">
						<c:choose>
							<c:when test="${detail.status eq '0'}">
								<span class="badge badge-pill badge-warning">진행전</span>
							</c:when>
							<c:when test="${detail.status eq '2' or detail.status eq '3'}">
								<span class="badge badge-pill badge-secondary">마감</span>
							</c:when>
							<c:otherwise>
								<span class="badge badge-pill badge-success">접수중 <c:if test="${detail.firstComeYn eq 'Y'}">(선착순)</c:if></span>
							</c:otherwise>
						</c:choose>
						<h6 class="card-title font-weight-bold mt-3"><c:out value="${detail.title }"/></h6>
						<hr/>
						<dl class="row mb-0">
							<dt class="col-sm-3">접수기간</dt>
							<dd class="col-sm-9"><c:out value="${detail.reqStartDate}"/> ~ <c:out value="${detail.reqEndDate}"/></dd>
							
							<dt class="col-sm-3">프로그램기간</dt>
							<dd class="col-sm-9"><c:out value="${detail.startDate}"/> ~ <c:out value="${detail.endDate}"/></dd>
							
							<dt class="col-sm-3">주최</dt>
							<dd class="col-sm-9"><c:out value="${detail.host}"/> </dd>
							
							<dt class="col-sm-3">위치</dt>
							<dd class="col-sm-9"><c:out value="${detail.location}"/> </dd>
							
							<dt class="col-sm-3">문의처</dt>
							<dd class="col-sm-9"><c:out value="${detail.tel}"/> </dd>
							
							<dt class="col-sm-3">대상자</dt>
							<dd class="col-sm-9"><c:out value="${detail.targetPersion}"/> </dd>
							
							<c:if test="${detail.firstComeYn eq 'Y'}">
								<dt class="col-sm-3">신청인원</dt>
								<dd class="col-sm-9"><c:out value="${detail.reqMaxPersonNumber}"/> / <c:out value="${detail.reqMemberTotalCount}"/></dd>
							</c:if>
							
							<dt class="col-sm-3">첨부파일</dt>
							<dd class="col-sm-9">
								<c:if test="${not empty atchFiles}">
									<c:forEach var="file" items="${atchFiles}">
										<svg class="bi bi-download" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
										  <path fill-rule="evenodd" d="M.5 8a.5.5 0 01.5.5V12a1 1 0 001 1h12a1 1 0 001-1V8.5a.5.5 0 011 0V12a2 2 0 01-2 2H2a2 2 0 01-2-2V8.5A.5.5 0 01.5 8z" clip-rule="evenodd"/>
										  <path fill-rule="evenodd" d="M5 7.5a.5.5 0 01.707 0L8 9.793 10.293 7.5a.5.5 0 11.707.707l-2.646 2.647a.5.5 0 01-.708 0L5 8.207A.5.5 0 015 7.5z" clip-rule="evenodd"/>
										  <path fill-rule="evenodd" d="M8 1a.5.5 0 01.5.5v8a.5.5 0 01-1 0v-8A.5.5 0 018 1z" clip-rule="evenodd"/>
										</svg>&nbsp;
										<a class="card-text" href="/cmm/fms/FileDown.do?atchFileId=${file.atchFileId}&fileSn=${file.fileSn}"><c:out value="${file.orignlFileNm}"/></a><br/>
									</c:forEach>
								</c:if>
							</dd>
						</dl>
					</div>
				</div>
			</div>
		</div>
		
		${detail.content}

		<div class="d-flex justify-content-end mt-5">
			<c:if test="${detail.status eq '1'}">
				<a href="#" class="btn btn-danger mr-2" id="reqProgramBtn" role="button">신청</a>
			</c:if>
			<a href="#" class="btn btn-secondary" id="listBtn" role="button">목록</a>
		</div>
	</div>
	
	<form id="commonForm">
		<input type="hidden" name="pageIndex" value="<c:out value="${searchVO.pageIndex}"/>" />
	</form>
	
	<script type="text/javascript">
		$(function() {
			var error = '${error}';
			if(error) {
				if(error == '1') {
					alert("접수기간이 아닙니다.");
				}
				else if(error == '2') {
					alert("접수가 마감되었습니다.");
				}
				else if(error == '3') {
					alert("여러건이 신청되어 오류가 발생하였습니다. 담당자에게 확인해주세요");
				}
				else if(error == '4') {
					alert("이미 신청하였습니다.");
				}
			}
			
			$("#listBtn").on("click", function(e) {
				e.preventDefault();
				$("#commonForm").attr("action", "<c:url value="/front/eventprogram/list.do"/>");
				$("#commonForm").submit();
			});
			
			$("#reqProgramBtn").on("click", function(e) {
				e.preventDefault();
				<c:if test="${user eq 'anonymousUser'}">
					alert('로그인을 해주세요');
					window.location.href = '<c:url value="/front/login/loginView.do" />';
					return;
				</c:if>
				
				$("#commonForm").append("<input type='hidden' name='id' value='<c:out value="${detail.id}"/>' />");
				$("#commonForm").attr("action", "<c:url value="/front/eventprogram/request/requestView.do"/>");
				$("#commonForm").submit();
			});
		});
	</script>
</body>
</html>