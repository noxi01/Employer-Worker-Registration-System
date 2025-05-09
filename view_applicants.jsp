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
    <title>Job Applicants</title>
    <style>
        body { font-family: Arial; background: #f4f4f4; }
        .job-block {
            background: #fff; border-radius: 8px; margin: 20px auto;
            padding: 20px; width: 600px; box-shadow: 0 0 10px #ccc;
        }
        h3 { color: #333; }
        ul { padding-left: 20px; }
    </style>
</head>
<body>
    <h2 style="text-align:center;">Applicants for Your Jobs</h2>

<%
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/employer_worker_system", "root", "your_password"
    );

    String jobSql = "SELECT * FROM jobs WHERE employer_id = ?";
    PreparedStatement jobStmt = conn.prepareStatement(jobSql);
    jobStmt.setInt(1, employerId);
    ResultSet jobRs = jobStmt.executeQuery();

    while (jobRs.next()) {
        int jobId = jobRs.getInt("id");
        String title = jobRs.getString("title");
%>
    <div class="job-block">
        <h3><%= title %></h3>
        <ul>
<%
        String appSql = "SELECT u.username, u.email FROM job_applications ja JOIN users u ON ja.worker_id = u.id WHERE ja.job_id = ?";
        PreparedStatement appStmt = conn.prepareStatement(appSql);
        appStmt.setInt(1, jobId);
        ResultSet appRs = appStmt.executeQuery();

        boolean hasApplicants = false;
        while (appRs.next()) {
            hasApplicants = true;
%>
            <li><strong><%= appRs.getString("username") %></strong> – <%= appRs.getString("email") %></li>
<%
        }
        if (!hasApplicants) {
%>
            <li>No applicants yet.</li>
<%
        }
        appRs.close();
        appStmt.close();
%>
        </ul>
    </div>
<%
    }
    jobRs.close();
    jobStmt.close();
    conn.close();
} catch (Exception e) {
    out.println("Error loading applicants: " + e.getMessage());
}
%>

</body>
</html>

