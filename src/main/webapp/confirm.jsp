<%@ page import="vn.hcmuaf.fit.drillsell.dao.ProductDAO" %>
<%@ page import="vn.hcmuaf.fit.drillsell.model.ProductCategorys" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <link rel="icon" type="image/png" sizes="96x96" href="./assets/images/logo.png">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>

    <title>Xác nhận</title>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.10.3/dist/sweetalert2.all.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.10.3/dist/sweetalert2.min.css" rel="stylesheet"/>

    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js"></script>

    <link href="assets/css/bootstrap.min.css" rel="stylesheet">


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
    <script src="https://esgoo.net/scripts/jquery.js"></script>
    <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport'/>
    <meta name="viewport" content="width=device-width"/>

</head>
<body>

<div class="container w-25 center-block mt-lg-5">
    <form id="send-otp" onsubmit="submitFormAndRedirect(event, this,'confirm')">
<%--    <form action="confirm" method="get">--%>
        <div class="text-center" style="margin-top: 3%;margin-left: 40%; margin-right: 40%">
            <label for="exampleInputPassword1" class="form-label">Nhập OTP xác nhận</label>
            <input name="code" type="text" class="form-control " style="width: 100%; margin-bottom: 10%"
                   id="exampleInputPassword1">
            <button type="submit" class="btn btn-primary">Xác nhận</button>
        </div>

    </form>
</div>
</body>

<script src="./assets/js/my-js/notify.js"></script>
<script src="./assets/js/my-js/ajax-process.js"></script>

<style>

</style>
</html>

