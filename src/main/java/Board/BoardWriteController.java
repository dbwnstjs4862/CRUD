package Board;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/board/write")
public class BoardWriteController extends HttpServlet {
	
	private boolean isLoggedIn(HttpServletRequest request) {
	    HttpSession session = request.getSession(false);
	    return (session != null && session.getAttribute("userid") != null);
	}

	private int getUserId(HttpServletRequest request) {
	    return (int) request.getSession(false).getAttribute("userid");
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {

	    request.setCharacterEncoding("UTF-8");

	    if (!isLoggedIn(request)) {
	        response.sendRedirect(request.getContextPath() + "/login/login.jsp?message=needLogin");
	        return;
	    }

	    String title = request.getParameter("title");
	    String content = request.getParameter("content");
	    int writerId = getUserId(request);

	    BoardDTO dto = new BoardDTO();
	    dto.setTitle(title);
	    dto.setContent(content);
	    dto.setWriterId(writerId);

	    BoardDAO dao = new BoardDAO();
	    dao.write(dto);
	    dao.close();

	    response.sendRedirect(request.getContextPath() + "/board/list");
	}

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
        if (!isLoggedIn(request)) {
            response.sendRedirect(request.getContextPath() + "/login/login.jsp?message=needLogin");
            return;
        }
        System.out.println("🔥 BoardWriteController - doGet() 실행됨");
        request.getRequestDispatcher("/board/write.jsp").forward(request, response);
    }


}
