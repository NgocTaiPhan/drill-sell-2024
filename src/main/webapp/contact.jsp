<%@ page import="vn.hcmuaf.fit.drillsell.dao.ProductDAO" %>
<%@ page import="vn.hcmuaf.fit.drillsell.model.ProductCategorys" %>
<%@ page import="vn.hcmuaf.fit.drillsell.model.User" %>
<%@ page import="vn.hcmuaf.fit.drillsell.dao.CartDAO" %>
<!--<%@ page contentType="text/html;charset=UTF-8" language="java" %>-->
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="icon" href="assets/images/logo.png" type="image/png">
    <title>Liên hệ</title>
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
</head>
<body>
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
                                <div class="basket" id="basketIcon" onclick="redirectToCart()">
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
                <li><a href="home.html">Trang chủ</a></li>
                <li class='active'>Liên hệ</li>
            </ul>
        </div><!-- /.breadcrumb-inner -->
    </div><!-- /.container -->
</div>
<div class="body-content">
    <div class="container">
        <div class="contact-page">
            <div class="row">

                <div class="mapouter">
                    <div class="gmap_canvas">
                        <iframe class="gmap_iframe" frameborder="0" scrolling="no" marginheight="0" marginwidth="0"
                                src="https://maps.google.com/maps?width=1100&amp;height=400&amp;hl=en&amp;q=Nông lâm&amp;t=&amp;z=14&amp;ie=UTF8&amp;iwloc=B&amp;output=embed"></iframe>
                        <a href="https://connectionsgame.org/">Connections Unlimited</a></div>
                    <style>.mapouter {
                        position: relative;
                        text-align: right;
                        width: 1100px;
                        height: 400px;
                    }

                    .gmap_canvas {
                        overflow: hidden;
                        background: none !important;
                        width: 1100px;
                        height: 400px;
                    }

                    .gmap_iframe {
                        width: 1100px !important;
                        height: 400px !important;
                    }</style>
                </div>
                <div class="col-md-9 contact-form">
                    <div class="col-md-12 contact-title">
                        <h4>Liên hệ</h4>
                    </div>
                    <div class="col-md-4 ">
                        <form class="register-form" role="form">
                            <div class="form-group">
                                <label class="info-title" for="exampleInputName">Tên của bạn <span>*</span></label>
                                <input type="email" class="form-control unicase-form-control text-input"
                                       id="exampleInputName" placeholder="">
                            </div>
                        </form>
                    </div>
                    <div class="col-md-4">
                        <form class="register-form" role="form">
                            <div class="form-group">
                                <label class="info-title" for="exampleInputEmail1"> Địa chỉ email<span>*</span></label>
                                <input type="email" class="form-control unicase-form-control text-input"
                                       id="exampleInputEmail1" placeholder="">
                            </div>
                        </form>
                    </div>
                    <div class="col-md-4">
                        <form class="register-form" role="form">
                            <div class="form-group">
                                <label class="info-title" for="exampleInputTitle">Tiêu đề <span>*</span></label>
                                <input type="email" class="form-control unicase-form-control text-input"
                                       id="exampleInputTitle" placeholder="Tiêu đề">
                            </div>
                        </form>
                    </div>
                    <div class="col-md-12">
                        <form class="register-form" role="form">
                            <div class="form-group">
                                <label class="info-title" for="exampleInputComments">Nội dung
                                    <span>*</span></label>
                                <textarea class="form-control unicase-form-control"
                                          id="exampleInputComments"></textarea>
                            </div>
                        </form>
                    </div>
                    <div class="col-md-12 outer-bottom-small m-t-20">
                        <button type="submit" class="btn-upper btn btn-primary checkout-page-button">Gửi
                        </button>
                    </div>
                </div>
                <div class="col-md-3 contact-info">
                    <div class="contact-title">
                        <h4>Thông tin </h4>
                    </div>
                    <div class="clearfix address">
                        <span class="contact-i"><i class="fa fa-map-marker"></i></span>
                        <span class="contact-span">Trường Đại học Nông Lâm TpHCM</span>
                    </div>
                    <div class="clearfix phone-no">
                        <span class="contact-i"><i class="fa fa-mobile"></i></span>
                        <span class="contact-span">+(888) 123-4567<br>+(888) 456-7890</span>
                    </div>
                    <div class="clearfix email">
                        <span class="contact-i"><i class="fa fa-envelope"></i></span>
                        <span class="contact-span"><a href="#">group25@gmail.com</a></span>
                    </div>
                </div>
            </div><!-- /.contact-page -->
        </div><!-- /.row -->
        <!-- ============================================== BRANDS CAROUSEL ============================================== -->
        <div id="brands-carousel" class="logo-slider wow fadeInUp">

            <div class="logo-slider-inner">
                <div id="brand-slider" class="owl-carousel brand-slider custom-carousel owl-theme">
                    <div class="item m-t-15">
                        <a href="#" class="image">
                            <img data-echo="assets/images/brands/brand1.png" src="assets/images/blank.gif" alt="">
                        </a>
                    </div><!--/.item-->

                    <div class="item m-t-10">
                        <a href="#" class="image">
                            <img data-echo="assets/images/brands/brand2.png" src="assets/images/blank.gif" alt="">
                        </a>
                    </div><!--/.item-->

                    <div class="item">
                        <a href="#" class="image">
                            <img data-echo="assets/images/brands/brand3.png" src="assets/images/blank.gif" alt="">
                        </a>
                    </div><!--/.item-->

                    <div class="item">
                        <a href="#" class="image">
                            <img data-echo="assets/images/brands/brand4.png" src="assets/images/blank.gif" alt="">
                        </a>
                    </div><!--/.item-->

                    <div class="item">
                        <a href="#" class="image">
                            <img data-echo="assets/images/brands/brand5.png" src="assets/images/blank.gif" alt="">
                        </a>
                    </div><!--/.item-->

                    <div class="item">
                        <a href="#" class="image">
                            <img data-echo="assets/images/brands/brand6.png" src="assets/images/blank.gif" alt="">
                        </a>
                    </div><!--/.item-->

                    <div class="item">
                        <a href="#" class="image">
                            <img data-echo="assets/images/brands/brand2.png" src="assets/images/blank.gif" alt="">
                        </a>
                    </div><!--/.item-->

                    <div class="item">
                        <a href="#" class="image">
                            <img data-echo="assets/images/brands/brand4.png" src="assets/images/blank.gif" alt="">
                        </a>
                    </div><!--/.item-->

                    <div class="item">
                        <a href="#" class="image">
                            <img data-echo="assets/images/brands/brand1.png" src="assets/images/blank.gif" alt="">
                        </a>
                    </div><!--/.item-->

                    <div class="item">
                        <a href="#" class="image">
                            <img data-echo="assets/images/brands/brand5.png" src="assets/images/blank.gif" alt="">
                        </a>
                    </div><!--/.item-->
                </div><!-- /.owl-carousel #logo-slider -->
            </div><!-- /.logo-slider-inner -->

        </div><!-- /.logo-slider -->
        <!-- ============================================== BRANDS CAROUSEL : END ============================================== -->
    </div><!-- /.container -->
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
                                <li class="first"><a href="#" title="Card">Giỏ hàng</a></li>
                                <li><a href="#" title="News">Tin tức</a></li>
                                <li class=" last"><a href="about-us.html" title="About us">Về chúng tôi</a></li>
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
                        <li class="googleplus pull-left"><a target="_blank" rel="nofollow" href="#"
                                                            title="GooglePlus"></a>
                        </li>

                        <li class="youtube pull-left"><a target="_blank" rel="nofollow" href="#" title="Youtube"></a>
                        </li>
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


    <!-- For demo purposes – can be removed on production -->


    <!-- For demo purposes – can be removed on production : End -->

    <!-- JavaScripts placed at the end of the document so the pages load faster -->


    <script>
        $(document).ready(function () {
            $(".changecolor").switchstylesheet({seperator: "color"});
            $('.show-theme-options').click(function () {
                $(this).parent().toggleClass('open');
                return false;
            });
        });

        $(window).bind("load", function () {
            $('.show-theme-options').delay(2000).trigger('click');
        });
    </script>
    <!-- For demo purposes – can be removed on production : End -->


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
