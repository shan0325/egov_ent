<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

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
		<form name="searchForm" id="searchForm" class="form-inline justify-content-center my-5">
			<input type="hidden" name="pageIndex" value="<c:out value="${searchVO.pageIndex}"/>" />
			
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

		<div class="row row-cols-1 row-cols-md-3">
			<c:if test="${not empty list and fn:length(list) > 0}">
				<c:forEach var="obj" items="${list}" varStatus="status">
					<div class="col mb-4">
						<a href="${pageContext.request.contextPath}/front/eventprogram/detailView.do?id=${obj.id}&pageIndex=${searchVO.pageIndex}">
						<div class="card h-100">
							<c:if test="${not empty obj.mainImgAtchFileId and not empty obj.fileSn}">
					      		<img class="card-img-top" src="/cmm/fms/getImage.do?atchFileId=${obj.mainImgAtchFileId}&amp;fileSn=${obj.fileSn}" alt="메인 이미지" height="300"/>
					      	</c:if>
							<div class="card-body">
								<c:choose>
									<c:when test="${obj.status eq '0'}">
										<span class="badge badge-pill badge-warning">진행전</span>
									</c:when>
									<c:when test="${obj.status eq '2' or obj.status eq '3'}">
										<span class="badge badge-pill badge-secondary">마감</span>
									</c:when>
									<c:otherwise>
										<span class="badge badge-pill badge-success">
											접수중<c:if test="${obj.firstComeYn eq 'Y'}"> (선착순)</c:if>
										</span>
									</c:otherwise>
								</c:choose>
								<p class="card-text mt-3"><c:out value="${obj.title}"/></p>
							</div>
						</div>
						</a>
					</div>
				</c:forEach>
			</c:if>
		</div>

		<%-- <table class="table">
			<colgroup>
				<col width="7%" />
				<col width="10%" />
				<col width="*" />
				<col width="15%" />
				<col width="15%" />
				<col width="10%" />
			</colgroup>
		  <thead>
		    <tr>
		      <th scope="col">순서</th>
		      <th scope="col">구분</th>
		      <th scope="col">프로그램명</th>
		      <th scope="col">프로그램기간</th>
		      <th scope="col">접수기간</th>
		      <th scope="col">등록일시</th>
		    </tr>
		  </thead>
		  <tbody>
		  	<c:choose>
		  	<c:when test="${not empty list and fn:length(list) > 0}">
		  		<c:forEach var="obj" items="${list}" varStatus="status">
			    <tr>
			      <th scope="row">${paginationInfo.totalRecordCount - ((paginationInfo.currentPageNo - 1) * paginationInfo.recordCountPerPage) - status.index}</th>
			      <td><c:out value="${obj.gubunName}"/></td>
			      <td>
			      	<a href="#" onclick="updateView(${obj.id}); return false;"><c:out value="${obj.title}"/></a>
			      	<c:if test="${not empty obj.mainImgAtchFileId and not empty obj.fileSn}">
			      		<img alt="메인 이미지" src="/cmm/fms/getImage.do?atchFileId=${obj.mainImgAtchFileId}&amp;fileSn=${obj.fileSn}" width="200">
			      	</c:if>
			      </td>
			      <td><c:out value="${obj.startDate}"/> ~ <c:out value="${obj.endDate}"/></td>
			      <td><c:out value="${obj.reqStartDate}"/> ~ <c:out value="${obj.reqEndDate}"/></td>
			      <td><c:out value="${obj.regDate}"/></td>
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
		</table> --%>
		
		<!-- 페이지 네비게이션 시작 -->
        <nav aria-label="Page navigation example">
            <ul class="pagination justify-content-center">
                <ui:pagination paginationInfo = "${paginationInfo}" type="bootStrap" jsFunction="linkPage"/>
            </ul>
        </nav>
        <!-- //페이지 네비게이션 끝 -->
	</div>
	
	<script type="text/javascript">
		$(document).ready(function() {
			$('#searchBtn').on('click', function() {
				linkPage('1');
			});
		});
		
		function linkPage(page) {
			$('#searchForm input[name="pageIndex"]').val(page);
			$('#searchForm').attr("method", "get");
			$('#searchForm').attr('action', '<c:url value="/front/eventprogram/list.do"/>');
			$('#searchForm').submit();
		}
	</script>
</body>
</html>