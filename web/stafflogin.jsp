<%@ page import="java.sql.*" %>
<%@ page import="yourpackage.DBConnection" %>
<html>
<body>
<h2>Staff Login</h2>

<form method="post">
    Username: <input type="text" name="username"/><br/>
    Password: <input type="password" name="password"/><br/>
    <input type="submit" value="Login"/>
</form>

<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    if (username != null && password != null) {
        Connection conn = DBConnection.getConnection();
        PreparedStatement ps = conn.prepareStatement("SELECT * FROM StaffRecords WHERE username=? AND password=?");
        ps.setString(1, username);
        ps.setString(2, password);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            session.setAttribute("staffUser", username);
            response.sendRedirect("staffchangepassword.jsp");
        } else {
            out.println("Invalid username or password.");
        }
    }
%>
</body>
</html>
