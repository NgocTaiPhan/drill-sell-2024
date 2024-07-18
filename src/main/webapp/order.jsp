<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.*" %>
<%@ page import="vn.hcmuaf.fit.drillsell.dao.ProductDAO" %>
<%@ page import="vn.hcmuaf.fit.drillsell.model.*" %>
<%@ page import="vn.hcmuaf.fit.drillsell.dao.CheckOutDAO" %>
<%@ page import="vn.hcmuaf.fit.drillsell.dao.CartDAO" %>
<%@ page import="vn.hcmuaf.fit.drillsell.utils.ProductCategoryUtils" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<OrderItem> checkOuts = (List<OrderItem>) session.getAttribute("checkOuts");
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
    <title>Thanh toán</title>
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
    <link rel="stylesheet" href="assets/css/styleCheckOut.css">
    <link rel="stylesheet" href="assets/css/styleCard.css">

    <!-- Favicon -->
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
    <%   NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN")); %>
    <link href='http://fonts.googleapis.com/css?family=Roboto:300,400,500,700' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,300,400italic,600,600italic,700,700italic,800'
          rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Montserrat:400,700' rel='stylesheet' type='text/css'>


    <%--    Link to css button back-to-home--%>
    <link href="assets/css/my-css/back-to-home.css" rel="stylesheet">
    <script src="https://esgoo.net/scripts/jquery.js"></script>
    <style type="text/css">
        .css_select_div { text-align: center; }
        .css_select { display: inline-table; width: 20%; padding: 5px; margin: 5px 2%; border: solid 1px #686868; border-radius: 5px; }
    </style>
    <script>
        $(document).ready(function () {
            // Biến lưu trữ thông tin về tỉnh, quận/huyện và phường/xã
            var provinces = {};
            var districts = {};
            var wards = {};

            // Lấy danh sách tỉnh thành từ API và điền vào dropdown tỉnh
            $.getJSON('https://esgoo.net/api-tinhthanh/1/0.htm', function (data_tinh) {
                if (data_tinh.error == 0) {
                    $.each(data_tinh.data, function (key_tinh, val_tinh) {
                        provinces[val_tinh.full_name] = val_tinh.id; // Lưu tên của tỉnh
                        $("#tinh").append('<option value="' + val_tinh.full_name + '">' + val_tinh.full_name + '</option>');
                    });
                }
            });

            // Xử lý sự kiện khi người dùng chọn tỉnh
            $("#tinh").change(function () {
                var ten_tinh = $(this).val(); // Lấy tên của tỉnh từ dropdown

                // Xóa các lựa chọn cũ của quận/huyện và phường/xã
                $("#quan").html('<option value="0">Chọn Quận Huyện</option>');
                $("#phuong").html('<option value="0">Chọn Phường Xã</option>');

                // Lấy danh sách quận/huyện từ API và điền vào dropdown quận/huyện
                $.getJSON('https://esgoo.net/api-tinhthanh/2/' + provinces[ten_tinh] + '.htm', function (data_quan) {
                    if (data_quan.error == 0) {
                        $.each(data_quan.data, function (key_quan, val_quan) {
                            districts[val_quan.full_name] = val_quan.id; // Lưu tên của quận/huyện
                            $("#quan").append('<option value="' + val_quan.full_name + '">' + val_quan.full_name + '</option>');
                        });
                    }
                });
            });

            // Xử lý sự kiện khi người dùng chọn quận/huyện
            $("#quan").change(function () {
                var ten_quan = $(this).val(); // Lấy tên của quận/huyện từ dropdown

                // Xóa các lựa chọn cũ của phường/xã
                $("#phuong").html('<option value="0">Chọn Phường Xã</option>');

                // Lấy danh sách phường/xã từ API và điền vào dropdown phường/xã
                $.getJSON('https://esgoo.net/api-tinhthanh/3/' + districts[ten_quan] + '.htm', function (data_phuong) {
                    if (data_phuong.error == 0) {
                        $.each(data_phuong.data, function (key_phuong, val_phuong) {
                            wards[val_phuong.full_name] = val_phuong.id; // Lưu tên của phường/xã
                            $("#phuong").append('<option value="' + val_phuong.full_name + '">' + val_phuong.full_name + '</option>');
                        });
                    }
                });
            });
        });
    </script>
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
                            <%=(u != null) ? u.getFullname() : ""%>
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
                                <input style="height: 44.5px;" id="searchInput" class="search-field dropdown-toggle" data-toggle="dropdown"
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
                                <li class="active  yamm-fw"><a href="<%=request.getContextPath()%>/product.jsp"
                                >Sản phẩm</a></li>
                                <li class="dropdown active  ">
                                    <a class="dropdown-menu-left" data-hover="dropdown">Danh mục sản phẩm</a>
                                    <ul class="dropdown-menu ">
                                        <%for (ProductCategorys pc :  ProductCategoryUtils.getAllCategory()) {%>
                                        <li>
                                            <a href="<%=request.getContextPath()%>/load-by-category?category-id=
                <%=pc.getId()%>"
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

<div class="breadcrumb-area">
    <div class="container">
        <div class="breadcrumb-content">
            <ul>
                <li><a href="home.jsp">Trang chủ</a></li>
                <li class="active">Thanh toán</li>
            </ul>
        </div>
    </div>
</div>
<div class="address">
    <form action="order" method="post">
        <input type="hidden" value="NCB" name="bankCode">
        <div class="receive">
            <div id="err" style="color: red; <% if (request.getAttribute("err") == null) { %>display: none;<% } %>">
                <%= request.getAttribute("err") %>
            </div>
            <p>Địa chỉ nhận hàng</p>
            <div class="information">

                <input style="background: none" value="<%= request.getParameter("nameCustomer") != null ? request.getParameter("nameCustomer") : "" %>" type="text" id="informations" name="nameCustomer" placeholder="Tên">
                <input style="background: none" value="" type="text" id="phone" name="phone" placeholder="Số điện thoại">
                <div class="css_select_div" style="display: flex">
                    <select   id="province" class="form-control" name="tinh">
                        <option value="">Chọn Tỉnh / Thành Phố</option>
                    </select>
                    <select style="margin-left: 20px" class="form-control" id="district" name="quan">
                        <option value="">Chọn Quận/Huyện</option>
                    </select >
                    <select style="margin-left: 20px" class="form-control" id="ward" name="phuong">
                        <option value="">Chọn Phường/Xã</option>
                    </select>
                </div>
                <input style="margin-left: 10px" value="" type="text" id="soNha"  name="soNha" placeholder="Nhập rõ địa chỉ ...">

            </div>
        </div>
        <div class="product">
            <table class="table">
                <thead>
                <tr>
                    <th class="cart-product-name">Sản phẩm</th>
                    <th class="li-product-price">Đơn Giá</th>
                    <th class="li-product-quantity">Số lượng</th>
                    <th class="li-product-subtotal">Thành tiền</th>
                </tr>
                </thead>
                <tbody>
                <%
                    double totalAmount = 0;
                    if (checkOuts != null) {
                        for (OrderItem s : checkOuts) {
                            double unitPrice = s.getUnitPrice() * 1000;
                            double totalPrice = s.getTotalPrice() * 1000;
                            totalAmount += totalPrice;
                            String formattedPrice = currencyFormat.format(unitPrice);
                            String formattedAmount = currencyFormat.format(totalPrice);
                %>
                <tr>
                    <input style="display: none" class="productId" name="productId" value="<%= s.getProductId()%>">
                    <input style="display: none" class="cartId" name="cartId" value="<%= s.getCartId()%>">
                    <td style="display: none"><input class="orderId" name="orderId" value="<%=s.getOrderId()%>"></td>
                    <td class="li-product-thumbnail">
                        <input type="hidden" name="productName" value="<%= s.getProductName() %>">
                        <a href="#"><%= s.getProductName() %></a>
                    </td>
                    <td class="li-product-price">
                        <input type="hidden" name="unitPrice" value="<%= unitPrice %>">
                        <span class="amount"><%= formattedPrice %></span>
                    </td>
                    <td class="quantity">
                        <div class="cart-plus-minus">
                            <input type="hidden" name="quantity" value="<%= s.getQuantity() %>">
                            <input name="quantityInput" class="cart-plus-minus-box" value="<%= s.getQuantity() %>">
                        </div>
                    </td>
                    <td class="product-subtotal">
                        <input type="hidden" name="totalPrice" value="<%= totalPrice %>">
                        <span class="amount"><%= formattedAmount %></span>
                    </td>
                </tr>
                <%
                        }
                    }
                    String formattedTotalAmount = currencyFormat.format(totalAmount);
                %>
                </tbody>
            </table>
            <div class="statistical">
                <div class="pay">
                    <table>
                        <tr>
                            <td colspan="5"><label>Tổng tiền đơn hàng: </label></td>
                            <td><input id="totalAmount" name="totalAmount" style="padding-left: 5px" value="<%= formattedTotalAmount %>" readonly></td>
                        </tr>
                    </table>
                    <button type="submit" class="order">Đặt hàng</button>
                </div>
            </div>
        </div>
    </form>
</div>


<style>
    input{
        border: none;
    }
</style>
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
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script src="assets/js/my-js/address.js"></script>
<script>
    function f() {
        Swal.fire({
            title: 'Đơn hàng đã đặt thành công',
            text: 'Cảm ơn quý khách',
            icon: 'success',
            confirmButtonText: 'OK',
        }).then((result) => {
            if (result.isConfirmed) {
                window.location.href = "history.jsp";
            }
        });
    }


</script>
</body>
</html>