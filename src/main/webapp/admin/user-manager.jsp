<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8"/>
    <link rel="icon" type="image/png" sizes="96x96" href="../assets/images/logo.png">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>

    <title>Quản lý người dùng</title>

    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <link rel="stylesheet" href="https://cdn.datatables.net/2.0.5/css/dataTables.dataTables.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/buttons/3.0.1/css/buttons.dataTables.min.css">
    <script src="https://cdn.datatables.net/2.0.5/js/dataTables.js"></script>
    <script src="https://cdn.datatables.net/buttons/3.0.2/js/dataTables.buttons.js"></script>
    <script src="https://cdn.datatables.net/buttons/3.0.1/js/buttons.jqueryui.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/3.0.2/js/buttons.html5.js"></script>

    <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport'/>
    <meta name="viewport" content="width=device-width"/>


    <!-- Bootstrap core CSS     -->
    <link href="../assets/css/my-css/admin/bootstrap.min.css" rel="stylesheet"/>

    <!-- Animation library for notifications   -->
    <link href="../assets/css/my-css/admin/animate.min.css" rel="stylesheet"/>

    <!--  Paper Dashboard core CSS    -->
    <link href="../assets/css/my-css/admin/paper-dashboard.css" rel="stylesheet"/>

    <link href="../assets/css/my-css/admin/animate.min.css" rel="stylesheet"/>
    <link href="../assets/css/my-css/pop-up.css" rel="stylesheet"/>
    <!--  Fonts and icons     -->
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">
    <link href='https://fonts.googleapis.com/css?family=Muli:400,300' rel='stylesheet' type='text/css'>

    <%--    Datatable--%>
    <link href="https://cdn.datatables.net/v/dt/jqc-1.12.4/dt-2.0.3/datatables.min.css" rel="stylesheet">
    <script src="https://cdn.datatables.net/v/dt/jqc-1.12.4/dt-2.0.3/datatables.min.js"></script>
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
                        $("#editTinh").append('<option value="' + val_tinh.full_name + '">' + val_tinh.full_name + '</option>');
                    });
                }
            });

            // Xử lý sự kiện khi người dùng chọn tỉnh
            $("#editTinh").change(function () {
                var ten_tinh = $(this).val(); // Lấy tên của tỉnh từ dropdown

                // Xóa các lựa chọn cũ của quận/huyện và phường/xã
                $("#editQuan").html('<option value="0">Chọn Quận Huyện</option>');
                $("#editPhuong").html('<option value="0">Chọn Phường Xã</option>');

                // Lấy danh sách quận/huyện từ API và điền vào dropdown quận/huyện
                $.getJSON('https://esgoo.net/api-tinhthanh/2/' + provinces[ten_tinh] + '.htm', function (data_quan) {
                    if (data_quan.error == 0) {
                        $.each(data_quan.data, function (key_quan, val_quan) {
                            districts[val_quan.full_name] = val_quan.id; // Lưu tên của quận/huyện
                            $("#editQuan").append('<option value="' + val_quan.full_name + '">' + val_quan.full_name + '</option>');
                        });
                    }
                });
            });

            // Xử lý sự kiện khi người dùng chọn quận/huyện
            $("#editQuan").change(function () {
                var ten_quan = $(this).val(); // Lấy tên của quận/huyện từ dropdown

                // Xóa các lựa chọn cũ của phường/xã
                $("#editPhuong").html('<option value="0">Chọn Phường Xã</option>');

                // Lấy danh sách phường/xã từ API và điền vào dropdown phường/xã
                $.getJSON('https://esgoo.net/api-tinhthanh/3/' + districts[ten_quan] + '.htm', function (data_phuong) {
                    if (data_phuong.error == 0) {
                        $.each(data_phuong.data, function (key_phuong, val_phuong) {
                            wards[val_phuong.full_name] = val_phuong.id; // Lưu tên của phường/xã
                            $("#editPhuong").append('<option value="' + val_phuong.full_name + '">' + val_phuong.full_name + '</option>');
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
                <a href="../home.jsp" class="simple-text">
                    Máy khoan
                </a>
            </div>

            <ul class="nav">


                <li class="active">
                    <a href="user-manager.jsp">
                        <i class="ti-user"></i>
                        <p>Quản lý người dùng</p>
                    </a>
                </li>
                <li>
                    <a href="products-management.jsp">
                        <i class="ti-check-box"></i>
                        <p>Quản lý sản phẩm</p>
                    </a>
                </li>
                <li>
                    <a href="order-management.jsp">
                        <i class="ti-shopping-cart"></i>
                        <p>Quản lý đơn hàng</p>
                    </a>
                </li>
                <li >
                    <a href="log_management.jsp">
                        <%--                        <i class="ti-shopping-cart"></i>--%>
                        <p>Quản lý log</p>
                    </a>
                </li>
                <li class="">
                    <a href="store-manager.jsp">
                        <i class="ti-user"></i>
                        <p>Quản lý kho</p>
                    </a>
                </li>


            </ul>
        </div>
    </div>

    <div class="main-panel">
        <nav class="navbar navbar-default">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar bar1"></span>
                        <span class="icon-bar bar2"></span>
                        <span class="icon-bar bar3"></span>
                    </button>
                    <a class="navbar-brand" href="#">Quản lý người dùng</a>
                </div>

            </div>
        </nav>

        <div class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="content table-responsive table-full-width">
                                <div class="btn btn-info" id="openModalBtn">Thêm người dùng</div>

                                <!-- Modal form thêm người dùng -->
                                <div id="addUserModal" class="modal">

                                    <div class="modal-content">
                                        <span class="close">&times;</span>
                                        <h2>Thêm người dùng</h2>
                                        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.10/dist/sweetalert2.all.min.js"
                                                integrity="sha256-73rO2g7JSErG8isZXCse39Kf5yGuePgjyvot/8cRCNQ="
                                                crossorigin="anonymous"></script>
                                        <link rel="stylesheet"
                                              href="https://cdn.jsdelivr.net/npm/sweetalert2@11.10/dist/sweetalert2.min.css"
                                              integrity="sha256-h2Gkn+H33lnKlQTNntQyLXMWq7/9XI2rlPCsLsVcUBs=" crossorigin="anonymous">
                                      <script src="../assets/js/my-js/notify.js"></script>
                                        <script src="../assets/js/my-js/ajax-process.js"></script>
                                        <form id="addUserForm">
                                            <label for="fullname">Tên người dùng:</label>
                                            <input type="text" id="fullname" name="fullname"><br><br>

                                            <label for="username">Tên đăng nhập:</label>
                                            <input type="text" id="username" name="username"><br><br>

                                            <label for="email">Email:</label>
                                            <input type="email" id="email" name="email"><br><br>

                                            <label for="passwords">Mật khẩu:</label>
                                            <input type="password" id="passwords" name="passwords"><br><br>

                                            <div class="form-group">
                                                <label class="info-title"  for="address" id="address"><span>Địa chỉ:</span></label>

                                                <div class="css_select_div">
                                                    <select class="css_select" id="tinh" name="tinh">
                                                        <option value="0">Chọn Tỉnh</option>
                                                        <!-- Thêm các tùy chọn cho tỉnh -->
                                                    </select>
                                                    <select class="css_select" id="quan" name="quan">
                                                        <option value="0">Chọn Quận Huyện</option>
                                                    </select>
                                                    <select class="css_select" id="phuong" name="phuong">
                                                        <option value="0">Chọn Phường Xã</option>
                                                        <!-- Thêm các tùy chọn cho xã -->
                                                    </select>
                                                </div>
                                            </div>


                                            <label for="phone">Số điện thoại:</label>
                                            <input type="text" id="phone" name="phone"><br><br>

                                            <label for="sex">Giới tính:</label>
                                            <select id="sex" name="sex">
                                                <option value="Nam">Nam</option>
                                                <option value="Nữ">Nữ</option>
                                            </select><br><br>

                                            <label for="yearOfBirth">Năm sinh:</label>
                                            <input type="date" id="yearOfBirth" name="yearOfBirth"><br><br>

                                            <label for="roleUser">Chức vụ:</label>
                                            <select id="roleUser" name="roleUser">
                                                <option value="User">User</option>
                                                <option value="Admin">Admin</option>
                                            </select><br><br>

                                            <button type="submit">Thêm người dùng</button>
                                        </form>
                                    </div>
                                </div>
                                <!-- Modal form chỉnh sửa người dùng -->
                                <div id="editUserModal" class="modal">
                                    <div class="modal-content">
                                        <span class="close">&times;</span>
                                        <h2>Chỉnh sửa người dùng</h2>
                                        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.10/dist/sweetalert2.all.min.js"
                                                integrity="sha256-73rO2g7JSErG8isZXCse39Kf5yGuePgjyvot/8cRCNQ="
                                                crossorigin="anonymous"></script>
                                        <link rel="stylesheet"
                                              href="https://cdn.jsdelivr.net/npm/sweetalert2@11.10/dist/sweetalert2.min.css"
                                              integrity="sha256-h2Gkn+H33lnKlQTNntQyLXMWq7/9XI2rlPCsLsVcUBs=" crossorigin="anonymous">
                                        <script src="../assets/js/my-js/notify.js"></script>
                                        <script src="../assets/js/my-js/ajax-process.js"></script>
                                        <form id="editUserForm">
                                            <!-- Thêm input ẩn để lưu ID của người dùng -->
                                            <input type="hidden" id="editUserId" name="editUserId">

                                            <label for="editFullname">Tên người dùng:</label>
                                            <input type="text" id="editFullname" name="editFullname"><br><br>

                                            <label for="editUsername">Tên đăng nhập:</label>
                                            <input type="text" id="editUsername" name="editUsername"><br><br>

                                            <label for="editEmail">Email:</label>
                                            <input type="email" id="editEmail" name="editEmail"><br><br>

                                            <label for="editPasswords">Mật khẩu:</label>
                                            <input type="password" id="editPasswords" name="editPasswords"><br><br>

                                            <div class="form-group">
                                                <label class="info-title" for="editAddress" id="editAddress"><span>Địa chỉ:</span></label>
                                                <div class="css_select_div">
                                                    <select class="css_select" id="editTinh" name="editTinh">
                                                        <option value="0">Chọn Tỉnh</option>
                                                        <!-- Thêm các tùy chọn cho tỉnh -->
                                                    </select>
                                                    <select class="css_select" id="editQuan" name="editQuan">
                                                        <option value="0">Chọn Quận Huyện</option>
                                                    </select>
                                                    <select class="css_select" id="editPhuong" name="editPhuong">
                                                        <option value="0">Chọn Phường Xã</option>
                                                        <!-- Thêm các tùy chọn cho xã -->
                                                    </select>
                                                </div>
                                            </div>

                                            <label for="editPhone">Số điện thoại:</label>
                                            <input type="text" id="editPhone" name="editPhone"><br><br>

                                            <label for="editSex">Giới tính:</label>
                                            <select id="editSex" name="editSex">
                                                <option value="Nam">Nam</option>
                                                <option value="Nữ">Nữ</option>
                                            </select><br><br>

                                            <label for="editYearOfBirth">Năm sinh:</label>
                                            <input type="date" id="editYearOfBirth" name="editYearOfBirth"><br><br>

                                            <label for="editRoleUser">Chức vụ:</label>
                                            <select id="editRoleUser" name="editRoleUser">
                                                <option value="User">User</option>
                                                <option value="Admin">Admin</option>
                                            </select><br><br>

                                            <button type="submit">Cập nhật người dùng</button>
                                        </form>
                                    </div>
                                </div>

                                <table id="user-mn" class="table table-striped">
                                    <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Tên người dùng</th>
                                        <th>Email</th>
                                        <th>Hành Động</th>
                                    </tr>
                                    </thead>
                                </table>

                                <%--                                ajax show người dùng trong quản lý người dùng--%>

                                <script>


                                    $(document).ready(function (){

                                        var table = $('#user-mn').DataTable({
                                            "ajax" :{
                                                "url":"ShowUser",
                                                "dataSrc":"",
                                            },
                                            "columns": [
                                                {"data":"id"},
                                                {"data":"username"},
                                                {"data":"email"},
                                                {
                                                    "data":null,

                                                    render: (data,type)=>   ' <button type="button" class="btn btn-info" >Xem chi tiết </button>' +
                                                        '  <button type="button" class="btn btn-warning" >Sửa </button>' +
                                                        '<button type="button" class="btn btn-danger" >Xóa </button>'
                                                }
                                            ],
                                        });

                                        // Xử lý sự kiện click nút chỉnh sửa
                                        // Handle modal open and populate form data
                                        $('#user-mn tbody').on('click', '.btn-warning', function () {
                                            var data = table.row($(this).parents('tr')).data();
                                            var id = data.id;
                                            var fullname = data.fullname;
                                            var username = data.username;
                                            var email = data.email;
                                            var address = data.address;
                                            var phone = data.phone;
                                            var sex = data.sex ===  true? 'Nam' : 'Nữ';
                                            var yearOfBirth = data.yearOfBirth;
                                            var roleUser = data.roleUser === true ? 'Admin' : 'User';


                                            // Split address into parts: province, district, ward
                                            var addressParts = address.split(',');
                                            console.log("Address Parts:", addressParts);
                                            var province = addressParts[0].trim();
                                            var district = addressParts[1] ? addressParts[1].trim() : ' ';
                                            var ward = addressParts[2] ? addressParts[2].trim() : ' ';
                                            console.log("Province:", province, "District:", district, "Ward:", ward);

                                            // Populate data into edit form
                                            $('#editUserId').val(id);
                                            $('#editFullname').val(fullname);
                                            $('#editUsername').val(username);
                                            $('#editEmail').val(email);
                                            $('#editPasswords').val('');
                                            $('#editTinh').val(province);
                                            // cập nhật quận và phường tương ứng trong user session
                                            $('#editQuan').html('<option value="' + district + '">' + district + '</option>');
                                            $('#editPhuong').html('<option value="' + ward + '">' + ward + '</option>');

                                            $('#editPhone').val(phone);
                                            $('#editSex').val(sex);
                                            $('#editYearOfBirth').val(yearOfBirth);
                                            $('#editRoleUser').val(roleUser);

                                            // Show edit user modal
                                            $('#editUserModal').show();
                                            $('#editUserModal').append('<div class="overlay"></div>');
                                        });

                                        // Handle modal close
                                        $('.close').click(function () {
                                            $('#editUserModal').hide();
                                            $('.overlay').remove();
                                        });

                                        // Handle form submission
                                        $('#editUserForm').submit(function (e) {
                                            e.preventDefault();

                                            $.ajax({
                                                type: "POST",
                                                url: "editUser", // Replace with your backend endpoint
                                                data: $('#editUserForm').serialize(),
                                                success: function (response) {
                                                    if (response.type === 'validation_error') {
                                                        // Nếu có lỗi validation, hiển thị thông báo validation
                                                        normalNotify(response.type, response.message);
                                                    } else if (response.type === 'success') {
                                                        // Nếu thành công, hiển thị thông báo xác nhận
                                                        Swal.fire({
                                                            title: "Bạn có chắc chắn muốn cập nhật thông tin?",
                                                            text: "Hãy kiểm tra lại thông tin trước khi xác nhận!",
                                                            icon: "warning",
                                                            showCancelButton: true,
                                                            confirmButtonColor: "#3085d6",
                                                            cancelButtonColor: "#d33",
                                                            confirmButtonText: "Đồng ý cập nhật!",
                                                            cancelButtonText: "Hủy"
                                                        }).then((result) => {
                                                            if (result.isConfirmed) {
                                                                // Nếu người dùng xác nhận, hiển thị thông báo thành công và reload data
                                                                Swal.fire({
                                                                    title: "Thành công!",
                                                                    text: response.message,
                                                                    icon: "success"
                                                                });
                                                                $('#editUserModal').hide();
                                                                table.ajax.reload(); // Assuming 'table' is your DataTable instance, reload data if needed
                                                            } else {
                                                                // Nếu người dùng hủy, không làm gì cả
                                                                Swal.fire({
                                                                    title: "Hủy",
                                                                    text: "Thông tin của bạn vẫn chưa thay đổi :)",
                                                                    icon: "info"
                                                                });
                                                            }
                                                        });
                                                    } else {
                                                        // Nếu có lỗi khác, hiển thị thông báo lỗi
                                                        Swal.fire({
                                                            title: "Lỗi!",
                                                            text: response.message,
                                                            icon: "error"
                                                        });
                                                    }
                                                },
                                                error: function (xhr, status, error) {
                                                    var errorMessage = xhr.responseText || "An error occurred: " + error;
                                                    Swal.fire({
                                                        title: "Lỗi!",
                                                        text: errorMessage,
                                                        icon: "error"
                                                    });
                                                }
                                            });
                                        });



                                        // thêm người dùng
                                        $("#openModalBtn").click(function() {
                                            $("#addUserModal").css("display", "block");
                                            $('#openModalBtn').append('<div class="overlay"></div>');
                                        });

// Đóng modal khi nhấn nút đóng hoặc nút đóng modal
                                        $(".close").click(function() {
                                            $("#addUserModal").css("display", "none");
                                            $('.overlay').remove();
                                        });

// Xử lý khi submit form thêm người dùng
                                        $("#addUserForm").submit(function(e) {
                                            e.preventDefault();

                                            $.ajax({
                                                type: "POST",
                                                url: "addUser",
                                                data: $(this).serialize(),
                                                success: function(response) {
                                                    if (response.type === "success") {
                                                        normalNotify(response.type, response.message, function() {
                                                            // Đóng modal sau khi thêm thành công
                                                            $("#addUserModal").css("display", "none");
                                                            $('.overlay').remove();
                                                            // Reset form sau khi thêm thành công
                                                            $("#addUserForm")[0].reset();
                                                            table.ajax.reload();
                                                        });
                                                    } else {
                                                        // Hiển thị thông báo lỗi
                                                        normalNotify(response.type, response.message);
                                                    }
                                                },
                                                error: function(xhr, status, error) {
                                                    normalNotify("error", "Lỗi khi thêm người dùng: " + error);
                                                }
                                            });
                                        });

                                        $('#user-mn tbody').on('click', '.btn-danger', function () {
                                            var data = table.row($(this).parents('tr')).data();
                                            var id = data.id;
                                            // Hiển thị hộp thoại confirm
                                            Swal.fire({
                                                title: "Bạn có chắc chắn muốn xóa?",
                                                text: "Bạn sẽ không thể phục hồi tài khoản này!",
                                                icon: "warning",
                                                showCancelButton: true,
                                                confirmButtonColor: "#3085d6",
                                                cancelButtonColor: "#d33",
                                                confirmButtonText: "Đồng ý xóa!",
                                                cancelButtonText: "Hủy"
                                            }).then((result) => {
                                                if (result.isConfirmed) {
                                                    // Nếu người dùng chọn "OK", thực hiện xóa
                                                    $.ajax({
                                                        type: "POST",    
                                                        url: "deleteUser",
                                                        data: {id: id},
                                                        success: function (response) {
                                                            Swal.fire({
                                                                title: "Thành công!",
                                                                text: response,
                                                                icon: "success"
                                                            });
                                                            // Tải lại bảng dữ liệu
                                                            table.ajax.reload();
                                                        },
                                                        error: function (xhr, status, error) {
                                                            var errorMessage = xhr.responseText || "An error occurred: " + error;
                                                            Swal.fire({
                                                                title: "Lỗi!",
                                                                text: errorMessage,
                                                                icon: "error"
                                                            });
                                                        }
                                                    });
                                                } else {
                                                    // Nếu người dùng chọn "Cancel", không thực hiện hành động nào
                                                    Swal.fire({
                                                        title: "Hủy",
                                                        text: "Tài khoản của bạn an toàn :)",
                                                        icon: "info"
                                                    });
                                                }
                                            })
                                        });
                                        $('#user-mn tbody').on('click','.btn-info',function (){
                                            var data = table.row($(this).parents('tr')).data();
                                            var id = data.id;
                                            var fullname = data.fullname;
                                            var username = data.username; // Lấy tên người dùng từ dữ liệu hàng được chọn
                                            var email = data.email; // Lấy mật khẩu từ dữ liệu hàng được chọn
                                            var address = data.address;
                                            var phone = data.phone;
                                            var sex = data.sex ? 'Nam' : 'Nữ';
                                            var yearOfBirth = data.yearOfBirth;
                                            $.ajax({
                                                type: "POST",
                                                url: "showDetailUser",
                                                 data : {id: id,
                                                    fullname: fullname,
                                                     username: username, // Truyền tên người dùng
                                                     email: email,
                                                     address: address,
                                                     phone: phone,
                                                    sex: sex,
                                                    yearOfBirth : yearOfBirth
                                                },
                                                success: function (response){

                                                    var popupContent = '<div id="userPopup">' +
                                                        '<button id="closePopup" class="closeButton">&#x2716;</button>' +
                                                        '<h1>Thông Tin Khách Hàng</h1>' +
                                                        '<p><strong>ID:</strong> ' + response.id + '</p>' +
                                                        '<p><strong>Tên Khách Hàng:</strong> ' + response.fullname + '</p>' +
                                                        '<p><strong>Tên Đăng Nhập:</strong> ' + response.username + '</p>' +
                                                        '<p><strong>Email:</strong> ' + response.email + '</p>' +
                                                        '<p><strong>Địa Chỉ:</strong> ' + response.address + '</p>' +
                                                        '<p><strong>Số Điện Thoại :</strong> ' + response.phone + '</p>' +
                                                        '<p><strong>Giới Tính:</strong> ' + sex + '</p>' +
                                                        '<p><strong>Ngày Sinh:</strong> ' + response.yearOfBirth + '</p>' +
                                                        '</div>';
                                                    $('body').append('<div class="overlay"></div>');
                                                    // Thêm popup vào trang
                                                    $('body').append(popupContent);

                                                    // Đóng popup khi nhấn nút "Close"
                                                    $('#closePopup').click(function() {
                                                        $('#userPopup').remove();
                                                        $('.overlay').remove();
                                                    });
                                                },
                                                error: function (xhr,status,error){
                                                    alert("Error: "+error);
                                                }
                                            })
                                        })




                                    })

                                </script>
                                <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.10.3/dist/sweetalert2.all.min.js"></script>
                                <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.10.3/dist/sweetalert2.min.css" rel="stylesheet">
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>


</body>
<script src="../assets/js/my-js/login.js"></script>
</html>