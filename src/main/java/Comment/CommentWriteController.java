package Comment;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/comment/write")
public class CommentWriteController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();

        Object userIdObj = session.getAttribute("userid");
        if (userIdObj == null) {
            response.sendRedirect(request.getContextPath() + "/login/login.jsp");
            return;
        }

        int writerId = (int) userIdObj;
        int boardId = Integer.parseInt(request.getParameter("boardId"));
        String content = request.getParameter("content");

        CommentDTO dto = new CommentDTO();
        dto.setBoardId(boardId);
        dto.setWriterId(writerId);
        dto.setContent(content);

        CommentDAO dao = new CommentDAO();
        dao.insert(dto);

        // 댓글 작성 후 해당 게시글 상세보기로 리다이렉트
        response.sendRedirect(request.getContextPath() + "/board/detail?id=" + boardId);
    }
}
