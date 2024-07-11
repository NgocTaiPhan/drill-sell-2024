<%@ page import="vn.hcmuaf.fit.drillsell.model.Order" %>
<%@ page import="java.util.List" %>
<%@ page import="vn.hcmuaf.fit.drillsell.model.OrderItem" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Cập nhật số lượng</title>
</head>
<body>
<form id="quantityForm" action="updateOrderQuantity" method="post">
    <div class="container">
        <%
            List<Order> orders = (List<Order>) request.getAttribute("order");
            if (orders != null && !orders.isEmpty()) {
                Order order = orders.get(0);
        %>
        <a class="back" href="showUpdateOrder?orderId=<%= order.getOrderId() %>">x</a>
        <p>Cập nhật số lượng đơn hàng</p>
        <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
        <input type="hidden" name="userId" value="<%= order.getUserId() %>">
<%--        <input style="width: 20px" name="productId" value="" placeholder="Nhập mã sản phẩm">--%>
        <select style="height: 30px; border-radius: 5px" name="productId" id="productId">
            <%for (OrderItem orderItem: order.getOrderItems()){%>

            <option value="<%=orderItem.getProductId()%>"><%=orderItem.getProductName()%></option>


            <%}%>

        </select>
        <input style="width: 100px" type="number" name="quantity" min="1" value="" placeholder="Nhập vào số lượng">
        <div>
            <button type="submit" class="btn">Lưu</button>
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

<script>
    document.getElementById('quantityForm').addEventListener('submit', function(event) {
        var quantityInput = document.querySelector('input[name="quantity"]');
        var quantityValue = parseInt(quantityInput.value, 10);

        if (quantityValue < 1 || isNaN(quantityValue)) {
            alert('Số lượng phải lớn hơn 0');
            event.preventDefault(); // Ngăn chặn việc submit form
        }
    });
</script>

<style>
    body {
        font-family: Arial;
        font-size: 20px;
    }
    .back {
        margin-left: 420px;
        text-decoration: none;
        color: #801e00;
        margin-top: 20px;
    }
    .container {
        width: 500px;
        height: 180px;
        border: 1px solid #cccccc;
        border-radius: 5px;
        text-align: center;
        background: #c5c3c3;
        margin-left: 600px;
        margin-top: 200px;
    }
    input {
        border-radius: 5px;
        height: 30px;
    }
    .btn {
        margin-top: 20px;
        background: #801e00;
        color: white;
        padding: 10px 20px; /* Thêm padding để nút trông đẹp hơn */
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }
</style>
</body>
</html>
