<%@ page import="org.example.Product" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="dbBean" scope="application" class="org.example.DbBean" />
<html>
<head>
    <title>Order</title>
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
        if(dbBean.insertOrder(request.getParameter("contactName"), request.getParameter("deliveryAddress")
            , request.getParameter("ccName")
            , request.getParameter("ccNumber")
            , request.getParameter("ccExpiryDate"), (Hashtable) session.getAttribute("shoppingCart"))) {
        session.invalidate();
        out.println("Thank you for your purchase");
        }
        else
        out.println("Error");
        %>
        </td>
    </tr>
</table>
</body>
</html>