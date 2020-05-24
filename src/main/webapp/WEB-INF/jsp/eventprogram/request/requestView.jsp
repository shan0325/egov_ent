<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Language" content="ko" >
	<link href="<c:url value='/'/>css/common.css" rel="stylesheet" type="text/css" >
	
	<title>행사프로그램신청관리</title>
	
</head>

<body>
	<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>    
	<!-- 전체 레이어 시작 -->
	<div id="wrapper">
	    <!-- header 시작 -->
	    <div id="header"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncHeader" /></div>
	    <div id="topnavi"><c:import url="/sym/mms/EgovMainMenuHead.do" /></div>        
	    <!-- //header 끝 --> 
	    <!-- container 시작 -->
	    <div class="container-fluid">
	        <!-- 좌측메뉴 시작 -->
	        <div id="leftmenu" class="clearfix"><c:import url="/sym/mms/EgovMainMenuLeft.do" /></div>
	        <!-- //좌측메뉴 끝 -->
	        
	         <!-- 현재위치 네비게이션 시작 -->
	         <div id="content-wrapper">
				<div id="cur_loc" class="clearfix mb-3">
				    <div id="cur_loc_align">
				        <ul>
				            <li>HOME</li>
				            <li>&gt;</li>
				            <li>행사프로그램관리</li>
				            <li>&gt;</li>
				            <li><strong>행사프로그램신청관리</strong></li>
				        </ul>
				    </div>
				</div>
				
				<h3><c:out value="${detail.title}"/></h3>
				<hr/>
				
				<form id="addForm" class="col-md-6 mt-5" method="post" enctype="multipart/form-data">
					<input type="hidden" name="id" value="${detail.id}" />
					<input type="hidden" name="masterId" value="${detail.masterId}" />
						
					<h4 class="text-center mt-5 mb-4">신청자 정보</h4>
					<div class="form-row">
						<div class="form-group col-md-6">
							<label>아이디</label> 
							<input type="text" class="form-control" name="reqUserId" id="reqUserId" value="${detail.reqUserId}" readonly="readonly">
						</div>
						<div class="form-group col-md-6">
							<label for="reqName">이름</label>
							<input type="text" class="form-control" name="reqName" id="reqName" value="${detail.reqName}">
						</div>
					</div>
					<div class="form-row">
						<div class="form-group col-md-6">
							<label for="reqPhone">휴대폰</label>
							<input type="text" class="form-control" name="reqPhone" id="reqPhone" value="<c:out value="${detail.reqPhone}"/>">
						</div>
						<div class="form-group col-md-6">
							<label for="reqEmail">이메일</label> 
							<input type="text" class="form-control" name="reqEmail" id="reqEmail" value="<c:out value="${detail.reqEmail}"/>">
						</div>
					</div>
					<div class="form-group">
						<label for="reqIntroduction">소개</label> 
						<textarea class="form-control" name="reqIntroduction" id="reqIntroduction" rows="10" cols="150"><c:out value="${detail.reqIntroduction}"/></textarea>
					</div>
					<div class="form-group">
						<label>첨부파일</label>
						<input type="file" name="atchFile" id="atchFile" class="form-control" />
						<c:if test="${not empty atchFiles and fn:length(atchFiles) > 0}">
							<input type="hidden" name="atchFileId" value="<c:out value="${detail.atchFileId}"/>" />
							<a href="/cmm/fms/FileDown.do?atchFileId=${atchFiles[0].atchFileId}&fileSn=${atchFiles[0].fileSn}"><c:out value="${atchFiles[0].orignlFileNm}"/></a>
						</c:if>
					</div>
					<!-- <div class="form-group">
						<label for="reqIntroduction">신청상태</label>
						<input type="radio" name="requestState" class="form-control" value="0"/>대기
						<input type="radio" name="requestState" class="form-control" value="1"/>승인
						<input type="radio" name="requestState" class="form-control" value="2"/>취소
					</div> -->
					
					<c:if test="${detail.saveState eq '1'}">
					<fieldset class="form-group">
						<legend class="col-form-label col-sm-2 px-0 pt-0">신청상태</legend>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="requestState" id="requestState_0" value="0" ${detail.requestState eq '0' ? 'checked' : ''}>
								<label class="form-check-label" for="requestState_0">대기</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="requestState" id="requestState_1" value="1" ${detail.requestState eq '1' ? 'checked' : ''}>
								<label class="form-check-label" for="requestState_1">승인</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="requestState" id="requestState_2" value="2" ${detail.requestState eq '2' ? 'checked' : ''}>
								<label class="form-check-label" for="requestState_2">취소</label>
							</div>
					</fieldset>
					</c:if>
					
					<h4 class="text-center mt-5 mb-4">참여자 명단</h4>
					<c:choose>
					<c:when test="${not empty eventRequestMemberList}">
						<c:forEach var="member" items="${eventRequestMemberList}">
							<div class="participantSection form-row">
								<div class="form-group col-md-6">
									<label for="name">이름</label>
									<input type="text" class="form-control" name="name" value="<c:out value="${member.name}"/>">
								</div>
								<div class="form-group col-md-6">
									<label for="age">나이</label>
									<input type="text" class="form-control" name="age" value="<c:out value="${member.age}"/>">
								</div>
							</div>
						</c:forEach>
						<c:if test="${fn:length(eventRequestMemberList) < 5}">
							<c:forEach begin="0" end="${4 - fn:length(eventRequestMemberList)}">
								<div class="participantSection form-row">
									<div class="form-group col-md-6">
										<label for="name">이름</label>
										<input type="text" class="form-control" name="name">
									</div>
									<div class="form-group col-md-6">
										<label for="age">나이</label>
										<input type="text" class="form-control" name="age">
									</div>
								</div>
							</c:forEach>	
						</c:if>
					</c:when>
					<c:otherwise>
						<c:forEach begin="0" end="4">
							<div class="participantSection form-row">
								<div class="form-group col-md-6">
									<label for="name">이름</label>
									<input type="text" class="form-control" name="name">
								</div>
								<div class="form-group col-md-6">
									<label for="age">나이</label>
									<input type="text" class="form-control" name="age">
								</div>
							</div>
						</c:forEach>
					</c:otherwise>
					</c:choose>
					
					<div class="d-flex justify-content-center">
						<input type="button" class="btn btn-outline-success mt-3" id="appendParticipantBtn" value="추가" />
					</div>	
					
					<div class="d-flex justify-content-center my-5">
						<a href="#" class="btn btn-danger mr-2" id="addBtn">등록</a>
						<a href="#this" class="btn btn-secondary" id="listBtn">목록</a>
					</div>			
				</form>
				
				<form id="commonForm">
					<input type="hidden" name="id" value="<c:out value="${detail.id}"/>" />
					<input type="hidden" name="pageIndex" value="<c:out value="${searchVO.pageIndex}"/>" />
					<input type="hidden" name="pageUnit" value="<c:out value="${searchVO.pageUnit}"/>" />
					<input type="hidden" name="searchCondition" value="<c:out value="${searchVO.searchCondition}"/>" />
					<input type="hidden" name="searchKeyword" value="<c:out value="${searchVO.searchKeyword}"/>" />
				</form>
				
				<script type="text/javascript">
					$(function() {
						$("#appendParticipantBtn").on("click", function() {
							appendParticipant();
						});
						
						$("#listBtn").on("click", function() {
							goList();
						});
						
						$("#addBtn").on("click", function() {
							submit();
						});
					});
					
					function goList() {
						$("#commonForm").attr("method", "get");
						$("#commonForm").attr("action", "/let/eventprogram/request/listView.do");
						$("#commonForm").submit();
					}
					
					function appendParticipant() {
						var html = "";
						html += '<div class="participantSection form-row">';
						html += '	<div class="form-group col-md-6">';
						html += '		<label for="name">이름</label>';
						html += '		<input type="text" class="form-control" name="name">';
						html += '	</div>';
						html += '	<div class="form-group col-md-6">';
						html += '		<label for="age">나이</label>';
						html += '		<input type="text" class="form-control" name="age">';
						html += '	</div>';
						html += '</div>';
						$(".participantSection").last().after(html);
					}
					
					function submit() {
						if(fn_validation()) {
							if(confirm("등록 하시겠습니까?")) {
								// participantSection 부분 name 변경
								$(".participantSection").each(function(i, e) {
									$(e).find("input[name='name']").attr("name", "memberVOList[" + i + "].name");
									$(e).find("input[name='age']").attr("name", "memberVOList[" + i + "].age");
								});
								
								$('#addForm').ajaxForm({
									type: 'post',
									url: '<c:url value="/let/eventprogram/request/addApi.do"/>',
									enctype : 'multipart/form-data',
									dataType: 'json',
									success: function(data) {
										alert(data.message);
										goList();
									},
									error : function(xhr, status, error) {
										console.log(error);
										alert('오류가 발생하였습니다. 다시 시도해주세요');
									}
								});
								$('#addForm').submit();
							}
						}
					}
					
					function fn_validation() {
						return true;
					}
				</script>
				
	         </div>
	         <!-- //content 끝 -->    
	    </div>  
	    <!-- //container 끝 -->
        
        <!-- footer 시작 -->
        <div id="footer"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" /></div>
        <!-- //footer 끝 -->
    </div>
    <!-- //전체 레이어 끝 -->
 </body>
</html>