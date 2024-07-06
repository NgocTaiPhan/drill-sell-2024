<%@ page import="vn.hcmuaf.fit.drillsell.model.Order" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Cập nhật số lượng</title>
</head>
<body>
<form action="updateOrderQuantity" method="post">
    <div class="container">
        <%
            Order order = (Order) request.getAttribute("order");
            if (order != null) {
        %>
        <a class="back" href="showUpdateOrder?orderId=<%= order.getOrderId() %>">x</a>
        <p>Cập nhật số lượng đơn hàng</p>
        <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
        <input name="productId" value="" placeholder="Nhập mã sản phẩm">
        <input name="quantity" value="" placeholder="Nhập vào số lượng">
        <div>
            <button type="submit" class="btn"> Lưu </button>
        </div>
        <%
        } else {
        %>
        <p>Order not found.</p>
        <%
            }
        %>
    </div>
</form>

<Style>
    body{
        font-family: Arial;
        font-size: 20px;
    }
    .back{
        margin-left: 300px;
        text-decoration: none;
        color: #801e00;
        margin-top: 10px;
    }
    .container{
        width: 360px;
        height: 180px;
        border: 1px solid #cccccc;
        border-radius: 5px;
        text-align: center;
        background: #c5c3c3;
        margin-left: 600px;
        margin-top: 200px;
    }
    input{
        border-radius: 5px;
        height: 30px;
    }
    .btn{
        margin-top: 20px;
        background: #801e00;
        color: white;
    }
    .btn a{
        text-decoration: none;
    }
</Style>
</body>
</html>
