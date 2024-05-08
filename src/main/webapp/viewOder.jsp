<%--<%@ page import="vn.hcmuaf.fit.drillsell.model.Order" %>--%>
<%--<%@ page import="vn.hcmuaf.fit.drillsell.dao.OrderDAO" %>--%>
<%--<%@ page import="java.util.List" %>--%>
<%--<%@ page import="java.text.NumberFormat" %>--%>
<%--<%@ page import="java.util.Locale" %>&lt;%&ndash;--%>
<%--  Created by IntelliJ IDEA.--%>
<%--  User: LaptopUSAPro--%>
<%--  Date: 5/3/2024--%>
<%--  Time: 1:43 PM--%>
<%--  To change this template use File | Settings | File Templates.--%>
<%--&ndash;%&gt;--%>


<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<html>--%>
<%--<head>--%>
<%--    <link href="https://cdn.datatables.net/v/dt/jqc-1.12.4/dt-2.0.3/datatables.min.css" rel="stylesheet">--%>

<%--    <script src="https://cdn.datatables.net/v/dt/jqc-1.12.4/dt-2.0.3/datatables.min.js"></script>--%>
<%--    <title>Title</title>--%>
<%--</head>--%>
<%--<body>--%>
<%--<table id="order" class="table table-bordered table-striped">--%>
<%--    <thead>--%>
<%--    <tr>--%>
<%--        <th>Mã đơn hàng</th>--%>
<%--        <th>Tên sản phẩm</th>--%>
<%--        <th>Số lượng</th>--%>
<%--        <th>Gía tiền</th>--%>
<%--        <th>Tên khách hàng</th>--%>
<%--        <th>Số điện thoại</th>--%>
<%--        <th>Địa chỉ</th>--%>
<%--        <th>Trạng thái</th>--%>
<%--        <th>Sửa</th>--%>
<%--        <th> Hủy</th>--%>

<%--    </tr>--%>
<%--    </thead>--%>
<%--    <% List<Order> viewOrders = OrderDAO.showOrder();%>--%>
<%--    <% for(Order s: viewOrders) {--%>
<%--        NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));--%>
<%--        String formattedPrice = currencyFormat.format(s.getTotalPrice() * 1000);--%>
<%--    %>--%>
<%--    <tr>--%>
<%--        <td><%= s.getId() %></td>--%>
<%--        <td><%= s.getProductName() %></td>--%>
<%--        <td><%= s.getQuantity() %></td>--%>
<%--        <td><%= formattedPrice %></td>--%>
<%--        <td><%= s.getNameCustom() %></td>--%>
<%--        <td><%= s.getPhone() %></td>--%>
<%--        <td><%= s.getAddress() %></td>--%>
<%--        <td><%= s.getStauss() %></td>--%>
<%--        <td><button><a style="color: black; text-decoration: none" href="<%=request.getContextPath()%>/viewEdit?id=<%= s.getId() %>" type="submit">Sửa</a></button></td>--%>
<%--        <td><input class="delete" data-id ="<%=s.getId()%>" type="submit" value="Xóa"></td>--%>
<%--    </tr>--%>
<%--    <% } %>--%>

<%--</table>--%>
<%--</body>--%>

<%--<script>--%>
<%--    $(document).ready(function (){--%>
<%--        $('#order').DataTable();--%>
<%--    });--%>
<%--    new DataTable('#order', {--%>
<%--       layout:{--%>
<%--           topStart: toolbar,--%>
<%--           bottomStart:toolbar--%>
<%--       }--%>
<%--    });--%>

<%--    $(document).ready(function (){--%>
<%--        $('.delete').click(function (e){--%>
<%--            e.preventDefault();--%>
<%--            var deleteOrder = $(this);--%>
<%--            var idOrder = $(this).data('id');--%>
<%--            $.ajax({--%>
<%--                type: "post",--%>
<%--                url: "deleteList?id=" + idOrder,--%>
<%--                success: function (response){--%>
<%--                    deleteOrder.closest('tr').remove();--%>
<%--                },--%>
<%--                error: function (xhr, status, error) {--%>
<%--                    console.error("Error", error);--%>
<%--                }--%>
<%--            });--%>
<%--        });--%>
<%--    });--%>

<%--</script>--%>
<%--</html>--%>
