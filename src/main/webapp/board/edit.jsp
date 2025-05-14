<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/common/navbar.jsp" %>
<%@ page import="Board.BoardDTO" %>
<%
    BoardDTO dto = (BoardDTO) request.getAttribute("dto");
%>
<html>
<head><title>게시글 수정</title></head>
<body>
    <h2>게시글 수정</h2>
    <form action="<%= request.getContextPath() %>/board/edit" method="post">
        <input type="hidden" name="boardId" value="<%= dto.getBoardId() %>">
        제목: <input type="text" name="title" value="<%= dto.getTitle() %>"><br>
        내용: <textarea name="content"><%= dto.getContent() %></textarea><br>
        <input type="submit" value="수정완료">
    </form>
</body>
</html>
