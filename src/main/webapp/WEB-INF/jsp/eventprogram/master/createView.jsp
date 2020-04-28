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
	
	<title>행사프로그램관리</title>
	
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
				            <li><strong>행사프로그램관리</strong></li>
				        </ul>
				    </div>
				</div>
				
				<h3>행사프로그램관리 등록</h3>
				<form id="eventProgramMasterForm">
					<input type="hidden" name="id" value="${detail.id}"/>
					<input type="hidden" name="startDate" id="startDate" />
					<input type="hidden" name="endDate" id="endDate" />
					<input type="hidden" name="reqStartDate" id="reqStartDate" />
					<input type="hidden" name="reqEndDate" id="reqEndDate" />

					<div class="form-row">
						<div class="form-group col-md-3">
							<label for="gubun">구분</label> <select name="gubun" class="form-control">
								<c:forEach var="code" items="${gubunCodeList}">
									<option value="${code.code}" ${code.code eq detail.gubun ? 'selected' : ''}>${code.codeNm}</option>
								</c:forEach>
							</select>
						</div>
					</div>
					<div class="form-row">
						<div class="form-group col-md-6">
							<label for="title">프로그램명</label> 
							<input type="text" name="title" class="form-control" id="title" maxlength="200" value="<c:out value="${detail.title}"/>">
						</div>
					</div>
					<div class="form-row">
						<div class="form-group col-md-6">
							<label for="content">내용</label>
							<textarea name="content" class="form-control" rows="5"><c:out value="${detail.content}" /></textarea>
						</div>
					</div>
					<div class="form-row">
						<div class="form-group col-md-6">
							<label for="mainImg">메인 이미지</label>
							<input type="file" class="form-control" name="mainImg" id="mainImg" />
							<input type="hidden" name="mainImgAtchFileId" value="${detail.mainImgAtchFileId}" />
							<div>
							<c:if test="${not empty mainImgs}">
								<c:forEach var="mainImg" items="${mainImgs}">
									<div class="pt-2">
										<img alt="메인 이미지" src="/cmm/fms/getImage.do?atchFileId=${mainImg.atchFileId}&fileSn=${mainImg.fileSn}" width="200">
										<br/>
										<c:out value="${mainImg.orignlFileNm}"/>
										<input type="checkbox" name="delMainImgFileSn" value="${mainImg.fileSn}" />[삭제]
									</div>
								</c:forEach>
							</c:if>
							</div>
						</div>
					</div>
					<div class="form-row">
						<div class="form-group col-md-1">
							<label for="startDateYmd">프로그램 시작일</label>
							<fmt:parseDate var="startDate" value="${detail.startDate}" pattern="yyyy-MM-dd HH:mm" />
							<fmt:formatDate var="startTime" value="${startDate}" pattern="HH" />
							<fmt:formatDate var="startMinute" value="${startDate}" pattern="mm" />
							<input type="text" name="startDateYmd" class="form-control datePicker" id="startDateYmd" readonly="readonly" value="<fmt:formatDate value="${startDate}" pattern="yyyy-MM-dd"/>">
						</div>
						<div class="form-group col-md-1">
							<label for="startTime">시간</label> <select name="startTime" class="form-control" id="startTime">
								<c:forEach var="time" begin="0" end="23">
									<fmt:formatNumber var="time" minIntegerDigits="2" value="${time}" type="number" />
									<option value="${time}" ${time eq startTime ? 'selected' : ''}>${time}</option>
								</c:forEach>
							</select>
						</div>
						<div class="form-group col-md-1">
							<label for="startMinute">분</label> <select name="startMinute" class="form-control" id="startMinute">
								<c:forEach var="minute" begin="0" end="59">
									<fmt:formatNumber var="minute" minIntegerDigits="2" value="${minute}" type="number" />
									<option value="${minute}" ${minute eq startMinute ? 'selected' : ''}>${minute}</option>
								</c:forEach>
							</select>
						</div>
						<div class="form-group col-md-1">
							<label for="endDateYmd">프로그램 종료일</label>
							<fmt:parseDate var="endDate" value="${detail.endDate}" pattern="yyyy-MM-dd HH:mm" />
							<fmt:formatDate var="endTime" value="${endDate}" pattern="HH" />
							<fmt:formatDate var="endMinute" value="${endDate}" pattern="mm" />
							<input type="text" name="endDateYmd" class="form-control datePicker" id="endDateYmd" readonly="readonly" value="<fmt:formatDate value="${endDate}" pattern="yyyy-MM-dd"/>">
						</div>
						<div class="form-group col-md-1">
							<label for="endTime">종료시간</label> <select name="endTime" class="form-control" id="endTime">
								<c:forEach var="time" begin="0" end="23">
									<fmt:formatNumber var="time" minIntegerDigits="2" value="${time}" type="number" />
									<option value="${time}" ${time eq endTime ? 'selected' : ''}>${time}</option>
								</c:forEach>
							</select>
						</div>
						<div class="form-group col-md-1">
							<label for="endMinute">분</label> <select name="endMinute" class="form-control" id="endMinute">
								<c:forEach var="minute" begin="0" end="59">
									<fmt:formatNumber var="minute" minIntegerDigits="2" value="${minute}" type="number" />
									<option value="${minute}" ${minute eq endMinute ? 'selected' : ''}>${minute}</option>
								</c:forEach>
							</select>
						</div>
					</div>
				   <div class="form-row">
				    <div class="form-group col-md-1">
				      <label for="reqStartDateYmd">접수 시작일</label>
				      <fmt:parseDate var="reqStartDate" value="${detail.reqStartDate}" pattern="yyyy-MM-dd HH:mm"/>
				      <fmt:formatDate var="reqStartTime" value="${reqStartDate}" pattern="HH"/>
				      <fmt:formatDate var="reqStartMinute" value="${reqStartDate}" pattern="mm"/>
				      <input type="text" name="reqStartDateYmd" class="form-control datePicker" id="reqStartDateYmd" readonly="readonly" value="<fmt:formatDate value="${reqStartDate}" pattern="yyyy-MM-dd"/>">
				    </div>
				    <div class="form-group col-md-1">
				      <label for="reqStartTime">시작시간</label>
					  <select name="reqStartTime" class="form-control" id="reqStartTime">
					  	<c:forEach var="time" begin="0" end="23">
					  		<fmt:formatNumber var="time" minIntegerDigits="2" value="${time}" type="number"/>
					  		<option value="${time}" ${time eq reqStartTime ? 'selected' : ''}>${time}</option>
					  	</c:forEach>
					  </select>
				    </div>
				    <div class="form-group col-md-1">
				      <label for="reqStartMinute">분</label>
					  <select name="reqStartMinute" class="form-control" id="reqStartMinute">
					  	<c:forEach var="minute" begin="0" end="59">
					  		<fmt:formatNumber var="minute" minIntegerDigits="2" value="${minute}" type="number"/>
					  		<option value="${minute}" ${minute eq reqStartMinute ? 'selected' : ''}>${minute}</option>
					  	</c:forEach>
					  </select>
				    </div>
				    <div class="form-group col-md-1">
				      <label for="reqEndDateYmd">접수 종료일</label>
				      <fmt:parseDate var="reqEndDate" value="${detail.reqEndDate}" pattern="yyyy-MM-dd HH:mm"/>
				      <fmt:formatDate var="reqEndTime" value="${reqEndDate}" pattern="HH"/>
				      <fmt:formatDate var="reqEndMinute" value="${reqEndDate}" pattern="mm"/>
				      <input type="text" name="reqEndDateYmd" class="form-control datePicker" id="reqEndDateYmd" readonly="readonly" value="<fmt:formatDate value="${reqEndDate}" pattern="yyyy-MM-dd"/>">
				    </div>
				    <div class="form-group col-md-1">
				      <label for="reqEndTime">종료시간</label>
					  <select name="reqEndTime" class="form-control" id="reqEndTime">
					  	<c:forEach var="time" begin="0" end="23">
					  		<fmt:formatNumber var="time" minIntegerDigits="2" value="${time}" type="number"/>
					  		<option value="${time}" ${time eq reqEndTime ? 'selected' : ''}>${time}</option>
					  	</c:forEach>
					  </select>
				    </div>
				    <div class="form-group col-md-1">
				      <label for="reqEndMinute">분</label>
					  <select name="reqEndMinute" class="form-control" id="reqEndMinute">
					  	<c:forEach var="minute" begin="0" end="59">
					  		<fmt:formatNumber var="minute" minIntegerDigits="2" value="${minute}" type="number"/>
					  		<option value="${minute}" ${minute eq reqEndMinute ? 'selected' : ''}>${minute}</option>
					  	</c:forEach>
					  </select>
				    </div>
				  </div>
				  <div class="form-row">
				    <div class="form-group col-md-3">
				      <label for="reqMaxPersonNumber">신청자전체최대인원수</label>
				      <input type="text" name="reqMaxPersonNumber" class="form-control" id="reqMaxPersonNumber" max="5" value="<c:out value="${detail.reqMaxPersonNumber}"/>">
				    </div>
				    <div class="form-group col-md-3">
				      <label for="reqTimeMaxPersonNumber">신청시받을최대인원수</label>
				      <input type="text" name="reqtimeMaxPersonNumber" class="form-control" id="reqTimeMaxPersonNumber" maxlength="5" value="<c:out value="${detail.reqtimeMaxPersonNumber}"/>">
				    </div>
				  </div>
				  <div class="form-row">
				    <div class="form-group col-md-3">
				      <label for="host">주최</label>
				      <input type="text" name="host" class="form-control" id="host" maxlength="50" value="<c:out value="${detail.host}"/>">
				    </div>
				    <div class="form-group col-md-3">
				      <label for="location">위치</label>
				      <input type="text" name="location" class="form-control" id="location" maxlength="100" value="<c:out value="${detail.location}"/>">
				    </div>
				  </div>
				  <div class="form-row">
				    <div class="form-group col-md-3">
				      <label for="tel">전화번호</label>
				      <input type="text" name="tel" class="form-control" id="tel" maxlength="50" value="<c:out value="${detail.tel}"/>">
				    </div>
				    <div class="form-group col-md-3">
				      <label for="targetPerson">대상자</label>
				      <input type="text" name="targetPerson" class="form-control" id="targetPerson" maxlength="100" value="<c:out value="${detail.targetPersion}"/>">
				    </div>
				  </div>
				  <div class="form-row">
						<div class="form-group col-md-6">
							<label for="attachFile">첨부파일</label>
							<input type="file" class="form-control" name="attachFile" id="attachFile" />
							<input type="hidden" name="atchFileId" value="${detail.atchFileId}" />
							<div class="mt-2">
							<c:if test="${not empty atchFiles}">
								<c:forEach var="atchFile" items="${atchFiles}">
									<a href="/cmm/fms/FileDown.do?atchFileId=${atchFile.atchFileId}&fileSn=${atchFile.fileSn}"><c:out value="${atchFile.orignlFileNm}"/></a>
									<input type="checkbox" name="delAtchFileFileSn" value="${atchFile.fileSn}" />[삭제]
									<br/>
								</c:forEach>
							</c:if>
							</div>
						</div>
					</div>
				  <div class="form-row">
				  	<div class="form-group col-md-6">
				  		<div class="form-check form-check-inline">
				  			<c:choose>
				  				<c:when test="${not empty detail}">
									<input class="form-check-input" type="radio" name="useYn" id="useYnY" value="Y" ${detail.useYn eq 'Y' ? 'checked' : ''}>
						  			<label class="form-check-label" for="useYnY">사용</label>				  				
				  				</c:when>
				  				<c:otherwise>
				  					<input class="form-check-input" type="radio" name="useYn" id="useYnY" value="Y" checked="checked">
						  			<label class="form-check-label" for="useYnY">사용</label>	
				  				</c:otherwise>
				  			</c:choose>
						</div>
						<div class="form-check form-check-inline">
						  <input class="form-check-input" type="radio" name="useYn" id="useYnN" value="N" ${detail.useYn eq 'N' ? 'checked' : ''}>
						  <label class="form-check-label" for="useYnN">미사용</label>
						</div>
				  	</div>
				</div>		
				  <div class="form-row">
				    <div class="form-group col-md-6">
				      <ul class="nav justify-content-end mb-3">
				      	<c:choose>
				      		<c:when test="${not empty detail}">
				      			<li><button type="button" class="btn btn-primary mr-1" id="modBtn">수정</button></li>
				      		</c:when>
				      		<c:otherwise>
				      			<li><button type="button" class="btn btn-primary mr-1" id="addBtn">등록</button></li>
				      		</c:otherwise>
				      	</c:choose>
						  <li><button type="button" class="btn btn-secondary" id="listBtn">목록</button></li>
						</ul>
				    </div>
				  </div>
				</form>
				
				<script>
					$(document).ready(function() {
						$('#listBtn').on('click', function() {
							window.location.href = '<c:out value="/let/eventprogram/master/listView.do"/>';
						});
						
						$('#addBtn').on('click', function() {
							fn_addSubmit();
						});
						
						$('#modBtn').on('click', function() {
							fn_modSubmit();
						});
						
						function fn_modSubmit() {
							if(fn_validation()) {
								if(confirm("수정 하시겠습니까?")) {
									fn_prepareSubmit();
									
									$('#eventProgramMasterForm').ajaxForm({
										type: 'post',
										url: '<c:url value="/let/eventprogram/master/updateApi.do"/>',
										enctype : 'multipart/form-data',
										dataType: 'json',
										success: function(data) {
											alert(data.message);
											location.href = '<c:url value="/let/eventprogram/master/listView.do"/>';
										},
										error : function(xhr, status, error) {
											console.log(error);
											alert('오류가 발생하였습니다. 다시 시도해주세요');
										}
									});
									$('#eventProgramMasterForm').submit();
								}
							}
						}
						
						function fn_addSubmit() {
							if(fn_validation()) {
								if(confirm("등록 하시겠습니까?")) {
									fn_prepareSubmit();
									
									$('#eventProgramMasterForm').ajaxForm({
										type: 'post',
										url: '<c:url value="/let/eventprogram/master/createApi.do"/>',
										enctype : 'multipart/form-data',
										dataType: 'json',
										success: function(data) {
											alert(data.message);
											location.href = '<c:url value="/let/eventprogram/master/listView.do"/>';
										},
										error : function(xhr, status, error) {
											console.log(error);
											alert('오류가 발생하였습니다. 다시 시도해주세요');
										}
									});
									$('#eventProgramMasterForm').submit();
								}
							}
						}
						function fn_validation() {
							if(!$('#title').val()) {
								alert("프로그램명을 입력하세요");
								$('#title').focus();
								return false;
							}
							/* if(!$('#mainImg').val()) {
								alert("메인 이미지를 등록하세요");
								$('#mainImg').focus();
								return false;
							} */
							if(!$('#startDateYmd').val()) {
								alert("프로그램 시작일을 입력하세요");
								$('#startDateYmd').focus();
								return false;
							}
							if(!$('#endDateYmd').val()) {
								alert("프로그램 종료일을 입력하세요");
								$('#endDateYmd').focus();
								return false;
							}
							if(!$('#reqStartDateYmd').val()) {
								alert("접수 시작일을 입력하세요");
								$('#reqStartDateYmd').focus();
								return false;
							}
							if(!$('#reqEndDateYmd').val()) {
								alert("접수 종료일을 입력하세요");
								$('#reqEndDateYmd').focus();
								return false;
							}
							return true;
						}
						function fn_prepareSubmit() {
							var startDateYmd = $('#startDateYmd').val();
							var startTime = $('#startTime').val();
							var startMinute = $('#startMinute').val();
							$('#startDate').val(startDateYmd + ' ' + startTime + ':' + startMinute);
							
							var endDateYmd = $('#endDateYmd').val();
							var endTime = $('#endTime').val();
							var endMinute = $('#endMinute').val();
							$('#endDate').val(endDateYmd + ' ' + endTime + ":" + endMinute);
							
							var reqStartDateYmd = $('#reqStartDateYmd').val();
							var reqStartTime = $('#reqStartTime').val();
							var reqStartMinute = $('#reqStartMinute').val();
							$('#reqStartDate').val(reqStartDateYmd + ' ' + reqStartTime + ":" + reqStartMinute);
							
							var reqEndDateYmd = $('#reqEndDateYmd').val();
							var reqEndTime = $('#reqEndTime').val();
							var reqEndMinute = $('#reqEndMinute').val();
							$('#reqEndDate').val(reqEndDateYmd + ' ' + reqEndTime + ":" + reqEndMinute);
						}
					});
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