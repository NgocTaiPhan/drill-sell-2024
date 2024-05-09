<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 25/04/2024
  Time: 3:10 SA
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>

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

<%--Giao diện sẽ hiển thị dựa vào nơi truy cập của người dùng dựa trên giá trị "forgot-pass" :--%>
<%--    + forgot-pass= 1. Nếu người dùng truy cập từ trang Đăng nhập và bấm quên mật khẩu.--%>
<%--        - Thì sau khi thực hiện các bước quên mật khẩu, giao diện sẽ hiển thị ô nhập mật khẩu và nhập lại--%>
<%--    + forgot-pass = 0. Nếu người dùng đã đăng nhập và muốn thay đổi mật khẩu thì giao diện sẽ là gồm: Nhập mật khẩu hiện tại, Mật khẩu mới va nhập lại--%>

<div class="container w-25 center m-t-20">
    <form action="change-pass" method="post">
        <%
            String forgotPass = (String) request.getParameter("forgot-pass");
            if (forgotPass.equals("0")) {


        %>
        <div class="mb-3">
            <label for="oldPass" class="form-label">Nhập mật khẩu hiện tại</label>
            <input name="old-pass" type="text" class="form-control" id="oldPass">
        </div>
        <div class="mb-3">
            <label for="newPass" class="form-label">Nhập mật khẩu mới</label>
            <input name="pass" type="text" class="form-control" id="newPass">
        </div>
        <div class="mb-3">
            <label for="cfNewPass" class="form-label">Nhập lại mật khẩu mới</label>
            <input name="cf-pass" type="text" class="form-control" id="cfNewPass">
        </div>
        <%} else {%>

        <div class="mb-3">
            <label for="exampleInputPassword1" class="form-label">Nhập mật khẩu</label>
            <input name="pass" type="text" class="form-control" id="exampleInputPassword1">
        </div>
        <div class="mb-3">
            <label for="exampleInputPassword2" class="form-label">Nhập lại</label>
            <input name="cf-pass" type="text" class="form-control" id="exampleInputPassword2">
        </div>
        <%}%>

        <button type="submit" class="btn btn-primary">Xác nhận</button>
    </form>
</div>
</body>
</html>
