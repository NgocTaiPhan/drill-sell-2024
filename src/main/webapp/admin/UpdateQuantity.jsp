<%@ page import="vn.hcmuaf.fit.drillsell.model.Order" %>
<%@ page import="java.util.List" %>
<%@ page import="vn.hcmuaf.fit.drillsell.dao.OrderDAO" %>
<%@ page import="vn.hcmuaf.fit.drillsell.model.OrderItem" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="vn.hcmuaf.fit.drillsell.dao.GHNProvinceFetcher" %>
<%@ page import="vn.hcmuaf.fit.drillsell.dao.GHNDistricFetcher" %>
<%@ page import="vn.hcmuaf.fit.drillsell.dao.GHNWardFetcher" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN")); %>
<% List<Order> list = (List<Order>) request.getAttribute("showUpdateOrder");%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <link rel="apple-touch-icon" sizes="76x76" href="assets/img/apple-icon.png">
    <link rel="icon" type="image/png" sizes="96x96" href="assets/img/favicon.png">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>

    <title>Quản lý đơn hàng</title>

    <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport'/>
    <meta name="viewport" content="width=device-width"/>

    <!-- Bootstrap core CSS     -->
    <link href="assets/css/my-css/admin/bootstrap.min.css" rel="stylesheet"/>

    <!-- Animation library for notifications   -->
    <link href="assets/css/my-css/admin/animate.min.css" rel="stylesheet"/>

    <!--  Paper Dashboard core CSS    -->
    <link href="assets/css/my-css/admin/paper-dashboard.css" rel="stylesheet"/>


    <!--  Fonts and icons     -->
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">
    <link href='https://fonts.googleapis.com/css?family=Muli:400,300' rel='stylesheet' type='text/css'>

    <%--    Datatable--%>
    <link href="https://cdn.datatables.net/v/dt/jqc-1.12.4/dt-2.0.3/datatables.min.css" rel="stylesheet">
    <script src="https://cdn.datatables.net/v/dt/jqc-1.12.4/dt-2.0.3/datatables.min.js"></script>

</head>
<body>

<div class="wrapper">
    <div class="sidebar" data-background-color="white" data-active-color="primary">

        <!--
            Tip 1: you can change the color of the sidebar's background using: data-background-color="white | black"
            Tip 2: you can change the color of the active button using the data-active-color="primary | info | success | warning | danger"
        -->

        <div class="sidebar-wrapper">
            <div class="logo">
                <a href="home.jsp" class="simple-text">
                    Máy khoan
                </a>
            </div>

            <ul class="nav">
                <li>
                    <a href="admin/user-manager.jsp">
                        <i class="ti-user"></i>
                        <p>Quản lý người dùng</p>
                    </a>
                </li>
                <li>
                    <a href="admin/products-management.jsp">
                        <i class="ti-check-box"></i>
                        <p>Quản lý sản phẩm</p>
                    </a>
                </li>
                <li class="active">
                    <a href="admin/order-management.jsp">
                        <i class="ti-shopping-cart"></i>
                        <p>Quản lý đơn hàng</p>
                    </a>
                </li>
                <li>
                    <a href="admin/log_management.jsp">
                        <%--                        <i class="ti-shopping-cart"></i>--%>
                        <p>Quản lý log</p>
                    </a>
                </li>
                <li class="">
                    <a href="admin/store-manager.jsp">
                        <i class="ti-user"></i>
                        <p>Quản lý kho</p>
                    </a>
                </li>

            </ul>
        </div>
    </div>

    <div class="main-panel">
        <nav class="navbar navbar-default">
            <div class="container-fluid">
                <div class="navbar-header">
                    <a class="navbar-brand" href="#">Cập nhật số lượng đơn hàng</a>
                </div>
            </div>
        </nav>
        <form id="quantityForm" action="updateOrderQuantity" method="post">
            <div class="container">
                <%
                    List<Order> orders = (List<Order>) request.getAttribute("order");
                    if (orders != null && !orders.isEmpty()) {
                        Order order = orders.get(0);
                %>
                <a class="back" href="<%= request.getContextPath()%>/admin/viewOrderMa">x</a>
                <p style="font-weight: bold; font-size: 25px;text-align: center">Cập nhật số lượng đơn hàng</p>
                <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
                <input type="hidden" name="userId" value="<%= order.getUserId() %>">
                <%--        <input style="width: 20px" name="productId" value="" placeholder="Nhập mã sản phẩm">--%>
               <div style="display: flex; margin-bottom: 10px">
                   <p>Chọn sản phẩm: </p>
                   <select  style="height: 30px; border-radius: 5px; font-size: 15px; width: 300px; margin-left: 30px" name="productId" id="productId">
                       <%for (OrderItem orderItem: order.getOrderItems()){%>

                       <option value="<%=orderItem.getProductId()%>"><%=orderItem.getProductName()%></option>


                       <%}%>

                   </select>
               </div>
                <div style="display: flex">
                    <p>Nhập vào số lượng: </p>
                    <input style="margin-left: 5px; width: 200px; font-size: 15px" type="number" name="quantity" min="1" value="" placeholder="Nhập vào số lượng">

                </div>
                <div>
                    <button style="margin-left: 200px" type="submit" class="btn">Lưu</button>
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
                height: 240px;
                border: 1px solid #cccccc;
                border-radius: 5px;
                background: white;
                margin-left: 300px;
                margin-top: 100px;
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
    </div>
</div>


</body>
<script src="assets/js/my-js/admin.js">
    $(document).ready(function () {
        $('.delete').click(function (e) {
            var deleteOrder = $(this);
            var idOrder = $(this).data('id');
            $.ajax({
                type: "post",
                url: "deleteList?id=" + idOrder,
                success: function (response) {
                    deleteOrder.closest('tr').remove();
                },
                error: function (xhr, status, error) {
                    console.error("Error", error);
                }
            });
        })
    })
</script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.13.1/jquery-ui.min.js"></script>
<script src="assets/js/my-js/address.js"></script>

</html>
