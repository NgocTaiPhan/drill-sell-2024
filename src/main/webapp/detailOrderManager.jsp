<%@ page import="vn.hcmuaf.fit.drillsell.model.Order" %>
<%@ page import="java.util.List" %>
<%@ page import="vn.hcmuaf.fit.drillsell.dao.OrderDAO" %>
<%@ page import="vn.hcmuaf.fit.drillsell.model.OrderItem" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN")); %>
<% List< Order> list = (List<Order>) request.getAttribute("showUpdateOrder");%>
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
                    <a href="admin/dashboard.jsp">
                        <i class="ti-panel"></i>
                        <p>Dashboard</p>
                    </a>
                </li>

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
                    <a class="navbar-brand" href="#">Chi tiết đơn hàng</a>
                </div>
            </div>
        </nav>

        <div id="container" style="margin-top: 50px; margin-bottom: 400px">
            <a href="<%= request.getContextPath() + "/admin/order-management.jsp"%>"  style="float: right; margin-right: 30px; text-decoration: none; margin-top: 20px; font-weight: bold; color: #772222">x</a>
            <form action="showUpdateOrder" method="post">
                <% if (list != null && !list.isEmpty()) {
                    Order p = list.get(0);
                     %>

                <div class="content">
                    <table>
                        <h3>Chỉnh sửa đơn hàng</h3>
                        <tr>
                            <td>Mã đơn hàng:</td>
                            <input type="hidden" name="userId" value="<%= p.getUserId() %>">
                            <td><input type="hidden" name="orderId" value="<%= p.getOrderId() %>"><%= p.getOrderId() %></td>
                        </tr>
                        <tr>
                            <td>Tên khách hàng:</td>
                            <td><%= p.getNameCustomer() %></td>
                        </tr>
                        <tr>
                            <td>Số điện thoại:</td>
                            <td><input name="phone" value="<%= p.getPhone() %>"></td>
                        </tr>
                        <tr>
                            <td>Địa chỉ:</td>
                            <td><input style="width: 400px" name="address" value="<%= p.getAddress() %>"></td>
                        </tr>
                        <tr>
                            <td>Trạng thái:</td>
                            <td><input type="text" name="statuss" value="<%= p.getStauss() %>" list="status">
                                <datalist id="status">
                                    <option value="Đang xử lý">Đang xử lý</option>
                                    <option value="Đã xác nhận">Đã xác nhận</option>
                                    <option value="Người bán đang chuẩn bị hàng">Người bán đang chuẩn bị hàng</option>
                                    <option value="Đã hủy">Đã hủy</option>
                                    <option value="Đã bàn giao cho đơn vị vận chuyển GHTK">Đã bàn giao cho đơn vị vận chuyển GHTK</option>
                                    <option value="Đang giao hàng">Đang giao hàng</option>
                                    <option value="Đã giao hàng">Đã giao hàng</option>
                                    <option value="Đã hoàn trả">Đã hoàn trả</option>
                                </datalist>
                            </td>
                        </tr>
                        <table style="margin-top: 20px; margin-bottom: 20px">
                            <tr>
                                <th>Tên sản phẩm</th>
                                <th style="text-align: center">Số lượng</th>
                                <th>Tổng giá</th>
                            </tr>
                            <% for (OrderItem s : p.getOrderItems()) { double price = s.getTotalPrice() * 1000; String unitPrice = currencyFormat.format(price); %>
                            <tr>
                                <input type="hidden" name="OrderIdItem" value="<%= s.getOrderId() %>">
                                <td><%= s.getProductName() %></td>
                                <td><input style="text-align: center" name="quantity" value="<%= s.getQuantity() %>"></td>
                                <td><%= unitPrice %></td>
                            </tr>
                            <% } %>
                        </table>
                        <tr>
                            <td>Ngày dự kiến giao hàng:</td>
                            <%
                                String formattedDate = "";
                                if (p != null && p.getOrderItems() != null && !p.getOrderItems().isEmpty()) {
                                    OrderItem firstItem = p.getOrderItems().get(0);
                                    if (firstItem.getExpectedDate() != null) {
                                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                                        formattedDate = sdf.format(firstItem.getExpectedDate());
                                    }
                                }
                            %>
                            <td><input type="text" id="datepicker" name="expectedDate" value="<%= formattedDate %>"></td>
                        </tr>
                        <script>
                            $(document).ready(function() {
                                $("#datepicker").datepicker({
                                    dateFormat: "yy-mm-dd", // Định dạng ngày tháng năm
                                    changeMonth: true,
                                    changeYear: true
                                });
                            });
                        </script>


                        <td>
                            <button type="submit" style="margin-left: 550px" class="btn btn-danger">
                                Cập nhật
                            </button>
                        </td>
                    </table>
                </div>
                <% } %>
            </form>
        </div>

            <style>
                #container{
                    background: white;
                    margin: auto;
                    width: 700px;
                    border: 1px solid black;
                    border-radius: 20px;
                }
                .content{
                    width: 650px;
                    margin: auto;

                }
                body{
                    font-size: 18px;
                    font-family: Arial;
                }

                input{
                    border: none;
                    background: none;
                }
                /*.btn{*/
                /*    font-weight: bold;*/
                /*    background: #772222;*/
                /*    border: none;*/
                /*    width: 90px;*/
                /*    height: 40px;*/
                /*    border-radius: 30px;*/
                /*    margin-top: 20px;*/
                /*    margin-bottom: 20px;*/
                /*    color: white;*/
                /*    float: right;*/
                /*    margin-right: 30px;*/
                /*}*/

            </style>
        </div>
        <footer class="footer">
            <div class="container-fluid">
                <nav class="pull-left">
                    <ul>

                        <li>
                            <a href="http://www.creative-tim.com">
                                Creative Tim
                            </a>
                        </li>
                        <li>
                            <a href="http://blog.creative-tim.com">
                                Blog
                            </a>
                        </li>
                        <li>
                            <a href="http://www.creative-tim.com/license">
                                Licenses
                            </a>
                        </li>
                    </ul>
                </nav>
                <div class="copyright pull-right">
                    &copy;
                    <script>document.write(new Date().getFullYear())</script>
                    , made with <i class="fa fa-heart heart"></i> by <a href="http://www.creative-tim.com">Creative
                    Tim</a>
                </div>
            </div>
        </footer>


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


</html>
