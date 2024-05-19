<%@ page import="vn.hcmuaf.fit.drillsell.model.Products" %>
<%@ page import="vn.hcmuaf.fit.drillsell.dao.ProductDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <link rel="icon" type="image/png" sizes="96x96" href="../assets/images/logo.png">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>

    <title>Quản lý sản phẩm</title>

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


    <script src="../assets/js/jquery-1.11.1.min.js"></script>
    <script src="../assets/js/bootstrap.min.js"></script>
    <script src="../assets/js/bootstrap-hover-dropdown.min.js"></script>
    <script src="../assets/js/owl.carousel.min.js"></script>
    <script src="../assets/js/echo.min.js"></script>
    <script src="../assets/js/jquery.easing-1.3.min.js"></script>
    <script src="../assets/js/bootstrap-slider.min.js"></script>
    <script src="../assets/js/jquery.rateit.min.js"></script>
    <script src="../assets/js/lightbox.min.js" type="text/javascript"></script>
    <script src="../assets/js/bootstrap-select.min.js"></script>
    <script src="../assets/js/wow.min.js"></script>

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
                    <a href="dashboard.jsp">
                        <i class="ti-panel"></i>
                        <p>Dashboard</p>
                    </a>
                </li>

                <li>
                    <a href="user-management.jsp">
                        <i class="ti-user"></i>
                        <p>Quản lý người dùng</p>
                    </a>
                </li>
                <li class="active">
                    <a href="products-management.jsp">
                        <i class="ti-check-box"></i>
                        <p>Quản lý sản phẩm</p>
                    </a>
                </li>
                <li>
                    <a href="order-management.jsp">
                        <i class="ti-shopping-cart"></i>
                        <p>Quản lý đơn hàng</p>
                    </a>
                </li>


            </ul>
        </div>
    </div>

    <div class="main-panel">
        <nav class="navbar navbar-default">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar bar1"></span>
                        <span class="icon-bar bar2"></span>
                        <span class="icon-bar bar3"></span>
                    </button>
                    <a class="navbar-brand" href="#">Quản lý sản phẩm</a>
                </div>

            </div>
        </nav>
        <div class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">

                            <div class="content table-responsive table-full-width">
                                <a class="btn btn-info" href="add-prods.jsp"> Thêm sản phẩm</a>
                                <table id="prod-mn" class="table table-striped">
                                    <thead>
                                    <th>Mã sản phẩm</th>
                                    <th>Tên sản phẩm</th>
                                    <th>Giá</th>
                                    <th>Số lượng đã bán</th>
                                    <th>Số lượng còn lại</th>
                                    <th>Hành động</th>
                                    </thead>
                                    <tbody>
                                    <%for (Products p : ProductDAO.getInstance().showProd()) {%>
                                    <tr>
                                        <td><%=p.getProductId()%>
                                        </td>
                                        <td><%=p.getProductName()%>
                                        </td>
                                        <td><%=ProductDAO.getInstance().getFormattedUnitPrice(p)%>
                                        </td>
                                        <td>10</td>

                                        <td>
                                            <%--                                               <%=p.getStatuss()%>--%>
                                        <td>
                                            <button type="button" class="btn btn-info" data-toggle="modal"
                                                    data-target="#prods-infor">Xem chi tiết
                                            </button>
                                            <button type="button" class="btn btn-warning"
                                            >Sửa
                                            </button>
                                            <button type="button" class="btn btn-danger"
                                            >Xóa
                                            </button>
                                        </td>
                                    </tr>

                                    <%}%>

                                    </tbody>
                                </table>

                            </div>
                        </div>
                    </div>


                </div>
            </div>
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


<%--Modal dùng đẻ hiển thị cửa sổ popup thêm sản phẩm--%>

<script !src="">

    let toolbar = document.createElement('div');
    toolbar.innerHTML = '<b></b>';
    // Tạo nút thêm sản phẩm để khi nhấp vào sẽ xuất hiện cửa sổ pop-up
    $(document).ready(function () {


        // Viết các hàm tạo datamodel


        // Áp dụng datatable cho bảng Quản lý sản phẩm với top là nút Thêm sản phẩm
        new DataTable('#prod-mn', {
            layout: {
                topStart: toolbar,
                bottomStart: toolbar
            }
        });

    });

</script>
</html>
