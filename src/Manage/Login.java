package Manage;

import javax.servlet.http.*;
import javax.servlet.*;
import java.io.IOException;

public class Login extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        String value = request.getParameter("submit");

        if(value.equals("user")){
            HttpSession session =  request.getSession();
            session.setAttribute("email", request.getParameter("email"));
            session.setAttribute("password", request.getParameter("password"));
            response.sendRedirect("user_validation.jsp");
        } else if (value.equals("admin")) {
            HttpSession session =  request.getSession();
            session.setAttribute("email", request.getParameter("email"));
            session.setAttribute("password", request.getParameter("password"));
            response.sendRedirect("admin.jsp");
        }
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        this.doGet(request, response);
    }
}
