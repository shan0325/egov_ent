<%--
  Class Name : EgovMenuManage.jsp
  Description : 메뉴관리 조회 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.03.10    이용             최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 이용
    since    : 2009.03.10
--%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
  /* Image Path 설정 */
  String imagePath_icon   = "/images/egovframework/sym/mpm/icon";
  String imagePath_button = "/images/egovframework/sym/mpm/button";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Language" content="ko" >
	<link href="<c:url value='/'/>css/common.css" rel="stylesheet" type="text/css" >
	
	<title>메뉴관리리스트</title>
	<style type="text/css">
	    h1 {font-size:12px;}
	    caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}
	</style>
	<script language="javascript1.2" type="text/javaScript">
	
	</script>
	
	<script type="text/javascript" src="<c:url value='/zTree_v3-master/js/jquery.ztree.core.js'/>"></script>
	<link rel="stylesheet" type="text/css" href="/zTree_v3-master/css/zTreeStyle/zTreeStyle.css"/>

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
				<div id="cur_loc" class="clearfix">
				    <div id="cur_loc_align">
				        <ul>
				            <li>HOME</li>
				            <li>&gt;</li>
				            <li>내부시스템관리</li>
				            <li>&gt;</li>
				            <li>메뉴관리</li>
				            <li>&gt;</li>
				            <li><strong>메뉴목록관리</strong></li>
				        </ul>
				    </div>
				</div>
				
				<div class="row pt-3">
				    <div class="col-4">
				    	<div class="border mb-3">
				    		<div class="pt-3 pl-3">
					    		<button type="button" class="btn btn-primary" onclick="addFormInit();">추가</button>
					    	</div>
					    	<div class="clearfix">
								<ul id="tree" class="ztree float-left p-3 mb-3"></ul>
							</div>
						</div>
				    </div>
				    <div class="col-8">
				    	<form id="menuForm" style="display: none;">
				    		<h3 id="title">수정</h3>
				    		<div class="form-row">
				    			<div class="form-group col-md-6">
							      <label for="inputPassword4">메뉴번호</label>
							      <input type="text" class="form-control" name="menuNo" id="menuNo">
							    </div>
							    <div class="form-group col-md-6">
							      <label for="inputEmail4">상위메뉴번호</label>
							      <input type="text" class="form-control" name="upperMenuId" id="upperMenuId">
							    </div>
							</div>
							<div class="form-row">
							    <div class="form-group col-md-6">
							      <label for="inputEmail4">메뉴명</label>
							      <input type="text" class="form-control" name="menuNm" id="menuNm">
							    </div>
							    <div class="form-group col-md-6">
							      <label for="progrmFileNm">프로그램파일명</label>
							      <select name="progrmFileNm" id="progrmFileNm" class="form-control">
							      	<c:forEach var="list" items="${progrmList}">
							      		<option value="${list.progrmFileNm}"><c:out value="${list.progrmFileNm}"/>(<c:out value="${list.progrmKoreanNm}"/>)</option>
							      	</c:forEach>
							      </select>
							      <!-- <input type="text" class="form-control" name="progrmFileNm" id="progrmFileNm"> -->
							    </div>
							</div>
							<div class="form-row">
							    <div class="form-group col-md-6">
							      <label for="inputPassword4">메뉴순서</label>
							      <input type="text" class="form-control" name="menuOrdr" id="menuOrdr">
							    </div>
							    <div class="form-group col-md-6">
							      <label for="inputEmail4">메뉴설명</label>
							      <input type="text" class="form-control" name="menuDc" id="menuDc">
							    </div>
							</div>
							<div class="form-row">
							    <div class="form-group col-md-6">
							      <label for="inputEmail4">관련이미지명</label>
							      <input type="text" class="form-control" name="relateImageNm" id="relateImageNm">
							    </div>
							    <div class="form-group col-md-6">
							      <label for="inputPassword4">관련이미지경로</label>
							      <input type="text" class="form-control" name="relateImagePath" id="relateImagePath">
							    </div>
							</div>
						  	<button type="button" id="modBtn" class="btn btn-primary" style="display: none;" onclick="modSubmit();">수정</button>
						  	<button type="button" id="delBtn" class="btn btn-danger" style="display: none;" onclick="delSubmit();">삭제</button>
						  	<button type="button" id="addBtn" class="btn btn-primary" style="display: none;" onclick="addSubmit();">등록</button>
						</form>
				    </div>
				</div>
				
				<script>
					$(document).ready(function() {
						selectList();
				   });
					
					function selectList() {
						$.ajax({
							type: "get",
							url: "<c:url value='/sym/mnu/mpm/EgovMenuManageSelectApi.do'/>",
							data: {},
							dataType: "json",
							success: function(data) {
								//console.log(data);
								var zNodes = [];
							  	if(data && data.length > 0) {
									for(i = 0; i < data.length; i++) {
										zNodes[i] = {
											id: data[i].menuNo,
											pId: data[i].upperMenuNo,
											name: data[i].menuNm + "[" + data[i].menuNo + "]",
											open: true
										};
									}
							  	}
							  	//console.log(zNodes);
							  	createTree(zNodes);
							}, 
							error: function(xhr, status, error) {
								console.log(status);
							}
					   });
					}
					
					function createTree(zNodes) {
						// zTree 설정 
					    var setting = {
					        data: {
					            simpleData: {
					                enable: true
					            }
					        },
					        callback: {
					        	beforeClick: beforeClick
					        }
					    };
						
					    $.fn.zTree.init($("#tree"), setting, zNodes);
					}
					
					function beforeClick(treeId, treeNode, clickFlag) {
				        $.ajax({
				        	type: "get",
				        	url: "<c:url value='/sym/mnu/mpm/selectMenuManageDetailApi.do'/>",
				        	data: {req_menuNo: treeNode.id},
				        	dataType: "json",
				        	success: function(data) {
				        		//console.log(data);
				        		if(data) {
				        			$("#upperMenuId").val(data.upperMenuId);
				        			$("#menuNo").val(data.menuNo);
				        			$("#menuNm").val(data.menuNm);
				        			$("#progrmFileNm").val(data.progrmFileNm);
				        			$("#menuOrdr").val(data.menuOrdr);
				        			$("#menuDc").val(data.menuDc);
				        			$("#relateImageNm").val(data.relateImageNm);
				        			$("#relateImagePath").val(data.relateImagePath);
				        			modFormInit();
				        		}
				        	},
				        	error: function(xhr, status, error) {
				        		console.log(status);
				        	}
				        });
				    }
					
					function modSubmit() {
						var queryString = $("#menuForm").serialize();
						$.ajax({
							type: "post",
							url: "<c:url value='/sym/mnu/mpm/EgovMenuDetailUpdtApi.do'/>",
							data: queryString,
							dataType: "json",
							success: function(data) {
								alert(data.message);
								selectList();
							},
							error: function(xhr, status, error) {
								console.log(status);
							}
						});
					}
					
					function modFormInit() {
	        			$("#menuForm").show();
						$("#menuNo").prop("readonly", true);
	        			$("#modBtn").show();
	        			$("#delBtn").show();
	        			$("#addBtn").hide();
	        			$("#title").text("수정");
					}
					
					function addFormInit() {
	        			$("#menuForm")[0].reset();
	        			$("#menuForm").show();
	        			$("#menuNo").prop("readonly", false);
	        			$("#modBtn").hide();
	        			$("#delBtn").hide();
	        			$("#addBtn").show();
	        			$("#title").text("추가");
					}
					
					function addSubmit() {
						var queryString = $("#menuForm").serialize();
						$.ajax({
							type: "post",
							url: "<c:url value='/sym/mnu/mpm/EgovMenuRegistInsertApi.do'/>",
							data: queryString,
							dataType: "json",
							success: function(data) {
								alert(data.message);
								selectList();
								$("#menuForm")[0].reset();
			        			$("#menuForm").hide();
							},
							error: function(xhr, status, error) {
								console.log(error);
							}
						});
					}
					
					function delSubmit() {
						if(confirm("정말로 삭제 하시겠습니까?")) {
							var queryString = $("#menuForm").serialize();
							$.ajax({
								type: "post",
								url: "<c:url value='/sym/mnu/mpm/EgovMenuManageDeleteApi.do'/>",
								data: queryString,
								dataType: "json",
								success: function(data) {
									alert(data.message);
									window.location.href = " <c:out value="/sym/mnu/mpm/EgovMenuManageSelectTree.do"/>";
								},
								error: function(xhr, status, error) {
									console.log(error);
								}
							});
						}
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