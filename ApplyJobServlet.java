 package com.system.controllers;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ApplyJobServlet")
public class ApplyJobServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/employer_worker_system";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASS = "your_password";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Integer workerId = (Integer) session.getAttribute("userId");
        String role = (String) session.getAttribute("role");

        if (workerId == null || !"worker".equals(role)) {
            response.sendRedirect("login.jsp");
            return;
        }

        int jobId = Integer.parseInt(request.getParameter("jobId"));

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASS)) {

                // Prevent duplicate application
                String checkSql = "SELECT * FROM job_applications WHERE job_id = ? AND worker_id = ?";
                try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                    checkStmt.setInt(1, jobId);
                    checkStmt.setInt(2, workerId);
                    ResultSet rs = checkStmt.executeQuery();
                    if (rs.next()) {
                        response.getWriter().println("You have already applied to this job.");
                        return;
                    }
                }

                String sql = "INSERT INTO job_applications (job_id, worker_id) VALUES (?, ?)";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setInt(1, jobId);
                    stmt.setInt(2, workerId);
                    stmt.executeUpdate();
                    response.sendRedirect("jsp/worker_dashboard.jsp");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error applying to job: " + e.getMessage());
        }
    }
}

