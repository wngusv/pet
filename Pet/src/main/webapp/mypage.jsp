<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.http.HttpSession, Util.MyWebContextListener" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>마이페이지</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <h1>마이페이지</h1>
    <% 
    try {

        String userId = (String) session.getAttribute("userId");
        
        // DB 연결
        Connection connection = MyWebContextListener.getConnection();
        Statement stmt = connection.createStatement();
        
        // 회원 정보 가져오기
        String userInfoQuery = "SELECT * FROM pet.user WHERE id = '" + userId + "'";
        ResultSet userInfoRs = stmt.executeQuery(userInfoQuery);
        if (userInfoRs.next()) {
            String id = userInfoRs.getString("id");
            String password = userInfoRs.getString("pw");
            String userName = userInfoRs.getString("user_name");
            String address = userInfoRs.getString("address");
            String addressDetail = userInfoRs.getString("address_detail");
    %>
    <div>
        <h2>회원 정보</h2>
        <p><strong>아이디:</strong> <%= id %></p>
        <p><strong>패스워드:</strong> <%= password %></p>
        <p><strong>이름:</strong> <%= userName %></p>
        <p><strong>주소:</strong> <%= address %> <%= addressDetail %></p>
    </div>
    <div>
        <h2>내가 쓴 글 보기</h2>
        <p><a href="내가_쓴_글_목록_페이지.jsp">내가 쓴 글 목록 보기</a></p>
    </div>
    <div>
        <h2>내 채팅방 보기</h2>
        <p><a href="내_채팅방_목록_페이지.jsp">내 채팅방 목록 보기</a></p>
    </div>
    <% 
        } else {
            // 회원 정보가 없는 경우
            out.println("회원 정보를 찾을 수 없습니다.");
        }
    } catch (Exception e) {
        out.println("오류가 발생했습니다. 오류 메시지: " + e.getMessage());
    }
    %>
</body>
</html>