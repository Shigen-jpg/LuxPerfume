<%@ page import="java.sql.*" %>
<%@ page import="yourpackage.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
    <title>PetPetPerfume | Manage Perfumes</title>
    <style>
        body {
            font-family: 'Georgia', serif;
            background-color: #f4f1ee;
            background-image: url('https://source.unsplash.com/1600x900/?luxury,perfume');
            background-size: cover;
            background-attachment: fixed;
            color: #2f2f2f;
            padding: 40px;
        }
        .container {
            background: rgba(255,255,255,0.95);
            padding: 30px;
            max-width: 800px;
            margin: auto;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.2);
        }
        h1 {
            text-align: center;
            color: #b28f63;
        }
        .perfume-box {
            border: 1px solid #ccc;
            padding: 20px;
            margin-bottom: 20px;
            border-radius: 10px;
            background-color: #fff;
        }
        input, button {
            width: 100%;
            padding: 12px;
            margin: 8px 0;
            border: 1px solid #ccc;
            border-radius: 6px;
        }
        button {
            background-color: #b28f63;
            color: white;
            font-weight: bold;
            cursor: pointer;
        }
        button:hover {
            background-color: #a47c50;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Manage Perfume Products</h1>

    <%
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();

            if ("POST".equalsIgnoreCase(request.getMethod())) {
                String action = request.getParameter("action");
                String id = request.getParameter("id");
                String pname = request.getParameter("name");
                String brand = request.getParameter("brand");
                String priceStr = request.getParameter("price");
                double price = Double.parseDouble(priceStr);

                if ("update".equals(action)) {
                    ps = conn.prepareStatement("UPDATE perfumes SET name=?, brand=?, price=? WHERE id=?");
                    ps.setString(1, pname);
                    ps.setString(2, brand);
                    ps.setDouble(3, price);
                    ps.setInt(4, Integer.parseInt(id));
                    ps.executeUpdate();
                    ps.close();
                }
            }

            ps = conn.prepareStatement("SELECT * FROM perfumes");
            rs = ps.executeQuery();
            while (rs.next()) {
    %>
    <div class="perfume-box">
        <form method="post">
            <input type="hidden" name="id" value="<%= rs.getInt("id") %>" />
            <label>Perfume Name:</label>
            <input type="text" name="name" value="<%= rs.getString("name") %>" required />

            <label>Brand:</label>
            <input type="text" name="brand" value="<%= rs.getString("brand") %>" required />

            <label>Price (RM):</label>
            <input type="text" name="price" value="<%= rs.getDouble("price") %>" required />

            <button type="submit" name="action" value="update">Update Perfume</button>
        </form>
    </div>
    <%
            }
        } catch (Exception e) {
            out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    %>
</div>
</body>
</html>
