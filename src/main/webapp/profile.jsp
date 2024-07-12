<%@ page import="vn.hcmuaf.fit.drillsell.model.User" %>
<%@ page import="vn.hcmuaf.fit.drillsell.model.ProductCategorys" %>
<%@ page import="vn.hcmuaf.fit.drillsell.dao.ProductDAO" %>
<%@ page import="vn.hcmuaf.fit.drillsell.utils.ProductCategoryUtils" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <link rel="icon" type="image/png" sizes="96x96" href="assets/images/logo.png">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>

    <title>Tài khoản</title>

    <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport'/>
    <meta name="viewport" content="width=device-width"/>


    <!-- Bootstrap core CSS     -->
    <link href="assets/css/my-css/admin/bootstrap.min.css" rel="stylesheet"/>

    <!-- Animation library for notifications   -->
    <link href="assets/css/my-css/admin/animate.min.css" rel="stylesheet"/>

    <!--  Paper Dashboard core CSS    -->
    <link href="assets/css/my-css/admin/paper-dashboard.css" rel="stylesheet"/>


    <!--  Fonts and icons     -->
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">
    <link href='https://fonts.googleapis.com/css?family=Muli:400,300' rel='stylesheet' type='text/css'>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.10.3/dist/sweetalert2.all.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.10.3/dist/sweetalert2.min.css" rel="stylesheet"/>

    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js"></script>

    <script src="assets/js/my-js/notify.js"></script>
    <style type="text/css">
        .css_select_div { text-align: center; }
        .css_select { display: inline-table; width: 25%; padding: 5px; margin: 5px 2%; border: solid 1px #686868; border-radius: 5px; }
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

<div class="wrapper">
    <div class="sidebar" data-background-color="white" data-active-color="primary">

        <!--
            Tip 1: you can change the color of the sidebar's background using: data-background-color="white | black"
            Tip 2: you can change the color of the active button using the data-active-color="primary | info | success | warning | danger"
        -->

        <div class="sidebar-wrapper">
            <div class="logo">
                <a href="home.jsp" class="simple-text">
                    Máy khoan
                </a>
            </div>

            <ul class="nav">
                <li class="active">
                    <a href="profile.jsp">
                        <i class="ti-panel"></i>
                        <p>Tài khoản</p>
                    </a>
                </li>

<%--                <li>--%>
<%--                    <a href="#">--%>
<%--                        <i class="ti-user"></i>--%>
<%--                        <p>Lịch sử mua hàng</p>--%>
<%--                    </a>--%>
<%--                </li>--%>
                <li>
                    <a href="<%= request.getContextPath()%>/viewOrderCustomer">
                        <i class="ti-check-box"></i>
                        <p>Đơn hàng của tôi</p>
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
                                            <li class="active  yamm-fw"><a href="home.jsp">Trang chủ</a></li>
                                            <li class="active  yamm-fw"><a
                                                    href="<%= request.getContextPath() %>/product.jsp"
                                            >Sản phẩm</a></li>
                                            <li class="dropdown active  ">
                                                <a class="dropdown-menu-left" data-hover="dropdown">Danh mục sản
                                                    phẩm</a>
                                                <ul class="dropdown-menu ">
                                                    <%for (ProductCategorys pc :  ProductCategoryUtils.getAllCategory()) {%>
                                                    <li>
                                                        <a href="<%= request.getContextPath() %>/load-by-category?category-id=<%=pc.getId()%>"
                                                           methods="post">
                                                            <%=pc.getNameCategory()%>
                                                        </a>

                                                    </li>
                                                    <%}%>

                                                </ul>
                                            </li>
                                            <li class="active  yamm-fw"><a href="contact.jsp">Liên hệ</a></li>

                                            <%

                                                User u = (User) session.getAttribute("auth");
                                                boolean logged = u != null;
                                                //Kiểm tra quyền người dùng, nếu là admin thì hiển thị thẻ Quản lý
                                                if (logged) {
                                                    if (u.isRoleUser()) {
                                            %>
                                            <li class="active yamm-fw"><a href="admin/dashboard.jsp">Quản lý</a>
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

            </div>
        </nav>


        <div class="content">
            <div class="container-fluid">
                <div class="row">
<%--                    <div class="col-lg-4 col-md-5">--%>
<%--                        <div class="card card-user">--%>
<%--                            <div class="image">--%>
<%--                                <img src="assets/img/background.jpg" alt="..."/>--%>
<%--                            </div>--%>
<%--                            <div class="content">--%>
<%--                                <div class="author">--%>
<%--                                    <img class="avatar border-white" src="../assets/img/faces/face-2.jpg" alt="..."/>--%>
<%--                                    <h4 class="title"><%=u.getFullname()%><br/>--%>
<%--                                        <a href="#"><small><%=u.getEmail()%>--%>
<%--                                        </small></a>--%>
<%--                                    </h4>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                            <hr>--%>

<%--                        </div>--%>

<%--                    </div>--%>
    <div class="col-lg-8 col-md-7">
        <div class="card">
            <div class="header">
                <h4 class="title">Thông tin tài khoản</h4>
            </div>
            <div class="content">

                <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.10/dist/sweetalert2.all.min.js"
                        integrity="sha256-73rO2g7JSErG8isZXCse39Kf5yGuePgjyvot/8cRCNQ="
                        crossorigin="anonymous"></script>
                <link rel="stylesheet"
                      href="https://cdn.jsdelivr.net/npm/sweetalert2@11.10/dist/sweetalert2.min.css"
                      integrity="sha256-h2Gkn+H33lnKlQTNntQyLXMWq7/9XI2rlPCsLsVcUBs=" crossorigin="anonymous">
                <script src="assets/js/my-js/notify.js"></script>
                <script src="assets/js/my-js/ajax-process.js"></script>
                <form onsubmit="submitFormAndRedirect(event,this,'showUserInfor')">
                    <div class="row">
                        <div class="col-md-5">
                            <div class="form-group">
                                <label>Họ và tên</label>
                                <input type="text" class="form-control border-input" id="fullname" placeholder="">
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label>Tên đăng nhập</label>
                                <input type="text" class="form-control border-input" id="username">
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="emailUser">Địa chỉ email</label>
                                <input id="emailUser" type="email" class="form-control border-input">
                            </div>
                        </div>
                    </div>




                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Giới tính</label>
                                <select class="form-control border-input" id="sex">
                                    <option value="Nam">Nam</option>
                                    <option value="Nữ">Nữ</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Ngày tháng năm sinh</label>
                                <input type="date" class="form-control border-input" id="yearOfBirth">
                            </div>
                        </div>
                    </div>


<%--                    <div class="row">--%>
<%--                        <div class="col-md-12">--%>
<%--                            <div class="form-group">--%>
<%--                                <label>Địa chỉ</label>--%>
<%--&lt;%&ndash;                                <input type="text" class="form-control border-input" id="address" placeholder="Home Address">&ndash;%&gt;--%>
<%--                                <div id="address">--%>
<%--                                    <select class="css_select" id="tinh" name="tinh">--%>
<%--                                        <option value="0">Chọn Tỉnh/Thành phố</option>--%>
<%--                                        <!-- Các tùy chọn tỉnh/thành phố sẽ được thêm vào đây từ dữ liệu nhận được -->--%>
<%--                                    </select>--%>
<%--                                    <select class="css_select" id="quan" name="quan">--%>
<%--                                        <option value="0">Chọn Quận/Huyện</option>--%>
<%--                                        <!-- Các tùy chọn quận/huyện sẽ được thêm vào đây từ dữ liệu nhận được -->--%>
<%--                                    </select>--%>
<%--                                    <select class="css_select" id="phuong" name="phuong">--%>
<%--                                        <option value="0">Chọn Phường/Xã</option>--%>
<%--                                        <!-- Các tùy chọn phường/xã sẽ được thêm vào đây từ dữ liệu nhận được -->--%>
<%--                                    </select>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </div>--%>

                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label>Địa chỉ</label>
                                <div id="address">
                                    <select class="css_select" id="tinh" name="tinh">
                                        <option value="">Chọn Tỉnh/Thành phố</option>
                                    </select>
                                    <select class="css_select" id="quan" name="quan">
                                        <option value="">Chọn Quận/Huyện</option>
                                    </select>
                                    <select class="css_select" id="phuong" name="phuong">
                                        <option value="">Chọn Phường/Xã</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>


                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Số điện thoại</label>
                                <input type="text" class="form-control border-input" id="phone">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Loại tài khoản</label>
                                <input type="text" class="form-control border-input" id="accountType" disabled>
                            </div>
                        </div>
                    </div>

                    <div class="text-center">
                        <a class="btn btn-warning btn-fill btn-wd"
                           onclick="callServletAndRedirect('reset-password')">Đổi
                            mật khẩu</a>
                        <a class="btn btn-info btn-fill btn-wd" id="changeUserInfo">Thay đổi thông tin</a>
                    </div>
                    <div class="clearfix"></div>
                </form>

            </div>
        </div>
    </div>

    <script>
    $(document).ready(function() {
        $.ajax({
            url: "showUserInfor",
            method: 'GET',
            success: function(data) {
                console.log("Received data: ", data);
                // Cập nhật các input thông tin cá nhân
                $('#fullname').val(data.fullname);
                $('#username').val(data.username);
                $('#emailUser').val(data.email);
                $('#sex').val(data.sex); // Cập nhật select theo giới tính
                $('#yearOfBirth').val(data.yearOfBirth);
                $('#phone').val(data.phone);
                $('#accountType').val(data.accountType);

                // Cập nhật các select cho địa chỉ
                updateAddressDropdowns(data.province, data.district, data.ward);
            },
            error: function(xhr, status, error) {
                try {
                    var errorResponse = JSON.parse(xhr.responseText);
                    console.log('Error fetching user info:', errorResponse);
                    alert('Đã xảy ra lỗi: ' + errorResponse.error);
                } catch (e) {
                    console.log('Unexpected error format. Response: ', xhr.responseText);
                    alert('Đã xảy ra lỗi không xác định. Vui lòng thử lại sau.');
                }
            }
        });

        function updateAddressDropdowns(province, district, ward) {
            $('#tinh').val(province);
            // Gọi hàm để cập nhật các option cho tỉnh/thành phố
            updateProvinces(province);
            // Cập nhật dropdown quận/huyện
            $('#quan').val(district); // Đặt giá trị của dropdown quận/huyện
            // Gọi hàm để cập nhật các option cho quận/huyện
            updateDistricts(province, district);

            // Cập nhật dropdown phường/xã
            $('#phuong').val(ward); // Đặt giá trị của dropdown phường/xã
            // Gọi hàm để cập nhật các option cho phường/xã
            updateWards(province, district, ward);
        }

        function updateProvinces(selectedProvince) {
            // Lấy danh sách tỉnh/thành phố từ API
            var provinces = [selectedProvince]; // Chỉ có một tỉnh/thành phố được chọn
            var options = '';
            provinces.forEach(function(province) {
                options += '<option value="' + province + '" selected>' + province + '</option>';
            });
            $('#tinh').html(options);
        }

        function updateDistricts(selectedProvince, selectedDistrict) {
            // Lấy danh sách quận/huyện từ API dựa trên tỉnh/thành phố đã chọn
            var districts = [selectedDistrict]; // Chỉ có một quận/huyện được chọn
            var options = '';
            districts.forEach(function(district) {
                options += '<option value="' + district + '" selected>' + district + '</option>';
            });
            $('#quan').html(options);
        }

        function updateWards(selectedProvince, selectedDistrict, selectedWard) {
            // Lấy danh sách phường/xã từ API hoặc dữ liệu đã có sẵn dựa trên tỉnh/thành phố và quận/huyện đã chọn
            var wards = [selectedWard]; // Chỉ có một phường/xã được chọn
            var options = '';
            wards.forEach(function(ward) {
                options += '<option value="' + ward + '" selected>' + ward + '</option>';
            });
            $('#phuong').html(options);
        }

        $('#changeUserInfo').click(function(e) {
            e.preventDefault();

            var fullname = $('#fullname').val();
            var username = $('#username').val();
            var email = $('#emailUser').val();
            var sex = $('#sex').val().toLowerCase() === 'nam';
            var yearOfBirth = $('#yearOfBirth').val();
            var address = $('#tinh').val() + ', ' + $('#quan').val() + ', ' + $('#phuong').val();
            var phone = $('#phone').val();
            var userData = {
                id: parseInt(sessionStorage.getItem('userid')),
                fullname: fullname,
                username: username,
                email: email,
                sex: sex,
                yearOfBirth: yearOfBirth,
                phone: phone,
                address: address
            };

            console.log(userData);

            $.ajax({
                url: 'updateUserInfo',
                method: 'POST',
                contentType: 'application/json; charset=UTF-8',
                data: JSON.stringify(userData),
                success: function(response) {
                    normalNotify(response.type,response.message);
                },
                error: function(xhr) {
                    try {
                        var errorResponse = JSON.parse(xhr.responseText);
                        console.log('Error updating user info:', errorResponse);
                        alert('Đã xảy ra lỗi: ' + errorResponse.error);
                    } catch (e) {
                        console.log('Unexpected error format. Response: ', xhr.responseText);
                        alert('Đã xảy ra lỗi không xác định. Vui lòng thử lại sau.');
                    }
                }
            });
        });
    });
    </script>



                </div>
            </div>
        </div>
    </div>
</div>


</body>

<!--   Core JS Files   -->
<script src="assets/js/bootstrap.min.js" type="text/javascript"></script>


<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js"></script>

<!-- Paper Dashboard Core javascript and methods for Demo purpose -->

<!-- Paper Dashboard DEMO methods, don't include it in your project! -->
<script src="assets/js/my-js/notify.js"></script>
<script src="assets/js/my-js/ajax-process.js"></script>

</html>
