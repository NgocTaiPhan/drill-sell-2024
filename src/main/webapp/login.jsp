<%@ page import="vn.hcmuaf.fit.drillsell.model.User" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    User auth = (User) session.getAttribute("auth");


%>

<!doctype html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"
          name="viewport">
    <meta content="ie=edge" http-equiv="X-UA-Compatible">
    <link href="assets/images/logo.png" rel="icon" type="image/png">
    <title>Đăng nhập/Đăng kí</title>
    <link href="assets/css/bootstrap.min.css" rel="stylesheet">


    <%--    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">--%>
    <%--    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>--%>
    <%--    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>--%>
    <%--    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>--%>
    <%--    <!--    Css tự viết-->--%>
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


    <%--    Link to css button back-to-home--%>
    <link href="assets/css/my-css/back-to-home.css" rel="stylesheet">


</head>
<body class="cnt-home">

<div><a href="./home.jsp">
    <button class="button-back-home " role="button">Quay về trang chủ</button>
</a></div>
<input type="hidden" id="notify" name="notify" value="<%=session.getAttribute("notify")%>">


<div class="body-content">
    <div class="container">
        <div class="sign-in-page">
            <div class="row">
                <!-- Sign-in -->
                <div class="col-md-6 col-sm-6 sign-in">
                    <h3 class="">Đăng nhập</h3>
                    <p class=""></p>

                    <form class="outer-top-xs" id="login-form" role="form" action="login" method="POST">
                        <div class="form-group">
                            <label class="info-title" for="username-login">Tên đăng nhập <span>*</span></label>
                            <div class="error-email-login"></div>
                            <input class="form-control unicase-form-control text-input" id="username-login" type="text"
                                   name="username-login" value="">
                        </div>
                        <div class="form-group">
                            <label class="info-title" for="password-login">Mật khẩu <span>*</span>
                                <div class="error-password-login"></div>
                            </label>
                            <input class="form-control unicase-form-control text-input" id="password-login"
                                   type="password" name="pass-login" value="">
                        </div>
                        <div class="radio outer-xs">
                            <label>
                                <input id="optionsRadios2" name="optionsRadios" type="radio" value="">Lưu đăng
                                nhập
                            </label>
                            <a href="#" class="pull-right " data-toggle="modal" data-target="#forgot-pass">
                                Quên mật khẩu
                            </a>
                        </div>
                        <input class="btn-upper btn btn-primary checkout-page-button" type="submit" value="Đăng nhập">

                        <a class="btn btn-primary"
                           href="https://accounts.google.com/o/oauth2/auth?scope=profile&redirect_uri=http://localhost:8080/drillsell_war/login-google&response_type=code&client_id=151385847457-tjenhqtvgt8s3lqfk3jondm5rtft5vae.apps.googleusercontent.com&approval_prompt=force">Đăng

                            nhập với Google</a>

                    </form>

                    <%--                    <script>--%>
                    <%--                        document.getElementById("login-form").addEventListener("submit", function(event) {--%>
                    <%--                            event.preventDefault(); // Prevent the default form submission--%>

                    <%--                            // Perform your custom action here, for example, redirecting to the servlet URL--%>
                    <%--                            window.location.href = "log";--%>
                    <%--                        });--%>
                    <%--                    </script>--%>
                </div>
                <!-- Sign-in -->
                <%
                    // Retrieve the user object from the session, handling null cases
                    User user = (User) session.getAttribute("user-register");
                    String fullName = user != null ? user.getFullname() : "";
                    String address = user != null ? user.getAddress() : "";
                    String phoneNumber = user != null ? user.getPhone() : "";
                    String email = user != null ? user.getEmail() : "";
                    String username = user != null ? user.getUsername() : "";
                    String password = ""; // Consider security implications, potentially use a placeholder
                    String birthDate = user != null ? user.getYearOfBirth() : "";

                    Date sqlDate = null;
                    if (birthDate != null && !birthDate.isEmpty()) {
                        try {
                            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                            java.util.Date utilDate = sdf.parse(birthDate);
                            sqlDate = new Date(utilDate.getTime());
                        } catch (Exception e) {
                            // Handle parsing exception (e.g., log the error)
//                            System.err.println("Error parsing birthDate: " + e.getMessage());
                        }
                    }
                %>


                <div class="col-md-6 col-sm-6 create-new-account">
                    <h3 class="checkout-subtitle">Tạo tài khoản mới</h3>
                    <p class="text title-tag-line"> Nhập thông tin bên dưới để tạo tài khoản mới</p>
                    <form class="register-form outer-top-xs" role="form" id="register-form" action="register"
                          method="post">
                        <h4>Thông tin người dùng</h4>

                        <div class="form-group">
                            <label class="info-title" for="full-name-register">Họ và tên <span>*</span></label>
                            <input class="form-control unicase-form-control text-input" id="full-name-register"
                                   name="full-name-register"
                                   type="text" value="<%=fullName%>">
                        </div>


                        <div class="form-group">
                            <label class="info-title" for="birth-date-register">Ngày, tháng, năm sinh
                                <span>*</span></label>
                            <input class="form-control unicase-form-control text-input" id="birth-date-register"
                                   name="birth-date-register"
                                   type="date" value="<%=sqlDate%>">
                        </div>
                        <div class="form-group ">
                            <label class="info-title" for="gender">Giới tính
                                <span>*</span></label>
                            <div class="radio outer-xs" id="gender"
                                 style="display: flex; justify-content: space-around">
                                <label>
                                    <input id="genderFemale" name="gender" type="radio" value="Nữ" checked>Nữ
                                </label>
                                <label>
                                    <input id="genderMale" name="gender" type="radio" value="Nam">Nam
                                </label>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="info-title" for="address-register">Địa chỉ <span>*</span></label>
                            <input class="form-control unicase-form-control text-input" id="address-register"
                                   name="address-register"
                                   type="text" value="<%=address%>">
                        </div>
                        <div class="form-group">
                            <label class="info-title" for="phone-number-register">Số điện thoại
                                <span>*</span></label>
                            <input class="form-control unicase-form-control text-input" id="phone-number-register"
                                   type="tel" name="phone-number-register" value="<%=phoneNumber%>">
                        </div>
                        <div class="form-group">
                            <label class="info-title" for="email-register">Địa chỉ email <span>*</span></label>
                            <input class="form-control unicase-form-control text-input" id="email-register"
                                   type="text" name="email-register"
                                   value="<%=email%>">

                        </div>
                        <h4>Thông tin tài khoản</h4>
                        <div class="form-group">

                            <label class="info-title" for="username-register">Tên đăng nhập <span>*</span></label>
                            <input class="form-control unicase-form-control text-input" id="username-register"
                                   type="text" name="username-register"
                                   value="<%=username%>">
                        </div>
                        <div class="form-group">
                            <label class="info-title" for="password-register">Mật khẩu <span>*</span></label>
                            <input class="form-control unicase-form-control text-input" id="password-register"
                                   type="password" name="password-register"
                                   value="<%=password%>">


                        </div>
                        <div class="form-group">
                            <label class="info-title" for="confirm-password-register">Nhập lại mật khẩu
                                <span>*</span></label>
                            <input class="form-control unicase-form-control text-input"
                                   id="confirm-password-register"
                                   type="password" name="confirm-password-register">
                        </div>

                        <div class="form-group" style="white-space: nowrap;  ">
                            <input class=" form-checkbox-input" id="agree-to-terms" style="margin-right: 5px;"
                                   type="checkbox" name="agree-to-terms">
                            <label class="info-title" for="agree-to-terms">Đồng ý với <a href="rules.jsp">điều
                                khoản</a> của chúng tôi
                                <span>*</span></label>
                        </div>


                        <button class="btn-upper btn btn-primary checkout-page-button" type="submit">Đăng
                            kí
                        </button>
                    </form>


                </div>

            </div>
        </div>
    </div>
</div>
<!-- ============================================================= FOOTER : MENU============================================================= -->


<!-- ============================================================= FOOTER : MENU============================================================= -->
<!-- ============================================================= Backtop ============================================================= -->


<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.10/dist/sweetalert2.all.min.js"
        integrity="sha256-73rO2g7JSErG8isZXCse39Kf5yGuePgjyvot/8cRCNQ="
        crossorigin="anonymous"></script>
<link rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/sweetalert2@11.10/dist/sweetalert2.min.css"
      integrity="sha256-h2Gkn+H33lnKlQTNntQyLXMWq7/9XI2rlPCsLsVcUBs=" crossorigin="anonymous">

</body>


<!-- The modal -->
<div class="modal fade" id="forgot-pass" tabindex="-1" role="dialog" aria-labelledby="modalLabelSmall"
     aria-hidden="true">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">

            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h5 class="modal-title" id="modalLabelSmall">Điền thông tin để lấy lại mật khẩu</h5>
            </div>

            <div class="modal-body">
                <form action="forgot-pas?forgot-pass=1" method="post">


                    <label for="input-email">Email</label>
                    <input name="input-email" type="text" id="input-email" class="form-control"
                           aria-describedby="help-input-email" placeholder="Nhập email">

                    <label for="input-username">Tên đăng nhập</label>
                    <input name="input-username" type="text" id="input-username" class="form-control"
                           aria-describedby="help-input-username" placeholder="Nhập tên đăng nhập">

                    <label for="submit-forgot-pass"></label>
                    <input type="submit" id="submit-forgot-pass" class=" btn btn-primary form-control"
                           aria-describedby="help-input-username"
                           value="Gửi ">
                </form>

            </div>

        </div>
    </div>
</div>
<%--Modal nhập mã OTP--%>

<!-- Modal nhập OTP -->
<script !src="">

    var errorParam = document.getElementById("notify").getAttribute('value');

    function handleErrorMessage(errorMessage) {
        Swal.fire({
            icon: "error",
            title: "Đăng kí thất bại",
            text: errorMessage,
            confirmButtonText: "Đóng",
        });
    }

    switch (errorParam) {
        case "null-fullname":
            handleErrorMessage("Hãy điền họ và tên");
            break;

        case "null-birthday":
            handleErrorMessage("Hãy nhập ngày sinh");
            break;


        case "null-address":
            handleErrorMessage("Hãy nhập địa chỉ");
            break;


        case "null-phone":
            handleErrorMessage("Hãy nhập số điện thoại");
            break;

        case "null-email":
            handleErrorMessage("Hãy nhập địa chỉ email");
            break;

        case "null-username":
            handleErrorMessage("Hãy nhập tên đăng nhập");
            break;

        case "null-pass":
            handleErrorMessage("Hãy nhập mật khẩu");
            break;

        case "null-cfpass":
            handleErrorMessage("Hãy nhập lại mật khẩu");
            break;

        case "null-agree":
            handleErrorMessage("Hãy đồng ý với điều khoản của chúng tôi.");
            break;

        case "future-birthday":
            handleErrorMessage("Ngày sinh không được lớn hơn ngày hiện tại");
            break;

        case "invalid-phone":
            handleErrorMessage("Số điện thoại không hợp lệ");
            break;

        case "invalid-email":
            handleErrorMessage("Email không hợp lệ");
            break;

        case "invalid-username":
            handleErrorMessage("Tên đăng nhập không hợp lệ");
            break;
        // case "invalid-pass":
        //     handleErrorMessage( "Mật khẩu phải từ 8 kí tự. Bao gồm chữ hoa, chữ thường và số");
        //     break;
        case "invalid-pass":
            handleErrorMessage("Mật khẩu phải từ 8 kí tự, bao gồm chữ hoa, chữ thường và số")
        case "pass-not-match":
            handleErrorMessage("Mật khẩu không khớp");
            break;
        case "not-found-user-login":
            handleErrorMessage("Không tìm thấy tài khoản");
            break;
        case "null-value-login":
            handleErrorMessage("Không được để trống tên tài khoản và mật khẩu");
            break;
        case "duplicate-acc":
            handleErrorMessage("Tên đăng nhập đã tồn tại");
            break;
        case"register-success":
            Swal.fire({
                icon: "success",
                title: "Đăng kí thành công",
                text: "Hãy xác nhận email và đăng nhập!",
                confirmButtonText: "Đóng",
            }).then((result) => {
                window.location.href = "login.jsp";
            });
        case"send-otp-success":

        case"admin":
            Swal.fire({
                icon: "success",
                title: "Đăng nhập với quyền quản trị",
                text: "Chào mừng",
                confirmButtonText: "Đóng",
            }).then((result) => {
                window.location.href = "home.jsp";
            });
        case"user":
            Swal.fire({
                icon: "success",
                title: "Đăng nhập thành công",
                text: "Chào mừng",
                confirmButtonText: "Đóng",
            }).then((result) => {
                window.location.href = "home.jsp";
            });
        case"vertified":
            Swal.fire({
                icon: "success",
                title: "Xác thực thành công",
                text: "Chào mừng",
                confirmButtonText: "Đóng",
            }).then((result) => {
                window.location.href = "home.jsp";
            });

        default:


        // break;


    }


</script>

</html>
<%
    //Xóa dữ liệu sao khi đã refill vào form đăng kí
    session.removeAttribute("user-register");
//    session.removeAttribute("notify");

%>