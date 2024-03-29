<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<script>
// 페이지가 로드될 때 함수를 실행
document.addEventListener('DOMContentLoaded', function () {
    // 입력 필드와 버튼 요소를 가져옴
    var nameInput = document.getElementById('name');
    var phoneInput = document.getElementById('phone');
    var certificationButton = document.getElementById('certificationNumber');

    // 입력 필드에 이벤트 리스너 추가
    nameInput.addEventListener('input', toggleCertificationButton);
    phoneInput.addEventListener('input', toggleCertificationButton);

    // 처음에 버튼 상태 설정
    toggleCertificationButton();

    // 버튼 활성화/비활성화 함수
    function toggleCertificationButton() {
        // 이름 입력란에 값이 있고, 전화번호 입력란의 길이가 11자리 숫자인지 확인
        certificationButton.disabled = !nameInput.value.trim() || !(phoneInput.value.length === 11 && /^\d+$/.test(phoneInput.value));
    }
});
</script>
</head>
<body>
<h2>아이디 찾기</h2>
 <label for="name">이름</label> 
 <input type="text" id="name" name="name" required>
 
 <label for="phone">전화번호</label> 
 <input type="text" maxlength="11" id="phone" name="phone" required oninput="this.value = this.value.replace(/[^0-9]/g, '')">

 <button type="button" id="certificationNumber" disabled>인증번호 받기</button>

 <p>인증번호:</p>
 <input type="text" id="checkNumber" name="checkNumber" class="gray-text" placeholder="5자리 숫자를 입력하세요." required />
</body>
</html>