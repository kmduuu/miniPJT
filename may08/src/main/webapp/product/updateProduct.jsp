<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%@ page import="com.model2.mvc.service.domain.*" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />

	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
		<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<script type="text/javascript" src="../javascript/calendar.js"></script>
 	<script src="/javascript/bootstrap-dropdownhover.min.js"></script>

	<style>
		body {
            padding-top : 50px;
        	 }
    </style>
    
 <script type="text/javascript">   

 $(function() {
		//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$( "button.btn.btn-primary" ).on("click" , function() {
			fncUpdateProduct();
		});
	});	
	
	
	//============= "���"  Event ó�� ��  ���� =============
	$(function() {
		//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$("href=#").on("click" , function() {
			history.go(-1);
		});
	});
	
	
	$(function() {
		//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$("a.btn.btn-primary").on("click" , function() {
			self.location = "/product/listProduct"
		});
	});	
 
	function fncUpdateProduct() {
		var name=$("input[name='prodName']").val();
		
		if(name == null || name.length <1){
			alert("��ǰ���� �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}
				
		$("form").attr("method" , "POST").attr("action" , "/product/updateProduct").submit();
	}
	</script>

</head>

<body>
<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header text-center">
	       <h3 class=" text-info">��ǰ��������</h3>
	       <h5 class="text-muted">�� ��ǰ�� <strong class="text-danger">�����</strong> �� �ּ���.</h5>
	    </div>
	    
<form name="detailForm" method="post" class="form-horizontal">



<input type="hidden" name="prodNo" value="${product.prodNo}"/>

	<div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">��ǰ��</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="prodName" name="prodName"  value="${product.prodName}">
		    </div>
	</div>
	
	<div class="form-group">
		    <label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">��ǰ������</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="prodDetail" name="prodDetail"  value="${product.prodDetail}">
		    </div>
	</div>
	
	<div class="form-group">
		    <label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">��������</label>
		    <div class="col-sm-4">
		      <input type="text" readonly="readonly" class="form-control" id="manuDate" name="manuDate"  value="${product.manuDate}">
		      <img 	src="../images/ct_icon_date.gif" width="15" height="15" 
									onclick="show_calendar('document.detailForm.manuDate', document.detailForm.manuDate.value)" />
		    </div>
	</div>
	
	<div class="form-group">
		    <label for="price" class="col-sm-offset-1 col-sm-3 control-label">����</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="price" name="price" value="${product.price}">
		</div>
	</div>
	
	<div class="form-group">
		    <label for="file" class="col-sm-offset-1 col-sm-3 control-label">��ǰ�̹���</label>
		    <div class="col-sm-4">
		      <input type="file" name="fileName" class="ct_input_g"  id="fileName" value="${product.fileName}">
		</div>
	</div>
	
	

	<div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  >�� &nbsp;��</button>
			  <a class="btn btn-primary" href="#" role="button">�� &nbsp;��</a>
		    </div>
	</div>
		  
		</form>
		
	</div>
	
</body>

</html>
