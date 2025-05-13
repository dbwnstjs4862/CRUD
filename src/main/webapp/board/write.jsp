<%@ page contentType="text/html; charset=UTF-8" session="true" %>
<%
    Object userId = session.getAttribute("userid");
    if (userId == null) {
        response.sendRedirect(request.getContextPath() + "/login/login.jsp");
        return;
    }
%>
<html>
<head><title>글 작성</title></head>
<body>
    <h2>게시글 작성</h2>
    <form action="<%= request.getContextPath() %>/board/write" method="post">
        제목: <input type="text" name="title"><br>
        내용: <textarea name="content"></textarea><br>
        <input type="submit" value="작성">
    </form>
</body>
</html>