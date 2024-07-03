<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 11/06/2024
  Time: 2:33 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Xác nhận mã</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"
            integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"
            integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF"
            crossorigin="anonymous"></script>
</head>
<body>
<div class="container w-25 center mt-lg-5">
    <form id="send-otp" action="confirm">

        <div class="mb-3">
            <label for="exampleInputPassword1" class="form-label">Nhập OTP xác nhận</label>
            <input name="code" type="text" class="form-control" id="exampleInputPassword1">
        </div>

        <button type="submit" class="btn btn-primary">Xác nhận</button>
    </form>
</div>
</body>
<script !src="">


    $(document).ready(() => {
        submitFormAngGetNotify('#send-otp', 'confirm');
        submitFormAndRedirect('#send-otp', 'confirm',)
    });
</script>
<script src="./assets/js/my-js/notify.js"></script>
<script src="./assets/js/my-js/ajax-process.js"></script>
</html>
