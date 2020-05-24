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
		<h3><c:out value="${detail.title}"/></h3>
		<hr/>

		<form id="addForm" class="mt-5" method="post" enctype="multipart/form-data">
			<input type="hidden" name="masterId" value="${detail.id}" />
			<input type="hidden" name="saveState" id="saveState" value="0" />
			
			<div class="form-row">
				<div class="form-group col-md-6">
					<label>아이디</label> 
					<input type="text" class="form-control" name="reqUserId" id="reqUserId" value="${user.username}" readonly="readonly">
				</div>
				<div class="form-group col-md-6">
					<label for="reqName">이름</label>
					<c:choose>
						<c:when test="${not empty saveEventRequest}">
							<input type="text" class="form-control" name="reqName" id="reqName" value="<c:out value="${saveEventRequest.reqName}"/>">
						</c:when>
						<c:otherwise>
							<input type="text" class="form-control" name="reqName" id="reqName" value="${user.egovUserVO.name}">
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			<div class="form-row">
				<div class="form-group col-md-6">
					<label for="reqPhone">휴대폰</label>
					<input type="text" class="form-control" name="reqPhone" id="reqPhone" value="<c:out value="${saveEventRequest.reqPhone}"/>">
				</div>
				<div class="form-group col-md-6">
					<label for="reqEmail">이메일</label> 
					<input type="text" class="form-control" name="reqEmail" id="reqEmail" value="<c:out value="${saveEventRequest.reqEmail}"/>">
				</div>
			</div>
			<div class="form-group">
				<label for="reqIntroduction">소개</label> 
				<textarea class="form-control" name="reqIntroduction" id="reqIntroduction" rows="10" cols="150"><c:out value="${saveEventRequest.reqIntroduction}"/></textarea>
			</div>
			<div class="form-group">
				<label>첨부파일</label>
				<input type="file" name="atchFile" id="atchFile" class="form-control" />
				<c:if test="${not empty atchFiles and fn:length(atchFiles) > 0}">
					<input type="hidden" name="atchFileId" value="<c:out value="${saveEventRequest.atchFileId}"/>" />
					<a href="/cmm/fms/FileDown.do?atchFileId=${atchFiles[0].atchFileId}&fileSn=${atchFiles[0].fileSn}"><c:out value="${atchFiles[0].orignlFileNm}"/></a>
				</c:if>
			</div>
			
			<h4 class="text-center mt-5 mb-4">참여자 명단</h4>
			<div class="reqMemberSection">
				<c:choose>
					<c:when test="${not empty saveEventRequestMemberList}">
						<c:forEach var="member" items="${saveEventRequestMemberList}">
							<div class="participantSection form-row">
								<div class="form-group col-md-6">
									<label for="name">이름</label>
									<input type="text" class="form-control memberName" name="name" value="<c:out value="${member.name}"/>">
								</div>
								<div class="form-group col-md-6">
									<label for="age">나이</label>
									<input type="text" class="form-control" name="age" value="<c:out value="${member.age}"/>">
								</div>
							</div>
						</c:forEach>
						<c:if test="${fn:length(saveEventRequestMemberList) < numberOfApplicablePeople}">
							<c:forEach begin="1" end="${numberOfApplicablePeople - fn:length(saveEventRequestMemberList)}">
								<div class="participantSection form-row">
									<div class="form-group col-md-6">
										<label for="name">이름</label>
										<input type="text" class="form-control memberName" name="name">
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
						<c:forEach begin="1" end="${numberOfApplicablePeople}">
							<div class="participantSection form-row">
								<div class="form-group col-md-6">
									<label for="name">이름</label>
									<input type="text" class="form-control memberName" name="name">
								</div>
								<div class="form-group col-md-6">
									<label for="age">나이</label>
									<input type="text" class="form-control" name="age">
								</div>
							</div>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</div>
			
			<!-- <div class="d-flex justify-content-center">
				<input type="button" class="btn btn-outline-success btn-lg mt-3" id="appendParticipantBtn" value="추가" />
			</div> -->
			
			<div class="d-flex justify-content-center my-5">
				<a href="#this" class="btn btn-dark btn-lg mr-2" id="saveBtn">임시저장</a>
				<a href="#this" class="btn btn-danger btn-lg mr-2" id="addBtn">등록</a>
				<a href="/front/eventprogram/list.do?pageIndex=${searchVO.pageIndex}" class="btn btn-secondary btn-lg">목록</a>
			</div>			
		</form>
	</div>
	
	<script type="text/javascript">
		$(function() {
			<c:if test="${not empty saveEventRequest}">
				alert("임시 저장된 데이터가 있습니다.");
			</c:if>
			
			$("#appendParticipantBtn").on("click", function() {
				var reqtimeMaxPersonNumber = '${detail.reqtimeMaxPersonNumber}';
				var participantSectionLength = $(".participantSection").length;
				
				if(reqtimeMaxPersonNumber <= participantSectionLength) {
					alert("더이상 추가할 수 없습니다.");
					return;
				}
				appendParticipant();
			});
			
			$("#saveBtn").on("click", function() {
				$("#saveState").val("0");
				submit("0");
			});
			
			$("#addBtn").on("click", function() {
				$("#saveState").val("1");
				submit("1");
			});
		});
		
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
		
		function submit(gubun) {
			if(!fn_isErrorValidation()) {
				if(confirm("등록 하시겠습니까?")) {
					// participantSection 부분 name 변경
					$(".participantSection").each(function(i, e) {
						$(e).find("input[name='name']").attr("name", "memberVOList[" + i + "].name");
						$(e).find("input[name='age']").attr("name", "memberVOList[" + i + "].age");
					});
					
					$('#addForm').ajaxForm({
						type: 'post',
						url: '<c:url value="/front/eventprogram/request/addApi.do"/>',
						enctype : 'multipart/form-data',
						dataType: 'json',
						success: function(data) {
							alert(data.message);
							if(gubun == "1") {
								location.href = '<c:url value="/front/eventprogram/list.do"/>';
							}
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
		
		function fn_isErrorValidation() {
			var result = false;
			
			if(fn_isZeroWriteMember()) {
				alert("참가자 명단을 입력해주세요");
				$(".reqMemberSection").focus();
				result = true;
			}
			
			var excessObj = fn_isExceededReqMember();
			if(excessObj.isExcess) {
				alert(excessObj.message);
				result = true;
			}
			
			return result;
		}
		
		function fn_isZeroWriteMember() {
			var writeMemberCount = 0;
			$(".reqMemberSection .memberName").each(function(i, e) {
				if($(e).val()) {
					writeMemberCount++;
				}
			});
			return writeMemberCount == 0 ? true : false;
		}
		
		function fn_isExceededReqMember() {
			var result = {isExcess: false, message: ""};
			var masterId = '${detail.id}';
			var firstComeYn = '${detail.firstComeYn}';
			
			// 선착순일경우 참여가능인원수 확인
			if(firstComeYn == 'Y') {
				$.ajax({
					type: 'get',
					url: '<c:url value="/front/eventprogram/request/getNumberOfRequestableMemberApi.do"/>',
					data: {id: masterId},
					dataType: 'json',
					async: false,
					success: function(data) {
						//console.log(data);
						var writeMemberCount = 0;
						$(".reqMemberSection .memberName").each(function(i, e) {
							if($(e).val()) {
								writeMemberCount++;
							}
						});
						if(data == 0) {
							result.isExcess = true;
							result.message = "첩수가 마감되었습니다.";
						}
						else if(data < writeMemberCount) {
							result.isExcess = true;
							result.message = "참여할 수 있는 인원을 넘었습니다.(참여가능인원 : " + data + ")";
						}
					},
					error: function(request, xhr, error) {
						console.log(error);
					}
				});
			}
			return result;
		}
	</script>
</body>
</html>