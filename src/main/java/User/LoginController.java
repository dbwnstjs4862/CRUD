package User;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/login/login.do")
public class LoginController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String id = request.getParameter("username");
        String pw = request.getParameter("password");

        UserDAO dao = new UserDAO();
        UserDTO user = dao.login(id, pw); // 한 번만 호출

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("userid", user.getUserId());      // int (PK)
            session.setAttribute("username", user.getUsername());  // 실제 로그인 ID
            response.sendRedirect(request.getContextPath() + "/login/success.jsp");
        } else {
            response.sendRedirect(request.getContextPath() + "/login/login.jsp?error=1");
        }
    }
}
