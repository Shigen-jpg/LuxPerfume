<%@ page import="java.sql.*" %>
<%@ page import="yourpackage.DBConnection" %>
<html>
<body>
<h2>Admin Login</h2>
<form method="post">
    Email: <input type="text" name="email"/><br/>
    Password: <input type="password" name="password"/><br/>
    <input type="submit" value="Login"/>
</form>

<%
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    if (email != null && password != null) {
        Connection conn = DBConnection.getConnection();
        PreparedStatement ps = conn.prepareStatement("SELECT * FROM AdminRecords WHERE email=? AND password=?");
        ps.setString(1, email);
        ps.setString(2, password);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            response.sendRedirect("adminpage.jsp");
        } else {
            out.println("Login Failed. Invalid email or password.");
        }
    }
%>
</body>
</html>
