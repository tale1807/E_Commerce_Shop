<%@ page import="org.example.Product" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="dbBean" scope="application" class="org.example.DbBean"/>
<%
String base = (String) application.getAttribute("base");
String imageUrl = (String) application.getAttribute("imageUrl");
%>
<html>
<head>
    <title>Product details</title>
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
            try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            Product product = dbBean.getProductDetails(productId);
            if(product!=null) {
        %>
            <table>
                <tr>
                    <td><img border="0" width="100" src="<%=(imageUrl + product.id)%>.gif"></td>
                    <br><b><%=product.name%></b><br>
                    <%=product.description%><br>
                    Price : $<%=product.price%></td>
                </tr>
                <tr>
                    <td colspan="2" align="right">
                        <a href="<%=base%>?action=addShoppingItem&productId=<%=product.id%>">Add to Cart</a>
                    </td>
                </tr>
            </table>
        <%
        }
        }
        catch(Exception e){
        out.println("Error : invalid product identifier");
        }
        %>
        </td>
    </tr>
</table>
</body>
</html>