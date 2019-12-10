<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title></title>
		<%-- <link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/newdesigncss/materialdesignicons.min.css"/>" />
	  	<link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/newdesigncss/bootstrap.css"/>" /> --%>
		<link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/newdesigncss/bootstrap.min.css"/>" />
	 	<%-- <link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/newdesigncss/bootstrap-grid.css"/>" /> --%>
	 	<link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/design.css"/>" />
	 	<link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/newdesigncss/bootstrap-grid.min.css"/>" />
	 	 
	 	
	 	
		<script type="text/javascript" src="<spring:url value="/resources/js/newdesignjs/bootstrap.bundle.min.js"/>"></script>
		<%-- <script type="text/javascript" src="<spring:url value="/resources/js/newdesignjs/bootstrap.bundle.js"/>"></script>
		<script type="text/javascript" src="<spring:url value="/resources/js/newdesignjs/bootstrap.js"/>"></script> --%>
		<script type="text/javascript" src="<spring:url value="/resources/js/newdesignjs/bootstrap.min.js"/>"></script>
	 
        
        
<script type="text/javascript">
	var fieldName;
	
	$(document).ready(function()
			{
	var message='';
	<%if (session.getAttribute("success") != null) {
		            if(session.getAttribute("successMessage") != null){%>
		            message='<%=session.getAttribute("successMessage").toString()%>';
		            <%
		            session.removeAttribute("successMessage");
		            }
					boolean test = ((Boolean) session.getAttribute("success")).booleanValue();
					session.removeAttribute("success");
					if (test) {
					%>	
		alert("Data Save successfully\n\n"+message);
	<%
	}}%>
	
});
	
	
function funSetData(code){

		switch(fieldName){

		case 'WCSubCategoryMaster' :
			funSetSubCategoryData(code);
			break;
		}
	}
	
function funResetFields()
{
	location.reload(true); 
}


function funSetSubCategoryData(code){

	$.ajax({
		type : "GET",
		url : getContextPath()+ "/loadWebClubSubCategoryData.html?docCode=" + code,
		dataType : "json",
		success : function(response){ 

			if(response.strSCCode=='Invalid Code')
        	{
        		alert("Invalid Company Code");
        		$("#txtCompanyCode").val('');
        	}
        	else
        	{      
	        	$("#txtSCCode").val(code);
	        	$("#textSCName").val(response.strSCName);
	        	$("#txtSCDesc").val(response.strSCDesc);
	      
	        	
        	}
		},
		error: function(jqXHR, exception) {
            if (jqXHR.status === 0) {
                alert('Not connect.n Verify Network.');
            } else if (jqXHR.status == 404) {
                alert('Requested page not found. [404]');
            } else if (jqXHR.status == 500) {
                alert('Internal Server Error [500].');
            } else if (exception === 'parsererror') {
                alert('Requested JSON parse failed.');
            } else if (exception === 'timeout') {
                alert('Time out error.');
            } else if (exception === 'abort') {
                alert('Ajax request aborted.');
            } else {
                alert('Uncaught Error.n' + jqXHR.responseText);
            }		            
        }
  });
}


	function funHelp(transactionName)
	{
		fieldName=transactionName;
	//	window.showModalDialog("searchform.html?formname="+transactionName+"&searchText=","","dialogHeight:600px;dialogWidth:600px;dialogLeft:400px;");
		window.open("searchform.html?formname="+transactionName+"&searchText=","","dialogHeight:600px;dialogWidth:600px;dialogLeft:400px;");
	}
</script>

</head>
<body>
		<div class="container">
			<label id="formHeading">Sub Category Master</label>
			<s:form name="SubCategoryMaster" method="POST" action="saveSubCategoryMaster.html">
				<div class="row masterTable">
					<div class="col-md-6">
						<label>Member Sub Category Code:</label><br>
							<div class="row">
								<div class="col-md-6"><s:input id="txtSCCode" ondblclick="funHelp('WCSubCategoryMaster')" cssClass="searchTextBox" 
									readonly="true" placeholder="Member Sub Category Code" type="text" path="strSCCode" ></s:input>
								</div>
					
								<div class="col-md-6"><s:input id="textSCName" path="strSCName" required=""
				              		placeholder="Member Sub Category Code" type="text" ></s:input>
								</div>
							</div>
						</div>	
						<div class="col-md-3">
							<label>MemberShip Class Description:</label><br>
							<s:input id="txtSCDesc" path="strSCDesc" type="text" placeholder="MemberShip Class Description"></s:input>
						</div>
				</div>
				<div class="center">
				<a href="#"><button class="btn btn-primary center-block" tabindex="3" value="Submit" onclick=""
					class="form_button">Submit</button></a>
				<a href="#"><button class="btn btn-primary center-block" type="reset"
					value="Reset" class="form_button" onclick="funResetField()" >Reset</button></a>
			</div>
		</s:form> 
	</body>
</html>

		
	<%-- <div id="formHeading">
	<label>SubCategoryMaster</label>
	</div>

<br/>
<br/>

	<s:form name="SubCategoryMaster" method="POST" action="saveSubCategoryMaster.html">

		<table class="masterTable">	
		
		<tr>
			 
			    <td width="180px"><label>Member Sub Category Code</label></td>   
				<td width="55px"><s:input id="txtSCCode" path="strSCCode" ondblclick="funHelp('WCSubCategoryMaster')"
									style="width: 118px" cssClass="searchTextBox" type="text"></s:input></td>
				
				<td><s:input id="textSCName" path="strSCName" required=""
				            cssStyle="width:53% ;" cssClass="longTextBox" type="text" ></s:input></td>
		</tr>
		<tr>
			 <td width="180px"><label>MemberShip Class Description</label> </td>
			 <td colspan="2"><s:input id="txtSCDesc" path="strSCDesc" 
						cssStyle="width:60% ;" cssClass="longTextBox" type="text"></s:input></td>		
		</tr>
		</table>	
<td>
		<br />
		<br />
		<p align="center">
			<input type="submit" value="Submit" tabindex="3" class="form_button" />
			<input type="reset" value="Reset" class="form_button" onclick="funResetFields()"/>
		</p>

	</s:form> --%>
