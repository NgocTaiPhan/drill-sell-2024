<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<%@ page import="vn.hcmuaf.fit.drillsell.model.Products" %>
<%@ page import="java.util.List" %>
<%@ page import="vn.hcmuaf.fit.drillsell.model.User" %>
<%@ page import="vn.hcmuaf.fit.drillsell.dao.ProductDAO" %>
<%@ page import="vn.hcmuaf.fit.drillsell.model.ProductCategorys" %>
<%@ page import="vn.hcmuaf.fit.drillsell.dao.CartDAO" %>
<%@ page import="vn.hcmuaf.fit.drillsell.utils.ProductUtils" %>
<%@ page import="vn.hcmuaf.fit.drillsell.utils.ProducerUtils" %>
<%@ page import="vn.hcmuaf.fit.drillsell.utils.ProductCategoryUtils" %>


<%
    ProductDAO prodsService = ProductDAO.getInstance();


%>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"
          name="viewport">
    <meta content="ie=edge" http-equiv="X-UA-Compatible">
    <link href="assets/images/logo.png" rel="icon" type="image/png">
    <title>Trang chủ</title>
    <link href="assets/css/bootstrap.min.css" rel="stylesheet">


    <!--    Css tự viết-->
    <link rel="stylesheet" href="assets/css/my-css/logo-page.css">
    <!--Css tự viết-->
    <!-- Customizable CSS -->
    <link href="assets/css/main.css" rel="stylesheet">
    <link href="assets/css/blue.css" rel="stylesheet">
    <link href="assets/css/owl.carousel.css" rel="stylesheet">
    <link href="assets/css/owl.transitions.css" rel="stylesheet">
    <link href="assets/css/animate.min.css" rel="stylesheet">
    <link href="assets/css/rateit.css" rel="stylesheet">
    <link href="assets/css/bootstrap-select.min.css" rel="stylesheet">
    <link rel="stylesheet" href="assets/css/my-css/footermenu.css">
    <script src="assets/js/jquery-1.11.1.min.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>
    <script src="assets/js/bootstrap-hover-dropdown.min.js"></script>
    <script src="assets/js/owl.carousel.min.js"></script>
    <script src="assets/js/echo.min.js"></script>
    <script src="assets/js/jquery.easing-1.3.min.js"></script>
    <script src="assets/js/bootstrap-slider.min.js"></script>
    <script src="assets/js/jquery.rateit.min.js"></script>
    <script src="assets/js/lightbox.min.js" type="text/javascript"></script>
    <script src="assets/js/bootstrap-select.min.js"></script>
    <script src="assets/js/wow.min.js"></script>
    <script src="assets/js/scripts.js"></script>
    <script src="assets/js/my-js/footermenu.js"></script>

    <!-- Icons/Glyphs -->
    <link href="assets/css/font-awesome.css" rel="stylesheet">

    <!-- Fonts -->
    <link href='http://fonts.googleapis.com/css?family=Roboto:300,400,500,700' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,300,400italic,600,600italic,700,700italic,800'
          rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Montserrat:400,700' rel='stylesheet' type='text/css'>


    <script src="
https://cdn.jsdelivr.net/npm/sweetalert2@11.10.3/dist/sweetalert2.all.min.js
"></script>
    <link href="
https://cdn.jsdelivr.net/npm/sweetalert2@11.10.3/dist/sweetalert2.min.css
" rel="stylesheet">
    <script src="./assets/js/my-js/ajax-process.js"></script>
    <script src="./assets/js/my-js/notify.js"></script>
</head>

<body class="cnt-home">
<header class="header-style-1 ">

    <div class="top-bar animate-dropdown">
        <div class="container">
            <div class="header-top-inner">
                <div class="cnt-account">
                    <ul class="list-unstyled">
                        <%
                            // Lấy user hoặc usergooogle từ session
                            User u = (User) session.getAttribute("auth");
                            boolean logged = u != null;
//                            Kiểm tra nếu user rỗng thì lấy dữ liệu từ usergoogle hoặc ngược lại
                            if (logged) { %>
                        <li><a href="profile.jsp"><i class="icon fa fa-user"></i>
                            <%= (u != null) ? u.getFullname() : "" %>
                        </a></li>
                        <li><a href="cart.jsp"><i class="icon fa fa-shopping-cart"></i>Giỏ hàng</a></li>
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
                                <input id="searchInput" class="search-field dropdown-toggle" data-toggle="dropdown"
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
                    <!-- SHOPPING CART DROPDOWN -->
                    <div class="dropdown dropdown-cart">
                        <div class="lnk-cart">
                            <div class="items-cart-inner">
                                <div class="basket" id="basketIcon"
                                     onclick="checkLogin(<%=logged%>,'cart.jsp')">
                                    <i class="glyphicon glyphicon-shopping-cart"></i>
                                    <div class="cart-count" id="cart-count">
                                        <%
                                            User u1 = (User) session.getAttribute("auth");
                                            long quantity = 0;

                                            if (u1 != null) {
                                                quantity = CartDAO.countQuantity(u1.getId());
                                            }
                                        %>
                                        <p><%=quantity%></p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- /.dropdown-cart -->
                </div>

                <Style>
                    .cart-count {
                        width: 20px;
                        height: 20px;
                        position: absolute;
                        top: -10px;
                        left: 20px;
                        background-color: red;
                        color: white;
                        padding-left: 3px;
                        border-radius: 50%;
                        margin-left: 13px;
                        font-size: 12px;
                    }

                </Style>
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
                                        <%for (ProductCategorys pc :  ProductCategoryUtils.getAllCategory()) {%>
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


                                    //Kiểm tra quyền người dùng, nếu là admin thì hiển thị thẻ Quản lý
                                    if (logged) {
                                        if (u.isRoleUser()) {
                                %>
                                <li class="active yamm-fw"><a
                                        href="${pageContext.request.contextPath}/admin/user-manager.jsp">Quản lý</a>
                                </li>
                                <%
                                        }
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

<!-- ============================================== HEADER : END ============================================== -->
<div class="body-content outer-top-xs" id="top-banner-and-menu">
    <div class="container">
        <div class="row">
            <!-- ============================================== SIDEBAR ============================================== -->
            <div class="col-xs-12 col-sm-12 col-md-3 sidebar">

                <div class="sidebar-widget product-tag wow fadeInUp">
                    <h3 class="section-title">Nhà sản xuất</h3>
                    <div class="sidebar-widget-body outer-top-xs">
                        <div class="tag-list">
                            <!-- JSP Code -->

                            <%for (String producerName : ProducerUtils.getAllProducer()) {%>
                            <a class="item" style="text-transform: uppercase"
                               href="<%=request.getContextPath()%>/load-by-category?producer-name=<%=producerName%>"><%=producerName%>
                            </a>

                            <%}%>
                            <!-- /.tag-list -->
                        </div>
                        <!-- /.sidebar-widget-body -->
                    </div>
                </div>
                <!-- /.sidebar-widget -->
                <!-- ============================================== PRODUCT TAGS : END ============================================== -->
                <!-- ============================================== SPECIAL DEALS ============================================== -->


                <!-- /.sidebar-widget -->
                <!-- ============================================== SPECIAL DEALS : END ============================================== -->


                <div class="home-banner"><img src="assets/images/banners/LHS-banner.jpg" alt="Image"></div>
                <div class="home-banner"><img src="assets/images/banners/banner-canva.png" alt="Image"
                                              style="width: 270px"></div>
            </div>
            <!-- /.sidemenu-holder -->
            <!-- ============================================== SIDEBAR : END ============================================== -->

            <!-- ============================================== CONTENT ============================================== -->
            <div class="col-xs-12 col-sm-12 col-md-9 homebanner-holder">
                <!-- ========================================== SECTION – HERO ========================================= -->

                <div id="hero">
                    <div id="owl-main" class="owl-carousel owl-inner-nav owl-ui-sm">
                        <div class="item" style="background-image: url(assets/images/sliders/01.jpg); ">

                        </div>

                        <div class="item" style="background-image: url(assets/images/sliders/02.jpg);">

                        </div>
                        <div class="item" style="background-image: url(assets/images/sliders/03.jpg);">

                        </div>


                    </div>
                    <!-- /.owl-carousel -->
                </div>

                <!-- ========================================= SECTION – HERO : END ========================================= -->

                <!-- ============================================== INFO BOXES ============================================== -->
                <div class="info-boxes wow fadeInUp">
                    <div class="info-boxes-inner">
                        <div class="row">
                            <div class="col-md-6 col-sm-4 col-lg-4">
                                <div class="info-box">
                                    <div class="row">
                                        <div class="col-xs-12">
                                            <h4 class="info-box-heading green">Tiện lợi</h4>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- .col -->

                            <div class="hidden-md col-sm-4 col-lg-4">
                                <div class="info-box">
                                    <div class="row">
                                        <div class="col-xs-12">
                                            <h4 class="info-box-heading green">Giao hàng miễn phí</h4>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- .col -->

                            <div class="col-md-6 col-sm-4 col-lg-4">
                                <div class="info-box">
                                    <div class="row">
                                        <div class="col-xs-12">
                                            <h4 class="info-box-heading green">Đẩy đủ phân khúc</h4>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- .col -->
                        </div>
                        <!-- /.row -->
                    </div>
                    <!-- /.info-boxes-inner -->

                </div>


                <div class="wide-banners wow fadeInUp outer-bottom-xs">
                    <div class="row">
                        <div class="col-md-7 col-sm-7">
                            <div class="wide-banner cnt-strip">
                                <div class="image"><img class="img-responsive"
                                                        src="assets/images/banners/home-banner1.jpg" alt="Ảnh sản phẩm">
                                </div>
                            </div>

                        </div>

                        <div class="col-md-5 col-sm-5">
                            <div class="wide-banner cnt-strip">
                                <div class="image"><img class="img-responsive"
                                                        src="assets/images/banners/home-banner2.jpg" alt="Ảnh sản phẩm">
                                </div>
                            </div>

                        </div>
                        <!-- /.col -->
                    </div>
                    <!-- /.row -->
                </div>
                <!-- /.wide-banners -->

                <section class="section featured-product wow fadeInUp">
                    <h3 class="section-title"><a style="color: #fe0000" href="product.jsp">Sản phẩm</a></h3>
                    <div class="owl-carousel home-owl-carousel custom-carousel owl-theme outer-top-xs mb-10">


                        <%
                            List<Products> listProds = ProductUtils.getAllProducts();
                            for (Products p : listProds) {
                                String formattedPrice = ProductUtils.getFormattedUnitPrice(p);

                        %>


                        <div class="item item-carousel">
                            <div class="products">
                                <div class="product">
                                    <div class="product-image">
                                        <div class="image"><a href="load-detail?productId=<%= p.getProductId()%>"
                                                              methods="get"><img height="189px" width="189px"
                                                                                 src="<%=p.getImage()%>"
                                                                                 alt="Ảnh sản phẩm"></a></div>


                                    </div>


                                    <div class="product-info text-left">
                                        <h3 class="name"><a href="load-detail?productId=<%= p.getProductId()%>"
                                                            methods="get"><%=p.getProductName()%>
                                        </a>
                                        </h3>
                                        <div class="rating rateit-small"></div>
                                        <div class="description"></div>
                                        <div class="product-price"><span
                                                class="price"><%=formattedPrice%></span>
                                        </div>
                                        <!-- /.product-price -->

                                    </div>

                                </div>


                            </div>

                        </div>


                        <%}%>

                    </div>
                </section>
                <!-- /.section -->
                <!-- ============================================== FEATURED PRODUCTS : END ============================================== -->


                <section class="section featured-product wow fadeInUp">
                    <h3 class="section-title"><a style="color: #fe0000"
                                                 href="<%= request.getContextPath() %>/load-by-category?category-id=9">Phụ
                        kiện</a></h3>
                    <div class="owl-carousel home-owl-carousel custom-carousel owl-theme outer-top-xs mb-10">
                        <%
                            List<Products> accessory = ProductUtils.getAccessory();
                            for (Products a : accessory) {
                                String formattedPrice = ProductUtils.getFormattedUnitPrice(a);
                        %>
                        <div class="item item-carousel">
                            <div class="products">
                                <div class="product">
                                    <div class="product-image">
                                        <div class="image"><a href="load-detail?productId=<%= a.getProductId()%>"
                                                              methods="post"><img width="189px" height="189px"

                                                                                  src="<%=a.getImage()%>"
                                                                                  alt="Ảnh sản phẩm"></a>
                                        </div>
                                        <!-- /.image -->

                                    </div>
                                    <!-- /.product-image -->

                                    <div class="product-info text-left">
                                        <h3 class="name"><a href="load-detail?productId=<%= a.getProductId()%>"
                                                            methods="get"><%=a.getProductName()%>
                                        </a>
                                        </h3>
                                        <div class="rating rateit-small"></div>
                                        <div class="description"></div>
                                        <div class="product-price"><span
                                                class="price"> <%=formattedPrice%> </span>
                                        </div>
                                        <!-- /.product-price -->

                                    </div>
                                    <!-- /.product-info -->

                                    <!-- /.cart -->
                                </div>
                                <!-- /.product -->

                            </div>
                            <!-- /.products -->
                        </div>
                        <%}%>

                    </div>
                    <!-- /.home-owl-carousel -->
                </section>

                <!-- /.section -->
                <!-- ============================================== FEATURED PRODUCTS : END ============================================== -->

            </div>

            <!-- ============================================== CONTENT : END ============================================== -->
        </div>
        <!-- /.row -->
        <!-- ============================================== BRANDS CAROUSEL ============================================== -->
        <!-- /.logo-slider -->
        <!-- ============================================== BRANDS CAROUSEL : END ============================================== -->
    </div>
    <!-- /.container -->
</div>
<!-- /detail.jsptop-banner-and-menu -->

<!-- ============================================================= FOOTER ============================================================= -->
<footer id="footer" class="footer color-bg">
    <div class="footer-bottom">
        <div class="container">
            <div class="row">
                <div class="col-xs-12 col-sm-6 col-md-3">
                    <div class="module-heading">
                        <h4 class="module-title">Liên hệ với chúng tôi</h4>
                    </div>
                    <!-- /.module-heading -->

                    <div class="module-body">
                        <ul class="toggle-footer" style="">
                            <li class="media">
                                <div class="pull-left"> <span class="icon fa-stack fa-lg"> <i
                                        class="fa fa-map-marker fa-stack-1x fa-inverse"></i> </span></div>
                                <div class="media-body">
                                    <p>Trường Đại học Nông Lâm TPHCM</p>
                                </div>
                            </li>
                            <li class="media">
                                <div class="pull-left"> <span class="icon fa-stack fa-lg"> <i
                                        class="fa fa-mobile fa-stack-1x fa-inverse"></i> </span></div>
                                <div class="media-body">
                                    <p>+(888) 123-4567<br>
                                        +(888) 456-7890</p>
                                </div>
                            </li>
                            <li class="media">
                                <div class="pull-left"> <span class="icon fa-stack fa-lg"> <i
                                        class="fa fa-envelope fa-stack-1x fa-inverse"></i> </span></div>
                                <div class="media-body"><span><a href="#">group25@st.hcmuaf.edu.vn</a></span>
                                </div>
                            </li>
                        </ul>
                    </div>
                    <!-- /.module-body -->
                </div>
                <!-- /.col -->

                <div class="col-xs-12 col-sm-6 col-md-3">
                    <div class="module-heading">
                        <h4 class="module-title">Dịch vụ khách hàng</h4>
                    </div>
                    <!-- /.module-heading -->

                    <div class="module-body">
                        <ul class='list-unstyled'>
                            <li class="first"><a href="#" title="Tài khoản của tôi">Tài khoản của tôi</a></li>
                            <li><a href="#" title="Lịch sử đặt hàng">Lịch sử đặt hàng</a></li>
                            <li class="last"><a href="#" title="Giúp đỡ">Giúp đỡ</a></li>
                        </ul>
                    </div>
                    <!-- /.module-body -->
                </div>
                <!-- /.col -->


                <!-- /.col -->

                <div class="col-xs-12 col-sm-6 col-md-3">
                    <div class="module-heading">
                        <h4 class="module-title">Tiện ích</h4>
                    </div>
                    <!-- /.module-heading -->

                    <div class="module-body">
                        <ul class='list-unstyled'>
                            <li class="first"><a href="#" title="About us">Giỏ hàng</a></li>
                            <li><a href="#" title="Blog">Tin tức</a></li>
                            <li class=" last"><a href="contact.jsp" title="Suppliers">Về chúng tôi</a></li>
                        </ul>
                    </div>
                    <!-- /.module-body -->
                </div>

            </div>
        </div>
    </div>
    <div class="copyright-bar">
        <div class="container">
            <div class="col-xs-12 col-sm-6 no-padding social">
                <ul class="link">
                    <li class="fb pull-left"><a target="_blank" rel="nofollow" href="#" title="Facebook"></a>
                    </li>
                    <li class="tw pull-left"><a target="_blank" rel="nofollow" href="#" title="Twitter"></a>
                    </li>
                    <li class="googleplus pull-left"><a target="_blank" rel="nofollow" href="#"
                                                        title="GooglePlus"></a>
                    </li>

                    <li class="youtube pull-left"><a target="_blank" rel="nofollow" href="#"
                                                     title="Youtube"></a></li>
                </ul>
            </div>
            <div class="col-xs-12 col-sm-6 no-padding">
                <div class="clearfix payment-methods">
                    <ul>
                        <li><img src="assets/images/payments/1.png" alt="Ảnh sản phẩm"></li>
                        <li><img src="assets/images/payments/2.png" alt="Ảnh sản phẩm"></li>
                        <li><img src="assets/images/payments/3.png" alt="Ảnh sản phẩm"></li>
                        <li><img src="assets/images/payments/4.png" alt="Ảnh sản phẩm"></li>
                        <li><img src="assets/images/payments/5.png" alt="Ảnh sản phẩm"></li>
                    </ul>
                </div>
                <!-- /.payment-methods -->
            </div>


            <div>

            </div>
        </div>

    </div>
    <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal">Open Modal</button>

    <!-- Modal -->
    <div class="modal fade" id="myModal" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Modal Header</h4>
                </div>
                <div class="modal-body">
                    <p>Some text in the modal.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>

        </div>
    </div>
</footer>

<!-- ============================================================= FOOTER : END============================================================= -->
<!-- ============================================================= FOOTER : MENU============================================================= -->
<div class="social-button">
    <div class="social-button-content">
        <a href="012345678" class="call-icon" rel="nofollow">
            <i class="fa fa-whatsapp" aria-hidden="true"></i>
            <div class="animated alo-circle"></div>
            <div class="animated alo-circle-fill"></div>
            <span>Hotline: 012345678</span>
        </a>
        <a href="012345678" class="sms">
            <i class="fa fa-weixin" aria-hidden="true"></i>
            <div class="animated alo-circle"></div>
            <div class="animated alo-circle-fill"></div>
            <span>SMS: 012345678</span>
        </a>
        <a href="" class="mes">
            <i class="fa fa-facebook-square" aria-hidden="true"></i>
            <div class="animated alo-circle"></div>
            <div class="animated alo-circle-fill"></div>
            <span>Nhắn tin Facebook</span>
        </a>
        <a href="http://zalo.me" class="zalo">
            <i class="fa fa-commenting-o" aria-hidden="true"></i>
            <div class="animated alo-circle"></div>
            <div class="animated alo-circle-fill"></div>
            <span>Zalo</span>
        </a>
    </div>
    <a href="#" class="user-support">
        <i class="fa fa-circle-o-notch" aria-hidden="true"></i>
        <div class="animated alo-circle"></div>
        <div class="animated alo-circle-fill"></div>
    </a>
</div>
<script src="./assets/js/my-js/ajax-process.js"></script>
<script src="./assets/js/my-js/notify.js"></script>
<script src="./assets/js/my-js/check-login.js"></script>
<!-- ============================================================= FOOTER : MENU============================================================= -->
<!-- ============================================================= Backtop ============================================================= -->
<button onclick="topFunction()" id="back-to-top" title="Go to top"><i class=" icon fa    fa-arrow-up"></i></button>
<link rel="stylesheet" href="assets/css/my-css/backtop.css">
<script src="assets/js/my-js/backtop.js"></script>
</body>

</html>