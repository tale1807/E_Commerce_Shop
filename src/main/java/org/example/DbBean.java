package org.example;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.Hashtable;

public class DbBean {

    public String dbUrl = "";
    public String dbUserName = "";
    public String dbPassword = "";
    public void setDbUrl(String dbUrl) {
        this.dbUrl = dbUrl;
    }

    public void setDbUserName(String dbUserName) {
        this.dbUserName = dbUserName;
    }

    public void setDbPassword(String dbPassword) {
        this.dbPassword = dbPassword;
    }

    public Hashtable getCategories() {
        Hashtable categories = new Hashtable();

        try{
            Connection connection = DriverManager.getConnection(dbUrl, dbUserName, dbPassword);
            Statement st = connection.createStatement();
            String sql = "SELECT CategoryId, Category FROM Categories" + " ";
            ResultSet rs = st.executeQuery(sql);
            while(rs.next())
                categories.put(rs.getString(1), rs.getString(2));
            rs.close();
            st.close();
            connection.close();
        }
        catch(Exception e){
            System.out.println(e.toString());
        }
        return categories;
    }

    public ArrayList getSearchResults(String keyword){
        ArrayList products = new ArrayList();
        try{
            Connection con = DriverManager.getConnection(dbUrl,dbUserName,dbPassword);
            Statement st = con.createStatement();
            String sql = "SELECT ProductId, Name, Description, Price FROM Products" +
                         " WHERE Name LIKE '%" + keyword.trim() + "%'" +
                         " OR Description LIKE '%" + keyword.trim() + "%'";
            ResultSet rs = st.executeQuery(sql);
            while(rs.next()){
                Product product = new Product();
                product.id = rs.getInt(1);
                product.name = rs.getString(2);
                product.description = rs.getString(3);
                product.price = rs.getDouble(4);
                products.add(product);
            }
            rs.close();
            st.close();
            con.close();
        }
        catch(Exception e){

        }
        return products;
    }

    public ArrayList getProductsInCategory(String categoryId){
        ArrayList products = new ArrayList();
        try{
            Connection con = DriverManager.getConnection(dbUrl,dbUserName,dbPassword);
            Statement st = con.createStatement();
            String sql = "SELECT ProductId, Name, Description, Price FROM Products"+
                         " WHERE CategoryId=" + categoryId;
            ResultSet rs = st.executeQuery(sql);
            while(rs.next()){
                Product product = new Product();
                product.id = rs.getInt(1);
                product.name = rs.getString(2);
                product.description = rs.getString(3);
                product.price = rs.getDouble(4);
                products.add(product);
            }
            rs.close();
            st.close();
            con.close();
        }
        catch(Exception e){

        }
        return products;
    }

    public Product getProductDetails(int productId){
        Product product = null;

        try{
            Connection con = DriverManager.getConnection(dbUrl,dbUserName,dbPassword);
            Statement st = con.createStatement();
            String sql = "SELECT ProductId, Name, Description, Price FROM Products"+
                         " WHERE ProductId=" + Integer.toString(productId);
            ResultSet rs = st.executeQuery(sql);
            if(rs.next()){
                product =  new Product();
                product.id = rs.getInt(1);
                product.name = rs.getString(2);
                product.description = rs.getString(3);
                product.price = rs.getDouble(4);
            }
            rs.close();
            st.close();
            con.close();
        }
        catch(Exception e){

        }
        return product;
    }

    public boolean insertOrder(String contactName, String deliveryAddress, String ccName, String ccNumber, String ccExpiryDate, Hashtable shoppingCart ){
        boolean returnValue = false;
        long orderId = System.currentTimeMillis();
        Connection con = null;

        try{
            con = DriverManager.getConnection(dbUrl,dbUserName,dbPassword);
            con.setAutoCommit(false);
            Statement st = con.createStatement();
            String sql = "INSERT INTO Orders" +
                         " (OrderId, ContactName, DeliveryAddress, CCName, CCNumber, CCExpiryDate)"+
                         " VALUES" + "(" + orderId+ ",'" + contactName + "','" + deliveryAddress + "','" + ccName + "','" + ccNumber + "','" + ccExpiryDate+"')";
            st.executeUpdate(sql);
            Enumeration enum1 = shoppingCart.elements();
            while(enum1.hasMoreElements()){
                ShoppingItem item = (ShoppingItem) enum1.nextElement();
                sql = "INSERT INTO OrderDetails (OrderId, ProductId, Quantity, Price)" +
                      " VALUES (" + orderId + "," + item.productId + "," + item.quantity + "," + item.price + ")";
                st.executeUpdate(sql);
            }
            st.close();
            con.commit();
            con.close();
            returnValue = true;
        }
        catch(Exception e){
            try{
                con.rollback();
                con.close();
            }
            catch(Exception se){

            }
        }
        return returnValue;
    }
}
