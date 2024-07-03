<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="vn.hcmuaf.fit.drillsell.model.Products" %>
<%@ page import="vn.hcmuaf.fit.drillsell.dao.ProductDAO" %>
<%@ page import="vn.hcmuaf.fit.drillsell.model.User" %>
<%@ page import="vn.hcmuaf.fit.drillsell.model.ProductCategorys" %>
<%@ page import="vn.hcmuaf.fit.drillsell.model.Review" %>
<%@ page import="vn.hcmuaf.fit.drillsell.dao.UsersDAO" %>
<%@ page import="java.sql.Timestamp" %>
<%
    Products product = (Products) request.getAttribute("prods");
    List<Review> reviewList = (List<Review>) request.getAttribute("reviews");
%>

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="icon" href="assets/images/logo.png" type="image/png">
    <title>Bán máy khoan</title>
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">

    <!-- Customizable CSS -->
    <link rel="stylesheet" href="assets/css/main.css">
    <link rel="stylesheet" href="assets/css/blue.css">
    <link rel="stylesheet" href="assets/css/owl.carousel.css">
    <link rel="stylesheet" href="assets/css/owl.transitions.css">
    <link rel="stylesheet" href="assets/css/animate.min.css">
    <link rel="stylesheet" href="assets/css/rateit.css">
    <link rel="stylesheet" href="assets/css/bootstrap-select.min.css">
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

    <!-- Icons/Glyphs -->
    <link rel="stylesheet" href="assets/css/font-awesome.css">

    <!-- Fonts -->
    <link href='http://fonts.googleapis.com/css?family=Roboto:300,400,500,700' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,300,400italic,600,600italic,700,700italic,800'
          rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Montserrat:400,700' rel='stylesheet' type='text/css'>
    <link rel="icon" href="assets/images/logo.png" type="image/png">
    <title>Chi tiết sản phẩm</title>

    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <!-- Customizable CSS -->
    <link rel="stylesheet" href="assets/css/styleAccount.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
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
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="assets/css/font-awesome.css">

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
                            <%= u.getFullname() %>
                        </a></li>
                        <li><a href="cart.jsp"><i class="icon fa fa-shopping-cart"></i>Giỏ hàng</a></li>
                        <li><a href="order.jsp"><i class="icon fa fa-check"></i>Thanh toán</a></li>
                        <li><a href="<%=request.getContextPath()%>/logout"><i
                                class="icon fa fa-arrow-circle-o-right"></i>Đăng xuất</a></li>
                        <% } else { %>
                        <li>
                            <a href="login.jsp"><i class="icon fa fa-lock"></i>Đăng nhập</a>
                        </li>
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
                                <label for="searchInput"></label>
                                <input id="searchInput"
                                       class="search-field dropdown-toggle"
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
                        <div class="dropdown-toggle lnk-cart" data-toggle="dropdown">
                            <div class="items-cart-inner">
                                <div class="basket" id="basketIcon"
                                     onclick="callServletAndRedirect('logged','cart.jsp')">
                                    <i class="glyphicon glyphicon-shopping-cart"></i>
                                </div>


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
                                <li class="active yamm-fw"><a href="<%=request.getContextPath()%>/admin/dashboard.jsp">Quản
                                    lý</a></li>
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
                <li><a href="#">Trang chủ</a></li>
                <li><a href="#">Chi tiết sản phẩm</a></li>
                <!--                <li class='active'>Floral Print Buttoned</li>-->
            </ul>
        </div><!-- /.breadcrumb-inner -->
    </div><!-- /.container -->
</div><!-- /.breadcrumb -->
<div class="body-content outer-top-xs">
    <div class='container'>
        <div class='row single-product'>
            <div class='col-md-3 sidebar'>
                <div class="sidebar-module-container">


                                    <div class="home-banner outer-top-n">
                        <img src="assets/images/banners/LHS-banner.jpg" alt="Image">
                    </div>

                </div>
            </div><!-- /.sidebar -->


            <div class='col-md-9'>
                <div class="detail-block">
                    <div class="row  wow fadeInUp">


                        <div class="col-xs-12 col-sm-6 col-md-5 gallery-holder">
                            <div class="product-item-holder size-big single-product-gallery small-gallery">

                                <div id="owl-single-product">
                                    <div class="single-product-gallery-item" id="slide1">
                                        <a data-lightbox="image-1" data-title="Gallery"
                                           href="#">
                                            <img class="img-responsive" alt="Mô tả sản phẩm"
                                                 src="<%= product.getImage()%>"
                                            >
                                        </a>
                                    </div>

                                </div>

                            </div>
                        </div><!-- /.gallery-holder -->
                        <div class='col-sm-6 col-md-7 product-info-block'>
                            <div class="product-info">
                                <h1 class="name"><%= product.getProductName()%>
                                </h1>

                                <div class="rating-reviews m-t-20">
                                    <div class="row">
                                        <div class="col-sm-4">
                                            <%
                                                double totalStars = 0;
                                                for (Review review : reviewList) {
                                                    totalStars += review.getRating();
                                                }

                                                double averageStar = reviewList.isEmpty() ? 0.0 : Math.floor(totalStars / reviewList.size());
                                                for (int i = 0; i < averageStar; i++) {
                                            %>
                                            <i class="fa fa-star "
                                               style="color:  #fdd922!important;"></i>
                                            <% } %>
                                        </div>
                                        <div class="col-sm-8">
                                            <div class="reviews">
                                                <div class="lnk"><%=reviewList.size()%>
                                                    Đánh giá
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="stock-container info-container m-t-10">
                                    <div class="row">
                                        <div class="col-sm-2">
                                            <div class="stock-box">
                                                <span class="label">Tình trạng :</span>
                                            </div>
                                        </div>
                                        <div class="col-sm-9">
                                            <div class="stock-box">
                                                <span class="value"> Còn:</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="description-container m-t-20">

                                </div>

                                <div class="price-container info-container m-t-20">
                                    <div class="row">

                                        <div class="col-sm-6">
                                            <div class="price-box">
                                                <span class="price"><%= ProductDAO.getInstance().getFormattedUnitPrice(product) %></span>
                                            </div>
                                        </div>

                                    </div>
                                </div>


                                <div class="quantity-container info-container">
                                    <div class="row">


                                        <div class="col-sm-7">
                                            <a href="" class="btn btn-danger" style="margin-bottom: 10px"><i
                                                    class="fa fa-check inner-right-vs"></i> Mua ngay</a>

                                            <div onclick="callServlet('cart','<%=product.getProductId()%>')"
                                                 class="btn btn-primary" style="margin-bottom: 10px ">
                                                <i class=" fa fa-shopping-cart inner-right-vs "></i> Thêm vào giỏ hàng
                                            </div>


                                        </div>


                                    </div><!-- /.row -->
                                </div><!-- /.quantity-container -->


                            </div><!-- /.product-info -->
                        </div><!-- /.col-sm-7 -->

                    </div><!-- /.row -->
                </div>


                <div class="product-tabs inner-bottom-xs  wow fadeInUp">
                    <div class="row">
                        <div class="col-sm-3">
                            <ul id="product-tabs" style="white-space: nowrap" class="nav nav-tabs nav-tab-cell">
                                <li class="active"><a data-toggle="tab" href="#description">Mô tả sản phẩm</a></li>
                                <li><a data-toggle="tab" href="#specifications">Thông số kỹ thuật</a></li>

                                <li><a data-toggle="tab" href="#reviews">Đánh giá</a></li>
                            </ul><!-- /.nav-tabs #product-tabs -->
                        </div>
                        <div class="col-sm-9">

                            <div class="tab-content">

                                <div id="description" class="tab-pane in active">
                                    <div class="product-tab">
                                        <p class="text">
                                            <%= product.getDescrible()%>
                                        </p>
                                    </div>
                                </div><!-- /.tab-pane -->
                                <div id="specifications" class="tab-pane in "><%= product.getSpecifions() %>
                                </div><!-- /.tab-pane -->
                                <!-- /.tab-pane -->

                                <div id="reviews" class="tab-pane">
                                    <div class="blog-sub-comments">
                                        <%
                                            if (logged) {

                                        %>
                                        <form class="container" action="add-review"
                                              id="reviewForm" role="form">

                                            <div class="rating form-group">
                                                <input type="radio" id="star5" name="rating" value="5"/>
                                                <label class="s" for="star5"></label>
                                                <input type="radio" id="star4" name="rating" value="4"/>
                                                <label class="s" for="star4"></label>
                                                <input type="radio" id="star3" name="rating" value="3"/>
                                                <label class="s" for="star3"></label>
                                                <input type="radio" id="star2" name="rating" value="2"/>
                                                <label class="s" for="star2"></label>
                                                <input type="radio" id="star1" name="rating" value="1"/>
                                                <label class="s" for="star1"></label>
                                            </div>

                                            <div class="form-group">
                                                <label for="inputReviews">Nhập đánh giá của bạn</label>
                                                <input type="text" name="mess" class="" id="inputReviews"
                                                       maxlength="500">
                                            </div>
                                            <%if (logged) {%>
                                            <input type="hidden" name="userId" value="<%=u.getId()%>">
                                            <%}%>
                                            <input type="hidden" name="prodId" value="<%=product.getProductId()%>">
                                            <input type="submit" class="btn btn-primary " value="Đánh giá"
                                            >
                                        </form>
                                        <%} else {%>

                                        <div class="text-center">
                                            <h6>Hãy đăng nhập để đánh giá sản phẩm</h6>
                                            <a href="login.jsp" class="btn btn-primary">Đăng nhập</a>
                                        </div>

                                        <%}%>
                                        <div>
                                            <div class="container">
                                                <div class="row">
                                                    <div class="col-md-8">
                                                        <div class="comments-list">
                                                            <%

                                                                if (!reviewList.isEmpty()) {
                                                                    for (Review r : reviewList) {
                                                            %>
                                                            <div class="media ">

                                                                <div class="media-body m-t-20 border-top-reviews">
                                                                    <h6 class="media-heading user_name m-t-20"><%= UsersDAO.getInstance().getUserById(r.getUserId()).getFullname() %>
                                                                    </h6>
                                                                    <div class="rating">
                                                                        <%
                                                                            for (int i = 0; i < r.getRating(); i++) {
                                                                        %>
                                                                        <i class="fa fa-star "
                                                                           style="color:  #fdd922!important;"></i>
                                                                        <% } %>

                                                                    </div>
                                                                    <div class="text"></div>
                                                                    <%= r.getMess() %>
                                                                    <p>

                                                                    <h6 class="dateComment"><%=r.caculateTime()%>
                                                                    </h6>
                                                                </div>
                                                            </div>
                                                            <%
                                                                }
                                                            } else {
                                                            %>
                                                            <p class="m-t-20 text-warning "><h5>Chưa có đánh giá
                                                            nào.</h5></p>
                                                            <%
                                                                }
                                                            %>
                                                        </div>


                                                    </div>
                                                </div>
                                            </div>
                                        </div>


                                    </div>
                                </div><!-- /.tab-pane -->

                            </div><!-- /.tab-content -->
                        </div><!-- /.col -->
                    </div><!-- /.row -->
                </div><!-- /.product-tabs -->
            </div><!-- /.col -->

        </div><!-- /.row -->

    </div><!-- /.container -->
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
<input type="hidden" id="notify" name="notify" value="<%=session.getAttribute("notify")%>">
<!-- ============================================================= FOOTER : MENU============================================================= -->
<!-- ============================================================= Backtop ============================================================= -->
<button onclick="topFunction()" id="back-to-top" title="Go to top"><i class=" icon fa    fa-arrow-up"></i></button>
<link rel="stylesheet" href="assets/css/my-css/backtop.css">
<link rel="stylesheet" href="assets/css/my-css/detailPage.css">
<script src="assets/js/my-js/notify.js"></script>
<script src="assets/js/my-js/backtop.js"></script>
<%
    String loginRequired = request.getParameter("loginRequired");
    if ("true".equals(loginRequired)) {
%>


<script>
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
        } else {
            window.history.back();
        }
    });

</script>


<%
    }
%>
</body>
</html>