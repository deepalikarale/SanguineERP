<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Material Production</title>
     <link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/design.css"/>" />
	 <link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/newdesigncss/bootstrap-grid.css"/>" />
	 <link rel="stylesheet" type="text/css" media="screen" href="<spring:url value="/resources/css/newdesigncss/bootstrap-grid.min.css"/>" />
	 <link rel="stylesheet" type="text/css" href="<spring:url value="/resources/css/Accordian/jquery-ui-1.8.9.custom.css "/>" />
	 <script type="text/javascript" src="<spring:url value="/resources/js/newdesignjs/bootstrap.bundle.min.js"/>"></script>
	 <script type="text/javascript" src="<spring:url value="/resources/js/newdesignjs/bootstrap.min.js"/>"></script>

<style>
.transTable td {
          padding-left: 1px;
         } 
.transTable th {
          padding: 0px;  
         }   
</style>
<script type="text/javascript">
		/**
		 * Global variable
		 */
		var strUOM,listRow=0;
		var list;
		/**
		 * Ready Function for Initialize textField with default value
		 * And Set date in date picker 
		 */
		$(function() {
			$("#txtPDDate").datepicker({ dateFormat: 'dd-mm-yy' });
			$("#txtPDDate" ).datepicker('setDate', 'today');
			$("#txtLocCode").val("${locationCode}");
			$("#spLocName").text("${locationName}");
			 /**
			  * Ready Function for Ajax Waiting and reset form
			  */			
			$(document).ajaxStart(function(){
			    $("#wait").css("display","block");
			  });
			  $(document).ajaxComplete(function(){
			    $("#wait").css("display","none");
			  });
		});
				
		/**
		 * Open help windows
		 */
		function funHelp(transactionName)
		{
			fieldName=transactionName;
		
			// window.showModalDialog("searchform.html?formname="+transactionName+"&searchText=","","dialogHeight:600px;dialogWidth:600px;dialogLeft:400px;")
			 window.open("searchform.html?formname="+transactionName+"&searchText=","","dialogHeight:600px;dialogWidth:600px;dialogLeft:400px;")
		}	
		/**
		 * Set Data after selecting form Help windows
		 */
		function funSetData(code)
		{
			var searchUrl="";
			switch (fieldName)
			{
				case'locationmaster':
					funSetLocation(code);
				break;
				
				case'productmaster':
					funSetProduct(code);
				break;
				
				case'Production':
					funSetProductionData(code);
				break;
				
				case'WorkOrder':
					funLoadWorkOrder(code);
				break;				
			}			
		}
		/**
		 * Set Location Data after selecting form Help windows
		 */
		function funSetLocation(code)
		{
			var searchUrl="";
			searchUrl=getContextPath()+"/loadLocationMasterData.html?locCode="+code;			
			$.ajax({
			        type: "GET",
			        url: searchUrl,
				    dataType: "json",
				    success: function(response)
				    {
				    	if(response.strLocCode=='Invalid Code')
				       	{
				       		alert("Invalid Location Code");
				       		$("#txtLocCode").val('');
				       		$("#spLocName").text("");
				       		$("#txtLocCode").focus();
				       		
				       	}
				       	else
				       	{
				    	$("#txtLocCode").val(response.strLocCode);
				    	$("#spLocName").text(response.strLocName); 
				    	$("#txtProdCode").focus();
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
		/**
		 * Set Product Data after selecting form Help windows
		 */
		function funSetProduct(code)
		{
			var searchUrl="";		
			searchUrl=getContextPath()+"/loadProductMasterData.html?prodCode="+code;
			$.ajax({
			        type: "GET",
			        url: searchUrl,
				    dataType: "json",
				    success: function(response)
				    {
				    	if('Invalid Code' == response.strProdCode){
				    		alert('Invalid Product Code');
					    	$("#txtProdCode").val('');
					    	$("#spProdName").text('');
					    	$("#txtProdCode").focus();
				    	}else{
				    	$("#txtProdCode").val(response.strProdCode);
				    	$("#spProdName").text(response.strProdName);	
						$("#txtPrice").val(response.dblCostRM);
						$("#txtQtyProd").focus();
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
		/**
		 * Get and Set WorkOrder Hd Data after selecting form Help windows
		 */
		function funLoadWorkOrder(code)
		{
			var searchUrl="";		
			searchUrl=getContextPath()+"/loadWorkOrder.html?WoCode="+code;
			//alert(searchUrl);
			$.ajax({
			        type: "GET",
			        url: searchUrl,
				    dataType: "json",
				    success: function(response)
				    {
				    	$("#txtWOCode").val(code);
				    	funRemRows();
				    	$.each(response, function(i,item)
						 {
						    $("#txtProdCode").val(response[i].strProdCode);			
							$("#spProdName").text(response[i].strProdName);
							$("#cmbProcess").val(response[i].strProcessName);
							$('#cmbProcess').empty();
							var newOption = $('<option value="'+response[i].strProcessCode+'">'+response[i].strProcessName+'</option>');
							$('#cmbProcess').append(newOption);
						    $("#txtQtyProd").val(response[i].dblQtyProd);
						    $("#txtWt").val(response[i].dblWeight);
						    $("#txtPrice").val(response[i].dblPrice);
						    $("#txtQtyRej").val(response[i].dblQtyRej);						   	   
						    $("#txtActTime").val(response[i].dblActTime);
						    strUOM=response[i].strUOM;
						    funAddProductRow();
						    funClearProduct();
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
		/**
		 * Get and Set Production hd Data 
		 */
		function funSetProductionData(code)
		{
			var searchUrl="";		
			searchUrl=getContextPath()+"/loadProductionData.html?PDCode="+code;
			//alert(searchUrl);
			$.ajax({
			        type: "GET",
			        url: searchUrl,
				    dataType: "json",
				    success: function(response)
				    {
				    	$.each(response, function(i,item)
				    	{
				    		if(response[i].strPDCode!="Invalid Code")
				    			{
				    				funFillData(response);	
				    			}
				    		else
				    			{
				    				alert("Invalid Code");
				    				$("#txtPDCode").val('');
				    				$("#txtPDCode").focus();	
				    				return false;
				    			}
				    	
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
		/**
		 * Set Production Hd Data in Textfield
		 */
		function funFillData(response)
		{
			var count=0;
			$.each(response, function(i,item)
	    			{		
						count=i;
						$("#txtPDCode").val(response[i].strPDCode);									    
			    		$("#txtWOCode").val(response[i].strWOCode);	
			    		$("#txtLocCode").val(response[i].strLocCode)
			    		$("#txtNarration").val(response[i].strNarration);	 
			    		$("#btnAdd").focus();	 
			    		funGetProdData($("#txtPDCode").val());
	    			});
			listRow=count+1;
		}
		
		/**
		 * Get and Set Production Dtl Data 
		 */
		function funGetProdData(strPDcode)
		{	
			searchUrl=getContextPath()+"/loadProductionDtlData.html?PDCode="+strPDcode;				
			$.ajax({				
	        	type: "GET",
		        url: searchUrl,
		        dataType: "json",
		        success: function(response)
		        {				        	
		        	funRemRows();
					$.each(response, function(i,item)
	                {
						funfillProdRow(response[i].strProdCode,response[i].strPartNo,response[i].strProdName,response[i].strProcessCode,response[i].strProcessName,response[i].strUOM,response[i].dblQtyProd,response[i].dblQtyRej,response[i].dblWeight,response[i].dblPrice,response[i].dblActTime);
	                                               
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
		/**
		 * Fill Production Data in grid 
		 */
		function funfillProdRow(strProdCode,strPartNo,strProdName,strProcessCode,strProcessName,strUOM,dblQtyProd,dblQtyRej,dblWeight,dblPrice,dblActTime)
		{	  
		    var dblAcceptedQty=dblQtyProd-dblQtyRej;
	        var dblTotWt=dblQtyProd*dblWeight;
	        var dblTotalPrice=dblAcceptedQty*dblPrice;
		    var table = document.getElementById("tblProdDet");
		    var rowCount = table.rows.length;
		    var row = table.insertRow(rowCount);
		  
		    row.insertCell(0).innerHTML= "<input name=\"listProductionDtl["+(rowCount)+"].strProdCode\" readonly=\"readonly\" class=\"Box\" size=\"8%\"   id=\"txtProdCode."+(rowCount)+"\" value='"+strProdCode+"' />";	
		    row.insertCell(1).innerHTML= "<input name=\"listProductionDtl["+(rowCount)+"].strProdName\" readonly=\"readonly\" class=\"Box\" size=\"23%\"  id=\"txtProdName."+(rowCount)+"\" value='"+strProdName+"' />";	
		    row.insertCell(2).innerHTML= "<input name=\"listProductionDtl["+(rowCount)+"].strUOM\" readonly=\"readonly\" class=\"Box\" size=\"3%\"  id=\"txtUOM."+(rowCount)+"\" value='"+strUOM+"' />";
		    row.insertCell(3).innerHTML=" <input name=\"listProductionDtl["+(rowCount)+"].strProcessCode\" readonly=\"readonly\" class=\"Box\" size=\"8%\"  id=\"strProcessCode."+(rowCount)+"\" value="+strProcessCode+">";
		    row.insertCell(4).innerHTML=" <input name=\"listProductionDtl["+(rowCount)+"].strProcessName\" readonly=\"readonly\" class=\"Box\" size=\"8%\"  id=\"strProcessName."+(rowCount)+"\" value="+strProcessName+">";	
		    row.insertCell(5).innerHTML= "<input name=\"listProductionDtl["+(rowCount)+"].dblQtyProd\" type=\"number\" step=\"any\" required = \"required\" style=\"text-align: right;width:100%;border:1px solid #a2a2a2;padding:1px;\" size=\"5%\" id=\"txtQtyProd."+(rowCount)+"\" value="+dblQtyProd+">";
		    row.insertCell(6).innerHTML= "<input name=\"listProductionDtl["+(rowCount)+"].dblWeight\" type=\"number\" step=\"any\" required = \"required\" style=\"text-align: right;width:100%;border:1px solid #a2a2a2;padding:1px;\"  size=\"5%\" id=\"txtWt."+(rowCount)+"\" value="+dblWeight+">";
		    row.insertCell(7).innerHTML= "<input name=\"listProductionDtl["+(rowCount)+"].dtlTotWt\"  class=\"Box\" style=\"text-align: right;width:100%\" size=\"5%\" id=\"dtlTotWt."+(rowCount)+"\" value="+dblTotWt+">";
		    row.insertCell(8).innerHTML= "<input name=\"listProductionDtl["+(rowCount)+"].dblPrice\"  type=\"number\" step=\"any\" required = \"required\" style=\"text-align: right;width:100%;border:1px solid #a2a2a2;padding:1px;\" size=\"5%\" id=\"dblPrice."+(rowCount)+"\" value="+dblPrice+">";
		    row.insertCell(9).innerHTML= "<input name=\"listProductionDtl["+(rowCount)+"].dblTotalPrice\"  class=\"Box\" style=\"text-align: right;width:100%\" size=\"5%\" id=\"dblTotalPrice."+(rowCount)+"\" value="+dblTotalPrice+">";
		    row.insertCell(10).innerHTML= "<input name=\"listProductionDtl["+(rowCount)+"].dblQtyRej\" type=\"number\" step=\"any\" required = \"required\" style=\"text-align: right;width:100%;border:1px solid #a2a2a2;padding:1px;\" size=\"5%\" id=\"txtQtyRej."+(rowCount)+"\" value="+dblQtyRej+">";
		    row.insertCell(11).innerHTML= "<input name=\"listProductionDtl["+(rowCount)+"].dblAcceptedQty\"  type=\"number\" step=\"any\" required = \"required\" style=\"text-align: right;width:100%;border:1px solid #a2a2a2;padding:1px;\"  size=\"5%\" id=\"dblAcceptedQty."+(rowCount)+"\" value="+dblAcceptedQty+">";	    
		    row.insertCell(12).innerHTML= "<input name=\"listProductionDtl["+(rowCount)+"].dblActTime\"  type=\"number\" step=\"any\" required = \"required\" style=\"text-align: right;width:100%;border:1px solid #a2a2a2;padding:1px;\"  size=\"5%\" id=\"txtActTime."+(rowCount)+"\" value="+dblActTime+">";		    
		    row.insertCell(13).innerHTML= '<input type="button" value = "Delete" class="deletebutton" onClick="Javacsript:funDeleteRow(this)">';
		    
		}
		/**
		 * Remove all product from grid
		 */
		function funRemRows()
	    {
			$('#tblProdDet tbody > tr').remove();
	    }
		/**
		 * Check validation before adding product data in grid
		 */
		function btnAdd_onclick() 
	    {	   
	        if($("#txtProdCode").val()=="" && $("#txtProdCode").val().trim().length==0)
	        {
	        	alert("Please Enter Product Code or Search");
	        	 $("#txtProdCode").focus() ; 
	        	return false;
	           
	        }
	        if($("#cmbProcess").val()==null  || $("#cmbProcess").val()==""  || $("#cmbProcess").val().trim().length==0)
	        	{
	        		alert("Please Select Process");
	        		return false;
	        	} 
	        if($("#txtQtyProd").val()=="" && $("#txtQtyProd").val()== 0 )
	           {		
			        	alert("Please Enter Quantity");
		                $("#txtQtyProd").focus();
		                return false;
	        	      
	           } 
	       else
	            {
		    	   funAddProductRow();
	               funClearProduct();
	            }
	    }
		/**
		 * Adding Product Data in grid 
		 */
		function funAddProductRow() 
		{		
			var strProdCode =$("#txtProdCode").val();			
			var strProdName=$("#spProdName").text();
			var strProcessName=$("#cmbProcess").text();
			//alert(strProcessName);
			var strProcessCode=$("#cmbProcess").val();			
		    var dblQtyProd = $("#txtQtyProd").val();
		    var dblwt = $("#txtWt").val();
		    if(dblwt=="")
		    	{
		    		dblwt=0;
		    	}
		    var dblPrice=$("#txtPrice").val();
		    var dblQtyRej=$("#txtQtyRej").val();
		    if(dblQtyRej=="")
		    	{
		    		dblQtyRej=0;
		    	}
		    var dblAcceptedQty=dblQtyProd-dblQtyRej;
		    var dblTotalPrice=dblPrice*dblAcceptedQty;
		    var strAcctualTime=$("#txtActTime").val();
		    if(strAcctualTime=="")
		    	{
		    		strAcctualTime=0;
		    	}
		    var dblTotWt=dblQtyProd*dblwt;		    
		    		
		    var table = document.getElementById("tblProdDet");
		    var rowCount = table.rows.length;
		    var row = table.insertRow(rowCount);
		   	rowCount=listRow;
		   	list = funGetToolTipData(strProdCode,dblQtyProd);
		   	var toolTip="";
		   	for(var i = 0;i<list.length;i++)
		   		{
		   			var pName = list[i][0];
		   			var uom = list[i][1];
		   			var finalWeight = list[i][2];
		   			var costRM = list[i][3];
		   			
		   			toolTip = toolTip+pName+" - "+uom+" "+finalWeight+" - "+costRM+"\n"
		   			
		   		}
		   	var x1 = row.insertCell(0);
		   	x1.title = toolTip;
		   	
		   	var x2 = row.insertCell(1);
		   	x2.title = toolTip;
		   	
		   	x1.innerHTML= "<input name=\"listProductionDtl["+(rowCount)+"].strProdCode\" readonly=\"readonly\" class=\"Box\" size=\"8%\"   id=\"txtProdCode."+(rowCount)+"\" value='"+strProdCode+"' />";	
		   	x2.innerHTML= "<input name=\"listProductionDtl["+(rowCount)+"].strProdName\" readonly=\"readonly\" class=\"Box\" size=\"17%\"  id=\"txtProdName."+(rowCount)+"\" value='"+strProdName+"' />";	
		    row.insertCell(2).innerHTML= "<input name=\"listProductionDtl["+(rowCount)+"].strUOM\" readonly=\"readonly\" class=\"Box\" size=\"10%\"  id=\"txtUOM."+(rowCount)+"\" value='"+strUOM+"' />";
		    row.insertCell(3).innerHTML=" <input name=\"listProductionDtl["+(rowCount)+"].strProcessCode\" readonly=\"readonly\" class=\"Box\" size=\"8%\"  id=\"strProcessCode."+(rowCount)+"\" value="+strProcessCode+">";
		    row.insertCell(4).innerHTML=" <input name=\"listProductionDtl["+(rowCount)+"].strProcessName\" readonly=\"readonly\" class=\"Box\" size=\"8%\"  id=\"strProcessName."+(rowCount)+"\" value="+strProcessName+">";	
		    row.insertCell(5).innerHTML= "<input name=\"listProductionDtl["+(rowCount)+"].dblQtyProd\" type=\"number\" step=\"any\" required = \"required\" style=\"text-align: right;width:100%;border:1px solid #a2a2a2;padding:1px;\"   size=\"5%\" id=\"txtQtyProd."+(rowCount)+"\" value="+dblQtyProd+">";
		    row.insertCell(6).innerHTML= "<input name=\"listProductionDtl["+(rowCount)+"].dblWeight\" type=\"number\" step=\"any\" required = \"required\" style=\"text-align: right;width:100%;border:1px solid #a2a2a2;padding:1px;\"  size=\"5%\" id=\"txtWt."+(rowCount)+"\" value="+dblwt+">";
		    row.insertCell(7).innerHTML= "<input name=\"listProductionDtl["+(rowCount)+"].dtlTotWt\" readonly=\"readonly\" class=\"Box\" style=\"text-align: right;width:100%\" size=\"5%\" id=\"dtlTotWt."+(rowCount)+"\" value="+dblTotWt+">";
		    row.insertCell(8).innerHTML= "<input name=\"listProductionDtl["+(rowCount)+"].dblPrice\"  type=\"number\" step=\"any\" readonly=\"readonly\" required = \"required\" style=\"text-align: right;width:100%;border:1px solid #a2a2a2;padding:1px;\"size=\"5%\" id=\"dblPrice."+(rowCount)+"\" value="+dblPrice+">";
		    row.insertCell(9).innerHTML= "<input name=\"listProductionDtl["+(rowCount)+"].dblTotalPrice\" readonly=\"readonly\" class=\"Box\" style=\"text-align: right;width:100%\"   size=\"5%\" id=\"dblTotalPrice."+(rowCount)+"\" value="+dblTotalPrice+">";
		    row.insertCell(10).innerHTML= "<input name=\"listProductionDtl["+(rowCount)+"].dblQtyRej\" type=\"number\" step=\"any\" required = \"required\" style=\"text-align: right;width:100%;border:1px solid #a2a2a2;padding:1px;\" size=\"5%\" id=\"txtQtyRej."+(rowCount)+"\" value="+dblQtyRej+">";
		    row.insertCell(11).innerHTML= "<input name=\"listProductionDtl["+(rowCount)+"].dblAcceptedQty\" type=\"number\" step=\"any\" required = \"required\" style=\"text-align: right;width:100%;border:1px solid #a2a2a2;padding:1px;\"  size=\"5%\" id=\"dblAcceptedQty."+(rowCount)+"\" value="+dblAcceptedQty+">";	    
		    row.insertCell(12).innerHTML= "<input name=\"listProductionDtl["+(rowCount)+"].dblActTime\" type=\"number\" step=\"any\" required = \"required\" style=\"text-align: right;width:100%;border:1px solid #a2a2a2;padding:1px;\"  size=\"5%\" id=\"txtActTime."+(rowCount)+"\" value="+strAcctualTime+">";		    
		    row.insertCell(13).innerHTML= '<input type="button" value = "Delete" class="deletebutton" onClick="Javacsript:funDeleteRow(this)">';
		    listRow++;
		    return false;
		}
		/**
		 * Delete a particular record from a grid
		 */
		function funDeleteRow(obj) 
		{
		    var index = obj.parentNode.parentNode.rowIndex;
		    var table = document.getElementById("tblProdDet");
		    table.deleteRow(index);
		}
		/**
		 * Clear textfiled after adding data in textfield
		 */
		function funClearProduct()
		{
			$("#txtProdCode").val("");			
			$("#spProdName").text("");
			$("#txtQtyProd").val("");
			$("#txtWt").val("");
			$("#txtPrice").val("");
			$("#txtQtyRej").val("");
			$("#txtWt").val("");
			$("#txtMacCode").val("");
			$("#spMacName").text("");
			$("#txtStaffCode").val("");
			$("#txtActTime").val("");
			
			 $("#txtProdCode").focus() ; 
		}
		
		/**
		 *  Ready function 
		 */
		$(function()
				{
				/**
				 *  Ready function open Document Attach
				 */
					$('a#baseUrl').click(function() 
					{
						if($("#txtPDCode").val().trim()=="")
						{
							alert("Please Enter WorkOrder Code or Search");
							return false;
						}
						 window.open('attachDoc.html?transName=frmProduction.jsp&formName=Material Production&code='+$('#txtPDCode').val(),"mywindow","directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no,width=600,height=600,left=400px");
					});
					
					/**
					 *  Ready function for Textfield on blur event
					 */
					$('#txtPDCode').blur(function () {
						 var code=$('#txtPDCode').val();
						if (code.trim().length > 0 && code !="?" && code !="/"){							  
							   funSetProductionData(code);
						   }
						});
					
					$('#txtLocCode').blur(function () {
						  var code=$('#txtLocCode').val();
						  if (code.trim().length > 0 && code !="?" && code !="/"){
							   funSetLocation(code);
						   }
						});
					
// 					$('#txtWOCode').blur(function () {
// 						 var code=$('#txtWOCode').val();
// 						 if (code.trim().length > 0 && code !="?" && code !="/"){
// 							   funLoadWorkOrder(code);
// 						   }
// 						});
					
					$('#txtProdCode').blur(function () {
						 var code=$('#txtProdCode').val();
						 if (code.trim().length > 0 && code !="?" && code !="/"){
							   funSetProduct(code);
						   }
						});
				});
		
				
		/**
		 *  Get Location Name
		 */
		function funGetLocationName(txtFieldName,lblFieldName)
		{
			code=document.getElementById(txtFieldName).value;	
			$.ajax({			
	        	type: "GET",
		        url: getContextPath()+"/loadLocationMasterData.html?locCode="+code,
		        dataType: "json",
		        success: function(response)
		        {			        	
		        	document.getElementById(lblFieldName).innerHTML=response.strLocName;
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
		
		function funGetProduct(strWorkOrderCode)
		{
			if(strWorkOrderCode!="")
				{
								
				}
		}
		
		/**
		 * Checking Validation before submiting the data
		 */
		function funCallFormAction(actionName,object) 
		{
			
			 var table = document.getElementById("tblProdDet");
			 var rowCount = table.rows.length;
			 
			if (!fun_isDate($("#txtPDDate").val())) {
				alert('Invalid Date');
				$("#txtPDDate").focus();
				return false;
			}
			if(! $("#chkDirectWorkOrder").is(':checked')){
				if($('#txtWOCode').val() == ''){
					alert('Please Select Work Order Code');
					$("#txtWOCode").focus();
					return false;
				}
			}
			if(rowCount == 0){
				alert('Please Add Products');
				return false;
			}
			
			if($("#txtLocCode").val()=='')
				{
					alert("Enter Location or Search");
					$("#txtLocCode").focus();
					return false;
				}			
			else{
				return true;
				
			}	
		}
		function funApplyNumberValidation(){
			$(".numeric").numeric();
			$(".integer").numeric(false, function() { alert("Integers only"); this.value = ""; this.focus(); });
			$(".positive").numeric({ negative: false }, function() { alert("No negative values"); this.value = ""; this.focus(); });
			$(".positive-integer").numeric({ decimal: false, negative: false }, function() { alert("Positive integers only"); this.value = ""; this.focus(); });
		    $(".decimal-places").numeric({ decimalPlaces: maxQuantityDecimalPlaceLimit, negative: false });
		    $(".decimal-places-amt").numeric({ decimalPlaces: maxAmountDecimalPlaceLimit, negative: false });
		}
		$(function() {
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
			
			var flagOpenFromAuthorization="${flagOpenFromAuthorization}";
			if(flagOpenFromAuthorization == 'true')
			{
				funSetProductionData("${authorizationProductionCode}");
			}
	    });
		/**
		 * Reset Form
		**/
		function funResetField()
		{
			location.reload(true);
		}
		
		function funGetToolTipData(prodCode,qty)
		{
			var list1;
			searchUrl=getContextPath()+"/loadToolTipData.html?prodCode="+prodCode+"&qty="+qty;				
			$.ajax({				
	        	type: "GET",
		        url: searchUrl,
		        dataType: "json",
		        async:false,
		        success: function(response)
		        {				        	
		        	list1 = response;
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
			return list1;
		} 
		
		
		
</script>
</head>
<body onload="funOnLoad();">
	<div  class="container transTable">
		<label id="formHeading">Material Production</label>
	    <s:form name="PD" action="savePD.html?saddr=${urlHits}" method="POST">

		<table>
			<tr>

				<th style="background-color:#d8d8d8"><s:input type="hidden" id="userCreated" name="userCreated"
						path="strUserCreated" value="${command.strUserCreated}" /></th>
				<th><s:input type="hidden" id="dateCreated" name="dateCreated"
						path="dtCreatedDate" value="${command.dtCreatedDate}" /></th>
				<!-- <th align="right"><a id="baseUrl" href="#">Attatch Document</a></th> -->
			</tr>
		</table>

        <div class="row">
			 <div class="col-md-2"><label>Production Code</label>
				   <s:input id="txtPDCode" ondblclick="funHelp('Production')" cssClass="searchTextBox"
						type="text" path="strPDCode" value="${command.strPDCode}"></s:input>
			 </div>

			  <div class="col-md-2"><label>Date</label>
			       <s:input id="txtPDDate" name="txtPDDate" required="required" cssClass="calenderTextBox" path="dtPDDate" style="width:70%"
						value="${command.dtPDDate}" type="text"></s:input>
			  </div>
			  <div class="col-md-8"></div>
			  
			  <div class="col-md-2"><label>Location</label>
				  <s:input id="txtLocCode" path="strLocCode" required="required" value="${command.strLocCode}"
						ondblclick="return funHelp('locationmaster');" cssClass="searchTextBox" type="text"></s:input>
			   </div>
			   
				<div class="col-md-2"><label id="spLocName" class="namelabel" style="background-color:#dcdada94; width: 100%; height:51%;margin-top: 27px;padding:4px;"></label></div>
				
				<div class="col-md-2"><label>Work Order Code</label>
				    <s:input id="txtWOCode" path="strWOCode" value="${command.strWOCode}"
					   ondblclick="return funHelp('WorkOrder');" cssClass="searchTextBox" type="text" ></s:input>
				</div>
                 <div class="col-md-6"></div>
                 
		        <div class="col-md-2"><label>Product</label>
				      <input id="txtProdCode" ondblclick="funHelp('productmaster');" type="text" class="searchTextBox"></input>
				</div>
				
				<div class="col-md-1"><br><br>
				     <input id="btnChar" disabled="disabled" onclick="return btnChar_onclick()" type="button" value=".." />
				</div>
				
				<div class="col-md-1">
				     <label id="spProdName" class="namelabel" style="font-size: 12px;background-color:#dcdada94; width: 166%; height:51%;margin-top: 27px;margin-left:-45px;padding:4px;"></label>
				</div>

				<div class="col-md-2"><label> Process </label>
				     <s:select id="cmbProcess" items="${strProcess}" path="" onchange="" style="width:auto;"></s:select>
				</div>
<!-- 				<option value="Assamble">Assamble</option> -->
<!--  				 <option value="Reparing">Reparing</option> -->
				
			    <div class="col-md-6"></div>
			    
				<div class="col-md-2"><label>Price/Unit</label>
				    <input id="txtPrice" type="text" class="decimal-places-amt numberField"></input>
				</div>
				
				<div class="col-md-2"><label>Wt/Unit:</label>
				    <input id="txtWt" ondblclick="" type="text" class="decimal-places numberField"></input>
				</div>	
					
				<div class="col-md-2"><label>Direct </label><br>
				    <input type="Checkbox" id="chkDirectWorkOrder"/>
				</div>
                 <div class="col-md-6"></div>
                 
			    <div class="col-md-2"><label>Quantity Produced</label>
				    <input id="txtQtyProd" type="text" class="decimal-places numberField" />
				</div>
				
				<div class="col-md-2"><label>Quantity Rejected</label>
				    <input id="txtQtyRej" type="text" class="decimal-places numberField" />
			     </div>
			     
				<div class="col-md-2"><label> Actual Time taken</label>
				    <input id="txtActTime" ondblclick="" type="text"  class="decimal-places numberField" />
				</div>
				
				<div class="col-md-2"><br>
				      <input id="btnAdd" class="btn btn-primary center-block" class="smallButton" type="button"
					value="Add" onclick="return btnAdd_onclick()" />
				</div>
			</div>
          
		<div class="dynamicTableContainer">
			<table style="height: 20px; border: #0F0; width: 100%;font-size:11px;font-weight: bold;">
               <tr bgcolor="#c0c0c0">
					<td width="6%">Product Code</td>
					<!--  COl1   -->
					<td width="11%">Product Name</td>
					<!--  COl2   -->
					<td width="6%">UOM</td>
					<!--  COl3   -->
					<td width="6%">Process Code</td>
					<td width="7%">Process</td>
					<!--  COl4   -->
					<td width="7%">Qty Produced</td>
					<!--  COl5   -->
					<td width="5%">Wt/Unit</td>
					<!--  COl6   -->
					<td width="5%">Total&nbsp;Wt</td>
					<!--  COl7   -->
					<td width="5%">Price / Unit</td>
					<!--  COl8   -->
					<td width="5%">Total Price</td>
					<!--  COl9   -->
					<td width="5%">Qty Rejected</td>
					<!--  COl10   -->
					<td width="5%">Qty Accepted</td>
					<!--  COl11   -->
					<td width="5%">Actual Time</td>
					<!--  COl12   -->
					<td width="3%">Delete</td>
					<!--  COl13   -->
				</tr>
			</table>
		 <div style="background-color: #fafbfb; border: 1px solid #ccc; display: block; height: 150px; margin: auto; overflow-x: hidden; overflow-y: scroll; width: 100%;">
              <table id="tblProdDet"
					style="width: 100%; border: #0F0; table-layout: fixed; overflow: scroll"
					class="transTablex col13-center">
					<tbody>
					<col style="width: 6%">
					<!--  COl1   -->
					<col style="width:10%">
					<!--  COl2   -->
					<col style="width:7%">
					<!--  COl3   -->
					<col style="width: 6%">
					<!--  COl4   -->
					<col style="width: 7%">
					<!--  COl5   -->
					<col style="width: 5%">
					<!--  COl6   -->
					<col style="width: 5%">
					<!--  COl7   -->
					<col style="width: 5%">
					<!--  COl8   -->
					<col style="width: 5%">
					<!--  COl9   -->
					<col style="width: 5%">
					<!--  COl10   -->
					<col style="width: 5%">
					<!--  COl11   -->
					<col style="width: 5%">
					<col style="width: 5%">
					<!--  COl12   -->
					<col style="width: 2%">
					<!--  COl13   -->

					<c:forEach items="${command.listProductionDtl}" var="pddtl"
						varStatus="status">
						<tr>
							<td><input name="listProductionDtl[${status.index}].strProdCode"
								value="${pddtl.strProdCode}" /></td>
							<td><input name="listProductionDtl[${status.index}].strProdName"
								value="${pddtl.strProdName}" /></td>
							<td><input name="listProductionDtl[${status.index}].strUOM"
								value="${pddtl.strUOM}" /></td>
							<td><input name="listProductionDtl[${status.index}].strProcessCode"
								value="${pddtl.strProcessCode}" /></td>
							<td><input name="listProductionDtl[${status.index}].dblQtyProd"
								value="${pddtl.dblQtyProd}" /></td>
							<td><input name="listProductionDtl[${status.index}].dblWeight"
								value="${pddtl.dblWeight}" /></td>
							<td><input value="${pddtl.dblWeight * pddtl.dblQtyProd}" /></td>
							<td><input name="listProductionDtl[${status.index}].dblQtyRej"
								value="${pddtl.dblQtyRej}" /></td>
							<td><input name="listProductionDtl[${status.index}].dblPrice"
								value="${pddtl.dblPrice}" type="hidden" /></td>
							<td><input name="listProductionDtl[${status.index}].dblActTime"
								value="${pddtl.dblActTime}" /></td>
							<td><input type="Button" class="deletebutton" value="Delete" /></td>
						</tr>
					</c:forEach>

					</tbody>
				</table>

			</div>
		</div>

          <div class="col-md-2"><label>Narration</label>
				<s:textarea id="txtNarration" cols="50" rows="3" path="strNarration" value="${command.strNarration}" style="width: 130%" />
			</div>

		
		<p align="center">
			<input type="submit" value="Submit" class="btn btn-primary center-block"
				onclick="return funCallFormAction('submit',this)" class="form_button" />
		    &nbsp;
		    <input type="reset" value="Reset" class="btn btn-primary center-block" class="form_button" onclick="funResetField()" />
		</p>
		<br><br>
		<div id="wait" style="display:none;width:60px;height:60px;border:0px solid black;position:absolute;top:60%;left:55%;padding:2px;">
				<img src="../${pageContext.request.contextPath}/resources/images/ajax-loader-light.gif" width="60px" height="60px" />
			</div>
	</s:form>
	</div>
	<script type="text/javascript">funApplyNumberValidation();</script>
</body>
</html>