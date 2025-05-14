<%@ page contentType="text/html; charset=UTF-8" session="true" %>
<%@ include file="/common/navbar.jsp" %>
<%
    String name = (String) session.getAttribute("name");
%>
<html>
<head>
    <title>회원가입 완료</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            padding: 40px;
            background-color: #f7f7f7;
            text-align: center;
        }
        .success-box {
            background: white;
            display: inline-block;
            padding: 40px 60px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        .success-box h2 {
            color: #4CAF50;
            margin-bottom: 20px;
        }
        .success-box p {
            font-size: 18px;
            color: #333;
            margin-bottom: 30px;
        }
        .success-box a {
            display: inline-block;
            padding: 10px 20px;
            background: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 4px;
        }
        .success-box a:hover {
            background: #45a049;
        }
    </style>
</head>
<body>

    <div class="success-box">
        <h2>✅ 회원가입 완료</h2>
        <p><%= name != null ? name : "회원" %>님, 가입을 환영합니다!</p>
        <a href="<%= request.getContextPath() %>/login/login.jsp">로그인하러 가기</a>
    </div>

</body>
</html>
