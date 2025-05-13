package Board;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/board/list")
public class BoardListController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        BoardDAO dao = new BoardDAO();
        List<BoardDTO> boardList = dao.getAll();
        dao.close();          // 꼭 닫기

        request.setAttribute("boardList", boardList);
        request.getRequestDispatcher("/board/list.jsp").forward(request, response);
    }
}
