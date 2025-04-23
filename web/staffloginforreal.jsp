<%@ page import="java.sql.*" %>
<%@ page import="yourpackage.DBConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PetPetPerfume | Staff Portal</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;700&family=Montserrat:wght@300;400;500&display=swap');
        
        :root {
            --gold: #c9a87c;
            --gold-light: #d8c3a5;
            --dark: #1a1a1a;
            --cream: #f8f3ea;
            --white: #ffffff;
            --error: #b71c1c;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Montserrat', sans-serif;
            background-color: var(--dark);
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background-image: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), url('https://source.unsplash.com/random/1920x1080/?perfume');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            color: var(--cream);
        }

        .login-container {
            width: 90%;
            max-width: 450px;
            background-color: rgba(26, 26, 26, 0.95);
            padding: 3rem;
            border-radius: 8px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.3);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(201, 168, 124, 0.3);
        }

        .logo {
            text-align: center;
            margin-bottom: 2rem;
        }

        .logo h1 {
            font-family: 'Playfair Display', serif;
            font-weight: 700;
            font-size: 2.5rem;
            color: var(--gold);
            letter-spacing: 2px;
            margin-bottom: 0.5rem;
        }

        .logo span {
            font-family: 'Montserrat', sans-serif;
            font-weight: 300;
            text-transform: uppercase;
            letter-spacing: 5px;
            font-size: 0.85rem;
            color: var(--gold-light);
        }

        .divider {
            height: 1px;
            background: linear-gradient(to right, transparent, var(--gold), transparent);
            margin: 2rem 0;
        }

        h2 {
            font-family: 'Playfair Display', serif;
            text-align: center;
            margin-bottom: 2rem;
            font-weight: 400;
            color: var(--white);
            letter-spacing: 1px;
            text-transform: uppercase;
            font-size: 1.5rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
            position: relative;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.8rem;
            font-size: 0.9rem;
            color: var(--gold-light);
            letter-spacing: 1px;
            text-transform: uppercase;
        }

        .form-group .input-wrapper {
            position: relative;
        }

        .form-group .input-wrapper i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--gold);
        }

        .form-control {
            width: 100%;
            padding: 15px 15px 15px 45px;
            border: 1px solid rgba(201, 168, 124, 0.3);
            background-color: rgba(26, 26, 26, 0.8);
            border-radius: 4px;
            color: var(--white);
            transition: all 0.3s ease;
            font-family: 'Montserrat', sans-serif;
            font-size: 1rem;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--gold);
            box-shadow: 0 0 0 2px rgba(201, 168, 124, 0.2);
        }

        .btn {
            width: 100%;
            padding: 15px;
            background: var(--gold);
            color: var(--dark);
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-family: 'Montserrat', sans-serif;
            font-weight: 500;
            letter-spacing: 1px;
            text-transform: uppercase;
            transition: all 0.3s ease;
            margin-top: 1rem;
            box-shadow: 0 4px 12px rgba(201, 168, 124, 0.3);
        }

        .btn:hover {
            background-color: #b89361;
            transform: translateY(-2px);
            box-shadow: 0 6px 18px rgba(201, 168, 124, 0.4);
        }

        .error-message {
            color: var(--error);
            text-align: center;
            margin-top: 1.5rem;
            font-size: 0.9rem;
            background-color: rgba(183, 28, 28, 0.1);
            padding: 12px;
            border-radius: 4px;
            border-left: 3px solid var(--error);
        }

        .footer {
            text-align: center;
            margin-top: 2rem;
            font-size: 0.8rem;
            color: var(--gold-light);
            opacity: 0.7;
        }

        @media (max-width: 768px) {
            .login-container {
                padding: 2rem;
                width: 95%;
            }

            .logo h1 {
                font-size: 2rem;
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="logo">
            <h1>PetPetPerfume</h1>
            <span>Exquisite Fragrances</span>
        </div>

        <div class="divider"></div>

        <h2>Staff Portal</h2>

        <form method="post">
            <div class="form-group">
                <label for="username">Username</label>
                <div class="input-wrapper">
                    <i class="fas fa-envelope"></i>
                    <input type="text" name="username" id="username" class="form-control" placeholder="Enter your Username" required>
                </div>
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <div class="input-wrapper">
                    <i class="fas fa-lock"></i>
                    <input type="password" name="password" id="password" class="form-control" placeholder="Enter your password" required>
                </div>
            </div>

            <button type="submit" class="btn">
                <i class="fas fa-sign-in-alt"></i> Sign In
            </button>

            <%
                String username = request.getParameter("username");
                String password = request.getParameter("password");

                if (username != null && password != null) {
                    try {
                        Connection conn = DBConnection.getConnection();
                        PreparedStatement ps = conn.prepareStatement("SELECT * FROM STAFFRECORDS WHERE username=? AND password=?");
                        ps.setString(1, username);
                        ps.setString(2, password);
                        ResultSet rs = ps.executeQuery();

                        if (rs.next()) {
                            response.sendRedirect("staffpage.jsp");
                        } else {
                            out.println("<div class='error-message'><i class='fas fa-exclamation-circle'></i> Login Failed. Invalid username or password.</div>");
                        }

                        rs.close();
                        ps.close();
                        conn.close();
                    } catch (Exception e) {
                        out.println("<div class='error-message'>Something went wrong: " + e.getMessage() + "</div>");
                    }
                }
            %>
        </form>

        <div class="footer">
            &copy; 2025 PetPetPerfume. All Rights Reserved.
        </div>
    </div>
</body>
</html>
