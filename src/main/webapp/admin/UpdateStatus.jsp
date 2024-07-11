<%@ page import="vn.hcmuaf.fit.drillsell.model.Order" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Cập nhật trạng thái</title>
</head>
<body>
<form action="updateStatus" method="post">
    <div class="container">
        <%
            Order order = (Order) request.getAttribute("updateStatus");
            if (order != null) {
        %>
        <a class="back" href="showUpdateOrder?orderId=<%= order.getOrderId() %>">x</a>
        <p>Cập nhật số lượng đơn hàng</p>
        <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
        <input type="hidden" name="userId" value="<%= order.getUserId() %>">
        <input style="width: 40px; text-align: center"  name="orderId" value="<%=order.getOrderId()%>">
        <select style="height: 30px; border-radius: 5px" class="status" name="status" id="status" >
            <option value=""><%=order.getStauss()%></option>
            <option value="Đang xử lý">Đang xử lý</option>
            <option value="Đã xác nhận">Đã xác nhận</option>
            <option value="Người bán đang chuẩn bị hàng">Người bán đang chuẩn bị hàng</option>
            <option value="Đã bàn giao cho đơn vị vận chuyển GHTK">Đã bàn giao cho đơn vị vận chuyển GHTK</option>
            <option value="Đang giao hàng">Đang giao hàng</option>
            <option value="Đã giao hàng">Đã giao hàng</option>
            <option value="Đã hoàn trả">Đã hoàn trả</option>
            <option value="Đã hủy">Đã hủy</option>
        </select>
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
        margin-left: 380px;
        text-decoration: none;
        color: #801e00;
        margin-top: 10px;
    }
    .container{
        width: 460px;
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
