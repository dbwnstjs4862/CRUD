package Board;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/board/write")
public class BoardWriteController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String title = request.getParameter("title");
        String content = request.getParameter("content");

        HttpSession session = request.getSession(false);
        Object userIdAttr = session.getAttribute("userid");

        if (userIdAttr == null) {
            response.sendRedirect(request.getContextPath() + "/login/login.jsp");
            return;
        }

        // ✅ 여기서 세션에서 writerId 꺼냄 (int형)
        int writerId = (int) userIdAttr;

        BoardDTO dto = new BoardDTO();
        dto.setTitle(title);
        dto.setContent(content);
        dto.setWriterId(writerId);

        BoardDAO dao = new BoardDAO();
        dao.write(dto);
        dao.close();

        response.sendRedirect(request.getContextPath() + "/board/list");
    }
}
