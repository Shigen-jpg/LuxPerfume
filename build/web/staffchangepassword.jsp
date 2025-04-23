<%@ page import="java.sql.*" %>
<%@ page import="yourpackage.DBConnection" %>
<%
    String staffUser = (String) session.getAttribute("staffUser");
    if (staffUser == null) {
        response.sendRedirect("stafflogin.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>PetPetPerfume | Change Password</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --gold: #d4af37;
            --gold-light: #e5d3a3;
            --gold-dark: #9f8327;
            --black: #121212;
            --dark-gray: #1e1e1e;
            --cream: #f9f5ed;
            --white: #ffffff;
            --error: #d32f2f;
        }

        body {
            font-family: 'Montserrat', sans-serif;
            background-color: var(--black);
            color: var(--cream);
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
            background-image: linear-gradient(rgba(0,0,0,0.8), rgba(0,0,0,0.9)), url('https://source.unsplash.com/1920x1080/?luxury,perfume');
            background-size: cover;
            background-position: center;
        }

        .container {
            background-color: rgba(20, 20, 20, 0.85);
            padding: 40px 60px;
            border-radius: 10px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.5);
            width: 100%;
            max-width: 500px;
            border: 1px solid rgba(212, 175, 55, 0.15);
        }

        h2 {
            color: var(--gold);
            font-family: 'Cormorant Garamond', serif;
            font-size: 2.5rem;
            margin-bottom: 20px;
        }

        label {
            font-size: 0.9rem;
            color: var(--gold-light);
            margin-bottom: 10px;
            display: block;
        }

        input[type="password"] {
            width: 100%;
            padding: 12px 15px;
            border-radius: 4px;
            border: 1px solid rgba(212, 175, 55, 0.3);
            background-color: rgba(40, 40, 40, 0.9);
            color: var(--white);
            font-size: 1rem;
            margin-bottom: 20px;
        }

        input[type="submit"] {
            background: linear-gradient(to right, var(--gold-dark), var(--gold));
            color: var(--black);
            padding: 12px 20px;
            border: none;
            border-radius: 4px;
            font-weight: 600;
            letter-spacing: 1px;
            cursor: pointer;
            font-size: 1rem;
            transition: 0.3s ease;
        }

        input[type="submit"]:hover {
            background: linear-gradient(to right, var(--gold), var(--gold-light));
            transform: translateY(-2px);
        }

        .message {
            margin-top: 20px;
            font-size: 0.95rem;
            padding: 10px 15px;
            border-left: 3px solid var(--gold);
            background-color: rgba(255, 255, 255, 0.05);
            color: var(--gold-light);
        }

        .error {
            border-left-color: var(--error);
            color: var(--error);
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Welcome, <%= staffUser %></h2>
        <form method="post">
            <label for="newpass">New Password</label>
            <input type="password" name="newpass" id="newpass" required/>
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
                    out.println("<div class='message'><i class='fas fa-check-circle'></i> Password updated successfully!</div>");
                } else {
                    out.println("<div class='message error'><i class='fas fa-times-circle'></i> Failed to update password.</div>");
                }
            }
        %>
    </div>
</body>
</html>
