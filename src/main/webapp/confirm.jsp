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

    <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport'/>
    <meta name="viewport" content="width=device-width"/>

</head>
<body>

<div class="container w-25 center mt-lg-5">
    <form id="send-otp" onsubmit="submitFormAndRedirect(event, this,'confirm')">

        <div class="mb-3">
            <label for="exampleInputPassword1" class="form-label">Nhập OTP xác nhận</label>
            <input name="code" type="text" class="form-control" id="exampleInputPassword1">
        </div>

        <button type="submit" class="btn btn-primary">Xác nhận</button>
    </form>
</div>
</body>

<script src="./assets/js/my-js/notify.js"></script>
<script src="./assets/js/my-js/ajax-process.js"></script>

<style>

</style>
</html>
