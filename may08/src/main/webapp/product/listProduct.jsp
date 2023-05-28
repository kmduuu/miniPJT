<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>

<html lang="ko">

<head>
	<meta charset="EUC-KR">
	
<title>��ǰ �����ȸ</title>

<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

	<!-- Bootstrap Dropdown Hover CSS -->
   	<link href="/css/animate.min.css" rel="stylesheet">
   	<link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
    <!-- Bootstrap Dropdown Hover JS -->
  	<script src="/javascript/bootstrap-dropdownhover.min.js"></script>
   
   
   	<!-- jQuery UI toolTip ��� CSS-->
  	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  	<!-- jQuery UI toolTip ��� JS-->
  	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  
 	 <style>
	  body {
            padding-top : 50px;
        }
   	 </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	
		//=============    �˻� / page �ΰ��� ��� ���  Event  ó�� =============	
		function fncGetProductList(currentPage) {
			$("#currentPage").val(currentPage)
			$("form").attr("method" , "POST").attr("action" , "/product/listProduct?menu=${menu}").submit();
		}
		
		
		//============= "�˻�"  Event  ó�� =============	
		 $(function() {
			 //==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			 $( "button.btn.btn-default" ).on("click" , function() {
				fncGetProductList(1);
			});
		 });
		
		 $(function() {
				
				//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
				$( "td:nth-child(2)" ).on("click" , function() {
					
					var text1 = $(this).children("input:hidden").val();
					
					if(${menu eq 'manage'}){
						self.location ="/product/updateProductView?prodNo="+text1;
					}
					else{
						self.location ="/product/getProduct?menu=${menu}&prodNo="+text1;
					}
					
		});
							
				//==> prodNo LINK Event End User ���� ���ϼ� �ֵ��� 
				$( "td:nth-child(2)" ).css("color" , "red");
		});
	
	// �˻� / page �ΰ��� ��� ��� Form ������ ���� JavaScrpt �̿�  
	//function fncGetProductList(currentPage) {
	//	document.getElementById("currentPage").value = currentPage;
	//  	document.detailForm.submit();		
	//}
	
	$(function(){	
		$(".ct_list_pop td:nth-child(6)").on("click", function(){
			
			var hiddenInputValue = document.getElementById('hiddenInput').value;
			alert(hiddenInputValue); 
			$.ajax( // �񵿱�� Ajax�� �̿��Ͽ� Http ��û�� �����Ѵ�.
					// �����͸� �ְ�޴� ������ ���
					// �Ƹ� JSON�������� �ְ����(?)
					
					{
					url : "/product/json/getProduct/"+hiddenInputValue,
					method : "GET",
					dataType : "json" ,
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					}, 
					success : function(JSONData, status)
					// status == 200, stats == 4 
					{
						var displayValue = "<h3>"
													+"��ǰ�� : "+JSONData.prodName+"<br/>"
													+"������ : "+JSONData.prodDetail+"<br/>"
													+"�������� : "+JSONData.manuDate+"<br/>"
													+"���� : "+JSONData.price+"<br/>"
													+"������� : "+JSONData.regDateString+"<br/>"
													+"</h3>";
													
						$("h3").remove();
						$( "#"+hiddenInputValue+"" ).html(displayValue);
					}
				});
			
			});
		
		
		$( ".ct_list_pop td:nth-child(2)" ).css("color" , "red");
		$("h7").css("color" , "red");
		
		
		$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
		//<a href="/product/updateProductView?prodNo=${product.prodNo}">${product.prodName}</a>
	});
	
	$(document).ready(function() {
	$('#searchKeyword').click('keydown',function(){
		var condition = $("select[name=searchCondition]").val()
		
		$.ajax( 
				{
					url : "/product/json/getProdListAutoComplete/"+condition ,
					method : "POST" ,
					dataType : "json" ,
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
					success : function(JSONData , status) {
						var list = JSONData;
						console.log(list)
						$("#searchKeyword").autocomplete({
							source:list
						});
					}
			}); 
	});	
	  });
</script>

</head>

<body>
	
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header text-info">
		
	       <c:if test="${menu eq 'manage'}">
							<h3>��ǰ����</h3>
		   </c:if>
		   <c:if test="${menu eq 'search' }">
							<h3>��ǰ�����ȸ</h3>
		   </c:if>
	    </div>
	    
		<div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}  ������
		    	</p>
		</div>

		<div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			    
				  <div class="form-group">
				    <select class="form-control" name="searchCondition" >
						<option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>��ǰ��ȣ</option>
						<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>��ǰ��</option>
						<option value="2"  ${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>����</option>
					</select>
		</div>

				<div class="form-group">
				    <label class="sr-only" for="searchKeyword">�˻���</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="�˻���" value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				</div>

			<button type="button" class="btn btn-default">�˻�</button>
				  
				  <!-- PageNavigation ���� ������ ���� ������ �κ� -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  
				</form>
		</div>
	</div>
	<table class="table table-hover table-striped" >
	<thread>
	<tr>
	<th align="center">No</th>
	<th align="left">��ǰ��</th>
	<th align="left">����</th>
	<th align="left">�����</th>
	<th align="left">������</th>
	<th align="left">��������</th>
	</tr>
	</thread>
	
	<tbody>
		 <c:set var="i" value="0" />
		  <c:forEach var="product" items="${list}">
			<c:set var="i" value="${ i+1 }" />
			<tr class="ct_list_pop">
			  <td align="center">${i}</td>
			  <td align="left" title="Click : ��ǰ���� Ȯ��">${product.prodName}
			  <input type="hidden" id="hiddenInput" value="${product.prodNo}">
			  </td>
			  <td align="left">${product.price}</td>
			  <td align="left">${product.manuDate}</td>
			  <td align="left">${product.prodDetail}</td>
			  <td align="left">.
			</tr>
          </c:forEach>
        
       </tbody>
</table>
</div>
			<jsp:include page="../common/pageNavigator_new2.jsp"/>	

</body>
</html>
