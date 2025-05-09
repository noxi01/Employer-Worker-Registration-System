package com.system.controllers;

import java.io.IOException;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/employer_worker_system";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASS = "your_password";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password"); // In real app, hash and compare

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASS)) {
                String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setString(1, email);
                    stmt.setString(2, password);

                    ResultSet rs = stmt.executeQuery();
                    if (rs.next()) {
                        String role = rs.getString("role");
                        HttpSession session = request.getSession();
                        session.setAttribute("username", rs.getString("username"));
                        session.setAttribute("role", role);

                        if ("employer".equals(role)) {
                            response.sendRedirect("jsp/employer_dashboard.jsp");
                        } else {
                            response.sendRedirect("jsp/worker_dashboard.jsp");
                        }
                    } else {
                        response.getWriter().println("Invalid credentials. <a href='login.jsp'>Try again</a>");
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}

