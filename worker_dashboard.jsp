<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%
  String user = (String) session.getAttribute("username");
  if (user == null) response.sendRedirect("../login.jsp");
%>
<h2>Welcome, <%= user %> (Worker)</h2>
<a href="../LogoutServlet">Logout</a>

