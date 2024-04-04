<%@ page import="vn.hcmuaf.fit.drillsell.service.ProductService" %>
<%@ page import="vn.hcmuaf.fit.drillsell.bean.ProductCategorys" %>
<%@ page import="vn.hcmuaf.fit.drillsell.bean.User" %>
<%@ page import="vn.hcmuaf.fit.drillsell.service.UserService" %>
<%@ page import="vn.hcmuaf.fit.drillsell.bean.Product" %>
<%@ page import="vn.hcmuaf.fit.drillsell.bean.Products" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="icon" href="assets/images/logo.png" type="image/png">
    <title>Quản trị</title>
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">

    <!-- Customizable CSS ================================================================================-->

    <link rel="stylesheet" href="assets/css/main.css">
    <link rel="stylesheet" href="assets/css/blue.css">
    <link rel="stylesheet" href="assets/css/owl.carousel.css">
    <link rel="stylesheet" href="assets/css/owl.transitions.css">
    <link rel="stylesheet" href="assets/css/animate.min.css">
    <link rel="stylesheet" href="assets/css/rateit.css">
    <link rel="stylesheet" href="assets/css/bootstrap-select.min.css">
    <link rel="stylesheet" href="assets/css/my-css/footermenu.css">

    <script src="assets/js/jquery-1.11.1.min.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>
    <script src="assets/js/bootstrap-hover-dropdown.min.js"></script>
    <script src="assets/js/owl.carousel.min.js"></script>
    <script src="assets/js/echo.min.js"></script>
    <script src="assets/js/jquery.easing-1.3.min.js"></script>
    <script src="assets/js/bootstrap-slider.min.js"></script>
    <script src="assets/js/jquery.rateit.min.js"></script>
    <script type="text/javascript" src="assets/js/lightbox.min.js"></script>
    <script src="assets/js/bootstrap-select.min.js"></script>
    <script src="assets/js/wow.min.js"></script>
    <script src="assets/js/scripts.js"></script>
    <script src="assets/js/my-js/footermenu.js"></script>


    <!-- Icons/Glyphs ==============================================================================================-->
    <link rel="stylesheet" href="assets/css/font-awesome.css">

    <!-- Fonts =========================================================================================================-->
    <link href='http://fonts.googleapis.com/css?family=Roboto:300,400,500,700' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,300,400italic,600,600italic,700,700italic,800'
          rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Montserrat:400,700' rel='stylesheet' type='text/css'>
</head>
<body>

<header class="header-style-1 ">

    <!-- ============================================== TOP MENU ============================================== -->
    <div class="top-bar animate-dropdown">
        <div class="container">
            <div class="header-top-inner">
                <div class="cnt-account">
                    <ul class="list-unstyled">

                        <li><a href="account.html"><i class="icon fa fa-user"></i>Tài khoản</a></li>
                        <li><a href="card.html"><i class="icon fa fa-shopping-cart"></i>Giỏ hàng</a></li>
                        <li><a href="oder.html"><i class="icon fa fa-check"></i>Thanh toán</a></li>
                        <li><a href="login.html"><i class="icon fa fa-lock"></i>Đăng nhập</a></li>
                    </ul>
                </div>


                <!-- /.cnt-cart -->
                <div class="clearfix"></div>
            </div>
            <!-- /.header-top-inner -->
        </div>
        <!-- /.container -->
    </div>
    <!-- /.header-top -->
    <!-- ============================================== TOP MENU : END ============================================== -->
    <div class="main-header">
        <div class="container">
            <div class="row">
                <div class="col-xs-12 col-sm-12 col-md-3 logo-holder">
                    <!-- ============================================================= LOGO ============================================================= -->
                    <link rel="stylesheet" href="assets/css/my-css/logo-page.css">
                    <div class="logo-page"><a href="home.html"> <img
                            src="assets/images/logo.png" alt="logo"
                    > </a></div>


                    <!-- /.logo -->
                    <!-- ============================================================= LOGO : END ============================================================= -->
                </div>
                <!-- /.logo-holder -->
                <div class="nameLogo">
                    <h1 class="name">MÁY KHOAN</h1>

                </div>

                <div class="col-xs-12 col-sm-12 col-md-7 top-search-holder">
                    <!-- /.contact-row -->
                    <!-- ============================================================= SEARCH AREA ============================================================= -->
                    <div class="search-area">
                        <form action="seachProduct" method="get">
                            <div class="control-group dropdown">
                                <input id="searchInput" class="search-field dropdown-toggle" data-toggle="dropdown"
                                       name="name" placeholder="Tìm kiếm...">
                                <a style="height: 44.5px;" class="search-button" href="#"
                                   onclick="searchProduct(event)"></a>


                            </div>
                        </form>

                    </div>
                    <!-- /.search-area -->
                    <!-- ============================================================= SEARCH AREA : END ============================================================= -->
                </div>
                <!-- /.top-search-holder -->
                <script>
                    function searchProduct(event) {
                        event.preventDefault();  // Ngăn chặn hành vi mặc định của liên kết
                        var keyword = document.getElementById("searchInput").value;

                        // Chuyển hướng đến trang seachProduct.jsp với tham số tìm kiếm
                        window.location.href = "seachProduct?name=" + encodeURIComponent(keyword);
                    }
                </script>
                <!-- /.top-search-holder -->
                <div class="col-xs-12 col-sm-12 col-md-2 animate-dropdown top-cart-row">
                    <!-- ============================================================= SHOPPING CART DROPDOWN ============================================================= -->
                    <div class="dropdown dropdown-cart">
                        <a href="#" class="dropdown-toggle lnk-cart" data-toggle="dropdown">
                            <div class="items-cart-inner">
                                <!-- Thêm một sự kiện nhấp chuột vào div -->
                                <div class="basket" id="basketIcon" onclick="redirectToCart()">
                                    <i class="glyphicon glyphicon-shopping-cart"></i>
                                </div>

                                <!-- Bạn có thể đặt mã JavaScript ở phía dưới trang hoặc tách riêng thành một tệp JS -->
                                <script>
                                    function redirectToCart() {
                                        // Thực hiện chuyển hướng đến trang s.jsp khi nhấp vào
                                        window.location.href = 'cart.jsp';
                                    }
                                </script>


                                <%--                                <div id="cartItemCount" class="basket-item-count">--%>
                                <%--                                    <span id="cartItemCountValue" class="count">0</span>--%>
                                <%--                                </div>--%>


                            </div>
                        </a>

                    </div>
                    <!-- /.dropdown-cart -->
                    <!-- ============================================================= SHOPPING CART DROPDOWN : END============================================================= -->
                </div>
                <!-- /.top-cart-row -->
            </div>
            <!-- /.row -->

        </div>
        <!-- /.container -->

    </div>
    <!-- /.main-header -->

    <!-- ============================================== NAVBAR ============================================== -->
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
                                <li class="active  yamm-fw"><a href="home.jsp">Trang chủ</a></li>
                                <li class="active  yamm-fw"><a href="<%= request.getContextPath() %>/product.jsp"
                                >Sản phẩm</a></li>
                                <li class="dropdown active  ">
                                    <a class="dropdown-menu-left" data-hover="dropdown">Danh mục sản phẩm</a>
                                    <ul class="dropdown-menu ">
                                        <%for (ProductCategorys pc : ProductService.getInstance().getAllCategory()) {%>
                                        <li>
                                            <a href="<%= request.getContextPath() %>/load-by-category?category-id=<%=pc.getId()%>"
                                               methods="post"></i>
                                                <%=pc.getNameCategory()%>
                                            </a>

                                        </li>
                                        <%}%>

                                    </ul>
                                </li>
                                <li class="active  yamm-fw"><a href="contact.jsp">Liên hệ</a></li>

                                <%
                                    Boolean role = (Boolean) session.getAttribute("role-acc");
                                    if (role != null && role) {
                                %>
                                <li class="active yamm-fw"><a href="admin.jsp">Quản lý</a></li>
                                <%
                                    }
                                %>


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
    <!-- /.header-nav -->
    <!-- ============================================== NAVBAR : END ============================================== -->

</header>
<div class="body-content outer-top-xs" id="top-banner-and-menu" style="font-size: medium">
    <div class="">
        <div class="row">
            <div class="product-tabs inner-bottom-xs  wow fadeInUp">
                <div class="row">
                    <div id="manager-label" class="col-sm-2">
                        <ul id="product-tabs" class="nav">
                            <li class="active"><a data-toggle="tab" href="#users-management">Quản lý người dùng</a></li>
                            <li><a data-toggle="tab" href="#products-management">Quản lý sản phẩm</a>
                            </li>
                            <li><a data-toggle="tab" href="#statistics">Doanh thu</a></li>
                        </ul><!-- /.nav-tabs #product-tabs -->
                    </div>
                    <style>
                        #manager-label {
                            white-space: nowrap;
                            margin-left: 50px;
                        }


                    </style>
                    <div class="col-sm-9">

                        <div class="tab-content">

                            <div id="users-management" class="tab-pane in active">
                                <div class="product-tab">
                                    <div class="container">


                                        <table class="table table-bordered ">
                                            <thead style="text-align: center">
                                            <tr>
                                                <th>ID</th>
                                                <th>Tên người dùng</th>
                                                <th>Email</th>
                                                <th>Hành động</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <%for (User u : UserService.getInstance().showAll()) {%>

                                            <tr>
                                                <td><%=u.getId()%>
                                                </td>
                                                <td><%=u.getFullname()%>
                                                </td>
                                                <td><%=u.getEmail()%>
                                                </td>
                                                <td>
                                                    <button class="btn btn-warning">Xem chi tiết</button>
                                                </td>
                                            </tr>
                                            <%}%>

                                            </tbody>
                                        </table>

                                    </div>
                                </div>
                            </div><!-- /.tab-pane -->

                            <div id="products-management" class="tab-pane">
                                <div class="product-tab container">

                                    <table class="table table-bordered  " style="white-space: nowrap">
                                        <thead>
                                        <tr>
                                            <th>Mã sản phẩm</th>
                                            <th>Tên sản phẩm</th>
                                            <th>Giá</th>
                                            <th>Số lượng đã bán</th>
                                            <th>Số lượng còn lại</th>
                                            <th>Hành động</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <%for (Products p : ProductService.getInstance().showProd()) {%>
                                        <tr>
                                            <td><%=p.getProductId()%>
                                            </td>
                                            <td><%=p.getProductName()%>
                                            </td>
                                            <td><%=ProductService.getInstance().getFormattedUnitPrice(p)%>
                                            </td>
                                            <td>10</td>
                                            <td><%=p.getStatuss()%>
                                            </td>
                                            <td>
                                                <button class="btn btn-warning">Xem chi tiết</button>
                                            </td>
                                        </tr>

                                        <%}%>
                                        <tr>
                                            <td>Tổng</td>
                                            <td>3</td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td>
                                                <a class="btn btn-danger" href="admin/insert-products.jsp">Thêm sản
                                                    phẩm</a>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>

                                </div><!-- /.product-tab -->
                            </div><!-- /.tab-pane -->
<div class="modal">





</div>
                            <div id="statistics" class="tab-pane">
                                <div class="product-tag container">

                                    <table class="table table-bordered ">
                                        <thead>
                                        <tr>
                                            <th>Số lượng bán ra</th>
                                            <th>Tổng doan thu</th>

                                        </tr>
                                        </thead>
                                        <tbody>

                                        <tr>
                                            <td>100</td>
                                            <td>10.000.000đ</td>

                                        </tr>
                                        </tbody>
                                    </table>

                                </div><!-- /.product-tab -->
                            </div><!-- /.tab-pane -->

                        </div><!-- /.tab-content -->
                    </div><!-- /.col -->
                </div><!-- /.row -->
            </div>

        </div>
    </div>
</div>

<!-- ============================================================= FOOTER : MENU============================================================= -->


<!-- ============================================================= FOOTER : MENU============================================================= -->
<!-- ============================================================= Backtop ============================================================= -->
<button onclick="topFunction()" id="back-to-top" title="Go to top"><i class=" icon fa    fa-arrow-up"></i></button>
<link rel="stylesheet" href="assets/css/my-css/backtop.css">
<script src="assets/js/my-js/backtop.js"></script>
</body>
</html>