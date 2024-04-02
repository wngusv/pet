<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>산책 아르바이트</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <header>
        <div class="container">
            <h1>산책  아르바이트</h1>
            <nav>
                <ul>
                    <li><a href="index.jsp">홈으로</a></li>
                    <li><a href="signupform.jsp">회원가입</a></li>
                    <li><a id="login-button" href="login.jsp">로그인</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <main>
        <div class="container">
            <section class="strays-info">
                <h2>산책 아르바이트</h2>
                <!-- 글쓰기 버튼 추가 -->
                <button onclick="location.href='dogwalking/form_new.jsp'">글쓰기</button>
            </section>
        </div>
    </main>

    <footer>
        <div class="container">
            <p>&copy; 2024 Pet. 모든 권리 보유.</p>
        </div>
    </footer>
</body>
</html>