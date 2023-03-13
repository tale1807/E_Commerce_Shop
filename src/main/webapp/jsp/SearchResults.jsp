<%@ page import="org.example.Product" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="dbBean" scope="application" class="org.example.DbBean" />
<%
String base = (String) application.getAttribute("base");
%>
<html>
<head>
    <title>
        Search Results
    </title>
</head>
<body>
<table>
    <tr>
        <td colspan="2"><jsp:include page = "/jsp/Header.jsp" flush="true"/></td>
    </tr>
    <tr>
        <td><jsp:include page="/jsp/Menu.jsp" flush="true"/></td>
        <td valign="TOP">
            <%
            String keyword = request.getParameter("keyword");
            if(keyword!=null && !keyword.trim().equals("")){
            %>
            <table>
                <tr>
                    <td><font face="Verdana" size="3"><b>Name</b></font></td>
                    <td><font face="Verdana" size="3"><b>Description</b></font></td>
                    <td><font face="Verdana" size="3"><b>Price</b></font></td>
                    <td><font face="Verdana" size="3"><b>Details</b></font></td>
                </tr>
                <%
                    ArrayList products = dbBean.getSearchResults(keyword);
                    Iterator iterator = products.iterator();
                    while(iterator.hasNext()){
                        Product product = (Product) iterator.next();
                %>
                <tr>
                    <td><font face="Verdana" size="2"><%=product.name%></font></td>
                    <td><font face="Verdana" size="2"><%=product.description%></font></td>
                    <td><font face="Verdana" size="2"><%=product.price%></font></td>
                    <td><a href="<%=base%>?action=productDetails&productId=<%=product.id%>">
                        <font face="Verdana" size="2">Details</font></a></td>
                </tr>
            </table>
                <%
                }
                }
                else
                    out.println("Please enter a search keyword.");
                %>
        </td>
    </tr>
</table>
</body>
</html>