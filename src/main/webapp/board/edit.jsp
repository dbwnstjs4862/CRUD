<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/common/navbar.jsp" %>
<%@ page import="Board.BoardDTO" %>
<%
    BoardDTO dto = (BoardDTO) request.getAttribute("dto");
%>
<html>
<head>
    <title>게시글 수정</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f7f7f7;
            padding: 40px;
        }

        .form-box {
            width: 600px;
            margin: 60px auto;
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        h2 {
            margin-bottom: 20px;
            color: #333;
        }

        input[type="text"],
        textarea {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }

        textarea {
            resize: vertical;
            height: 150px;
        }

        input[type="submit"] {
            padding: 12px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            font-weight: bold;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>

    <div class="form-box">
        <h2>✏ 게시글 수정</h2>
        <form action="<%= request.getContextPath() %>/board/edit" method="post">
            <input type="hidden" name="boardId" value="<%= dto.getBoardId() %>">

            제목:
            <input type="text" name="title" value="<%= dto.getTitle() %>" required>

            내용:
            <textarea name="content" required><%= dto.getContent() %></textarea>

            <input type="submit" value="수정 완료">
        </form>
    </div>

</body>
</html>