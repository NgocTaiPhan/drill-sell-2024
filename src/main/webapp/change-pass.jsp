<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>

    <!-- Bootstrap CSS and JS CDN links -->
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
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.10/dist/sweetalert2.all.min.js"
            integrity="sha256-73rO2g7JSErG8isZXCse39Kf5yGuePgjyvot/8cRCNQ="
            crossorigin="anonymous"></script>
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/sweetalert2@11.10/dist/sweetalert2.min.css"
          integrity="sha256-h2Gkn+H33lnKlQTNntQyLXMWq7/9XI2rlPCsLsVcUBs=" crossorigin="anonymous">
    <script src="assets/js/my-js/notify.js"></script>
    <script src="assets/js/my-js/ajax-process.js"></script>

</head>
<body>

<div class="container w-25 center m-t-20">
    <form onsubmit="submitFormAndRedirect(event,this,'change-password')">
        <input type="hidden" name="forgot-pass" value="<%= request.getParameter("forgot-pass") %>">
        <%
            String forgotPass = request.getParameter("forgot-pass");
            if ("1".equals(forgotPass)) {
        %>
        <div class="mb-3">
            <label for="newPassForgot" class="form-label">Nhập mật khẩu mới</label>
            <input name="pass" type="password" class="form-control" id="newPassForgot" required>
        </div>
        <div class="mb-3">
            <label for="cfNewPassForgot" class="form-label">Nhập lại mật khẩu mới</label>
            <input name="cf-pass" type="password" class="form-control" id="cfNewPassForgot" required>
        </div>
        <% } else { %>
        <div class="mb-3">
            <label for="oldPass" class="form-label">Nhập mật khẩu hiện tại</label>
            <input name="old-pass" type="password" class="form-control" id="oldPass" required>
        </div>
        <div class="mb-3">
            <label for="newPass" class="form-label">Nhập mật khẩu mới</label>
            <input name="pass" type="password" class="form-control" id="newPass" required>
        </div>
        <div class="mb-3">
            <label for="cfNewPass" class="form-label">Nhập lại mật khẩu mới</label>
            <input name="cf-pass" type="password" class="form-control" id="cfNewPass" required>
        </div>
        <% } %>
        <button type="submit" class="btn btn-primary">Xác nhận</button>
    </form>
</div>

</body>
</html>