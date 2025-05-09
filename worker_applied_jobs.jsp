<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<%
  String role = (String) session.getAttribute("role");
  Integer workerId = (Integer) session.getAttribute("userId");

  if (workerId == null || !"worker".equals(role)) {
      response.sendRedirect("../login.jsp");
      return;
  }
%>
<!DOCTYPE html>
<html>
<head>
    <title>My Applications</title>
    <style>
        body { font-family: Arial; background: #eef; }
        .job-box {
            background: white; width: 500px; margin: 20px auto;
            padding: 20px; border-radius: 8px; box-shadow: 0 0 10px #ccc;
        }
    </style>
</head>
<body>
<h2 style="text-align:center;">My Applications</h2>

<%
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/employer_worker_system", "root", "your_password");

    String sql = "SELECT j.title, j.description, ja.status FROM job_applications ja JOIN jobs j ON ja.job_id = j.id WHERE ja.worker_id = ?";
    PreparedStatement stmt = conn.prepareStatement(sql);
    stmt.setInt(1, workerId);
    ResultSet rs = stmt.executeQuery();

    while (rs.next()) {
%>
    <div class="job-box">
        <h3><%= rs.getString("title") %></h3>
        <p><%= rs.getString("description") %></p>
        <p><strong>Status:</strong> <%= rs.getString("status") %></p>
    </div>
<%
    }
    rs.close(); stmt.close(); conn.close();
} catch (Exception e) {
    out.println("Error loading applications: " + e.getMessage());
}
%>

</body>
</html>

