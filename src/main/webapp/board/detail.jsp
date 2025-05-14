<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/common/navbar.jsp" %>
<%@ page import="Board.BoardDTO" %>
<%@ page import="java.util.*, Comment.CommentDTO" %>
<%
    BoardDTO dto = (BoardDTO) request.getAttribute("dto");
%>
<%
    int boardId = Integer.parseInt(request.getParameter("id"));
    Comment.CommentDAO commentDAO = new Comment.CommentDAO();
    List<CommentDTO> commentList = commentDAO.getByBoardId(boardId);
%>
<%
    Object userId = session.getAttribute("userid");
    if (userId == null) {
        response.sendRedirect(request.getContextPath() + "/login/login.jsp");
        return;
    }
    int loginUserId = (int) userId;
    
    String title = (String) request.getAttribute("title");
    String content = (String) request.getAttribute("content");
    String writer = (String) request.getAttribute("writer");
    String createdAt = (String) request.getAttribute("createdAt");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시글 상세 보기</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        html, body {
            background-color: #f7f7f7;
            font-family: 'Segoe UI', sans-serif;
            padding: 40px;
        }

        .detail-box {
            width: 700px;
            margin: 0 auto;
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }

        h2 {
            font-size: 22px;
            margin-bottom: 15px;
            border-bottom: 1px solid #ddd;
            padding-bottom: 10px;
            text-align: left;
        }

        .meta {
            font-size: 13px;
            color: #666;
            margin-bottom: 25px;
            text-align: left;
        }

        .content {
            font-size: 15px;
            line-height: 1.6;
            white-space: pre-wrap;
            color: #222;
            text-align: left;
        }
    </style>
</head>
<body>

    <div class="detail-box">
        <h2><%= title %></h2>
        <div class="meta">
            작성자: <%= writer %> | 작성일: <%= createdAt %>
        </div>
        <div class="content">
            <%= content %>
        </div>
    </div>
	
	<div class="comment-box" style="margin-top: 40px; width: 700px; margin: 40px auto;">
	    <h3>💬 댓글</h3>
	    <% if (commentList.isEmpty()) { %>
	        <p style="color: gray;">아직 댓글이 없습니다.</p>
	    <% } else { %>
	        <ul style="list-style: none; padding: 0;">
	            <% for (CommentDTO c : commentList) { %>
	                <li style="padding: 10px; border-bottom: 1px solid #eee;">
					    <strong><%= c.getWriterName() %></strong>
					    <span style="color: gray; font-size: 12px;">[<%= c.getCreatedAt() %>]</span><br>
					
					    <div style="margin-top: 5px;" class="comment-content"><%= c.getContent() %></div>
					
					    <% if (loginUserId == c.getWriterId()) { %>
					        <div style="margin-top: 5px;">
					            <button class="edit-comment-btn" data-comment-id="<%= c.getCommentId() %>">✏ 수정</button>
					            <button class="delete-comment-btn" data-comment-id="<%= c.getCommentId() %>">🗑 삭제</button>
					        </div>
					    <% } %>
					</li>
	            <% } %>
	        </ul>
	    <% } %>
	
	    <form action="<%= request.getContextPath() %>/comment/write" method="post" style="margin-top: 20px;">
	        <input type="hidden" name="boardId" value="<%= boardId %>">
	        <textarea name="content" rows="3" style="width: 100%; padding: 10px;" required></textarea><br>
	        <button type="submit" style="margin-top: 10px;">✏ 댓글 작성</button>
	    </form>
	</div>
	
	<%
	    int writerId = (int) request.getAttribute("writerId");
	    boolean isWriter = (loginUserId == writerId);
	%>
	
	<div style="margin-top: 20px;">
    	<% if (isWriter) { %>
	        <a href="<%= request.getContextPath() %>/board/edit-form?id=<%= request.getParameter("id") %>">
	            <button>✏ 수정하기</button>
	        </a>
	        <a href="<%= request.getContextPath() %>/board/delete?id=<%= request.getParameter("id") %>"
	           onclick="return confirm('정말 삭제하시겠습니까?');">
	            <button style="margin-left: 10px;">🗑 삭제하기</button>
	        </a>
	    <% } %>
	    <a href="<%= request.getContextPath() %>/board/list">
	        <button style="margin-left: 10px;">📋 목록으로</button>
	    </a>
	</div>

	<script>
	const contextPath = "<%= request.getContextPath() %>";
	
	document.addEventListener('DOMContentLoaded', function () {
	
	    // ✏ 댓글 수정 버튼
	    document.querySelectorAll('.edit-comment-btn').forEach(btn => {
	        btn.addEventListener('click', function () {
	            const commentId = this.dataset.commentId;
	            const commentItem = this.closest('li');
	            const contentDiv = commentItem.querySelector('.comment-content');
	            const originalText = contentDiv.textContent;
	
	            // textarea + 저장버튼 생성
	            contentDiv.innerHTML = '';
				const textarea = document.createElement('textarea');
				textarea.className = 'edit-text';
				textarea.style.width = '100%';
				textarea.value = originalText;
				
				const saveBtn = document.createElement('button');
				saveBtn.className = 'save-edit-btn';
				saveBtn.textContent = '저장';
				
				contentDiv.appendChild(textarea);
				contentDiv.appendChild(saveBtn);

	
	            commentItem.querySelector('.save-edit-btn').addEventListener('click', () => {
	                const newContent = commentItem.querySelector('.edit-text').value;
	
	                fetch(contextPath + '/comment/edit', {
	                    method: 'POST',
	                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
	                    body: 'commentId=' + commentId + '&content=' + encodeURIComponent(newContent)
	                }).then(res => {
	                    if (res.ok) return res.text();
	                    else throw new Error('수정 실패');
	                }).then(msg => {
	                    contentDiv.innerText = newContent;
	                }).catch(err => {
	                    alert("오류: " + err.message);
	                });
	            });
	        });
	    });
	
	    // 🗑 댓글 삭제 버튼
	    document.querySelectorAll('.delete-comment-btn').forEach(btn => {
	        btn.addEventListener('click', function () {
	            const commentId = this.dataset.commentId;
	            const commentItem = this.closest('li');
	
	            if (!confirm("정말 삭제하시겠습니까?")) return;
	
	            fetch(contextPath + '/comment/delete', {
	                method: 'POST',
	                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
	                body: 'commentId=' + commentId
	            }).then(res => {
	                if (res.ok) return res.text();
	                else throw new Error('삭제 실패');
	            }).then(msg => {
	                commentItem.remove();
	            }).catch(err => {
	                alert("오류: " + err.message);
	            });
	        });
	    });
	});
	</script>
</body>
</html>
