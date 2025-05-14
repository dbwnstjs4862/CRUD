package Board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/board/delete")
public class BoardDeleteController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        // 로그인 여부 확인
        HttpSession session = request.getSession();
        Object userIdObj = session.getAttribute("userid");

        if (userIdObj == null) {
            response.sendRedirect(request.getContextPath() + "/login/login.jsp");
            return;
        }

        int loginUserId = (int) userIdObj;

        // 삭제할 게시글 ID 파라미터 확인
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/board/list");
            return;
        }

        int postId = Integer.parseInt(idParam);
        BoardDAO dao = new BoardDAO();
        BoardDTO dto = dao.findById(postId);

        // 게시글이 없거나 작성자가 다르면 차단
        if (dto == null || dto.getWriterId() != loginUserId) {
            response.sendRedirect(request.getContextPath() + "/board/list");
            return;
        }

        // 삭제 수행
        dao.delete(postId);

        // 삭제 후 목록으로
        response.sendRedirect(request.getContextPath() + "/board/list");
    }
}