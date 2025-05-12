package User;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/login/login.do")
public class LoginController extends HttpServlet {
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("username");
        String pw = request.getParameter("password");

        UserDAO dao = new UserDAO();
        boolean result = dao.login(id, pw);

        if (result) {
            HttpSession session = request.getSession();
            session.setAttribute("userid", id);
            response.sendRedirect(request.getContextPath() + "/login/success.jsp");
        } else {
            response.sendRedirect(request.getContextPath() + "/login/login.jsp?error=1");
        }
    }
}
