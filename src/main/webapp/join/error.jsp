<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/common/navbar.jsp" %>
<%
    String reason = request.getParameter("reason");
    String message = "알 수 없는 오류가 발생했습니다.";
    if ("duplicate".equals(reason)) {
        message = "이미 존재하는 아이디입니다.";
    }
%>
<html>
<head>
    <title>회원가입 실패</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            padding: 40px;
            background-color: #f7f7f7;
            text-align: center;
        }
        .error-box {
            background: white;
            display: inline-block;
            padding: 40px 60px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        .error-box h2 {
            color: #e74c3c;
            margin-bottom: 20px;
        }
        .error-box p {
            font-size: 18px;
            color: #555;
            margin-bottom: 30px;
        }
        .error-box a {
            display: inline-block;
            padding: 10px 20px;
            background: #e74c3c;
            color: white;
            text-decoration: none;
            border-radius: 4px;
        }
        .error-box a:hover {
            background: #c0392b;
        }
    </style>
</head>
<body>
    <div class="error-box">
        <h2>❌ 회원가입 실패</h2>
        <p><%= message %></p>
        <a href="<%= request.getContextPath() %>/join/join.jsp">다시 시도하기</a>
    </div>
</body>
</html>
