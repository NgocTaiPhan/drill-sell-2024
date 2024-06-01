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
    <!--  Fonts and icons     -->
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">
    <link href='https://fonts.googleapis.com/css?family=Muli:400,300' rel='stylesheet' type='text/css'>

    <%--    Datatable--%>
    <link href="https://cdn.datatables.net/v/dt/jqc-1.12.4/dt-2.0.3/datatables.min.css" rel="stylesheet">
    <script src="https://cdn.datatables.net/v/dt/jqc-1.12.4/dt-2.0.3/datatables.min.js"></script>
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
                <li>
                    <a href="dashboard.jsp">
                        <i class="ti-panel"></i>
                        <p>Dashboard</p>
                    </a>
                </li>

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
                <div class="collapse navbar-collapse">
                    <ul class="nav navbar-nav navbar-right">
                        <li>
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                <i class="ti-panel"></i>
                                <p>Stats</p>
                            </a>
                        </li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                <i class="ti-bell"></i>
                                <p class="notification">5</p>
                                <p>Notifications</p>
                                <b class="caret"></b>
                            </a>
                            <ul class="dropdown-menu">
                                <li><a href="#">Notification 1</a></li>
                                <li><a href="#">Notification 2</a></li>
                                <li><a href="#">Notification 3</a></li>
                                <li><a href="#">Notification 4</a></li>
                                <li><a href="#">Another notification</a></li>
                            </ul>
                        </li>
                        <li>
                            <a href="#">
                                <i class="ti-settings"></i>
                                <p>Settings</p>
                            </a>
                        </li>
                    </ul>

                </div>
            </div>
        </nav>


        <div class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="header">
                                <h4 class="title">Striped Table</h4>
                                <p class="category">Here is a subtitle for this table</p>
                            </div>
                            <div class="content table-responsive table-full-width">
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
                                            var sex = data.sex;
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
                                                    // window.location.href = "detailUser.jsp";

                                                    // localStorage.setItem('userDetails', JSON.stringify(response));
                                                    // // Chuyển hướng đến trang detail.jsp
                                                    // // window.location.href = "detailUser.jsp";
                                                    // var popup = window.open("detailUser.jsp", "userDetailPopup", "width=600,height=400");
                                                    // if (popup && !popup.closed) {
                                                    //     // Thực hiện các thao tác khác ở đây nếu cần thiết, ví dụ: load dữ liệu vào popup
                                                    // } else {
                                                    //     // Xử lý khi popup không thể mở được
                                                    //     console.error("Popup could not be opened.");
                                                    // }
                                                    // table.ajax.reload();
                                                    var popupContent = '<div id="userPopup">' +
                                                        '<button id="closePopup" class="closeButton">&#x2716;</button>' +
                                                        '<h1>Thông Tin Khách Hàng</h1>' +
                                                        '<p><strong>ID:</strong> ' + response.id + '</p>' +
                                                        '<p><strong>Tên Khách Hàng:</strong> ' + response.fullname + '</p>' +
                                                        '<p><strong>Tên Đăng Nhập:</strong> ' + response.username + '</p>' +
                                                        '<p><strong>Email:</strong> ' + response.email + '</p>' +
                                                        '<p><strong>Địa Chỉ:</strong> ' + response.address + '</p>' +
                                                        '<p><strong>Số Điện Thoại :</strong> ' + response.phone + '</p>' +
                                                        '<p><strong>Giới Tính:</strong> ' + response.sex + '</p>' +
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
</html>