<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page session="true" %>
<html>
<head><title>로그인 성공</title></head>
<body>
    <h2>로그인 성공!</h2>
    <p><%= session.getAttribute("userid") %>님 환영합니다.</p>
</body>
</html>
