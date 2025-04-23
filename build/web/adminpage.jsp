<%@ page import="java.sql.*" %>
<%@ page import="yourpackage.DBConnection" %>
<html>
<head>
    <title>Admin Page</title>
    <link rel="stylesheet" type="text/css" href="adminpage.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
</head>
<body>
<div class="container">
    <header>
        <h1><i class="fas fa-user-shield"></i> Admin Dashboard</h1>
        <p class="subtitle">Perfume Management System</p>
    </header>
    
    <div class="card">
        <h2><i class="fas fa-tasks"></i> Management Options</h2>
        <div class="button-group">
            <form action="addperfume.jsp" method="get">
                <button type="submit" class="action-button add"><i class="fas fa-plus-circle"></i> Add Perfume</button>
            </form>
            <form action="deleteperfume.jsp" method="get">
                <button type="submit" class="action-button delete"><i class="fas fa-trash-alt"></i> Delete Perfume</button>
            </form>
            <form action="updateperfume.jsp" method="get">
                <button type="submit" class="action-button update"><i class="fas fa-edit"></i> Update Perfume</button>
            </form>
            <form action="printreport.jsp" method="get">
                <button type="submit" class="action-button report"><i class="fas fa-chart-bar"></i> Print Report</button>
            </form>
        </div>
    </div>
    
    <div class="card">
        <h2><i class="fas fa-user-plus"></i> Register New Staff</h2>
        <form method="post" class="staff-form">
            <div class="form-group">
                <label for="staffuser"><i class="fas fa-user"></i> Staff Username:</label>
                <input type="text" id="staffuser" name="staffuser" required />
            </div>
            <div class="form-group">
                <label for="staffpass"><i class="fas fa-lock"></i> Default Password:</label>
                <input type="text" id="staffpass" name="staffpass" required />
            </div>
            <button type="submit" class="submit-button"><i class="fas fa-save"></i> Register Staff</button>
        </form>
        
        <div class="message">
            <%
                String staffuser = request.getParameter("staffuser");
                String staffpass = request.getParameter("staffpass");
                if (staffuser != null && staffpass != null) {
                    Connection conn = DBConnection.getConnection();
                    PreparedStatement ps = conn.prepareStatement("INSERT INTO StaffRecords (username, password) VALUES (?, ?)");
                    ps.setString(1, staffuser);
                    ps.setString(2, staffpass);
                    ps.executeUpdate();
                    out.println("<div class='success-message'><i class='fas fa-check-circle'></i> New staff registered successfully!</div>");
                }
            %>
        </div>
    </div>
    
    <footer>
        <p>&copy; 2025 Perfume Management System. All petpet reserved.</p>
    </footer>
</div>
</body>
</html>