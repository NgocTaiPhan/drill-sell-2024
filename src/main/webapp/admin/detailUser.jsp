<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Detail</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<div>
    <h1>User Detail</h1>
    <div id="userDetails">
        <table id="user-m" class="table table-striped">
            <thead>
            <tr>
                <th>ID</th>
                <th>Tên khách hàng</th>
                <th>Tên Đăng nhập</th>
                <th>Email</th>
                <th>Địa chỉ</th>
                <th>Số điện thoại</th>
                <th>Giới tính</th>
                <th>Ngày sinh</th>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
</div>

<script>
    $(document).ready(function() {
        // Lấy thông tin người dùng từ localStorage
        var userDetails = JSON.parse(localStorage.getItem('userDetails'));
        if (userDetails) {
            // Hiển thị thông tin người dùng trong bảng
            $('#user-m tbody').append(
                '<tr>' +
                '<td>' + userDetails.id + '</td>' +
                '<td>' + userDetails.fullname + '</td>' +
                '<td>' + userDetails.username + '</td>' +
                '<td>' + userDetails.email + '</td>' +
                '<td>' + userDetails.address + '</td>' +
                '<td>' + userDetails.phone + '</td>' +
                '<td>' + userDetails.sex + '</td>' +
                '<td>' + userDetails.yearOfBirth + '</td>' +
                '</tr>'
            );
        } else {
            // Xử lý khi không có thông tin người dùng
        }
    });
</script>
</body>
</html>
