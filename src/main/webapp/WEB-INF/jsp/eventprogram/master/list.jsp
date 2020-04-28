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
				
				<h3>행사프로그램관리</h3>
				
				<form name="searchForm" id="searchForm" class="form-inline justify-content-end">
					<input type="hidden" name="pageIndex" value="<c:out value="${searchVO.pageIndex}"/>" />
					<input type="hidden" name="pageUnit" value="<c:out value="${searchVO.pageUnit}"/>" />
					
					<div class="form-group mb-2">
						<select name="searchCondition" class="form-control">
							<option value="1" ${searchVO.searchCondition eq 1 ? 'selected' : ''}>프로그램구분</option>
							<option value="2" ${searchVO.searchCondition eq 2 ? 'selected' : ''}>프로그램명</option>
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
						<col width="10%" />
						<col width="*" />
						<col width="15%" />
						<col width="15%" />
						<col width="10%" />
						<col width="5%" />
					</colgroup>
				  <thead>
				    <tr>
				      <th scope="col">순서</th>
				      <th scope="col">프로그램구분</th>
				      <th scope="col">프로그램명</th>
				      <th scope="col">프로그램기간</th>
				      <th scope="col">접수기간</th>
				      <th scope="col">등록일시</th>
				      <th scope="col">사용여부</th>
				    </tr>
				  </thead>
				  <tbody>
				  	<c:choose>
				  	<c:when test="${not empty list and fn:length(list) > 0}">
				  		<c:forEach var="obj" items="${list}" varStatus="status">
					    <tr>
					      <th scope="row">${paginationInfo.totalRecordCount - ((paginationInfo.currentPageNo - 1) * paginationInfo.recordCountPerPage) - status.index}</th>
					      <td><c:out value="${obj.gubunName}"/></td>
					      <td><a href="#" onclick="updateView(${obj.id}); return false;"><c:out value="${obj.title}"/></a></td>
					      <td><c:out value="${obj.startDate}"/> ~ <c:out value="${obj.endDate}"/></td>
					      <td><c:out value="${obj.reqStartDate}"/> ~ <c:out value="${obj.reqEndDate}"/></td>
					      <td><c:out value="${obj.regDate}"/></td>
					      <td><c:out value="${obj.useYn}"/></td>
					    </tr>
					  	</c:forEach>
				  	</c:when>
				  	<c:otherwise>
				  		<tr>
				  			<td colspan="6">내용이 없습니다.</td>
				  		</tr>
				  	</c:otherwise>
				  	</c:choose>
				  	
				  </tbody>
				</table>
				
				<ul class="nav justify-content-end">
				  <li><button type="button" class="btn btn-primary" id="addBtn">등록</button></li>
				</ul>
                
                <!-- 페이지 네비게이션 시작 -->
		        <nav aria-label="Page navigation example">
		            <ul class="pagination justify-content-center">
		                <ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="linkPage"/>
		            </ul>
		        </nav>
		        <!-- //페이지 네비게이션 끝 -->  
				
				<script type="text/javascript">
					$(document).ready(function() {
						$('#addBtn').on('click', function() {
							window.location.href = '<c:out value="/let/eventprogram/master/createView.do"/>';
						});
						
						$('#searchBtn').on('click', function() {
							linkPage('1');
						});
					});
					
					function linkPage(page) {
						$('#searchForm input[name="pageIndex"]').val(page);
						$('#searchForm').attr('action', '<c:url value="/let/eventprogram/master/listView.do"/>');
						$('#searchForm').submit();
					}
					function updateView(id) {
						var url = '${pageContext.request.contextPath}/let/eventprogram/master/updateView.do?id=' + id;
						window.location.href = url;
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