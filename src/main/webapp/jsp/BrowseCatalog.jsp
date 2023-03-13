<%@ page import="org.example.Product" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="dbBean" scope="application" class="org.example.DbBean" />
<%
String base = (String) application.getAttribute("base");
%>
<html>
<head>
    <title>Browse Catalog</title>
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
            String categoryId = request.getParameter("categoryId");
            if(categoryId!=null && !categoryId.trim().equals("")){
            %>
            <td>
                <tr>
                    <td><font face="Verdana" size="3"><b>Name</b></font></td>
                    <td><font face="Verdana" size="3"><b>Description</b></font></td>
                    <td><font face="Verdana" size="3"><b>Price</b></font></td>
                    <td><font face="Verdana" size="3"><b>Details</b></font></td>
                </tr>
                <%
                ArrayList products = dbBean.getProductsInCategory(categoryId);
                Iterator iterator = products.iterator();
                while(iterator.hasNext()){
                Product product = (Product) iterator.next();
                %>
                <tr>
                    <td><font face="Verdana" size="2"><%=product.name%></font></td>
                    <td><font face="Verdana" size="2"><%=product.description%></font></td>
                    <td><font face="Verdana" size="2"><%=product.price%></font></td>
                    <td><A href="<%=base%>?action=productDetails&productId=<%=product.id%>"><font face="Verdana" size="2">Details</font></A></td>
                </tr>
                <%
                }
                }
                else
                    out.println("Invalid category");
                %>
            </td>
    </tr>
</table>
</body>
</html>
