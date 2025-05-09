<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<%
  String role = (String) session.getAttribute("role");
  Integer employerId = (Integer) session.getAttribute("userId");

  if (employerId == null || !"employer".equals(role)) {
      response.sendRedirect("../login.jsp");
      return;
  }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Applicants</title>
    <style>
        body { font-family: Arial; background: #f4f4f4; }
        .card {
            background: white; margin: 20px auto; padding: 20px;
            width: 600px; border-radius: 8px; box-shadow: 0 0 10px #ccc;
        }
        select, button {
            padding: 5px; margin-top: 5px;
        }
    </style>
</head>
<body>
<h2 style="text-align:center;">Manage Application Status</h2>

<%
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/employer_worker_system", "root", "your_password");

    String sql = "SELECT ja.id AS app_id, u.username, u.email, ja.status, j.title FROM job_applications ja " +
                 "JOIN users u ON ja.worker_id = u.id " +
                 "JOIN jobs j ON ja.job_id = j.id WHERE j.employer_id = ?";
    PreparedStatement stmt = conn.prepareStatement(sql);
    stmt.setInt(1, employerId);
    ResultSet rs = stmt.executeQuery();

    while (rs.next()) {
%>
    <div class="card">
        <h4>Job: <%= rs.getString("title") %></h4>
        <p>Applicant: <strong><%= rs.getString("username") %></strong> – <%= rs.getString("email") %></p>
        <p>Status: <%= rs.getString("status") %></p>
        <form action="../UpdateStatusServlet" method="post">
            <input type="hidden" name="applicationId" value="<%= rs.getInt("app_id") %>"/>
            <select name="status">
                <option value="Pending" <%= rs.getString("status").equals("Pending") ? "selected" : "" %>>Pending</option>
                <option value="Accepted" <%= rs.getString("status").equals("Accepted") ? "selected" : "" %>>Accepted</option>
                <option value="Rejected" <%= rs.getString("status").equals("Rejected") ? "selected" : "" %>>Rejected</option>
            </select>
            <button type="submit">Update</button>
        </form>
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

