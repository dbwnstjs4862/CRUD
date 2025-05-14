package Board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/board/edit")
public class BoardEditController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        int boardId = Integer.parseInt(request.getParameter("boardId"));
        String title = request.getParameter("title");
        String content = request.getParameter("content");

        BoardDTO dto = new BoardDTO();
        dto.setBoardId(boardId);
        dto.setTitle(title);
        dto.setContent(content);

        BoardDAO dao = new BoardDAO();
        dao.update(dto);

        response.sendRedirect(request.getContextPath() + "/board/detail?id=" + boardId);
    }
}