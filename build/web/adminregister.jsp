<%@ page import="java.sql.*" %>
<%@ page import="yourpackage.DBConnection" %>
<html>
<body>
<h2>Admin Registration</h2>
<form method="post">
    Email: <input type="text" name="email"/><br/>
    Password: <input type="password" name="password"/><br/>
    <input type="submit" value="Register"/>
</form>

<%
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    if (email != null && password != null) {
        Connection conn = DBConnection.getConnection();
        PreparedStatement ps = conn.prepareStatement("INSERT INTO AdminRecords (email, password) VALUES (?, ?)");
        ps.setString(1, email);
        ps.setString(2, password);
        ps.executeUpdate();
        out.println("Registered Successfully!");
    }
%>
</body>
</html>
