
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="s"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title></title>
	  
		<link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/newdesigncss/bootstrap.min.css"/>" />
	 		<link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/design.css"/>" />
	 	<link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/newdesigncss/bootstrap-grid.min.css"/>" />
	 	
		<script type="text/javascript" src="<spring:url value="/resources/js/newdesignjs/bootstrap.bundle.min.js"/>"></script>
		<script type="text/javascript" src="<spring:url value="/resources/js/newdesignjs/bootstrap.min.js"/>"></script>
<style>
	 
.center {
	text-align: right;
    padding-top: 25px;
}	
.btn{
margin:0px;}

</style>

<script type="text/javascript">
		var fieldName,gurl,listRow=0,mastercode;
	 $(document).ready(function()
					{
		    $(".tab_content").hide();
			$(".tab_content:first").show();

			$("ul.tabs li").click(function() {
				$("ul.tabs li").removeClass("active");
				$(this).addClass("active");
				$(".tab_content").hide();

				var activeTab = $(this).attr("data-state");
				$("#" + activeTab).fadeIn();
			});
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
	
	 
	 function btnAdd_onclick() 
		{	
		 	
			if(($("#txtRoomCode").val().trim().length == 0) )
	        {
				 alert("Please Enter Product Code Or Search");
	             $("#txtRoomCode").focus() ; 
	             return false;
	        }						 		     	 
			else
		    {
				var strFacilityCode=$("#txtRoomCode").val();
				if(funDuplicateProduct(strFacilityCode))
	            	{
						var facilityCode = $("#txtRoomCode").val();
					    var facilityName = $("#txtRoomDescription").val();						  
						funAddRow(facilityCode,facilityName);
	            	}
			}	
			return false;
		}	 
	 
		 /*
		 * Check duplicate record in grid
		 */
		function funDuplicateProduct(strFacilityCode)
		{
		    var table = document.getElementById("tblProduct");
		    var rowCount = table.rows.length;		   
		    var flag=true;
		    if(rowCount > 0)
		    	{
				    $('#tblProduct tr').each(function()
				    {
					    if(strFacilityCode==$(this).find('input').val())// `this` is TR DOM element
	    				{
					    	alert("Already added "+ strFacilityCode);
					    	 funResetProductFields();
		    				flag=false;
	    				}
					});
				    
		    	}
		    return flag;
		  
		}
		
		/**
		 * Adding Product Data in grid 
		 */
		function funAddRow(facilityCode,facilityName) 
		{   	    	    
		    var table = document.getElementById("tblProduct");
		    var rowCount = table.rows.length;
		    var row = table.insertRow(rowCount);   
		    
		    rowCount=listRow;
		    row.insertCell(0).innerHTML= "<input class=\"Box\" readonly=\"readonly\"  size=\"8%\" name=\"listStaffMasterDtl["+(rowCount)+"].strRoomCode\" id=\"txtRoomCode."+(rowCount)+"\" value="+facilityCode+">";
		    row.insertCell(1).innerHTML= "<input class=\"Box\" readonly=\"readonly\"  size=\"55%\" name=\"listStaffMasterDtl["+(rowCount)+"].strRoomDesc\" value='"+facilityName+"' id=\"txtRoomDescription."+(rowCount)+"\" >";
		    row.insertCell(2).innerHTML= "<input type=\"button\" class=\"deletebutton\" size=\"5%\" value = \"Delete\" onClick=\"Javacsript:funDeleteRow(this)\"/>";
			   
		    listRow++;		    
		    funResetProductFields();		   		    
		}
		
		
		/**
		 * Delete a particular record from a grid
		 */
		function funDeleteRow(obj)
		{
		    var index = obj.parentNode.parentNode.rowIndex;
		    var table = document.getElementById("tblProduct");
		    index--;
		    table.deleteRow(index);
		}
		
		/**
		 * Remove all product from grid
		 */
		function funRemProdRows()
	    {
			var table = document.getElementById("tblProduct");
			var rowCount = table.rows.length;
			for(var i=rowCount;i>=0;i--)
			{
				table.deleteRow(i);
			}
	    }
		

		/**
		 * Clear textfiled after adding data in textfield
		 */
		function funResetProductFields()
		{
			$("#txtRoomCode").val('');
			$("#txtRoomDescription").val('');
		}
		
		function funRemoveProductRows()
		{
			var table = document.getElementById("tblProduct");
			var rowCount = table.rows.length;
			while(rowCount>0)
			{
				table.deleteRow(0);
				rowCount--;
			}
		}
		
		
		
	 function funHelp(transactionName)
		{	       
			fieldName=transactionName;
	        window.open("searchform.html?formname="+transactionName+"&searchText=","","dialogHeight:600px;dialogWidth:600px;dialogLeft:400px;")
	       
	    }
	 
	 function funResetFields()
		{
			location.reload(true); 
		}	 
	 
	 function funSetData(code)
	 {
		 switch(fieldName)
		 {		
				
			case 'WCCatMaster' :			
				funSetStaffMasterDtlList();
				break;
				
			case "roomForStaffMaster":
				 funSetRoomMasterData(code);
				 break;
				 
		    case 'PmsStaffCode':
		    	funSetStaffCode(code);
		        break;		
			}
		}
	 
	 function funSetRoomMasterData(roomCode)
		{
			var searchUrl=getContextPath()+"/loadRoomMasterData.html?roomCode="+roomCode;
			$.ajax({
				
				url:searchUrl,
				type :"GET",
				dataType: "json",
		        success: function(response)
		        {
		        	if(response.strRoomCode=='Invalid Code')
		        	{
		        		alert("Invalid Room Code");
		        		$("#txtRoomCode").val('');
		        	}
		        	else
		        	{
		        		$("#txtRoomCode").val(response.strRoomCode);
		        		$("#txtRoomDescription").val(response.strRoomDesc);		        		
		        	}
				},
				error: function(jqXHR, exception) 
				{
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
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 function funSetStaffCode(code)
		{
				var searchUrl="";
				searchUrl=getContextPath()+"/loadPMSStaffMasterData.html?staffCode="+code;			
				$.ajax({
				        type: "GET",
				        url: searchUrl,
					    dataType: "json",
					    success: function(response)
					    {
					    	$("#txtStaffCode").val(code);
					    	$("#txtStaffName").val(response.strStaffName);
					    	funSetStaffMasterDtlList();
					    					    	
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
	 
	 function funSetStaffMasterDtlList(){
		 	funRemoveProductRows();
			var staffCode=$("#txtStaffCode").val();
			var searchurl=getContextPath()+"/loadStaffMasterRoomsDtl.html?staffCode="+staffCode;
			//alert(searchurl);
			 $.ajax({
				        type: "GET",
				        url: searchurl,
				        dataType: "json",
				        success: function(response)
				        {
				        	
				        	$.each(response, function(cnt,item)
		 					{
					        	funAddRow(item[1],item[2])
					        	//alert(response);
				      		});					        	
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
</script>



</head>
<body>
	<div class="container">
		<label id="formHeading">Staff Master</label>
		<s:form name="frmMemberCategoryMaster" action="savePMSStaffMaster.html?saddr=${urlHits}" method="POST">
			<div id="tab_container">
				<ul class="tabs">
					<li class="active" data-state="tab1">Staff Creation</li>
					<li data-state="tab2">Staff Wise Room</li>
				</ul> 
				<div id="tab1" class="tab_content">
				
									<div class="row transTable">
										 <div class="col-md-2">
									        <label>Staff Code</label>
										     <s:input id="txtStaffCode" placeholder="Staff Code" name="txtreqCode" path="strStaffCode" cssClass="searchTextBox" ondblclick="funHelp('PmsStaffCode')" readonly="true"/>
										 </div>
									
									    <div class="col-md-3"><label>Staff Name</label>
									          <s:input id="txtStaffName" placeholder="Enter Staff Name" name="txtStaffName" path="strStaffName" />
										</div>	
									</div>						
					</div>
					<div id="tab2" class="tab_content">
						<div class="row transTable">
							<div class="col-md-6">
									<div class="row">
										<div class="col-md-6">
											<label>Room Code</label><br>
										<s:input id="txtRoomCode" required="" ondblclick="funHelp('roomForStaffMaster')" cssClass="searchTextBox"
											readonly="true" placeholder="Room Code" type="text" path=""></s:input>
										</div>
					
										<div class="col-md-6">
										<label>Room Description</label><br><s:input id="txtRoomDescription" path="" required="" readonly="true"
									 		placeholder="Enter Room Descriptio" type="text"></s:input><s:errors path=""></s:errors>
										</div>
									</div>
							</div>
							<div class="col-md-6">
									<div class="row">
									
									<%-- <div class="col-md-4">
										<label>Operational:</label><br>
										<s:checkbox id="txtOperationalNY" path="" value="Y" checked="true" />
									</div> --%>
										<div class="col-md-6">
										<div class="center">
										<a href="#"><button class="btn btn-primary center-block" id="btnAdd" value="Add" onclick="return btnAdd_onclick()" class="form_button">Add</button></a>
										</div>
										</div>
									</div>
							</div>
						</div>
						  <table class="table table-striped dynamicTableContainer"> 
								<thead>
									<tr>
									   <th>Room Code</th>
									   <th>Room Description</th>									   
									    <th>Delete</th>
									  </tr>
								 </thead>
								<tbody id="tblProduct"> 
									  
								</tbody>
						 </table> 
					</div>
					</div>
					<div class="center"style="text-align:center;">
						<a href="#"><button class="btn btn-primary center-block" value="Submit" onclick=""
							class="form_button">Submit</button></a>
						<a href="#"><button class="btn btn-primary center-block" type="reset"
						 	value="Reset" class="form_button" onclick="funResetField()" >Reset</button></a>
					</div>
			
		</s:form>
</div>
</body>
</html>









<%-- <%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="s"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title></title>
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
				alert("Data Save successfully :\t"+message);
	<%
	}}%>

});
	

	
	//validation
	function funValidate(data)
	{
		var flg=true;
		if($("#txtStaffName").val().trim().length==0)
			{
			alert("Please Enter Staff Name !!");
			 flg=false;
			}
		else if($("#txtStaffCatCode").val().trim().length==0)
			{
			
			alert("Please Select Staff Categeory Code !!");
			 flg=false;
			
			}
		return flg;
	}
	
	
	function funSetData(code){

		switch(fieldName)
		{		
		   case 'PmsStaffCode':
		    	funSetStaffCode(code);
		        break;		
		}
	}

	
	function funSetStaffCode(code)
	{
			var searchUrl="";
			searchUrl=getContextPath()+"/loadPMSStaffMasterData.html?staffCode="+code;			
			$.ajax({
			        type: "GET",
			        url: searchUrl,
				    dataType: "json",
				    success: function(response)
				    {
				    	$("#txtStaffCode").val(code);
				    	$("#txtStaffName").val(response.strStaffName);
				    	$("#txtStaffCatCode").val(response.strStaffCatCode);
		        		
				    	if(response.strOperationalYN=="Y")
			        	{
			        		
			        		document.getElementById("chkOperationalYN").checked = response.strOperationalYN == 'Y' ? true: false;
			        	}
		        		else
			        	{
			        		$("#chkOperationalYN").attr('checked', false);
			        		
			        	}
				    	$("#txtMobile").val(response.strMobile);
				    	$("#txtEmail").val(response.strEmail);
				    	
				    	
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
		window.open("searchform.html?formname="+transactionName+"&searchText=","","dialogHeight:600px,dialogWidth:1100px,top=500,left=500")
		
	}
</script>

</head>
<body>

	<div class="container">
	<label  id="formHeading">Staff Master</label>
	 <s:form name="BanquetStaffMaster" method="POST" action="savePMSStaffMaster.html">

		<div class=" row masterTable">				
			    <div class="col-md-2">
			        <label>Staff Code</label>
				     <s:input id="txtStaffCode" name="txtreqCode" path="strStaffCode" cssClass="searchTextBox" ondblclick="funHelp('PmsStaffCode')" readonly="true"/>
				 </div>
			
			   <div class="col-md-3"><label>Staff Name</label>
			          <s:input id="txtStaffName" name="txtStaffName" path="strStaffName" />
				</div>				
		
			<tr>
				<td>
					<label>Staff Categeory Code</label>
				</td>								
					<td><s:input id="txtStaffCatCode" name="txtStaffCatCode" path="strStaffCatCode" class="searchTextBox" ondblclick="funHelp('StaffCatCode')" readonly="true"/>
					</td>					
			</tr>
			
			<tr>			
			<td><label>Operational Y/N</label></td>
				
				<td><s:checkbox id="chkOperationalYN" name="chkOperationalYN" path="strOperationalYN" value="Y" checked="true"/></td> 
				
			</tr>
			
			<tr>			
			   <td> <label> Mobile No.  </label> </td>
		       <td>
					        <!-- pattern="[789][0-9]{9}" -->
			     <s:input  type="tel" pattern="[0-9]{10,10}"  maxlength="11"  placeholder="Enter Valid MobileNo." id="txtMobile" name="txtMobile" path="strMobile" cssClass="BoxW116px" />
			   </td> 
				
		    </tr> 
			
			<tr>
			   <td><label>Email  </label></td>
			   <td colspan="3">
			     <s:input   placeholder="name@email.com"   id="txtEmail" name="txtEmail" path="strEmail" cssClass="longTextBox"/>
			   </td>
		   </tr>
		
		</div>

		<br />
		<br />
		<p align="center" style="margin-right: 32%;">
			<input type="submit" value="Submit" tabindex="3"  class="btn btn-primary center-block" class="form_button" onclick="return funValidate(this)"/>
			&nbsp;
			<input type="reset" value="Reset" class="btn btn-primary center-block" class="form_button" onclick="funResetFields()"/>
		</p>

	</s:form>
	</div>
</body>
</html>
 --%>