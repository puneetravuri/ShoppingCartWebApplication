<%@ page import="java.util.*" %>
<%@ page import="ajax.store.*" %>
<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <script type="text/javascript" language="javascript" src="ajax1.js"></script>
        <script type="text/javascript" language="javascript" src="cart.js"></script>
        <script type="text/javascript" language="javascript" src="json-minified.js"></script>
        <link rel="stylesheet" href="newcss.css" type="text/css" />
    </head>
    <body>
        <div style="float: left; width: 600px">
            <h2>Catalog</h2>
            <table border="1">
                <thead><th>Name</th><th>Description</th><th>Price</th><th></th><th></th></thead>
                <tbody>
                    <%
                        for (Iterator<Item> I = new Catalog().getAllItems().iterator(); I.hasNext();) {
                            Item item = I.next();
                    %>
                    <tr><td><%= item.getName()%></td><td><%= item.getDescription()%></td><td><%= item.getFormattedPrice()%></td><td><button onclick="addToCart('<%= item.getCode()%>')">Add to Cart</button></td><td><button onclick="deleteFromCart('<%= item.getCode()%>')">Delete From Cart</button></td></tr>
                    <% }%>
                </tbody>
            </table>
            <div style="position: absolute; top: 0px; right: 200px; width: 250px;">
                <h2>Cart Contents</h2>
                <ul id="contents">
                </ul>
                <h3>Total Cost: <span id="total">$0.00</span></h3>
            </div>
        </div>
    </body>
</html>
