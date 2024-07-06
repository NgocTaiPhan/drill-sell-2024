<%@ page import="java.util.List" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.ArrayList" %>

<%@ page import="vn.hcmuaf.fit.drillsell.dao.ProductDAO" %>

<%@ page import="vn.hcmuaf.fit.drillsell.model.Products" %>
<%@ page import="vn.hcmuaf.fit.drillsell.model.User" %>
<%@ page import="vn.hcmuaf.fit.drillsell.model.*" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%List<Products> searchResults = (List<Products>) request.getAttribute("loadProduct");%>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="icon" href="assets/images/logo.png" type="image/png">
    <title>Sản phẩm</title>
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
                                </div>
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
                <li><a href="home.jsp">Trang chủ / Máy Khoan</a></li>
                <li class='active'>Sản phẩm</li>
            </ul>
        </div><!-- /.breadcrumb-inner -->
    </div><!-- /.container -->
</div>
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
                            <li class="nav-bg-class"><a href="<%= request.getContextPath() %>/battery_drill"
                                                        methods="post"></i>Máy khoan pin</a>

                            </li>
                            <li class="nav-bg-class"><a href="<%= request.getContextPath() %>/movers"
                                                        methods="post"></i>Máy khoan động lực</a>

                            </li>

                            <li class="nav-bg-class"><a href="<%= request.getContextPath() %>/hand_drill"
                                                        methods="post"></i>Máy khoan cầm tay gia đình</a>

                            </li>
                            <li class="nav-bg-class"><a href="<%= request.getContextPath() %>/mini_drill"
                                                        methods="post"></i>Máy khoan mini</a>

                            </li>
                            <li class="nav-bg-class"><a href="<%= request.getContextPath() %>/hammer_drill"
                                                        methods="post"></i>Máy khoan bê tông, Máy khoan búa</a>

                            </li>

                            <li class="">
                                <a href="accessory.jsp" class="dropdown-med" data-toggle="dropdown">Phụ kiện máy khoan
                                    <b
                                            class="caret"></b></a>
                                <ul class="dropdown-menu">
                                    <li><a href="<%= request.getContextPath() %>/z_battery" methods="post"></i> Pin máy
                                        khoan</a></li>
                                    <li><a href="<%= request.getContextPath() %>/z_charger" methods="post"></i> Sạc pin
                                        máy khoan</a></li>
                                    <li><a href="<%= request.getContextPath() %>/z_countersink" methods="post"></i>Mũi
                                        khoan</a></li>
                                </ul>
                            </li>


                        </ul>
                        <!-- /.nav -->
                    </nav>
                    <!-- /.megamenu-horizontal -->
                </div>
                <!-- /.side-menu -->

                <div class="sidebar-widget product-tag wow fadeInUp">
                    <h3 class="section-title">Nhà sản xuất</h3>
                    <div class="sidebar-widget-body outer-top-xs">
                        <div class="tag-list">
                            <!-- JSP Code -->
                            <form id="producerForm" action="producers" method="get">
                                <input type="hidden" id="producerInput" name="producer" value=""/>
                                <input type="hidden" id="prInput" name="pr" value=""/>
                            </form>
                            <a class="item" href="#" onclick="submitForm(1, 'Bosh')">Bosh</a>
                            <a class="item" href="#" onclick="submitForm(2, 'Makute')">Makute</a>
                            <a class="item" href="#" onclick="submitForm(3, 'DeWalt')">DeWalt</a>
                            <a class="item" href="#" onclick="submitForm(4, 'Milwaukee')">Milwaukee</a>
                            <a class="item" href="#" onclick="submitForm(5, 'Tolsen')">Tolsen</a>
                            <a class="item" href="#" onclick="submitForm(6, 'Classic')">Classic</a>
                            <a class="item" href="#" onclick="submitForm(7, 'Sasuke')">Sasuke</a>
                            <a class="item" href="#" onclick="submitForm(8, 'Huynhdai')">Huynhdai</a>
                            <a class="item" href="#" onclick="submitForm(9, 'Oshima')">Oshima</a>
                            <a class="item" href="#" onclick="submitForm(10, 'Gomes')">Gomes</a>

                            <script>
                                // Function to set producer value and pr value, and submit the form
                                function submitForm(prValue, producerName) {
                                    // Set the pr value in the hidden input field
                                    document.getElementById('prInput').value = prValue;

                                    // Set the producer value in the hidden input field
                                    document.getElementById('producerInput').value = producerName;
                                    console.log(producerName);

                                    // Submit the form
                                    document.getElementById('producerForm').submit();
                                }
                            </script>

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

            <style>
                .products {
                    display: flex;
                    flex-wrap: wrap;
                    justify-content: space-between;
                }

                .product {
                    width: calc(90% - 6px); /* Tính toán chiều rộng với khoảng cách 10px */
                    margin: 5px; /* Khoảng cách 5px giữa các sản phẩm */
                }
            </style>


            <!-- ============================================== CONTENT ============================================== -->
            <div class='col-md-9'>
                <!-- ========================================== SECTION – HERO ========================================= -->
                <section class="section featured-product wow fadeInUp">
                    <h3 class="section-title">Sản phẩm</h3>
                    <div class="owl-carousel home-owl-carousel custom-carousel owl-theme outer-top-xs mb-10">
                        <%
                            int productsPerRow = 4;
                            if (searchResults != null && !searchResults.isEmpty()) {
                                for (int i = 0; i < searchResults.size(); i++) {
                                    Products p = searchResults.get(i);
                                    NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
                                    String formattedPrice = currencyFormat.format(p.getUnitPrice() * 1000);
                        %>
                        <div class="product">
                            <div class="product-image">
                                <div class="image"><a href="load-detail?productId=<%= p.getProductId()%>"><img height="189px"
                                                                                                         width="189px"
                                                                                                         src="<%=p.getImage()%>"
                                                                                                         alt="Ảnh sản phẩm"></a>
                                </div>
                                <!-- /.image -->
                            </div>
                            <!-- /.product-image -->

                            <div class="product-info text-left">
                                <h3 class="name"><a
                                        href="load-detail?productId=<%= p.getProductId()%>"><%=p.getProductName()%>
                                </a></h3>
                                <div class="rating rateit-small"></div>
                                <div class="description"></div>
                                <div class="product-price">
                                    <span class="price"> <%=formattedPrice%></span>
                                </div>
                                <!-- /.product-price -->
                            </div>
                            <!-- /.product-info -->
                        </div>

                        <%
                            // Tăng biến đếm, nếu đạt đến số sản phẩm trên mỗi hàng, bắt đầu hàng mới
                            if ((i + 1) % productsPerRow == 0) {
                        %>
                    </div>
                    <div class="owl-carousel home-owl-carousel custom-carousel owl-theme outer-top-xs mb-10">
                        <%
                                    }
                                }
                            }
                        %>
                    </div>
                </section>

            </div>


        </div>

    </div>


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
</div>

<!-- ============================================================= FOOTER : MENU============================================================= -->

</body>
</html>