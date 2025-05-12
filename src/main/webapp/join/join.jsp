<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <title>회원가입</title>
</head>
<body>
    <h2>회원가입</h2>
    <form action="JoinController" method="post">
        아이디: <input type="text" name="username"><br>
        비밀번호: <input type="password" name="password"><br>
        이름: <input type="text" name="name"><br>
        나이: <input type="number" name="age"><br>
        <input type="submit" value="가입하기">
    </form>
</body>
</html>