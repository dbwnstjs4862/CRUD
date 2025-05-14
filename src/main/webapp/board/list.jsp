<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/common/navbar.jsp" %>
<%@ page import="java.util.*, Board.BoardDTO" %>
<html>
<head>
    <title>게시판 목록</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            padding: 30px;
            background: #f7f7f7;
        }
        h2 {
            color: #333;
        }
        .board-table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        }
        .board-table th, .board-table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        .board-table th {
            background-color: #f0f0f0;
        }
        .btn-write {
            display: inline-block;
            margin-top: 20px;
            padding: 8px 16px;
            background: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 4px;
        }
        .btn-write:hover {
            background: #45a049;
        }
    </style>
</head>
<body>
    <h2>📋 게시판 목록</h2>

    <table class="board-table">
        <tr>
            <th>제목</th>
            <th>작성자</th>
            <th>작성일</th>
        </tr>
        <%
            List<BoardDTO> list = (List<BoardDTO>) request.getAttribute("boardList");
            for (BoardDTO dto : list) {
        %>
        <tr>
            <td>
   				<a href="<%= request.getContextPath() %>/board/detail?id=<%= dto.getBoardId() %>">
      				<%= dto.getTitle() %>
   			 	</a>
			</td>
            <td><%= dto.getWriterName() %></td>
            <td><%= dto.getCreatedAt() %></td>
        </tr>
        <% } %>
    </table>

    <a class="btn-write" href="<%= request.getContextPath() %>/board/write">글쓰기</a>
</body>
</html>
