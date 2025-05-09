<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<%
  String user = (String) session.getAttribute("username");
  String role = (String) session.getAttribute("role");
  if (user == null || !"employer".equals(role)) {
      response.sendRedirect("../login.jsp");
  }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Post a Job</title>
    <style>
        body { font-family: Arial; background-color: #f4f4f4; }
        .form-box {
            width: 400px; margin: 50px auto; padding: 25px;
            background: white; box-shadow: 0 0 8px #ccc; border-radius: 10px;
        }
        input, textarea, button {
            width: 100%; margin-bottom: 15px; padding: 10px;
            border-radius: 5px; border: 1px solid #ccc;
        }
        button { background: #007bff; color: white; border: none; }
    </style>
</head>
<body>
    <div class="form-box">
        <h2>Post a Job</h2>
        <form action="../PostJobServlet" method="post">
            <input type="text" name="title" placeholder="Job Title" required />
            <textarea name="description" placeholder="Job Description" rows="5" required></textarea>
            <button type="submit">Post Job</button>
        </form>
        <a href="employer_dashboard.jsp">Back to Dashboard</a>
    </div>
</body>
</html>

