<%@ page import="org.example.Product" %>
<%@ page import="org.example.ShoppingItem" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="dbBean" scope="application" class="org.example.DbBean" />
<%
String base = (String) application.getAttribute("base");
Hashtable shoppingCart = (Hashtable) session.getAttribute("shoppingCart");
if(shoppingCart==null)
    shoppingCart = new Hashtable(10);
String action = request.getParameter("action");
if(action!=null && action.equals("addShoppingItem")) {
try {
int productId = Integer.parseInt(request.getParameter("productId"));
Product product = dbBean.getProductDetails(productId);
if(product!=null){
ShoppingItem item =  new ShoppingItem();
item.productId = productId;
item.quantity = 1;
item.price = product.price;
item.name = product.name;
item.description = product.description;

shoppingCart.remove(Integer.toString(productId));
shoppingCart.put(Integer.toString(productId), item);
session.setAttribute("shoppingCart", shoppingCart);
}
}
catch(Exception e){
out.println("Error adding the selected product to the shopping cart");
}
}
if(action!=null && action.equals("updateShoppingItem")) {
try {
int productId = Integer.parseInt(request.getParameter("productId"));
int quantity = Integer.parseInt(request.getParameter("quantity"));
ShoppingItem item = (ShoppingItem) shoppingCart.get(Integer.toString(productId));
if(item!=null){
item.quantity = quantity;
}
}
catch(Exception e){
out.println("Error updating shopping cart");
}
}
if(action!=null && action.equals("deleteShoppingItem")) {
try{
int productId =  Integer.parseInt(request.getParameter("productId"));
shoppingCart.remove(Integer.toString(productId));
}
catch(Exception e){
out.println("Error deleting the selected item from the shopping cart");
}
}
%>
<html>
<head>
    <title>Shopping Cart</title>
</head>
<body>
<table>
    <tr>
        <td colspan="2"><jsp:include page="/jsp/Header.jsp" flush="true"/></td>
    </tr>
    <tr>
        <td><jsp:include page="/jsp/Menu.jsp" flush="true"/></td>
        <td valign="top">
        <%
        %>
            <table>
                <tr>
                    <td><font face="Verdana" size="4"><b>Name</b></font> </td>
                    <td><font face="Verdana" size="4"><b>Description</b></font> </td>
                    <td><font face="Verdana" size="4"><b>Price</b></font> </td>
                    <td><font face="Verdana" size="4"><b>Quantity</b></font> </td>
                    <td><font face="Verdana" size="4"><b>Subtotal</b></font> </td>
                    <td><font face="Verdana" size="4"><b>Update</b></font> </td>
                    <td><font face="Verdana" size="4"><b>Delete</b></font> </td>
                </tr>
                <%
                Enumeration enum1 = shoppingCart.elements();
                while(enum1.hasMoreElements()){
                ShoppingItem item = (ShoppingItem) enum1.nextElement();
                %>
                <tr>
                    <td><font face="Verdana" size="2"><%=item.name%></font> </td>
                    <td><font face="Verdana" size="2"><%=item.description%></font> </td>
                    <td><font face="Verdana" size="2"><%=item.price%></font> </td>
                    <form>
                        <input type="hidden" name="action" value="updateShoppingItem">
                        <input type="hidden" name="productId" value="<%=item.productId%>">
                        <td><input type="text" size="2" name="quantity" value="<%=item.quantity%>"></td>
                        <td><font face="Verdana" size="2"><%=item.quantity*item.price%></font></td>
                        <td><input type="submit" value="Update"></td>
                    </form>
                    <form>
                        <input type="hidden" name="action" value="deleteShoppingItem">
                        <input type="hidden" name="productId" value="<%=item.productId%>">
                        <td><input type="submit" value="Delete"></td>
                    </form>
                </tr>
                <%
                }
                %>
                <tr>
                    <td colspan="7"><a href="<%=base%>?action=checkOut">Check Out</a> </td>
                </tr>
            </table>
    </tr>
</table>
</body>
</html>