<%@ page contentType="text/html; charset=UTF-8" session="true" %>
<div style="background: #333; padding: 14px; display: flex; justify-content: space-between; align-items: center;">
    
    <!-- 왼쪽 메뉴 -->
    <div>
        <a href="<%= request.getContextPath() %>/board/list" style="color:white; margin-right: 20px;">📋 게시판</a>
		<a href="<%= request.getContextPath() %>/board/write" style="color:white; margin-right: 20px;">✍ 글쓰기</a>
    </div>

    <!-- 오른쪽 메뉴 -->
    <div>
        <% if (session.getAttribute("username") != null) { %>
            <span style="color: white; margin-right: 20px;">👤 <%= session.getAttribute("username") %></span>
            <a href="<%= request.getContextPath() %>/logout" style="color:white;">🚪 로그아웃</a>
        <% } else { %>
            <a href="<%= request.getContextPath() %>/login/login.jsp" style="color:white; margin-right: 20px;">🔐 로그인</a>
            <a href="<%= request.getContextPath() %>/join/join.jsp" style="color:white;">📝 회원가입</a>
        <% } %>
    </div>
</div>