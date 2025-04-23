<%@ page import="java.sql.*" %>
<%@ page import="yourpackage.DBConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PetPetPerfume | Staff Portal</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@300;400;500;600;700&family=Montserrat:wght@300;400;500;600&display=swap');
        
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
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Montserrat', sans-serif;
            background-color: var(--black);
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background-image: linear-gradient(rgba(0, 0, 0, 0.75), rgba(0, 0, 0, 0.85)), url('https://source.unsplash.com/random/1920x1080/?luxury,perfume,fragrance');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            color: var(--cream);
            overflow-x: hidden;
        }
        
        .login-container {
            width: 90%;
            max-width: 900px;
            background-color: rgba(14, 14, 14, 0.92);
            box-shadow: 0 20px 50px rgba(0, 0, 0, 0.4);
            display: flex;
            overflow: hidden;
            border-radius: 6px;
            backdrop-filter: blur(15px);
            border: 1px solid rgba(212, 175, 55, 0.1);
        }
        
        .login-image {
            flex: 1;
            background-image: linear-gradient(rgba(0, 0, 0, 0.4), rgba(0, 0, 0, 0.4)), url('https://source.unsplash.com/random/800x1200/?luxury,perfume,bottle');
            background-size: cover;
            background-position: center;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            position: relative;
        }
        
        .login-image::after {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 30px;
            height: 100%;
            background: linear-gradient(to left, rgba(14, 14, 14, 0.92), transparent);
        }
        
        .brand-logo {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            text-align: center;
            z-index: 10;
            width: 85%;
            padding: 40px;
            background-color: rgba(0, 0, 0, 0.6);
            backdrop-filter: blur(5px);
            border: 1px solid rgba(212, 175, 55, 0.2);
        }
        
        .brand-logo h1 {
            font-family: 'Cormorant Garamond', serif;
            font-weight: 300;
            font-size: 3rem;
            color: var(--gold);
            letter-spacing: 3px;
            margin-bottom: 0.5rem;
        }
        
        .brand-logo .tagline {
            font-family: 'Montserrat', sans-serif;
            font-weight: 300;
            text-transform: uppercase;
            letter-spacing: 8px;
            font-size: 0.8rem;
            color: var(--gold-light);
            opacity: 0.8;
        }
        
        .brand-logo .est {
            margin-top: 20px;
            font-family: 'Cormorant Garamond', serif;
            font-style: italic;
            font-size: 0.9rem;
            color: var(--white);
            opacity: 0.7;
        }
        
        .login-form {
            flex: 1;
            padding: 3.5rem;
            display: flex;
            flex-direction: column;
        }
        
        .form-header {
            margin-bottom: 2.5rem;
        }
        
        .form-header h2 {
            font-family: 'Cormorant Garamond', serif;
            font-weight: 500;
            font-size: 2.2rem;
            color: var(--white);
            margin-bottom: 0.8rem;
            letter-spacing: 1px;
        }
        
        .form-header p {
            color: var(--gold-light);
            font-size: 0.9rem;
            opacity: 0.7;
        }
        
        .divider {
            height: 1px;
            background: linear-gradient(to right, var(--gold), transparent);
            margin-bottom: 2.5rem;
        }
        
        .form-group {
            margin-bottom: 1.8rem;
            position: relative;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 0.6rem;
            font-size: 0.8rem;
            color: var(--gold-light);
            letter-spacing: 1px;
            text-transform: uppercase;
            font-weight: 500;
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
            background-color: rgba(30, 30, 30, 0.7);
            border: 1px solid rgba(212, 175, 55, 0.2);
            border-radius: 4px;
            color: var(--white);
            font-family: 'Montserrat', sans-serif;
            font-size: 0.95rem;
            transition: all 0.3s ease;
        }
        
        .form-control:focus {
            outline: none;
            border-color: var(--gold);
            background-color: rgba(30, 30, 30, 0.9);
            box-shadow: 0 0 0 3px rgba(212, 175, 55, 0.15);
        }
        
        .login-button {
            background: linear-gradient(to right, var(--gold-dark), var(--gold), var(--gold-dark));
            color: var(--black);
            border: none;
            padding: 15px 25px;
            border-radius: 4px;
            font-family: 'Montserrat', sans-serif;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 2px;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
            margin-top: 10px;
        }
        
        .login-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 7px 20px rgba(0, 0, 0, 0.4);
            background: linear-gradient(to right, var(--gold), var(--gold-light), var(--gold));
        }
        
        .login-button i {
            margin-right: 8px;
        }
        
        .error-message {
            color: var(--error);
            background-color: rgba(211, 47, 47, 0.1);
            border-left: 3px solid var(--error);
            padding: 12px 15px;
            margin-top: 20px;
            font-size: 0.9rem;
            display: flex;
            align-items: center;
        }
        
        .error-message i {
            margin-right: 10px;
        }
        
        .perfume-options {
            margin-top: auto;
            border-top: 1px solid rgba(212, 175, 55, 0.2);
            padding-top: 20px;
        }
        
        .perfume-options h3 {
            font-family: 'Cormorant Garamond', serif;
            font-size: 1.2rem;
            color: var(--gold-light);
            margin-bottom: 15px;
            letter-spacing: 1px;
        }
        
        .option-buttons {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
        }
        
        .option-button {
            flex: 1;
            min-width: 130px;
            padding: 12px 15px;
            background-color: rgba(30, 30, 30, 0.7);
            border: 1px solid rgba(212, 175, 55, 0.3);
            border-radius: 4px;
            color: var(--gold-light);
            font-family: 'Montserrat', sans-serif;
            font-size: 0.8rem;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 1px;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            text-decoration: none;
        }
        
        .option-button i {
            margin-right: 8px;
            font-size: 0.9rem;
        }
        
        .option-button:hover {
            background-color: rgba(212, 175, 55, 0.15);
            border-color: var(--gold);
            transform: translateY(-2px);
        }
        
        .login-footer {
            margin-top: 20px;
            text-align: center;
            font-size: 0.75rem;
            color: var(--gold-light);
            opacity: 0.5;
        }
        
        @media (max-width: 992px) {
            .login-container {
                flex-direction: column;
                width: 95%;
                max-width: 500px;
            }
            
            .login-image {
                height: 180px;
                min-height: 180px;
            }
            
            .brand-logo {
                width: 100%;
                padding: 20px;
            }
            
            .brand-logo h1 {
                font-size: 2rem;
            }
            
            .login-form {
                padding: 2rem;
            }
            
            .form-header h2 {
                font-size: 1.8rem;
            }
            
            .option-buttons {
                flex-direction: column;
            }
            
            .option-button {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-image">
            <div class="brand-logo">
                <h1>PetPetPerfume</h1>
                <div class="tagline">ARTISANAL FRAGRANCES</div>
                <div class="est">ESTABLISHED 1997</div>
            </div>
        </div>
        
        <div class="login-form">
            <div class="form-header">
                <h2>Staff Portal</h2>
                <p>Enter your credentials to access the management system</p>
            </div>
            
            <div class="divider"></div>
            
            <form method="post">
                <div class="form-group">
                    <label for="username">Staff Username</label>
                    <div class="input-wrapper">
                        <i class="fas fa-user"></i>
                        <input type="text" name="username" id="username" class="form-control" placeholder="Enter your username" required>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="password">Password</label>
                    <div class="input-wrapper">
                        <i class="fas fa-lock"></i>
                        <input type="password" name="password" id="password" class="form-control" placeholder="Enter your password" required>
                    </div>
                </div>
                
                <button type="submit" class="login-button">
                    <i class="fas fa-sign-in-alt"></i> Sign In
                </button>
                
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
                            out.println("<div class='error-message'><i class='fas fa-exclamation-circle'></i> Invalid username or password. Please try again.</div>");
                        }
                    }
                %>
            </form>
            
            <div class="login-footer">
                &copy; 2025 Luxe Parfum. All rights reserved.
            </div>
        </div>
    </div>
</body>
</html>