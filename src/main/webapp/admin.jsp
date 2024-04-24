<%@ page import="vn.hcmuaf.fit.drillsell.dao.ProductDAO" %>
<%@ page import="vn.hcmuaf.fit.drillsell.dao.UsersDAO" %>
<%@ page import="vn.hcmuaf.fit.drillsell.model.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="icon" href="assets/images/logo.png" type="image/png">
    <title>Quản trị</title>
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">

    <!-- Customizable CSS ================================================================================-->

    <link rel="stylesheet" href="assets/css/main.css">
    <link rel="stylesheet" href="assets/css/blue.css">
    <link rel="stylesheet" href="assets/css/owl.carousel.css">
    <link rel="stylesheet" href="assets/css/owl.transitions.css">
    <link rel="stylesheet" href="assets/css/animate.min.css">
    <link rel="stylesheet" href="assets/css/rateit.css">
    <link rel="stylesheet" href="assets/css/bootstrap-select.min.css">
    <link rel="stylesheet" href="assets/css/my-css/footermenu.css">

    <script src="assets/js/jquery-1.11.1.min.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>
    <script src="assets/js/bootstrap-hover-dropdown.min.js"></script>
    <script src="assets/js/owl.carousel.min.js"></script>
    <script src="assets/js/echo.min.js"></script>
    <script src="assets/js/jquery.easing-1.3.min.js"></script>
    <script src="assets/js/bootstrap-slider.min.js"></script>
    <script src="assets/js/jquery.rateit.min.js"></script>
    <script type="text/javascript" src="assets/js/lightbox.min.js"></script>
    <script src="assets/js/bootstrap-select.min.js"></script>
    <script src="assets/js/wow.min.js"></script>
    <script src="assets/js/scripts.js"></script>
    <script src="assets/js/my-js/footermenu.js"></script>


    <!-- Icons/Glyphs ==============================================================================================-->
    <link rel="stylesheet" href="assets/css/font-awesome.css">

    <!-- Fonts =========================================================================================================-->
    <link href='http://fonts.googleapis.com/css?family=Roboto:300,400,500,700' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,300,400italic,600,600italic,700,700italic,800'
          rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Montserrat:400,700' rel='stylesheet' type='text/css'>

    <link href="https://cdn.datatables.net/v/dt/jqc-1.12.4/dt-2.0.3/datatables.min.css" rel="stylesheet">

    <script src="https://cdn.datatables.net/v/dt/jqc-1.12.4/dt-2.0.3/datatables.min.js"></script>
</head>
<body>


<div class="body-content outer-top-xs" id="top-banner-and-menu" style="font-size: medium">
    <div class="">
        <div class="row">
            <div class="product-tabs inner-bottom-xs  wow fadeInUp">
                <div class="row">
                    <div id="manager-label" class="col-sm-2">
                        <ul id="product-tabs" class="nav">
                            <li class="active"><a data-toggle="tab" href="#users-management">Quản lý người dùng</a></li>
                            <li><a data-toggle="tab" href="#products-management">Quản lý sản phẩm</a>
                            </li>
                            <li><a data-toggle="tab" href="#statistics">Doanh thu</a></li>
                            <li><a data-toggle="tab" href="#order-history">Lịch Sử Đặt Hàng</a></li>
                        </ul><!-- /.nav-tabs #product-tabs -->
                    </div>
                    <style>
                        #manager-label {
                            white-space: nowrap;
                            margin-left: 50px;
                        }


                    </style>
                    <div class="col-sm-9">

                        <div class="tab-content">

                            <div id="users-management" class="tab-pane in active">
                                <div class="product-tab">
                                    <div class="container">


                                        <table id="user-mn" class="table table-bordered table-striped">
                                            <thead style="text-align: center">
                                            <tr>
                                                <th>ID</th>
                                                <th>Tên người dùng</th>
                                                <th>Email</th>
                                                <th>Hành động</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <%
                                                User userInfor;

                                                for (User us : UsersDAO.getInstance().showAll()) {%>
                                            <tr>
                                                <td><%=us.getId()%>
                                                </td>
                                                <td><%=us.getFullname()%>
                                                </td>
                                                <td><%=us.getEmail()%>
                                                </td>
                                                <td>
                                                    <button type="button" class="btn btn-info" data-toggle="modal"
                                                            data-target="#user-infor"
                                                    >Xem chi tiết
                                                    </button>
                                                    <%--Thẻ input trung gian để lưu id của người dùng sau đó load qua modal--%>
                                                    <%--                                                    <input type="hidden" id="userIdInput" name="userId"/>--%>
                                                    <%--                                                    <script !src="">--%>


                                                    <%--                                                        function showUserInfor(id) {--%>
                                                    <%--                                                            // Lưu id người dùng vào thẻ input--%>
                                                    <%--                                                            document.getElementById("userIdInput").value = parseInt(id);--%>

                                                    <%--                                                        }--%>
                                                    <%--                                                    </script>--%>
                                                </td>
                                            </tr>
                                            <%}%>

                                            </tbody>
                                        </table>


                                        <!-- The modal -->
                                        <div class="modal fade" id="user-infor" tabindex="-1" role="dialog"
                                             aria-labelledby="modalLabelLarge" aria-hidden="true">
                                            <div class="modal-dialog modal-lg">
                                                <div class="modal-content">

                                                    <div class="modal-header">
                                                        <button type="button" class="close" data-dismiss="modal"
                                                                aria-label="Close">
                                                            <span aria-hidden="true">&times;</span>
                                                        </button>
                                                        <h4 class="modal-title" id="">Thông tin người dùng</h4>
                                                    </div>

                                                    <div class="modal-body">
                                                        <div class="container">
                                                            <%--                                                        <%--%>
                                                            <%--                                                            String userIdStr = request.getParameter("userId");--%>
                                                            <%--                                                            int userId = userIdStr != null ? Integer.parseInt(userIdStr) : -1;--%>
                                                            <%--                                                            User u = UsersDAO.getInstance().getUserById(userId);--%>
                                                            <%--                                                        %>--%>
                                                            <div class="col-sm-9">

                                                                <div class="tab-content">

                                                                    <div id="profile" class="tab-pane in active">
                                                                        <div class="product-tab">
                                                                            <div class="container">


                                                                                <table class="table table-border">
                                                                                    <thead>

                                                                                    <tr>
                                                                                        <td>Tên khách hàng:</td>
                                                                                        <td>

                                                                                            <%--                                                                                        <%=u.getFullname()%>--%>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>Tên đăng nhập:</td>
                                                                                        <td>

                                                                                            <%--                                                                                        <%=u.getUsername()%>--%>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>Email:</td>
                                                                                        <td>

                                                                                            <%--                                                                                        <%=u.getEmail()%>--%>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>Giới tính:</td>
                                                                                        <td>

                                                                                            <%--                                                                                        <%=u.getSex()%>--%>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>Ngày sinh:</td>
                                                                                        <td>

                                                                                            <%--                                                                                        <%=u.getYearOfBirth()%>--%>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>Địa chỉ:</td>
                                                                                        <td>

                                                                                            <%--                                                                                        <%=u.getAddress()%>--%>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>Số điện thoại:</td>
                                                                                        <td>

                                                                                            <%--                                                                                        <%=u.getPhone()%>--%>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <%--                                                                                        <a class="btn btn-primary"--%>
                                                                                            <%--                                                                                           href="#change-infor">Thay đổi--%>
                                                                                            <%--                                                                                            thông--%>
                                                                                            <%--                                                                                            tin--%>
                                                                                            <%--                                                                                        </a>--%>

                                                                                        </td>
                                                                                        <td>
                                                                                            <%--                                                                                        <%request.setAttribute("username-forgot-pass", u.getUsername());%>--%>
                                                                                            <%--                                                                                        <a href="<%=request.getContextPath()%>/user-service/change-pass.jsp?"--%>
                                                                                            <%--                                                                                           class="btn btn-primary">Đổi--%>
                                                                                            <%--                                                                                            mật khẩu</a>--%>
                                                                                        </td>
                                                                                    </tr>

                                                                                </table>


                                                                            </div>
                                                                        </div>
                                                                    </div><!-- /.tab-pane -->
                                                                    <div id="change-infor" class="tab-pane">
                                                                        <div class="product-tab">
                                                                            <div class="container">

                                                                                <form action="change-infor-user"
                                                                                      method="get">
                                                                                    <table class="table table-border">
                                                                                        <thead>

                                                                                        <tr>
                                                                                            <td>Tên khách hàng:</td>
                                                                                            <td>
                                                                                                <%--                                                                                            <input type="text"--%>
                                                                                                <%--                                                                                                   name="input-fullname"--%>
                                                                                                <%--                                                                                                   value=" <%=u.getFullname()%>">--%>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>Tên đăng nhập:</td>
                                                                                            <td>
                                                                                                <%--                                                                                            <input type="text"--%>
                                                                                                <%--                                                                                                   name="input-username"--%>
                                                                                                <%--                                                                                                   value=" <%=u.getUsername()%>">--%>

                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>Email:</td>
                                                                                            <td>
                                                                                                <%--                                                                                            <input type="text"--%>
                                                                                                <%--                                                                                                   name="input-email"--%>
                                                                                                <%--                                                                                                   value=" <%=u.getEmail()%>">--%>

                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>Giới tính:</td>
                                                                                            <td>
                                                                                                <%--                                                                                            <input type="text"--%>
                                                                                                <%--                                                                                                   name="input-phone"--%>
                                                                                                <%--                                                                                                   value="<%=u.getSex()%>">--%>

                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>Ngày sinh:</td>
                                                                                            <td>
                                                                                                <%--                                                                                            <input type="date"--%>
                                                                                                <%--                                                                                                   name="input-date"--%>
                                                                                                <%--                                                                                                   value=" <%=u.getYearOfBirth()%>">--%>

                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>Địa chỉ:</td>
                                                                                            <td>
                                                                                                <%--                                                                                            <input type="text"--%>
                                                                                                <%--                                                                                                   name="input-address"--%>
                                                                                                <%--                                                                                                   value="<%=u.getAddress()%>">--%>

                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                Số điện thoại:
                                                                                            </td>
                                                                                            <td>
                                                                                                <%--                                                                                            <input type="text"--%>
                                                                                                <%--                                                                                                   name="input-phone"--%>
                                                                                                <%--                                                                                                   value="<%=u.getPhone()%>">--%>

                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <input class="btn btn-primary"
                                                                                                       value="Thay đổi">
                                                                                            </td>
                                                                                        </tr>

                                                                                    </table>

                                                                                </form>
                                                                            </div>
                                                                        </div>
                                                                    </div>


                                                                </div><!-- /.tab-content -->
                                                            </div>

                                                        </div>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div><!-- /.tab-pane -->

                            <div id="products-management" class="tab-pane">
                                <div class="product-tab container">

                                    <table id="prod-mn" class="table table-bordered  table-striped"
                                           style="white-space: nowrap">
                                        <thead>

                                        <tr>
                                            <th>Mã sản phẩm</th>
                                            <th>Tên sản phẩm</th>
                                            <th>Giá</th>
                                            <th>Số lượng đã bán</th>
                                            <th>Số lượng còn lại</th>
                                            <th>Hành động</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <%for (Products p : ProductDAO.getInstance().showProd()) {%>
                                        <tr>
                                            <td><%=p.getProductId()%>
                                            </td>
                                            <td><%=p.getProductName()%>
                                            </td>
                                            <td><%=ProductDAO.getInstance().getFormattedUnitPrice(p)%>
                                            </td>
                                            <td>10</td>

                                            <td>
                                                <%--                                               <%=p.getStatuss()%>--%>
                                            <td>
                                                <button type="button" class="btn btn-info" data-toggle="modal"
                                                        data-target="#prods-infor">Xem chi tiết
                                                </button>
                                            </td>
                                        </tr>

                                        <%}%>


                                        </tbody>
                                        <tfoot>
                                        <tr>
                                            <td>Tổng</td>
                                            <td></td>
                                            <td></td>
                                            <td>200</td>
                                            <td></td>
                                            <td></td>
                                        </tr>
                                        </tfoot>
                                    </table>


                                </div><!-- /.product-tab -->
                            </div><!-- /.tab-pane -->
                            <div class="modal">


                            </div>
                            <div id="statistics" class="tab-pane">
                                <div class="product-tag container">

                                    <table class="table table-bordered table-striped ">
                                        <thead>
                                        <tr>
                                            <th>Số lượng bán ra</th>
                                            <th>Tổng doan thu</th>

                                        </tr>
                                        </thead>
                                        <tbody>

                                        <tr>
                                            <td>100</td>
                                            <td>10.000.000đ</td>

                                        </tr>
                                        </tbody>
                                    </table>

                                </div><!-- /.product-tab -->
                            </div><!-- /.tab-pane -->
                            <div id="order-history" class="tab-pane">
                                <div class="product-tag container">

                                    <table id="order-history-table" class="table table-bordered  table-striped">
                                        <thead>
                                        <tr>
                                            <th>Người đặt hàng</th>
                                            <th>Địa chỉ</th>
                                            <th>Email</th>
                                            <th>Số điện thoại</th>
                                            <th>Ghi chú</th>

                                        </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>

                                </div><!-- /.product-tab -->
                            </div>
                        </div><!-- /.tab-content -->
                    </div><!-- /.col -->
                </div><!-- /.row -->
            </div>

        </div>
    </div>
</div>

<!-- ============================================================= FOOTER : MENU============================================================= -->


<!-- ============================================================= FOOTER : MENU============================================================= -->
<!-- ============================================================= Backtop ============================================================= -->
<button onclick="topFunction()" id="back-to-top" title="Go to top"><i class=" icon fa    fa-arrow-up"></i></button>
<link rel="stylesheet" href="assets/css/my-css/backtop.css">
<script src="assets/js/my-js/backtop.js"></script>
</body>
<script>
    let toolbar = document.createElement('div');
    toolbar.innerHTML = '<b></b>';
    let addProdBtn = document.createElement('div')
    addProdBtn.innerHTML = ' <button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#add-product">Thêm sản phẩm </button>'
    $(document).ready(function () {
        // $('#prod-mn, #user-mn,#order-history-table').dataTable();
        // $('#prod-mn').DataTable()

        new DataTable('#user-mn,#order-history-table', {
            layout: {
                topStart: toolbar,
                bottomStart: toolbar
            }
        });
        new DataTable('#prod-mn', {
            layout: {
                topStart: addProdBtn,
                bottomStart: toolbar
            }
        });

    });


</script>

<%--Modal dùng đẻ hiển thị cửa sổ popup thêm sản phẩm--%>
<div class="modal fade" id="add-product" tabindex="-1" role="dialog" aria-labelledby="modalLabelLarge"
     aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">

            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="modalLabelLarge">Thêm sản phẩm</h4>
            </div>

            <div class="modal-body">
                <div class="col-md-6 col-sm-6 center-block">
                    <h2>Thêm sản phẩm</h2>
                    <form action="add-product" method="post" enctype="multipart/form-data">
                        <div class="form-group" style="margin: 0 auto">
                            <img width="200px" height="200px" src="" id="loadProdsImg" class="img-thumbnail"
                                 alt="Ảnh sản phẩm">
                        </div>

                        <div class="form-group">
                            <label for="imageUrl">Ảnh sản phẩm</label>
                            <input type="hidden" id="imageUrl" name="imageUrl">
                            <button type="button" id="chooseImageBtn">Chọn ảnh từ CKFinder</button>
                        </div>

                        <script src="https://cdn.ckeditor.com/ckeditor5/41.3.1/classic/ckeditor.js"></script>
                        <script>
                            const imageUrlInput = document.getElementById("imageUrl");
                            const loadProdsImg = document.getElementById("loadProdsImg");
                            const chooseImageBtn = document.getElementById("chooseImageBtn");

                            chooseImageBtn.addEventListener("click", () => {
                                // Open CKFinder with image selection and resizing capabilities
                                CKFinder.popup({
                                    chooseFiles: true,
                                    width: 800,
                                    height: 600,
                                    resourceType: 'Images', // Restrict to images only
                                    onInit: function (finder) {
                                        finder.on('files:choose', function (evt) {
                                            const file = evt.data.files.first();

                                            // Check if a file is actually selected
                                            if (file) {
                                                const imageUrl = file.getUrl();
                                                loadProdsImg.src = imageUrl;
                                                imageUrlInput.value = imageUrl;
                                            } else {
                                                console.warn('No image selected from CKFinder.');
                                            }
                                        });
                                    }
                                });
                            });
                        </script>

                        <div class="form-group">
                            <label for="productID">Mã sản phẩm</label>
                            <input type="text" class="form-control" id="productID" name="productID" required>
                        </div>
                        <div class="form-group">
                            <label for="productName">Tên sản phẩm</label>
                            <input type="text" class="form-control" id="productName" name="productName" required>
                        </div>
                        <div class="form-group">
                            <label for="productDescription">Mô tả</label>
                            <textarea class="form-control" id="productDescription" name="productDescription" rows="3"
                                      required></textarea>
                        </div>
                        <div class="form-group">
                            <label for="productPrice">Giá bán</label>
                            <input type="number" class="form-control" id="productPrice" name="productPrice" required>
                        </div>
                        <div class="form-group">
                            <label for="productQuality">Số lượng</label>
                            <input type="number" class="form-control" id="productQuality" name="productQuality"
                                   required>
                        </div>
                        <div class="form-group">
                            <label for="manufacturer_id">Nhà sản xuất</label>
                            <select class="form-control" id="manufacturer_id" name="manufacturer_id">
                                <option value="">Chọn nhà sản xuất</option>
                                <option value="1">Công ty A</option>
                                <option value="2">Công ty B</option>
                                <option value="3">Công ty C</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="category_id">Danh mục sản phẩm</label>
                            <select class="form-control" id="category_id" name="category_id">
                                <option value="">Chọn danh mục sản phẩm</option>
                                <option value="1">Danh mục 1</option>
                                <option value="2">Danh mục 2</option>
                                <option value="3">Danh mục 3</option>
                            </select>
                        </div>

                        <button type="submit" class="btn btn-primary">Thêm</button>
                    </form>
                </div>
            </div>

        </div>
    </div>
</div>
<%--Modal hiển thị chi tiết sản phẩm--%>
<div class="modal fade" id="prods-infor" tabindex="-1" role="dialog"
     aria-labelledby="modalLabelLarge" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">

            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="prods-detail">Chi tiết sản phẩm</h4>
            </div>

            <div class="modal-body">
                <div class="container">
                    <%--                                                        <%--%>
                    <%--                                                            String userIdStr = request.getParameter("userId");--%>
                    <%--                                                            int userId = userIdStr != null ? Integer.parseInt(userIdStr) : -1;--%>
                    <%--                                                            User u = UsersDAO.getInstance().getUserById(userId);--%>
                    <%--                                                        %>--%>
                    <div class="col-sm-9">

                        <div class="tab-content">

                            <div class="tab-pane in">
                                <div class="product-tab">
                                    <div class="container">


                                        <table class="table table-border">
                                            <thead>

                                            <tr>
                                                <td>Tên khách hàng:</td>
                                                <td>

                                                    <%--                                                                                        <%=u.getFullname()%>--%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Tên đăng nhập:</td>
                                                <td>

                                                    <%--                                                                                        <%=u.getUsername()%>--%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Email:</td>
                                                <td>

                                                    <%--                                                                                        <%=u.getEmail()%>--%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Giới tính:</td>
                                                <td>

                                                    <%--                                                                                        <%=u.getSex()%>--%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Ngày sinh:</td>
                                                <td>

                                                    <%--                                                                                        <%=u.getYearOfBirth()%>--%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Địa chỉ:</td>
                                                <td>

                                                    <%--                                                                                        <%=u.getAddress()%>--%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Số điện thoại:</td>
                                                <td>

                                                    <%--                                                                                        <%=u.getPhone()%>--%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <%--                                                                                        <a class="btn btn-primary"--%>
                                                    <%--                                                                                           href="#change-infor">Thay đổi--%>
                                                    <%--                                                                                            thông--%>
                                                    <%--                                                                                            tin--%>
                                                    <%--                                                                                        </a>--%>

                                                </td>
                                                <td>
                                                    <%--                                                                                        <%request.setAttribute("username-forgot-pass", u.getUsername());%>--%>
                                                    <%--                                                                                        <a href="<%=request.getContextPath()%>/user-service/change-pass.jsp?"--%>
                                                    <%--                                                                                           class="btn btn-primary">Đổi--%>
                                                    <%--                                                                                            mật khẩu</a>--%>
                                                </td>
                                            </tr>

                                        </table>


                                    </div>
                                </div>
                            </div><!-- /.tab-pane -->
                            <div class="tab-pane">
                                <div class="product-tab">
                                    <div class="container">

                                        <form action="change-infor-user"
                                              method="get">
                                            <table class="table table-border">
                                                <thead>

                                                <tr>
                                                    <td>Tên khách hàng:</td>
                                                    <td>
                                                        <%--                                                                                            <input type="text"--%>
                                                        <%--                                                                                                   name="input-fullname"--%>
                                                        <%--                                                                                                   value=" <%=u.getFullname()%>">--%>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>Tên đăng nhập:</td>
                                                    <td>
                                                        <%--                                                                                            <input type="text"--%>
                                                        <%--                                                                                                   name="input-username"--%>
                                                        <%--                                                                                                   value=" <%=u.getUsername()%>">--%>

                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>Email:</td>
                                                    <td>
                                                        <%--                                                                                            <input type="text"--%>
                                                        <%--                                                                                                   name="input-email"--%>
                                                        <%--                                                                                                   value=" <%=u.getEmail()%>">--%>

                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>Giới tính:</td>
                                                    <td>
                                                        <%--                                                                                            <input type="text"--%>
                                                        <%--                                                                                                   name="input-phone"--%>
                                                        <%--                                                                                                   value="<%=u.getSex()%>">--%>

                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>Ngày sinh:</td>
                                                    <td>
                                                        <%--                                                                                            <input type="date"--%>
                                                        <%--                                                                                                   name="input-date"--%>
                                                        <%--                                                                                                   value=" <%=u.getYearOfBirth()%>">--%>

                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>Địa chỉ:</td>
                                                    <td>
                                                        <%--                                                                                            <input type="text"--%>
                                                        <%--                                                                                                   name="input-address"--%>
                                                        <%--                                                                                                   value="<%=u.getAddress()%>">--%>

                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        Số điện thoại:
                                                    </td>
                                                    <td>
                                                        <%--                                                                                            <input type="text"--%>
                                                        <%--                                                                                                   name="input-phone"--%>
                                                        <%--                                                                                                   value="<%=u.getPhone()%>">--%>

                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <input class="btn btn-primary"
                                                               value="Thay đổi">
                                                    </td>
                                                </tr>

                                            </table>

                                        </form>
                                    </div>
                                </div>
                            </div>


                        </div><!-- /.tab-content -->
                    </div>

                </div>
            </div>

        </div>
    </div>
</div>
</html>