<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head><title>로그인</title></head>
<body>
    <h2>로그인 페이지</h2>
    <form action="login.do" method="post">
        아이디: <input type="text" name="username"><br>
        비밀번호: <input type="password" name="password"><br>
        <input type="submit" value="로그인">
    </form>

    <% if (request.getParameter("error") != null) { %>
        <p style="color:red;">로그인 실패. 다시 시도해주세요.</p>
    <% } %>
</body>
</html>