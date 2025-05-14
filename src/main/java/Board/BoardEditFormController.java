package Board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/board/edit-form")
public class BoardEditFormController extends HttpServlet {
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
        BoardDTO dto = dao.findById(postId);

        if (dto == null) {
            response.sendRedirect(request.getContextPath() + "/board/list");
            return;
        }

        request.setAttribute("dto", dto);
        request.getRequestDispatcher("/board/edit.jsp").forward(request, response);
        System.out.println("idParam: " + idParam); // 넘어온 글번호
        System.out.println("dto: " + dto); // null 여부 확인

    }
}
