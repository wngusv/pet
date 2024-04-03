<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>게시판</title>
</head>
<script>
	// < 업로드용 폼 화면 > 
	function validateForm(form){
		if(form.title.value == ""){
			alert("제목을 입력하세여")
			form.title.focus();
			return false;
		}
	}
</script>
<body>
 <form name="writeForm" method="post"enctype="multipart/form-data" action="/UploadProcess.do" onsubmit="return validateForm(this);">
    <!-- 파일을 업로드하기 위해 enctype을 multipart/form-data로 설정 -->
    <table border="1" width=500>
        <tr>
            <th colspan="2">
                 글쓰기
            </th>
        </tr>
        <tr>
       
            <td width=50>
                <select name="category">
                    <option value="소통">소통</option>
                    <option value="긴급">긴급</option>
                    <option value="후기">후기</option>
                </select>
            </td>
            <td >
               <input type="text" name="title" placeholder="제목을 입력하세요."
                maxlength="20"
                style="width:100%">
            </td>
        </tr>
        
        <tr>
            <td colspan="2" height=400>
               <textarea name="content" placeholder="내용을 입력하세요." style="width: 100%; height: 100%"></textarea>
            </td>
        </tr>
        <tr>
            <td >첨부 파일</td>
            <td >
                <input type="file" name="oFile"/>
            </td>
        </tr>
        <tr>
            <td colspan="2" align=right>
                <input type="submit" value="글쓰기">
                <input type="button" value="목록으로" onclick="location.href='board.jsp';">
            </td>
        </tr>
    </table>
</form>
</body>
</html>