<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
				
				<h3>행사프로그램신청관리</h3>

				<form name="searchForm" id="searchForm" class="form-inline justify-content-end">
					<input type="hidden" name="pageIndex" value="<c:out value="${searchVO.pageIndex}"/>" />
					<input type="hidden" name="pageUnit" value="<c:out value="${searchVO.pageUnit}"/>" />
					
					<div class="form-group mb-2">
						<select name="searchCondition" class="form-control">
							<option value="1" ${searchVO.searchCondition eq 1 ? 'selected' : ''}>프로그램명</option>
							<option value="2" ${searchVO.searchCondition eq 2 ? 'selected' : ''}>프로그램아이디</option>
							<option value="3" ${searchVO.searchCondition eq 3 ? 'selected' : ''}>아이디</option>
							<option value="4" ${searchVO.searchCondition eq 4 ? 'selected' : ''}>이름</option>
						</select>
					</div>
					<div class="form-group mx-sm-3 mb-2">
						<input type="text" name="searchKeyword" class="form-control" value="<c:out value="${searchVO.searchKeyword}"/>" />
					</div>
					<button type="button" class="btn btn-info mb-2" id="searchBtn">검색</button>
				</form>
				
				<table class="table">
					<colgroup>
						<col width="5%" />
						<col width="*" />
						<col width="15%" />
						<col width="15%" />
						<col width="15%" />
						<col width="5%" />
						<col width="10%" />
						<col width="5%" />
						<col width="5%" />
					</colgroup>
				  <thead>
				    <tr>
				      <th scope="col">순서</th>
				      <th scope="col">프로그램명</th>
				      <th scope="col">아이디</th>
				      <th scope="col">이름</th>
				      <th scope="col">휴대폰</th>
				      <th scope="col">참여자수</th>
				      <th scope="col">등록일</th>
				      <th scope="col">저장구분</th>
				      <th scope="col">신청상태</th>
				    </tr>
				  </thead>
				  <tbody>
				  	<c:choose>
				  	<c:when test="${not empty list and fn:length(list) > 0}">
				  		<c:forEach var="obj" items="${list}" varStatus="status">
					    <tr>
					      <th scope="row">${paginationInfo.totalRecordCount - ((paginationInfo.currentPageNo - 1) * paginationInfo.recordCountPerPage) - status.index}</th>
					      <td><a href="#" onclick="updateView(${obj.id}); return false;"><c:out value="${obj.title}"/></a></td>
					      <td><c:out value="${obj.reqUserId}"/></td>
					      <td><c:out value="${obj.reqName}"/></td>
					      <td><c:out value="${obj.reqPhone}"/></td>
					      <td><c:out value="${obj.memberCnt}"/></td>
					      <td><c:out value="${obj.regDate}"/></td>
					      <td>
					      	<c:if test="${obj.saveState eq '0'}">
								<span class="badge badge-primary">임시저장</span>					      	
					      	</c:if>
					      	<c:if test="${obj.saveState eq '1'}">
					      		<span class="badge badge-success">저장완료</span>
					      	</c:if>
					      </td>
					      <td>
					      	<c:if test="${obj.requestState eq '0'}">
					      		<span class="badge badge-primary">대기</span>	
					      	</c:if>
					      	<c:if test="${obj.requestState eq '1'}">
					      		<span class="badge badge-success">승인</span>	
					      	</c:if>
					      	<c:if test="${obj.requestState eq '2'}">
					      		<span class="badge badge-danger">취소</span>	
					      	</c:if>
					      </td>
					    </tr>
					  	</c:forEach>
				  	</c:when>
				  	<c:otherwise>
				  		<tr>
				  			<td colspan="9">내용이 없습니다.</td>
				  		</tr>
				  	</c:otherwise>
				  	</c:choose>
				  	
				  </tbody>
				</table>
                
                <!-- 페이지 네비게이션 시작 -->
		        <nav aria-label="Page navigation example">
		            <ul class="pagination justify-content-center">
		                <ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="linkPage"/>
		            </ul>
		        </nav>
		        <!-- //페이지 네비게이션 끝 -->  
				
				<script type="text/javascript">
					$(document).ready(function() {
						$('#searchBtn').on('click', function() {
							linkPage('1');
						});
					});
					
					function linkPage(page) {
						$('#searchForm input[name="pageIndex"]').val(page);
						$('#searchForm').attr('action', '<c:url value="/let/eventprogram/request/listView.do"/>');
						$('#searchForm').submit();
					}
					function updateView(id) {
						var url = '${pageContext.request.contextPath}/let/eventprogram/request/updateView.do';
						
						$("#searchForm").append('<input type="hidden" name="id" value="' + id + '"/>');
						$("#searchForm").attr("method", "get");
						$("#searchForm").attr("action", url);
						$("#searchForm").submit();
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