<%@ page contentType="text/html; charset=UTF-8" session="true" %>
<%@ include file="/common/navbar.jsp" %>
<%
    Integer userId = (Integer) session.getAttribute("userid");       // DB 작업용
    String username = (String) session.getAttribute("username");     // 출력용

    if (userId == null || username == null) {
        response.sendRedirect(request.getContextPath() + "/login/login.jsp?error=unauthorized");
        return;
    }
%>
<html>
<head>
    <title>로그인 성공</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f4f4f4;
            padding: 60px;
        }

        .success-box {
            width: 450px;
            margin: 100px auto;
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .success-box h2 {
            color: #4CAF50;
            margin-bottom: 20px;
        }

        .success-box p {
            font-size: 16px;
            color: #333;
            margin-bottom: 30px;
        }

        .success-box a {
            text-decoration: none;
            display: inline-block;
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            margin: 0 10px;
            border-radius: 5px;
            font-weight: bold;
        }

        .success-box a:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>

    <div class="success-box">
        <h2>🎉 로그인 성공</h2>
        <p><strong><%= username %></strong>님 환영합니다.</p>
        <a href="<%= request.getContextPath() %>/board/list">📋 게시판 보기</a>
        <a href="<%= request.getContextPath() %>/board/write.jsp">글쓰기</a>
        <a href="<%= request.getContextPath() %>/logout">로그아웃</a>
    </div>

</body>
</html>
