<%@ page contentType="text/html; charset=UTF-8" session="true" %>
<html>
<head>
    <title>회원가입</title>
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
            width: 400px;
            margin: auto;
            background: white;
            padding: 30px;
            border-radius: 6px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        .form-box input[type="text"],
        .form-box input[type="password"],
        .form-box input[type="number"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .form-box input[type="submit"] {
            width: 100%;
            padding: 12px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            font-weight: bold;
            cursor: pointer;
        }
        .form-box input[type="submit"]:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>

    <div class="form-box">
        <h2>👤 회원가입</h2>
        <form action="join" method="post">
            아이디: <span id="usernameCheck" style="font-size: 13px; color: gray;"></span>
		    <input type="text" id="username" name="username" required><br>
            비밀번호: <input type="password" name="password" required><br>
            이름: <input type="text" name="name" required><br>
            나이: <input type="number" name="age" required><br>
            <input type="submit" value="가입하기">
        </form>
    </div>
	
	<script>
	document.getElementById("username").addEventListener("blur", function () {
	    const username = this.value.trim();
	    if (!username) return;
	
	    fetch("<%= request.getContextPath() %>/check-username?username=" + encodeURIComponent(username))
	        .then(res => res.text())
	        .then(msg => {
	            const span = document.getElementById("usernameCheck");
	            span.innerText = msg;
	            span.style.color = msg.includes("사용 가능") ? "green" : "red";
	        });
	});
	</script>
	
</body>
</html>
