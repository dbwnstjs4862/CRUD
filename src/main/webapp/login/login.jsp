<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/common/navbar.jsp" %>
<html>
<head>
    <title>로그인</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f7f7f7;
            padding: 40px;
        }

        .login-box {
            width: 400px;
            margin: 80px auto;
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 25px;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 12px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }

        input[type="submit"] {
            width: 100%;
            padding: 12px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            font-weight: bold;
            font-size: 15px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
        }

        .error-message {
            color: red;
            font-size: 13px;
            text-align: center;
            margin-top: 10px;
        }
    </style>
</head>
<body>
	
    <div class="login-box">
        <h2>🔐 로그인</h2>
        <form action="login.do" method="post">
            <input type="text" name="username" placeholder="아이디" required>
            <input type="password" name="password" placeholder="비밀번호" required>
            <input type="submit" value="로그인">
        </form>

        <% if (request.getParameter("error") != null) { %>
            <div class="error-message">❌ 로그인 실패. 다시 시도해주세요.</div>
        <% } %>
    </div>
	<%
	    String message = request.getParameter("message");
		if ("needLogin".equals(message)) {
	%>
		    <script>
		        alert("글쓰기는 로그인한 회원만 가능합니다.");
		    </script>
	<% 
		}
	%>
</body>
</html>
