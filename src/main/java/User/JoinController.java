package User;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/join/join")
public class JoinController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String name = request.getParameter("name");
        int age = Integer.parseInt(request.getParameter("age"));

        UserDTO user = new UserDTO();
        user.setUsername(username);
        user.setPassword(password);
        user.setName(name);
        user.setAge(age);

        UserService service = new UserService();
        int result = service.join(user);

        if (result == 1) {
            request.getSession().setAttribute("name", name);
            response.sendRedirect(request.getContextPath() + "/join/success.jsp");
        } else if (result == -1) {
            response.sendRedirect(request.getContextPath() + "/join/error.jsp?reason=duplicate");
        } else {
            response.sendRedirect(request.getContextPath() + "/join/error.jsp?reason=etc");
        }
    }
}
