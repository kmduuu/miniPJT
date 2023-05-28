<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!DOCTYPE html>

<html lang="ko">

<head>
	<meta charset="UTF-8">
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

<style>
       body > div.container{
        	border: 3px solid #D6CDB7;
            margin-top: 10px;
        }
</style>
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script src="../javascript/calendar.js"></script>
<script type="text/javascript">
    
    
function fncAddProduct(){
	//Form ��ȿ�� ����
	
	var name =$("input[name='prodName']").val();
	var detail =$("input[name='prodDetail']").val();
	var manuDate =$("input[name= 'manuDate']").val();
	var price =$("input[name='price']").val();

	if(name == null || name.length<1){
		alert("��ǰ���� �ݵ�� �Է��Ͽ��� �մϴ�.");
		return;
	}
	if(detail == null || detail.length<1){
		alert("��ǰ�������� �ݵ�� �Է��Ͽ��� �մϴ�.");
		return;
	}
	if(manuDate == null || manuDate.length<1){
		alert("�������ڴ� �ݵ�� �Է��ϼž� �մϴ�.");
		return;
	}
	if(price == null || price.length<1){
		alert("������ �ݵ�� �Է��ϼž� �մϴ�.");
		return;
	}
	
	//document.detailForm.action='/product/addProduct';
	//document.detailForm.submit();
	$("form").attr("method" , "POST").attr("action" , "/product/addProduct").submit();
	
}

function resetData(){
	document.detailForm.reset();
}

$(function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//==> 1 �� 3 ��� ���� : $("tagName.className:filter�Լ�") �����.	
			 $( "button.btn.btn-primary" ).on("click" , function() {
				//Debug..
				//alert(  $( "td.ct_btn01:contains('����')" ).html() );
				fncAddProduct();
			});
		});	
 
$(function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//==> 1 �� 3 ��� ���� : $("tagName.className:filter�Լ�") �����.	
			 $("a[href='#' ]").on("click" , function() {
					//Debug..
					//alert(  $( "td.ct_btn01:contains('���')" ).html() );
					$("form")[0].reset();
			});
		});	

$(function() {
	//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
	//==> 1 �� 3 ��� ���� : $("tagName.className:filter�Լ�") �����.	
	//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
	//==> 1 �� 3 ��� ���� : $("tagName.className:filter�Լ�") �����.	
	 $('#ronaldo').on("click" , function() {
			//Debug..
			//alert(  $( "div").html() );
		 show_calendar('document.detailForm.manuDate', document.detailForm.manuDate.value);
	});
});	

</script>
</head>

<body bgcolor="#ffffff" text="#000000">

	<div class="navbar  navbar-default">
        <div class="container">
        	<a class="navbar-brand" href="/index.jsp">Model2 MVC Shop</a>
   		</div>
	</div>

		<div class="container">
	
		<h1 class="bg-primary text-center">�� ǰ �� ��</h1>
		
		<form class="form-horizontal" name="detailForm" enctype="multipart/form-data">
		
 		<div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">��ǰ��</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="prodName" name="prodName">
		    </div>
		 </div>
		<div class="form-group">
		    <label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">��ǰ������</label>
		    <div class="col-sm-4">
		      <input type="prodDetail" class="form-control" id="prodDetail" name="prodDetail">
		    </div>
		 </div>
		 
		 <div class="form-group">
		    <label for="price" class="col-sm-offset-1 col-sm-3 control-label">����</label>
		    <div class="col-sm-4">
		      <input type="price" class="form-control" id="price" name="price">
		    </div>
		 </div>
		 
		<div class="form-group">
		   <label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">��������</label>
		   <div class="col-sm-4">
		   <input type="manuDate" class="form-control" id="manuDate" readonly="readonly" name="manuDate">
		   <img id = "ronaldo" src= "../images/ct_icon_date.gif" width="15" height="15" />
		   </div>
		 </div>
	
		<div class="form-group">
			<label for="file" class="col-sm-offset-1 col-sm-3 control-label">��ǰ�̹���</label>
			<div class="col-sm-4">
			<input type="file" class="form-control" id="fileName" name="file">
			</div>
		</div>

		<div class="form-group">
		  <div class="col-sm-offset-4  col-sm-4 text-center">
  			<button type="button" class="btn btn-primary"  >��&nbsp;��</button>
		  <a class="btn btn-primary btn" href="#" role="button">��&nbsp;��</a>
		</div>
		
	</div>
	</form>
	
	</div>
	
</body>
</html>
