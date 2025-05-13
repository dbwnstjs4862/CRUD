package User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/check-username")
public class CheckUsernameController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String username = request.getParameter("username");
        UserDAO dao = new UserDAO();
        boolean exists = dao.existsByUsername(username);

        response.setContentType("text/plain; charset=UTF-8");
        response.getWriter().write(exists ? "이미 사용 중인 아이디입니다." : "사용 가능한 아이디입니다.");
    }
}
