package com.system.controllers;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/PostJobServlet")
public class PostJobServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/employer_worker_system";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASS = "your_password";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String role = (String) session.getAttribute("role");
        Integer employerId = (Integer) session.getAttribute("userId"); // You'll need to store this on login

        if (session == null || employerId == null || !"employer".equals(role)) {
            response.sendRedirect("login.jsp");
            return;
        }

        String title = request.getParameter("title");
        String description = request.getParameter("description");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASS)) {
                String sql = "INSERT INTO jobs (title, description, employer_id) VALUES (?, ?, ?)";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setString(1, title);
                    stmt.setString(2, description);
                    stmt.setInt(3, employerId);

                    stmt.executeUpdate();
                    response.sendRedirect("jsp/employer_dashboard.jsp");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error posting job: " + e.getMessage());
        }
    }
}

