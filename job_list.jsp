<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<%
  String role = (String) session.getAttribute("role");
  Integer userId = (Integer) session.getAttribute("userId");
  if (userId == null || !"worker".equals(role)) {
      response.sendRedirect("../login.jsp");
      return;
  }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Available Jobs</title>
    <style>
        body { font-family: Arial; background-color: #f8f8f8; }
        .job-card {
            background: white; margin: 20px auto; padding: 15px;
            width: 500px; border: 1px solid #ddd; border-radius: 8px;
        }
        form { margin-top: 10px; }
        button {
            background: #28a745; color: white;
            border: none; padding: 8px 12px; border-radius: 4px;
        }
    </style>
</head>
<body>
<h2 style="text-align:center;">Available Jobs</h2>

<%
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/employer_worker_system", "root", "your_password"
    );
    Statement stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT * FROM jobs ORDER BY created_at DESC");

    while (rs.next()) {
%>
    <div class="job-card">
        <h3><%= rs.getString("title") %></h3>
        <p><%= rs.getString("description") %></p>
        <form action="../ApplyJobServlet" method="post">
            <input type="hidden" name="jobId" value="<%= rs.getInt("id") %>" />
            <button type="submit">Apply</button>
        </form>
    </div>
<%
    }
    rs.close();
    stmt.close();
    conn.close();
} catch (Exception e) {
    out.println("Error loading jobs: " + e.getMessage());
}
%>

</body>
</html>

