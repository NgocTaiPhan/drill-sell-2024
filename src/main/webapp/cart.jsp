<%@ page import="vn.hcmuaf.fit.drillsell.model.Cart" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Set" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="vn.hcmuaf.fit.drillsell.dao.ProductDAO" %>
<%@ page import="vn.hcmuaf.fit.drillsell.model.ProductCategorys" %>

<%@ page import="vn.hcmuaf.fit.drillsell.model.User" %>
<%@ page import="vn.hcmuaf.fit.drillsell.model.UserGoogleDto" %>

<%@ page import="java.util.List" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% ProductDAO prodsService = ProductDAO.getInstance();%>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">


    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
    <link rel="icon" href="assets/images/logo.png" type="image/png">

    <title>Giỏ hàng</title>
    <link rel="stylesheet" href="assets\css\bootstrap.min.css">

    <!-- Customizable CSS -->
    <link rel="stylesheet" href="assets\css\main.css">
    <!-- Icons/Glyphs -->
    <link rel="stylesheet" href="assets\css\font-awesome.css">

    <!-- Fonts -->
    <link href='http://fonts.googleapis.com/css?family=Roboto:300,400,500,700' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,300,400italic,600,600italic,700,700italic,800'
          rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Montserrat:400,700' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" href="assets\css\StyleCard.css">

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


    <!-- Main Style CSS -->
    <link rel="stylesheet" href="assets/css/style.css">
    <!-- Responsive CSS -->
    <link rel="stylesheet" href="css/responsive.css">
    <!-- Modernizr js -->
    <script src="js/vendor/modernizr-2.8.3.min.js"></script>
</head>

<body>
<!-- ============================================== HEADER ============================================== -->
<header class="header-style-1 ">

    <!-- ============================================== TOP MENU ============================================== -->
    <div class="top-bar animate-dropdown">
        <div class="container">
            <div class="header-top-inner">
                <div class="cnt-account">
                    <ul class="list-unstyled">
                        <%
                            User u = (User) session.getAttribute("auth");
                            UserGoogleDto user = (UserGoogleDto) session.getAttribute("auth-google");
                            if ((boolean) session.getAttribute("logged")) { %>
                        <li><a href="account.jsp"><i class="icon fa fa-user"></i>
                            <%= (u != null) ? u.getFullname() : user.getName() %>
                        </a></li>
                        <li><a href="card.jsp"><i class="icon fa fa-shopping-cart"></i>Giỏ hàng</a></li>
                        <li><a href="order.jsp"><i class="icon fa fa-check"></i>Thanh toán</a></li>
                        <li><a href="<%=request.getContextPath()%>/logout"><i
                                class="icon fa fa-arrow-circle-o-right"></i>Đăng xuất</a></li>
                        <% } else { %>
                        <li><a href="login.jsp"><i class="icon fa fa-lock"></i>Đăng nhập</a></li>
                        <% } %>
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
                    <div class="logo-page"><a href="home.jsp"> <img
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
                                <input id="searchInput" class="search-field dropdown-toggle" style="height: 44.5px"
                                       data-toggle="dropdown"
                                       name="name" placeholder="Tìm kiếm...">
                                <a style="height: 44.5px;" class="search-button" href="#"
                                   onclick="searchProduct(event)"></a>


                            </div>
                        </form>

                    </div>
                    <script>
                        function searchProduct(event) {
                            event.preventDefault();  // Ngăn chặn hành vi mặc định của liên kết
                            var keyword = document.getElementById("searchInput").value;

                            // Chuyển hướng đến trang seachProduct.jsp với tham số tìm kiếm
                            window.location.href = "seachProduct?name=" + encodeURIComponent(keyword);
                        }
                    </script>
                    <!-- /.search-area -->
                    <!-- ============================================================= SEARCH AREA : END ============================================================= -->
                </div>
                <!-- /.top-search-holder -->

                <div class="col-xs-12 col-sm-12 col-md-2 animate-dropdown top-cart-row">
                    <!-- ============================================================= SHOPPING CART DROPDOWN ============================================================= -->

                    <div class="dropdown dropdown-cart">
                        <a href="#" class="dropdown-toggle lnk-cart" data-toggle="dropdown">
                            <div class="items-cart-inner">
                                <div class="basket" id="basketIcon" onclick="redirectToCart()">
                                    <i class="glyphicon glyphicon-shopping-cart"></i>
                                </div>
                                <script>
                                    function redirectToCart() {

                                        <% if (!(boolean) session.getAttribute("logged")) { %>
                                        Swal.fire({
                                            icon: 'error',
                                            title: 'Bạn chưa đăng nhập',
                                            text: 'Vui lòng đăng nhập để tiếp tục!',
                                            confirmButtonText: 'Đồng ý'
                                        });
                                        <% } else { %>
                                        window.location.href = 'cart.jsp';
                                        <% } %>
                                    }
                                </script>


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
                                        <%for (ProductCategorys pc : ProductDAO.getInstance().getAllCategory()) {%>
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

                                <%--                                <%--%>

                                <%--                                    User user = (User) session.getAttribute("kh");--%>
                                <%--                                    if (user != null) {--%>

                                <%--                                                System.out.println("boxsell: " + user.getboxsell());--%>
                                <%--                                                System.out.println("username: " + user.getUsername());--%>

                                <%--                                                if (user.getboxsell() != 0 && user.getUsername() != null) {--%>
                                <%--                                %>--%>
                                <%--                                <li class="active yamm-fw"><a href="manager">quản lí sp</a></li>--%>
                                <%--                                <%--%>
                                <%--                                                }--%>
                                <%--                                            }--%>

                                <%--                                %>--%>


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

<div class="breadcrumb-area">
    <div class="container">
        <div class="breadcrumb-content">
            <ul>
                <li><a href="home.jsp">Trang chủ</a></li>
                <li class="active">Giỏ hàng</li>
            </ul>
        </div>
    </div>
</div>
<!-- Li's Breadcrumb Area End Here -->
<!--Shopping Cart Area Strat-->
<div class="body-content outer-top-xs" id="top-banner-and-menu">
    <div class="container">
        <div class="row">
            <div class="col-12">

                <form action="#">

                    <div class="table-content table-responsive">

                        <table class="table">
                            <thead>
                            <tr>
                                <th class="li-product-remove">Xóa</th>
                                <th class="li-product-sub">Chọn</th>
                                <th class="li-product-thumbnail">Hình ảnh</th>
                                <th class="cart-product-name">Thông tin</th>
                                <th class="li-product-price">Đơn Gía</th>
                                <th class="li-product-quantity">Số lượng</th>
                                <th class="li-product-subtotal">Thành tiền</th>
                            </tr>
                            </thead>
                            <tbody>
                            <%
                                for (Cart p : (List<Cart>) request.getAttribute("products")) {
                                    NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
                                    String formattedPrice = currencyFormat.format(p.getUnitPrice() * 1000);
                                    String formattedAmount = currencyFormat.format(p.getTotalPrice() * 1000);
                            %>
                            <tr>

                                <td class="li-product-remove"><a href="#"><i class="fa fa-times"></i></a></td>
                                <td class="sub">
                                    <input type="checkbox" id="checkbox">

                                </td>

                                <td class="li-product-thumbnail"><a href="#"><img height="100px" width="100px"
                                                                                  src="<%= p.getImage()%>"
                                                                                  alt="Li's Product Image"></a></td>
                                <td class="li-product-name"><a href="#"><%= p.getProductName()%>
                                </a></td>
                                <td class="li-product-price"><span
                                        class="amount"> <%= formattedPrice%></span></td>
                                <div id="errorMessage" style="color: red;"></div>
                                <td class="quantity">
                                    <button class="minus-button"  type="button" onclick="reduceQuantity(<%= p.getProductId()%>)">-</button>
                                    <div class="cart-plus-minus">
                                        <input id="quantityInput" class="cart-plus-minus-box"
                                               value="<%= p.getQuantity()%>">

                                    </div>
                                    <button class="plus-button" type="button"
                                            onclick="increaseQuantity(<%= p.getProductId()%>)">+
                                    </button>
                                    <script>
                                        function increaseQuantity(productId) {
                                        $.ajax({
                                            type: "POST",
                                            url: "UpdateQuantityHight",
                                            data: {productId: productId},
                                            success: function (response) {
                                              location.reload();
                                            },
                                            error: function (xhr, status, error) {
                                                console.error("Lỗi: " + error);
                                            }
                                        });
                                    }

                                    function reduceQuantity(productId){
                                        $.ajax({
                                           type: "POST",
                                           url: "updateQuantityLow",
                                           data: {productId: productId},
                                           success:function (response){
                                               location.reload();
                                           } ,
                                            error: function (xhr, status, error) {
                                                console.error("Lỗi: " + error);
                                            }
                                        });
                                    }

                                    </script>
                                </td>

                                <style>
                                    .quantity {
                                        display: flex;
                                    }

                                    .quantity button,
                                    .quantity .cart-plus-minus-box,
                                    .quantity .plus-button {
                                        display: inline-block;
                                        text-align: center;
                                    }

                                    .quantity .cart-plus-minus-box {
                                        margin-left: 10px;
                                    }

                                </style>


                                <td class="product-subtotal">
                                    <span id="subtotal" class="amount"><%= formattedAmount%></span>
                                </td>

                            </tr>
                            <%}%>

                            </tbody>
                        </table>

                    </div>

                    <div class="cart-page-total">
                        <a class="checkOut" href="#">Thanh toán</a>

                    </div>

                </form>

            </div>
        </div>
    </div>
</div>
<!-- ============================================================= FOOTER : MENU============================================================= -->
<div class="social-button">
    <div class="social-button-content">
        <a href="tel:0353933224" class="call-icon" rel="nofollow">
            <i class="fa fa-whatsapp" aria-hidden="true"></i>
            <div class="animated alo-circle"></div>
            <div class="animated alo-circle-fill"></div>
            <span>Hotline: 035 393 3224</span>
        </a>
        <a href="sms:0353933224" class="sms">
            <i class="fa fa-weixin" aria-hidden="true"></i>
            <div class="animated alo-circle"></div>
            <div class="animated alo-circle-fill"></div>
            <span>SMS: 035 393 3224</span>
        </a>
        <a href="https://www.facebook.com/Ngocthang.net/" class="mes">
            <i class="fa fa-facebook-square" aria-hidden="true"></i>
            <div class="animated alo-circle"></div>
            <div class="animated alo-circle-fill"></div>
            <span>Nhắn tin Facebook</span>
        </a>
        <a href="http://zalo.me/0353933224" class="zalo">
            <i class="fa fa-commenting-o" aria-hidden="true"></i>
            <div class="animated alo-circle"></div>
            <div class="animated alo-circle-fill"></div>
            <span>Zalo: 035.393.3224</span>
        </a>
    </div>
    <a href="#" class="user-support">
        <i class="fa fa-circle-o-notch" aria-hidden="true"></i>
        <div class="animated alo-circle"></div>
        <div class="animated alo-circle-fill"></div>
    </a>
</div>

<!-- ============================================================= FOOTER : MENU============================================================= -->
<!-- ============================================================= Backtop ============================================================= -->
<button onclick="topFunction()" id="back-to-top" title="Go to top"><i class=" icon fa    fa-arrow-up"></i></button>
<link rel="stylesheet" href="assets/css/my-css/backtop.css">
<script src="assets/js/my-js/backtop.js"></script>

</body>
</html>