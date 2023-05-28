<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="UTF-8"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="UTF-8">
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style></style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
		
		//=============  "중복확인"  Event 처리 =============
		$(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			 $("#agree").on("click" , function() {
				 
					var phone2 = $("input[id='phone2']").val();
					var phone3 = $("input[id='phone3']").val();
					
					
					if(phone2.length == 4 && phone3.length == 4) { // 숫자 4글자 제한도 기억하기
						
						alert("인증번호를 발송하였습니다.");
						var phone = $("option:selected").val() + $("input[name='phone2']").val() + $("input[name='phone3']").val();
						
						var rnd = Math.floor(Math.random() * 9000) + 1000;
						
						// HTML 요소 생성
						var newDiv = document.createElement("div");

						// hidden 속성 추가
						var newInput = document.createElement("input");
						newInput.type = "hidden";
						newInput.name = "rnd";
						newInput.value = rnd;

						// 생성된 hidden 요소를 div 요소에 추가
						newDiv.appendChild(newInput);
						// 생성된 div 요소를 body 태그에 추가
						document.body.appendChild(newDiv);
						
						$.ajax({
						      type: "POST",
						      url: "/user/check",
						      data: { phone:phone,
						    	  rnd:rnd
						    	  },
						      success: function(data) {
						      }
						    });
					
						$("#phone2, #phone3").prop('readonly', true); // 번호 입력 성공 시 ReadOnly 전환
						$('#phone1').prop('disabled', true); // 선택 바는 ReadOnly를 Disabled 설정으로 전환
						const verifyGroup = document.getElementById('verify-group');
						verifyGroup.style.display = 'block'; // 감춰진 내용 보이기 
							
							var duration = 20; // 5분(300초) 설정
							var timer = setInterval(function() {
							var min = parseInt(duration / 60, 10);
							var sec = parseInt(duration % 60, 10);
							
							min = min < 10 ? "0" + min : min;
							sec = sec < 10 ? "0" + sec : sec;
							
							document.getElementById("timer").innerHTML = min + ":" + sec;
					
								if (--duration < 0) {
									clearInterval(timer);
									alert("인증이 만료되었습니다. 다시 혀~");
									verifyGroup.style.display = 'none';
								}
							}, 1000); // 1초 간격으로 실행	
					}
					else {
						alert("입력한 휴대폰 번호를 다시 확인해 주세요.");
						const verifyGroup = document.getElementById('verify-group');
						return;
					}
			});
		});
		
		//==> 확인을 누른다. 
		$(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			 $("#verify-button").on("click" , function() {
				 	
					var verify = $("input[id='verify-code']").val();
					var random = $("input[name='rnd']").val();
					if(verify == random) { // 숫자 4글자 제한도 기억하기 
						alert("인증이 완료되었습니다.");
						var phone = $("option:selected").val() + $("input[name='phone2']").val() + $("input[name='phone3']").val();
						
					if(opener){
						opener.phone.value = phone;
						opener.$("input[name='email']").focus();
						
					}
					window.close();
					}
					else {
						alert("인증번호를 다시 입력해 주세요!");
						return;
					}
			});
		});

	</script>
	
</head>

<body>
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
		
		<br/><br/>
		
		<!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal">
		
		 <div class="form-group">
		    <label class="col-sm-offset-1 col-sm-3 control-label">휴대전화번호</label>
		     <div class="col-sm-2">
		      <select class="form-control" name="phone1" id="phone1">
				  	<option value="010" >010</option>
					<option value="011" >011</option>
					<option value="016" >016</option>
					<option value="018" >018</option>
					<option value="019" >019</option>
			  </select>
		    </div>
		    <div class="col-sm-2">
		      <input type="text" class="form-control" id="phone2" name="phone2" placeholder="번호" ">
		    </div>
		    <div class="col-sm-2">
		      <input type="text" class="form-control" id="phone3" name="phone3" placeholder="번호" >
		    </div>
		    <input type="hidden" id="phone" name="phone" />
		    <button type="button" class="btn btn-primary" id="agree">인증번호 발송 </button>
		    
		    <br><div id="verify-group" style="display:none;">
  				<label class="col-sm-offset-1 col-sm-3 control-label" for="verify-code">인증번호</label>
  				<div class="col-sm-2">
  				<input type="text" class="form-control" id="verify-code" name="verifyCode">
  				</div>
  				<button type="button" class="btn btn-primary" id="verify-button">확인</button>
  				남은 시간: <span id="timer">00:20</span>
			</div>
		    
		</div>
		</form>
		<!-- form Start /////////////////////////////////////-->
	
 	</div>
 	<!--  화면구성 div End /////////////////////////////////////-->

</body>

</html>
