package Comment;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/comment/edit")
public class CommentEditController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        int commentId = Integer.parseInt(request.getParameter("commentId"));
        String content = request.getParameter("content");

        CommentDAO dao = new CommentDAO();
        int result = dao.update(commentId, content);

        response.setContentType("text/plain; charset=UTF-8");
        response.getWriter().write(result > 0 ? "success" : "fail");
    }
}
