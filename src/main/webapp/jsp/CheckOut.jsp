<%
String base = (String) application.getAttribute("base");
%>
<html>
<head>
    <title>Check Out</title>
</head>
<body>
<table>
    <tr>
        <td colspan="2"><jsp:include page="/jsp/Header.jsp" flush="true"/></td>
    </tr>
    <tr>
        <td><jsp:include page="/jsp/Menu.jsp" flush="true"/></td>
        <td valign="top">
            <form>
                <input type="hidden" name="action" value="order">
                <table>
                    <tr>
                        <td colspan="2"><i><b>Delivery Details</b></i></td>
                    </tr>
                    <tr>
                        <td>Contact Name:</td>
                        <td><input type="text" name="contactName"></td>
                    </tr>
                    <tr>
                        <td>Address:</td>
                        <td><input type="text" name="deliveryAddress"></td>
                    </tr>
                    <tr>
                        <td colspan="2"><i><b>Credit Card Details</b></i></td>
                    </tr>
                    <tr>
                        <td>Name on Credit Card:</td>
                        <td><input type="text" name="ccName"></td>
                    </tr>
                    <tr>
                        <td>Credit Card Number:</td>
                        <td><input type="text" name="ccNumber"></td>
                    </tr>
                    <tr>
                        <td>Credit Card Expiry Date:</td>
                        <td><input type="text" name="ccExpiryDate"></td>
                    </tr>
                    <tr>
                        <td>&nbsp</td>
                        <td><input type="submit" value="Check Out"></td>
                    </tr>
                </table>
            </form>
        </td>
    </tr>
</table>
</body>
</html>