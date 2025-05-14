<%@ page contentType="text/html; charset=UTF-8" session="true" %>
<%@ include file="/common/navbar.jsp" %>
<%
    Object userId = session.getAttribute("userid");
    if (userId == null) {
        response.sendRedirect(request.getContextPath() + "/login/login.jsp");
        return;
    }
%>
<html>
<head>
    <title>글 작성</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            padding: 40px;
            background-color: #f7f7f7;
        }
        h2 {
            color: #333;
        }
        .form-box {
            width: 600px;
            margin: auto;
            background: white;
            padding: 30px;
            border-radius: 6px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        .form-box input[type="text"],
        .form-box textarea {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 15px;
        }
        .form-box textarea {
            resize: vertical;
            min-height: 150px;
        }
        .form-box input[type="submit"] {
            width: 100%;
            padding: 12px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            font-weight: bold;
            font-size: 16px;
            cursor: pointer;
        }
        .form-box input[type="submit"]:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>

    <div class="form-box">
        <h2>📝 게시글 작성</h2>
        <form action="<%= request.getContextPath() %>/board/write" method="post">
            제목: <input type="text" name="title" required><br>
            내용: <textarea name="content" required></textarea><br>
            <input type="submit" value="작성">
        </form>
    </div>

</body>
</html>
