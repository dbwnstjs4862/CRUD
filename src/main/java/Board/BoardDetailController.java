package Board;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/board/detail")
public class BoardDetailController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/board/list");
            return;
        }

        int postId = Integer.parseInt(idParam);
        BoardDAO dao = new BoardDAO();
        BoardDTO dto = dao.findById(postId); // post → dto 로 수정

        if (dto == null) {
            response.sendRedirect(request.getContextPath() + "/board/list");
            return;
        }
        
        request.setAttribute("writerId", dto.getWriterId());
        request.setAttribute("title", dto.getTitle());
        request.setAttribute("content", dto.getContent());
        request.setAttribute("writer", dto.getWriterName());
        request.setAttribute("createdAt", dto.getCreatedAt());

        request.getRequestDispatcher("/board/detail.jsp").forward(request, response);
    }
}
