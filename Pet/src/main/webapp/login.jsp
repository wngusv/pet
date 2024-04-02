<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>로그인 창</title>
<style>
body {
	font-family: sans-serif;
}

.login-wrapper {
	margin: 50px auto;
	width: 300px;
	border: 1px solid #ddd;
	padding: 20px;
}

h2 {
	text-align: center;
	margin-bottom: 20px;
}

input[type="text"], input[type="password"] {
	width: 100%;
	padding: 10px;
	margin-bottom: 10px;
	border: 1px solid #ccc;
}

input[type="submit"] {
	width: 100%;
	padding: 10px;
	background-color: #4caf50;
	color: white;
	border: none;
	cursor: pointer;
}
</style>
 <script>
    document.addEventListener('DOMContentLoaded', function() {
        // 아이디찾기 버튼에 클릭 이벤트 리스너 추가
        document.getElementById('findID').addEventListener('click', function() {
            // "아이디 찾기" 페이지로 이동
            window.location.href = 'findID.jsp'; // 아이디 찾기 페이지의 URL로 변경해야 함
        });
    });
    document.addEventListener('DOMContentLoaded', function() {
        // 아이디찾기 버튼에 클릭 이벤트 리스너 추가
        document.getElementById('findPW').addEventListener('click', function() {
            // "아이디 찾기" 페이지로 이동
            window.location.href = 'findPW.jsp'; // 비번 찾기 페이지의 URL로 변경해야 함
        });
    });
    </script>
</head>
<body>
	<div class="login-wrapper">
		<h2>로그인</h2>
		 <div id="login-error" style="color: red; text-align: center;"></div>
		<form method="post" action="api/login" id="login-form">
			<input type="text" name="userId" placeholder="아이디" /> <input
				type="password" name="userPassword" placeholder="비밀번호" /> <input
				type="submit" value="로그인" />
			<button type="button" id="findID">아이디찾기</button>
			<button type="button" id="findPW">비밀번호찾기</button>
		</form>
	</div>
	<script>
		// URL의 쿼리스트링에서 loginStatus가 fail인 경우 실패 알림을 표시
		const urlParams = new URLSearchParams(window.location.search);
		if (urlParams.has('loginStatus')
				&& urlParams.get('loginStatus') === 'fail') {
			document.getElementById('login-error').innerText = "로그인에 실패했습니다. 아이디와 비밀번호를 확인하세요.";
		}
	</script>
</body>
</html>