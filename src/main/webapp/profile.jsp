<%@ page import="vn.hcmuaf.fit.drillsell.model.User" %>
<%@ page import="vn.hcmuaf.fit.drillsell.model.ProductCategorys" %>
<%@ page import="vn.hcmuaf.fit.drillsell.dao.ProductDAO" %>
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
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

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
                                                    <%for (ProductCategorys pc : ProductDAO.getInstance().getAllCategory()) {%>
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
                <form>
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
                                <input type="text" class="form-control border-input" id="gender">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Ngày tháng năm sinh</label>
                                <input type="text" class="form-control border-input" id="yearOfBirth">
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label>Địa chỉ</label>
                                <input type="text" class="form-control border-input" id="address" placeholder="Home Address">
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
                                <input type="text" class="form-control border-input" id="accountType">
                            </div>
                        </div>
                    </div>

                    <div class="text-center">
                        <a class="btn btn-warning btn-fill btn-wd">Đổi mật khẩu</a>
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
                url: "showUserInfor", // URL của servlet hoặc phương thức controller để lấy thông tin người dùng
                method: 'GET',
                success: function(data) {
                    console.log("Received data: ", data); // Log để kiểm tra dữ liệu nhận được
                    // Giả sử dữ liệu nhận được từ máy chủ có định dạng JSON và có các thuộc tính: fullname, username, email, sex, yearOfBirth, address, phone, roleUser
                    $('#fullname').val(data.fullname);
                    $('#username').val(data.username);
                    $('#emailUser').val(data.email);
                    $('#gender').val(data.sex ? 'Nam' : 'Nữ');
                    $('#yearOfBirth').val(data.yearOfBirth);
                    $('#address').val(data.address);
                    $('#phone').val(data.phone);
                    $('#accountType').val(data.roleUser ? 'Quản trị' : 'Người dùng');
                },
                error: function(error) {
                    console.log('Error fetching user info:', error);
                }
            });
            $('#changeUserInfo').click(function(e) {
                e.preventDefault(); // Ngăn chặn hành động mặc định của nút submit

                // Lấy dữ liệu từ các input
                var fullname = $('#fullname').val();
                var username = $('#username').val();
                var email = $('#emailUser').val();
                var gender = $('#gender').val();
                var yearOfBirth = $('#yearOfBirth').val(); // Kiểm tra xem biến này có giá trị hay không
                var address = $('#address').val();
                var phone = $('#phone').val();

                // Tạo đối tượng dữ liệu để gửi lên server
                var userData = {
                    id: parseInt(sessionStorage.getItem('userid')),
                    fullname: fullname,
                    username: username,
                    email: email,
                    gender: gender,
                    yearOfBirth: yearOfBirth, // Kiểm tra giá trị này
                    address: address,
                    phone: phone
                };

                console.log(userData); // Kiểm tra dữ liệu trước khi gửi

                // Gửi yêu cầu Ajax để cập nhật thông tin người dùng
                $.ajax({
                    url: 'updateUserInfo', // URL của servlet hoặc controller xử lý cập nhật
                    method: 'POST', // Phương thức HTTP
                    contentType: 'application/json; charset=UTF-8', // Kiểu dữ liệu gửi đi
                    data: JSON.stringify(userData), // Dữ liệu gửi đi (đã chuyển thành JSON)
                    success: function(response) {
                        // Xử lý kết quả thành công
                        console.log('Update successful:', response);
                        // Có thể cập nhật lại giao diện hoặc hiển thị thông báo thành công
                        alert('Cập nhật thông tin thành công!');
                    },
                    error: function(error) {
                        // Xử lý lỗi
                        console.log('Error updating user info:', error);
                        alert('Đã xảy ra lỗi khi cập nhật thông tin.');
                    }
                });
            });

        });
    </script>


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

<!--   Core JS Files   -->
<script src="assets/js/jquery-1.10.2.js" type="text/javascript"></script>
<script src="assets/js/bootstrap.min.js" type="text/javascript"></script>

<!--  Checkbox, Radio & Switch Plugins -->
<script src="assets/js/bootstrap-checkbox-radio.js"></script>

<!--  Charts Plugin -->
<script src="assets/js/chartist.min.js"></script>

<!--  Notifications Plugin    -->
<script src="assets/js/bootstrap-notify.js"></script>

<!--  Google Maps Plugin    -->
<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js"></script>

<!-- Paper Dashboard Core javascript and methods for Demo purpose -->
<script src="assets/js/paper-dashboard.js"></script>

<!-- Paper Dashboard DEMO methods, don't include it in your project! -->
<script src="assets/js/demo.js"></script>

</html>
