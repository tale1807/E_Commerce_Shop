package org.example.servlet;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.DbBean;

import java.io.IOException;

public class ControllerServlet extends HttpServlet {
    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req,resp);
    }

    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String base = "/jsp/";
        String url = base + "Default.jsp";
        String action = req.getParameter("action");
        if(action != null){
            switch(action){
                case "search":
                        url = base + "SearchResults.jsp";
                        break;
                case  "browseCatalog":
                        url = base + "BrowseCatalog.jsp";
                        break;
                case "productDetails":
                        url = base + "ProductDetails.jsp";
                        break;
                case "addShoppingItem":
                case "updateShoppingItem":
                case "deleteShoppingItem":
                case "displayShoppingItem":
                        url = base + "ShoppingCart.jsp";
                        break;
                case "checkOut":
                        url = base + "CheckOut.jsp";
                        break;
                case "order":
                        url = base + "Order.jsp";
                        break;
            }
        }
        RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher(url);
        requestDispatcher.forward(req,resp);
    }

    public void init(ServletConfig config) throws ServletException {
        System.out.println("initializing controller servlet.");

        ServletContext context = config.getServletContext();

        context.setAttribute("base", config.getInitParameter("base"));
        context.setAttribute("imageUrl", config.getInitParameter("imageUrl"));

        DbBean dbBean = new DbBean();
        dbBean.setDbUrl(config.getInitParameter("dbUrl"));
        dbBean.setDbUserName(config.getInitParameter("dbUserName"));
        dbBean.setDbPassword(config.getInitParameter("dbPassword"));

        context.setAttribute("dbBean", dbBean);

        try{
            Class.forName(config.getInitParameter("jdbcDriver"));
        }
        catch(Exception e){
            System.out.println(e.toString());
        }
        super.init(config);
    }
}
