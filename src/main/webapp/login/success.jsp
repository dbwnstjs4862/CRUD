<%@ page contentType="text/html; charset=UTF-8" session="true" %>
<%
    int userId = (Integer) session.getAttribute("userid");       // 글쓰기 등 DB 작업용
    String username = (String) session.getAttribute("username"); // 환영 메시지 등 출력용
%>


<html>
<head><title>로그인 성공</title></head>
<body>
    <h2>로그인 성공!</h2>
    <p><%= username %>님 환영합니다.</p>
    <a href="<%= request.getContextPath() %>/logout">로그아웃</a>
    <a href="<%= request.getContextPath() %>/board/write.jsp">글쓰기</a>
</body>
</html>
