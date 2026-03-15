package main.java.controller;

import main.java.dao.UserDAO;
import main.java.dao.impl.UserDAOImpl;
import main.java.model.entity.User;
import main.java.service.UserServices;
import main.java.service.impl.UserServicesImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(
        name = "Authentication",
        value = {"/auth"}
)
public class Authentication extends HttpServlet {
    private UserServices userServices;

    public Authentication() {
        UserDAO userDAO = new UserDAOImpl();
        this.userServices = new UserServicesImpl(userDAO);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action.equals("logout")) {
            request.getSession().invalidate();
            response.sendRedirect("/home");
        } else {
            request.getRequestDispatcher("/views/auth.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        if ("login".equals(action)) {
            this.handleLogin(request, response);
        } else if ("register".equals(action)) {
            this.handleRegister(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/home");
        }

    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String emailOrUsername = request.getParameter("email");
        String password = request.getParameter("password");
        User loggedInUser = this.userServices.login(emailOrUsername, password);
        if (loggedInUser != null) {
            HttpSession session = request.getSession();
            session.setAttribute("currentUser", loggedInUser);
            response.sendRedirect(request.getContextPath() + "/home");
        } else {
            request.setAttribute("error", "Tên đăng nhập, Email hoặc mật khẩu không chính xác!");
            request.getRequestDispatcher("/views/auth.jsp?action=login").forward(request, response);
        }

    }

    private void handleRegister(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User newUser = new User();
        newUser.setFull_name(request.getParameter("fullName"));
        newUser.setUsername(request.getParameter("username"));
        newUser.setEmail(request.getParameter("email"));
        newUser.setPassword(request.getParameter("password"));
        String confirmPassword = request.getParameter("confirmPassword");
        String result = this.userServices.register(newUser, confirmPassword);
        if ("SUCCESS".equals(result)) {
            request.setAttribute("message", "Đăng ký thành công! Vui lòng đăng nhập.");
            request.getRequestDispatcher("/views/auth.jsp?action=login").forward(request, response);
        } else {
            request.setAttribute("error", result);
            request.getRequestDispatcher("/views/auth.jsp?action=register").forward(request, response);
        }

    }
}