package User;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UserController")
public class UserController extends HttpServlet {
	
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
	    boolean result = service.join(user);

	    if (result) {
	        response.sendRedirect("success.jsp");
	    } else {
	        response.sendRedirect("error.jsp");
	    }
	}

}