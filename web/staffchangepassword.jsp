<%@ page import="java.sql.*" %>
<%@ page import="yourpackage.DBConnection" %>
<%
    String staffUser = (String) session.getAttribute("staffUser");
    if (staffUser == null) {
        response.sendRedirect("stafflogin.jsp");
        return;
    }
%>

<html>
<body>
<h2>Change Password for <%= staffUser %></h2>

<form method="post">
    New Password: <input type="password" name="newpass"/><br/>
    <input type="submit" value="Update Password"/>
</form>

<%
    String newpass = request.getParameter("newpass");
    if (newpass != null && !newpass.isEmpty()) {
        Connection conn = DBConnection.getConnection();
        PreparedStatement ps = conn.prepareStatement("UPDATE StaffRecords SET password=? WHERE username=?");
        ps.setString(1, newpass);
        ps.setString(2, staffUser);
        int rows = ps.executeUpdate();
        if (rows > 0) {
            out.println("Password updated successfully!");
        } else {
            out.println("Failed to update password.");
        }
    }
%>
</body>
</html>
