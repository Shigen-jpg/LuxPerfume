<%@ page import="java.sql.*" %>
<%@ page import="yourpackage.DBConnection" %>
<html>
<head>
    <title>Admin Page</title>
</head>
<body>

<h2>Admin Dashboard</h2>

<!-- Perfume Management Buttons -->
<form action="addperfume.jsp" method="get">
    <input type="submit" value="Add Perfume">
</form>

<form action="deleteperfume.jsp" method="get">
    <input type="submit" value="Delete Perfume">
</form>

<form action="updateperfume.jsp" method="get">
    <input type="submit" value="Update Perfume Details">
</form>

<form action="printreport.jsp" method="get">
    <input type="submit" value="Print Report">
</form>

<hr/>

<!-- Staff Registration Section -->
<h3>Register New Staff</h3>
<form method="post">
    Staff Username: <input type="text" name="staffuser" required /><br/>
    Default Password: <input type="text" name="staffpass" required /><br/>
    <input type="submit" value="Register Staff"/>
</form>

<%
    String staffuser = request.getParameter("staffuser");
    String staffpass = request.getParameter("staffpass");

    if (staffuser != null && staffpass != null) {
        Connection conn = DBConnection.getConnection();
        PreparedStatement ps = conn.prepareStatement("INSERT INTO StaffRecords (username, password) VALUES (?, ?)");
        ps.setString(1, staffuser);
        ps.setString(2, staffpass);
        ps.executeUpdate();
        out.println("New staff registered successfully!");
    }
%>

</body>
</html>
