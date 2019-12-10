<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>

		<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
		<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
		<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
		<%@ page import="java.util.List,com.sanguine.model.clsTreeMasterModel"%>
		<%-- <%@ taglib prefix="tab" uri="http://ditchnet.org/jsp-tabs-taglib"%> --%>

<html>
<head>
<style>
</style>
	    <link rel="icon" href="${pageContext.request.contextPath}/resources/images/favicon.ico" type="image/x-icon" sizes="16x16">
	    <link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/newdesigncss/bootstrap.grid.css"/>" />
		<link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/newdesigncss/bootstrap.grid.min.css"/>" />
		<link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/newdesigncss/bootstrap.css"/>" /> 
		<link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/design.css"/>" />
		<link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/styles/materialdesignicons.min.css"/>" />
		<%-- <script type="text/javascript" src="<spring:url value="/resources/js/bootstrap.min.js"/>"></script>
		<link rel="stylesheet"  href="<spring:url value="/resources/css/bootstrap.min.css"/>" /> --%>
		<script type="text/javascript" src="<spring:url value="/resources/js/newdesignjs/bootstrap.bundle.js"/>"></script>
		<script type="text/javascript" src="<spring:url value="/resources/js/newdesignjs/bootstrap.bundle.min.js"/>"></script>
		<script type="text/javascript" src="<spring:url value="/resources/js/newdesignjs/bootstrap.js"/>"></script>
		<script type="text/javascript" src="<spring:url value="/resources/js/newdesignjs/bootstrap.min.js"/>"></script>
	<script type="text/javascript">
		var cntrlIsPressed = false;
		
		
		$(document).keydown(function(event){
		    if(event.which=="17")
		        cntrlIsPressed = true;
		});
		
		$(document).keyup(function(){
		    cntrlIsPressed = false;
		});
		
		function selectMe(mouseButton)
		{
			//alert(mouseButton);
			var _href = $(mouseButton).attr("href");
			
			//$(mouseButton).attr("href", _href + '?saddr=50.1234567,-50.03452');
			var split=_href.split("=");
			
			_href=split[0]+"=1" ;
			$(mouseButton).attr("href", _href);
			
		    if(cntrlIsPressed)
		    {
		    	var split1=_href.split("=");
		    
		    	_href=split1[0];
		    	$(mouseButton).attr("href", _href + '=2');
		    	cntrlIsPressed=false;
		    }
		    cntrlIsPressed=false;
		
		   
		}
		
		function onContextClick(mouseButton){
			var _href = $(mouseButton).attr("href");
			
			//$(mouseButton).attr("href", _href + '?saddr=50.1234567,-50.03452');
			var split=_href.split("=");
			
			_href=split[0]+"=1" ;
			$(mouseButton).attr("href", _href);
			
			var split1=_href.split("=");
		    
			_href=split1[0];
			$(mouseButton).attr("href", _href + '=2');		
		}
		
		
	</script>
</head>

<body onload="">
	        <div class="app-sidebar">
        		<ul class="side-menu" id="tree">
        			<c:forEach items="${treeMap}" var="draw1" varStatus="status1">
        				<li>
        				  <a href="#" class="link">
			             	 <i class="mdi mdi-source-fork rotate"></i>
			             	 	<div class="link-text">${draw1.key}</div>
			           	 </a>
			              	<div class="submenu">
			           			<c:forEach items="${draw1.value}" var="draw2" varStatus="status2">
								<c:forEach items="${draw2.value}" var="draw3" varStatus="status3">
								<c:if test="${draw3.key=='Parent'}">
									<a href="${draw3.value.strRequestMapping}?saddr=1" id="${draw3.value.strRequestMapping}" onclick="selectMe(this)" oncontextmenu="onContextClick(this)"
			 							title='${draw3.value.strFormDesc}'>${draw3.value.strFormDesc}</a>
							
								</c:if>
								<c:if test="${draw3.key !='Parent'}">
									${draw3.key}
								<c:forEach items="${draw3.value}" var="draw4" varStatus="status4">
							 	<a href="${draw4.strRequestMapping}?saddr=1" id="${draw4.strRequestMapping}" onclick="selectMe(this)" oncontextmenu="onContextClick(this)"
			 									title='${draw4.strFormDesc}'>${draw4.strFormDesc}</a>
								</c:forEach>
								</c:if>
								</c:forEach>
								</c:forEach>
			           
				        	</div>
        				</li>
        			</c:forEach>
        		</ul>     
			 </div>
			 <script>
		window.onscroll = function() {myFunction()};
		
		var sidebar = document.getElementsByClassName("app-sidebar");
		var sticky = header.offsetTop;
		
		function myFunction() {
		  if (window.pageYOffset > sticky) {
			  sidebar.classList.add("sticky");
		  } else {
			  sidebar.classList.remove("sticky");
		  }
		}
		</script>
</body>
</html>