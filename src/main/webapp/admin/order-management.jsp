<%@ page import="vn.hcmuaf.fit.drillsell.model.Order" %>

<%@ page import="java.util.List" %>
<%@ page import="vn.hcmuaf.fit.drillsell.dao.OrderDAO" %>
<%@ page import="vn.hcmuaf.fit.drillsell.model.ProductCategorys" %>
<%@ page import="vn.hcmuaf.fit.drillsell.dao.ProductDAO" %>
<%@ page import="vn.hcmuaf.fit.drillsell.model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <link href="../assets/css/my-css/admin/bootstrap.min.css" rel="stylesheet"/>

    <!-- Animation library for notifications   -->
    <link href="../assets/css/my-css/admin/animate.min.css" rel="stylesheet"/>

    <!--  Paper Dashboard core CSS    -->
    <link href="../assets/css/my-css/admin/paper-dashboard.css" rel="stylesheet"/>


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
                <a href="../home.jsp" class="simple-text">
                    Máy khoan
                </a>
            </div>

            <ul class="nav">


                <li>
                    <a href="user-manager.jsp">
                        <i class="ti-user"></i>
                        <p>Quản lý người dùng</p>
                    </a>
                </li>
                <li>
                    <a href="products-management.jsp">
                        <i class="ti-check-box"></i>
                        <p>Quản lý sản phẩm</p>
                    </a>
                </li>
                <li class="active">
                    <a href="viewOrderMa">
                        <i class="ti-shopping-cart"></i>
                        <p>Quản lý đơn hàng</p>
                    </a>
                </li>
                <li>
                    <a href="log_management.jsp">
                        <%--                        <i class="ti-shopping-cart"></i>--%>
                        <p>Quản lý log</p>
                    </a>
                </li>
                <li class="">
                    <a href="store-manager.jsp">
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
                <div class="header-nav animate-dropdown">
                    <div class="container">
                        <div class="yamm navbar navbar-default" role="navigation">
                            <!--                <div class="navbar-header">-->
                            <!--                    <button data-target="#mc-horizontal-menu-collapse" data-toggle="collapse"-->
                            <!--                            class="navbar-toggle collapsed"-->
                            <!--                            type="button">-->
                            <!--                        <span class="sr-only">Toggle navigation</span> <span class="icon-bar"></span> <span-->
                            <!--                            class="icon-bar"></span> <span class="icon-bar"></span></button>-->
                            <!--                </div>-->


                            <div class="nav-bg-class">
                                <div class="navbar-collapse collapse" id="mc-horizontal-menu-collapse"
                                >
                                    <div class="nav-outer">
                                        <ul class="nav navbar-nav">
                                            <li class="active  yamm-fw"><a
                                                    href="<%= request.getContextPath() %>/home.jsp">Trang chủ</a></li>
                                            <li class="active  yamm-fw"><a
                                                    href="<%= request.getContextPath() %>/product.jsp"
                                            >Sản phẩm</a></li>
                                            <li class="active  yamm-fw"><a
                                                    href="<%= request.getContextPath() %>/revenueChart">Xem thống kê</a>
                                            </li>
                                        </ul>
                                        <!-- /.navbar-nav -->
                                        <div class="clearfix"></div>
                                    </div>
                                    <!-- /.nav-outer -->
                                </div>
                                <!-- /.navbar-collapse -->

                            </div>
                            <!-- /.nav-bg-class -->
                        </div>
                        <!-- /.navbar-default -->
                    </div>
                    <!-- /.container-class -->

                </div>

            </div>
        </nav>

        <table id="order" style="margin-top: 30px" class="table">

            <thead>
            <tr>
                <th>Mã đơn hàng</th>
                <th>Người đặt hàng</th>
                <th>Địa chỉ</th>
                <th>Số điện thoại</th>
                <th>Trạng thái</th>
                <th></th>
            </tr>
            </thead>
            <tbody>


            <%
                List<Order> showView = (List<Order>) request.getAttribute("viewOrderMa");
                if (showView != null) {
                    for (Order p : showView) {
            %>

            <tr>
                <td><%=p.getOrderId()%>
                </td>
                <td><%= p.getNameCustomer()%>
                </td>
                <td><%= p.getAddress()%>
                </td>
                <td><%= p.getPhone()%>
                </td>
                <%--                <td><%= p.getStauss()%></td>--%>
                <td>
                    <form action="<%=request.getContextPath()%>/updateStatus" method="post">
                        <%--                            <%--%>
                        <%--                                Order order = (Order) request.getAttribute("updateStatus");--%>
                        <%--                                if (order != null) {--%>
                        <%--                            %>--%>
                        <%--                            <a class="back" href="<%= request.getContextPath()%>/admin/viewOrderMa">x</a>--%>
                        <%--                            <p style="font-size: 20px ; font-weight: bold">Cập nhật trạng thái đơn hàng</p>--%>
                        <input type="hidden" name="orderId" value="<%= p.getOrderId() %>">
                        <input type="hidden" name="userId" value="<%= p.getUserId() %>">
                        <%--                            <input style="width: 40px; text-align: center"  name="orderId" value="<%=order.getOrderId()%>">--%>
                        <select style="height: 30px; border-radius: 5px" class="status" name="status" id="status">
                            <option value=""><%=p.getStauss()%>
                            </option>
                            <option value="1">Đang xử lý</option>
                            <option value="2">Đã xác nhận</option>
                            <option value="3">Người bán đang chuẩn bị hàng</option>
                            <option value="4">Đã bàn giao cho đơn vị vận chuyển GHTK</option>
                            <option value="5">Đang giao hàng</option>
                            <option value="6">Đã giao hàng</option>
                            <option value="7">Đã hoàn trả</option>
                            <option value="8">Đã hủy</option>
                        </select>
                        <button style="float: right" type="submit"
                           class="btn btn-warning">
                            Lưu
                        </button>
                    </form>
                </td>
                <td>

                    <input type="hidden" name="status" value="<%= p.getStauss()%>">
                    <a href="<%= request.getContextPath()%>/showUpdateOrder?orderId=<%=p.getOrderId()%>"
                       class="btn btn-info">
                        Chi tiết
                    </a>

                </td>
            </tr>


            <%
                    }
                }
            %>
            </tbody>
        </table>
    </div>

    <script>
        $(document).ready(function () {
            $('#order').DataTable({
                "order": [[0, "desc"]]  // Sắp xếp theo cột đầu tiên (Mã log) giảm dần
            });
        });
    </script>


</div>
</div>
</div>
<Style>
    input {
        border: none;
        background: none;
    }
</Style>


</div>
</div>


</body>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.datatables.net/1.10.24/js/jquery.dataTables.min.js"></script>
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.24/css/jquery.dataTables.min.css">
<script src="../assets/js/my-js/admin.js">

</script>
<script>
    function updateQuantity(orderId){
        $.ajax({
            type: "POST",
            url: "updateStatus",
            data: {orderId: orderId},
            success: function (response) {
                location.reload();
            },
            error: function (xhr, status, error) {
                console.error("Lỗi: " + error);
            }
        });
    }

</script>


</html>
