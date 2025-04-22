package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet(name = "CartServlet", urlPatterns = {"/CartServlet"})
public class CartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 获取商品参数
        String productName = request.getParameter("productName");
        String productPrice = request.getParameter("productPrice");

        // 获取 Session 购物车
        HttpSession session = request.getSession();
        List<String> cart = (List<String>) session.getAttribute("cart");

        if (cart == null) {
            cart = new ArrayList<>();
        }

        // 模拟商品存入购物车（这里只是简单例子，实际可用对象表示）
        cart.add(productName + " - $" + productPrice);
        session.setAttribute("cart", cart);

        // 返回简单响应
        response.setContentType("text/plain");
        response.getWriter().write("Item added to cart");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        List<String> cart = (List<String>) session.getAttribute("cart");

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        if (cart == null) {
            response.getWriter().write("[]");
        } else {
            response.getWriter().write(cart.toString()); // 简单显示购物车
        }
    }
}
