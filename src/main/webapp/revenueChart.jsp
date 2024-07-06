<%@ page import="vn.hcmuaf.fit.drillsell.model.Order" %>
<%@ page import="vn.hcmuaf.fit.drillsell.dao.OrderDAO" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="vn.hcmuaf.fit.drillsell.dao.UsersDAO" %><%--
  Created by IntelliJ IDEA.
  User: LaptopUSAPro
  Date: 6/30/2024
  Time: 4:48 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<% NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN")); %>
<html>
<head>
    <title>Doanh thu</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
<div class="container">
    <div class="header">
        <div class="nav-outer">
            <ul class="nav navbar-nav">
                <li class="active  yamm-fw"><a href="<%= request.getContextPath() %>/home.jsp">Trang chủ</a></li>
                <li class="active  yamm-fw"><a
                        href="<%= request.getContextPath() %>/product.jsp"
                >Sản phẩm</a></li>
            </ul>
            <!-- /.navbar-nav -->
            <div class="clearfix"></div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-3 ">
            <h2>Doanh thu hôm nay</h2>
            <%
                Order list = OrderDAO.getDaily();
                if (list != null) {
                    String formattedAmount = currencyFormat.format(list.getSumTotalDay() * 1000);
            %>
            <p><%= formattedAmount%></p>
            <%}%>
        </div>
        <div class="col-md-3 ">
            <h2>Doanh thu tháng này</h2>
            <%
                long p = OrderDAO.revenue();
                String formattedAmount = currencyFormat.format(p * 1000);

            %>
            <p>  <%= formattedAmount%></p>

        </div>
        <div class="col-md-3 ">
            <h2>Số tài khoản đăng ký</h2>
            <%
                long u = UsersDAO.getCountCustomer();
            %>
            <p>  <%= u%></p>
        </div>
    </div>
</div>
<style>
    .header {
        background: #075949;
        margin-left: -300px;
        height: 80px;
        margin-top: -15px;
    }

    h2 {
        color: #075949;
    }

    .nav {
        display: flex;
        list-style: none;
        margin-left: 100px;
    }

    .nav li {
        padding: 30px;
    }

    .nav li a {
        text-decoration: none;
        color: #ffffff;

    }

    body {
        font-family: Arial;
    }

    .container {
        margin-left: 260px;
    }

    .row {
        display: flex;
        margin: auto;
    }

    .col-md-3 {
        text-align: center;
        margin: 40px;
        width: 300px;
        height: 150px;
        border: 1px solid #f1ecec;
        border-radius: 10px;
        box-shadow: 10px 10px 5px 5px rgba(0, 0, 0, 0.2);
    }

    .col-md-3 p {
        font-size: 20px;
        color: coral;
        margin-top: 30px;
        font-weight: bold;
    }
    h1 {
        margin-top: 50px;
        margin-bottom: 50px;
        margin-left: 700px;
        color: #075949;
    }
</style>
<h1>Biểu đồ doanh thu</h1>
<canvas id="revenueChart" width="600" height="200"></canvas>
<script>
    var ctx = document.getElementById('revenueChart').getContext('2d');
    var monthlyRevenues = <%= new com.google.gson.Gson().toJson(request.getAttribute("monthlyRevenues")) %>;

    // Kiểm tra xem dữ liệu đã được lấy đúng chưa
    console.log(monthlyRevenues);

    var labels = monthlyRevenues.map(revenue => revenue.year + '-' + revenue.month);
    var data = monthlyRevenues.map(revenue => revenue.totalRevenue *1000);

    // Định dạng tiền tệ VND
    var formatter = new Intl.NumberFormat('vi-VN', {
        style: 'currency',
        currency: 'VND',
    });

    var chart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [{
                label: 'Doanh thu (VND)',
                data: data,
                backgroundColor: 'rgba(75, 192, 192, 0.2)',
                borderColor: 'rgba(75, 192, 192, 1)',
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        callback: function(value, index, values) {
                            return formatter.format(value);
                        }
                    }
                }
            },
            tooltips: {
                callbacks: {
                    label: function(tooltipItem, data) {
                        return formatter.format(tooltipItem.yLabel);
                    }
                }
            }
        }
    });
</script>
</body>
</html>
