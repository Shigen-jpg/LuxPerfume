<%@ page import="java.sql.*" %>
<%@ page import="yourpackage.DBConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>PetPetPerfume | Admin Registration</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Playfair+Display:wght@500;700&family=Montserrat:wght@300;400;600&display=swap');
        
        :root {
            --gold: #c9a87c;
            --dark: #1a1a1a;
            --light: #fdfaf6;
            --error: #b71c1c;
        }

        body {
            font-family: 'Montserrat', sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(rgba(0, 0, 0, 0.75), rgba(0, 0, 0, 0.75)), url('https://source.unsplash.com/1920x1080/?luxury,perfume');
            background-size: cover;
            background-position: center;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--light);
        }

        .container {
            background-color: rgba(26, 26, 26, 0.95);
            padding: 40px;
            border-radius: 12px;
            max-width: 500px;
            width: 90%;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
            border: 1px solid rgba(201, 168, 124, 0.3);
        }

        h2 {
            text-align: center;
            color: var(--gold);
            font-family: 'Playfair Display', serif;
            margin-bottom: 30px;
        }

        label {
            display: block;
            margin-top: 15px;
            font-weight: 500;
            color: var(--light);
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 12px 15px;
            margin-top: 5px;
            border: 1px solid rgba(201, 168, 124, 0.3);
            border-radius: 5px;
            background-color: rgba(255, 255, 255, 0.1);
            color: var(--light);
        }

        input[type="submit"] {
            width: 100%;
            padding: 12px;
            margin-top: 25px;
            border: none;
            border-radius: 5px;
            background-color: var(--gold);
            color: var(--dark);
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: #b89361;
        }

        .message {
            text-align: center;
            margin-top: 20px;
            font-weight: bold;
        }

        .footer {
            margin-top: 30px;
            text-align: center;
            font-size: 0.85rem;
            color: #aaa;
            opacity: 0.6;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Admin Registration</h2>
        <form method="post">
            <label for="email">Email</label>
            <input type="text" name="email" id="email" required />

            <label for="password">Password</label>
            <input type="password" name="password" id="password" required />

            <input type="submit" value="Register" />
        </form>

        <div class="message">
        <%
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            if (email != null && password != null) {
                try {
                    Connection conn = DBConnection.getConnection();
                    PreparedStatement ps = conn.prepareStatement("INSERT INTO AdminRecords (email, password) VALUES (?, ?)");
                    ps.setString(1, email);
                    ps.setString(2, password);
                    ps.executeUpdate();
                    out.println("<span style='color: var(--gold);'>Registered Successfully!</span>");
                } catch (Exception e) {
                    out.println("<span style='color: var(--error);'>Error: " + e.getMessage() + "</span>");
                }
            }
        %>
        </div>

        <div class="footer">
            &copy; 2025 PetPetPerfume. All rights reserved.
        </div>
    </div>
</body>
</html>

