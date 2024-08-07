<%@ page import="java.util.List" %>
<%@ page import="vn.hcmuaf.fit.drillsell.model.Products" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="vn.hcmuaf.fit.drillsell.dao.ProductDAO" %>
<%@ page import="vn.hcmuaf.fit.drillsell.model.ProductCategorys" %>
<%@ page import="vn.hcmuaf.fit.drillsell.model.User" %>
<%@ page import="vn.hcmuaf.fit.drillsell.dao.CartDAO" %>
<%@ page import="vn.hcmuaf.fit.drillsell.utils.ProductUtils" %>
<%@ page import="vn.hcmuaf.fit.drillsell.utils.ProducerUtils" %>
<%@ page import="vn.hcmuaf.fit.drillsell.utils.ProductCategoryUtils" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%


%>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">


    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">

    <link rel="icon" href="assets/images/logo.png" type="image/png">
    <title>Sản phẩm
    </title>
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">

    <!-- Customizable CSS -->
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

    <!-- Icons/Glyphs -->
    <link rel="stylesheet" href="assets/css/font-awesome.css">

    <!-- Fonts -->
    <link href='http://fonts.googleapis.com/css?family=Roboto:300,400,500,700' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,300,400italic,600,600italic,700,700italic,800'
          rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Montserrat:400,700' rel='stylesheet' type='text/css'>
    <script src="./assets/js/my-js/check-login.js"></script>
</head>

<body class="cnt-home">
<!-- ============================================== HEADER ============================================== -->
<header class="header-style-1 ">

    <!-- ============================================== TOP MENU ============================================== -->
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
                    <!-- ============================================================= SHOPPING CART DROPDOWN ============================================================= -->

                    <div class="dropdown dropdown-cart">
                        <div class="dropdown-toggle lnk-cart" data-toggle="dropdown">
                            <div class="items-cart-inner">
                                <div class="basket" id="basketIcon" onclick="checkLogin(<%=logged%>,'cart.jsp')">
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
                                <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.10.3/dist/sweetalert2.all.min.js"></script>
                                <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.10.3/dist/sweetalert2.min.css"
                                      rel="stylesheet"/>
                                <script>
                                    //Kiểm tra xem nếu chưa đăng nhập thì hiển thị thông báo
                                    function redirectToCart() {

                                        <% if (!logged) { %>
                                        Swal.fire({
                                            title: "Bạn chưa đăng nhập",
                                            icon: "warning",
                                            showCancelButton: true,
                                            confirmButtonText: "Đăng nhập",
                                            cancelButtonText: `Để sau`
                                        }).then((result) => {
                                            //Bấm vào nút Đăng nhập lúc thông báo sẽ chuyển đến trang Đăng nhập
                                            if (result.isConfirmed) {
                                                window.location.href = 'login.jsp';
                                            }
                                        });
                                        <% } else { %>
                                        window.location.href = 'cart.jsp';
                                        <% } %>
                                    }
                                </script>


                            </div>
                        </div>

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
                                <li class="active yamm-fw"><a href="/admin/dashboard.jsp">Quản lý</a></li>
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
<div class="breadcrumb">
    <div class="container" style="white-space: nowrap">
        <div class="breadcrumb-inner">
            <ul class="list-inline list-unstyled">
                <li><a href="home.jsp">Trang chủ</a></li>
                <li class='active'>Sản phẩm</li>
            </ul>
        </div><!-- /.breadcrumb-inner -->
    </div><!-- /.container -->
</div>

<!-- ============================================== HEADER : END ============================================== -->
<div class="body-content outer-top-xs" id="top-banner-and-menu">
    <div class="container">
        <div class="row">
            <!-- ============================================== SIDEBAR ============================================== -->
            <div class="col-xs-12 col-sm-12 col-md-3 sidebar">

                <!-- ================================== TOP NAVIGATION ================================== -->
                <div class="side-menu animate-dropdown outer-bottom-xs">
                    <div class="head"><i class="icon fa fa-align-justify fa-fw"></i> Máy khoan</div>
                    <nav class="yamm megamenu-horizontal">
                        <ul class="nav">

                            <%
                                List<ProductCategorys> allCate =  ProductCategoryUtils.getAllCategory();
                                for (ProductCategorys pc : allCate) {%>
                            <li class="nav-bg-class">
                                <a href="<%= request.getContextPath() %>/load-by-category?category-id=<%=pc.getId()%>">
                                    <%=pc.getNameCategory()%>
                                </a>

                            </li>
                            <%}%>

                        </ul>
                        <!-- /.nav -->
                    </nav>
                    <!-- /.megamenu-horizontal -->
                </div>
                <!-- /.side-menu -->
                <!-- ================================== TOP NAVIGATION : END ================================== -->


                <!-- ============================================== PRODUCT TAGS ============================================== -->
                <div class="sidebar-widget product-tag wow fadeInUp">
                    <h3 class="section-title">Nhà sản xuất</h3>
                    <div class="sidebar-widget-body outer-top-xs">
                        <div class="tag-list">
                            <!-- JSP Code -->

                            <%for (String producerName :   ProducerUtils.getAllProducer()) {%>
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
                <div class="home-banner"><img src="assets/images/banners/LHS-banner.jpg" alt="Image"></div>
                <div class="home-banner"><img src="assets/images/banners/banner-canva.png" alt="Image"
                                              style="width: 270px"></div>
            </div>
            <!-- /.sidemenu-holder -->
            <!-- ============================================== SIDEBAR : END ============================================== -->


            <!-- ============================================== CONTENT ============================================== -->
            <div class='col-md-9'>
                <!-- ========================================== SECTION – HERO ========================================= -->

                <div id="category" class="category-carousel hidden-xs">
                    <div class="item">
                        <div class="image"><img src="assets/images/banners/cat-banner-1.jpg" alt="Ảnh sản phẩm"
                                                class="img-responsive"></div>
                        <div class="container-fluid">
                            <div class="caption vertical-top text-left">
                                <h1 class="big-text"> Sốc</h1>
                                <div class="excerpt hidden-sm hidden-md"> Giảm đến 49%</div>
                                <div class="excerpt-normal hidden-sm hidden-md"> Dành cho những sản phẩm bán chạy
                                </div>
                            </div>
                            <!-- /.caption -->
                        </div>
                        <!-- /.container-fluid -->
                    </div>
                </div>

                <div class="product" style="background: white">
                    <h3 class="section-title" style="padding: 10px">Tất cả sản phẩm</h3>
                    <div class="row">
                        <%
                            List<Products> products = ProductUtils.getAllProducts();
                            int productsPerPage = 16;
                            int currentPage = 1;
                            if (request.getParameter("page") != null) {
                                currentPage = Integer.parseInt(request.getParameter("page"));
                            }
                            int totalProducts = products.size();
                            int totalPages = (int) Math.ceil((double) totalProducts / productsPerPage);

                            int startProductIndex = (currentPage - 1) * productsPerPage;
                            int endProductIndex = Math.min(startProductIndex + productsPerPage, totalProducts);

                            for (int i = startProductIndex; i < endProductIndex; i++) {
                                Products p = products.get(i);
                                NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
                                String formattedPrice = currencyFormat.format(p.getUnitPrice() * 1000);
                                if (i % 4 == 0 && i != startProductIndex) {
                        %>
                    </div>
                    <div class="row">
                        <%
                            }
                        %>
                        <div class="col-xl-3 col-md-3 col-sm-6">
                            <div class="product-image">
                                <div class="image"><a href="load-detail?productId=<%= p.getProductId()%>"><img height="189px"
                                                                                                               width="189px"
                                                                                                               src="<%=p.getImage()%>"
                                                                                                               alt="Ảnh sản phẩm"></a>
                                </div>
                            </div>

                            <div class="product-info text-left">
                                <h3 class="name"><a href="load-detail?productId=<%= p.getProductId()%>"><%=p.getProductName()%>
                                </a></h3>
                                <div class="rating rateit-small"></div>
                                <div class="description"></div>
                                <div class="product-price">
                                    <span class="price"> <%=formattedPrice%></span>
                                </div>
                            </div>
                        </div>
                        <%
                            }
                        %>
                    </div>

                </div>
                <div class="pagination">
                    <nav aria-label="Page navigation" style="margin: auto">
                        <ul class="pagination">
                            <%
                                for (int i = 1; i <= totalPages; i++) {
                            %>
                            <li class="page-item <%= (i == currentPage) ? "active" : "" %>">
                                <a class="page-link" href="?page=<%= i %>"><%= i %></a>
                            </li>
                            <%
                                }
                            %>
                        </ul>
                    </nav>
                </div>

            </div>

            <!-- ============================================== CONTENT : END ============================================== -->
        </div>

    </div>
    <!-- /.container -->
</div>
<!-- /#top-banner-and-menu -->

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
                                    <p>Đại học Nông Lâm TPHCM</p>
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
                                <div class="media-body"><span><a href="#">group25@st.hcmuaf.edu.vn</a></span></div>
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
                            <li class=" last"><a href="about-us.jsp" title="Suppliers">Về chúng tôi</a></li>
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
                    <li class="fb pull-left"><a target="_blank" rel="nofollow" href="#" title="Facebook"></a></li>
                    <li class="tw pull-left"><a target="_blank" rel="nofollow" href="#" title="Twitter"></a></li>
                    <li class="googleplus pull-left"><a target="_blank" rel="nofollow" href="#" title="GooglePlus"></a>
                    </li>

                    <li class="youtube pull-left"><a target="_blank" rel="nofollow" href="#" title="Youtube"></a></li>
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
        </div>
    </div>
</footer>
<!-- ============================================================= FOOTER : END============================================================= -->
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
<style>


    .col-sm-6.col-md-4.wow.fadeInUp .product-image img {
        width: 250px;
        height: 200px;
    }
</style>


</html>