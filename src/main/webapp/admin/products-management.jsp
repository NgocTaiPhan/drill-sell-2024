<%@ page import="vn.hcmuaf.fit.drillsell.model.Products" %>
<%@ page import="vn.hcmuaf.fit.drillsell.dao.ProductDAO" %>
<%@ page import="vn.hcmuaf.fit.drillsell.model.ProductCategorys" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <link rel="icon" type="image/png" sizes="96x96" href="../assets/images/logo.png">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>

    <title>Quản lý sản phẩm</title>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.10.3/dist/sweetalert2.all.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.10.3/dist/sweetalert2.min.css" rel="stylesheet"/>

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

                <li>
                    <a href="user-manager.jsp">
                        <i class="ti-user"></i>
                        <p>Quản lý người dùng</p>
                    </a>
                </li>
                <li class="active">
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
        <h3 style="margin-left: 20px" class="title-uppercase">Quản lý sản phẩm</h3>
        <div class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="content table-responsive table-full-width">
                                <button class="btn btn-info addProds" id="addProds">Thêm sản phẩm</button>
                                <table id="prod-mn" class="table table-striped">
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
                                </table>
                                <script>
                                    $(document).ready(function () {
                                        var table = $('#prod-mn').DataTable({
                                            layout: {
                                                topStart: null,
                                                bottomStart: null
                                            },
                                            "ajax": {
                                                "url": "load-all-prods",
                                                "dataSrc": "",
                                            },
                                            "columns": [
                                                {"data": "productId"},
                                                {"data": "productName"},
                                                {"data": "unitPrice"},
                                                {"data": null},
                                                {"data": null},
                                                {
                                                    "data": null,
                                                    "render": function (data, type, row) {
                                                        return ' <button type="button" class="btn btn-info">Xem chi tiết</button>' +
                                                            ' <button type="button" class="btn btn-warning">Ẩn</button>' +
                                                            ' <button type="button" class="btn btn-danger">Xóa</button>';
                                                    }
                                                }
                                            ]
                                        });
                                        // $('#user-mn tbody').on('click', '.btn-danger', function () {
                                        //     var data = table.row($(this).parents('tr')).data();
                                        //     var id = data.id;
                                        //     // Hiển thị hộp thoại confirm
                                        //     Swal.fire({
                                        //         title: "Bạn có chắc chắn muốn xóa?",
                                        //         text: "Bạn sẽ không thể phục hồi tài khoản này!",
                                        //         icon: "warning",
                                        //         showCancelButton: true,
                                        //         confirmButtonColor: "#3085d6",
                                        //         cancelButtonColor: "#d33",
                                        //         confirmButtonText: "Đồng ý xóa!",
                                        //         cancelButtonText: "Hủy"
                                        //     }).then((result) => {
                                        //         if (result.isConfirmed) {
                                        //             // Nếu người dùng chọn "OK", thực hiện xóa
                                        //             $.ajax({
                                        //                 type: "POST",
                                        //                 url: "remove-prod",
                                        //                 data: {id: id},
                                        //                 success: function (response) {
                                        //                     Swal.fire({
                                        //                         title: "Thành công!",
                                        //                         text: response,
                                        //                         icon: "success"
                                        //                     });
                                        //                     // Tải lại bảng dữ liệu
                                        //                     table.ajax.reload();
                                        //                 },
                                        //                 error: function (xhr, status, error) {
                                        //                     var errorMessage = xhr.responseText || "An error occurred: " + error;
                                        //                     Swal.fire({
                                        //                         title: "Lỗi!",
                                        //                         text: errorMessage,
                                        //                         icon: "error"
                                        //                     });
                                        //                 }
                                        //             });
                                        //         } else {
                                        //             // Nếu người dùng chọn "Cancel", không thực hiện hành động nào
                                        //             Swal.fire({
                                        //                 title: "Hủy",
                                        //                 text: "Tài khoản của bạn an toàn :)",
                                        //                 icon: "info"
                                        //             });
                                        //         }
                                        //     })
                                        // })
                                    });

                                    ;
                                </script>
                            </div>
                        </div>

                    </div>


                </div>
            </div>
        </div>

        <%--Modal thêm sản phẩm--%>
        <div id="myModal" class="modal">
            <div class="modal-content">
                <span class="close-btn">&times;</span>
                <h4>Thêm sản phẩm</h4>
                <div class="container ">
                    <div class=" center-block">

                        <form class="col-lg-6 center-block" action="<%=request.getContextPath()%>/admin/add-product"
                              method="post"
                        >
                            <div class="form-group center-block">
                                <img width="200px" height="200px" src="" id="loadProdsImg" class="img-thumbnail"
                                     alt="Ảnh sản phẩm">
                            </div>
                            <div class="form-group">
                                <label for="imageFileInput">Ảnh sản phẩm (URL hoặc tệp):</label>
                                <input type="file" id="imageFileInput" name="imageUrl" accept="image/*">
                                <input type="text" id="imageUrlInput" name="imageUrl" placeholder="Nhập URL ảnh">
                            </div>
                            <script !src="">
                                const imageUrlInput = document.getElementById('imageUrlInput');
                                const loadProdsImg = document.getElementById('loadProdsImg');

                                imageUrlInput.addEventListener('input', function () {
                                    const imageUrl = this.value.trim();
                                    if (imageUrl !== '') {
                                        loadProdsImg.src = imageUrl;
                                    } else {
                                        // Nếu không có URL, bạn có thể đặt lại ảnh mặc định hoặc xóa src
                                        loadProdsImg.src = ''; // Hoặc một đường dẫn mặc định
                                    }
                                });
                            </script>

                            <div class="form-group">
                                <label for="productName">Tên sản phẩm</label>
                                <input type="text" class="form-control" id="productName" name="productName">
                            </div>
                            <div class="form-group">
                                <label for="productDescription">Mô tả</label>
                                <textarea class="form-control" id="productDescription" name="productDescription"
                                          rows="3"
                                ></textarea>
                            </div>
                            <div class="form-group">
                                <label for="specifications">Thông số kỹ thuật</label>
                                <textarea class="form-control" id="specifications" name="specifications"
                                          rows="3"
                                ></textarea>
                            </div>
                            <div class="form-group">
                                <label for="productPrice">Giá bán</label>
                                <input type="number" class="form-control" id="productPrice" name="productPrice"
                                >
                            </div>
                            <div class="form-group">
                                <label for="manufacturerId">Nhà sản xuất</label>
                                <select class="form-control" id="manufacturerId" name="manufacturerId">
                                    <option value="">Chọn nhà sản xuất</option>
                                    <%for (String pdName : ProductDAO.getInstance().getAllProducers()) {%>
                                    <option value="<%=pdName%>"><%=pdName%>
                                    </option>
                                    <%}%>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="categoryId">Danh mục sản phẩm</label>
                                <select class="form-control" id="categoryId" name="categoryId">
                                    <option value="">Chọn danh mục sản phẩm</option>
                                    <%for (ProductCategorys ct : ProductDAO.getInstance().getAllCategory()) {%>
                                    <option value="<%=ct.getId()%>"><%=ct.getNameCategory()%>
                                    </option>
                                    <%}%>
                                </select>
                            </div>

                            <button type="submit" class="btn btn-primary">Thêm</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <div id="modal-detail" class="modal">
            <div class="modal-content">
                <span class="close-btn">&times;</span>
                <h4>Thêm sản phẩm</h4>
                <div class="container ">
                    <div class=" center-block">


                    </div>
                </div>
            </div>
        </div>
        <footer class="footer">
            <div class="container-fluid">
                <nav class="pull-left">
                    <ul>

                        <li>
                            <a href="http://www.creative-tim.com">
                                Creative Tim
                            </a>
                        </li>
                        <li>
                            <a href="http://blog.creative-tim.com">
                                Blog
                            </a>
                        </li>
                        <li>
                            <a href="http://www.creative-tim.com/license">
                                Licenses
                            </a>
                        </li>
                    </ul>
                </nav>
                <div class="copyright pull-right">
                    &copy;
                    <script>document.write(new Date().getFullYear())</script>
                    , made with <i class="fa fa-heart heart"></i> by <a href="http://www.creative-tim.com">Creative
                    Tim</a>
                </div>
            </div>
        </footer>

        <input type="hidden" id="notify" name="notify" value="<%=session.getAttribute("notify")%>">
    </div>
</div>
</body>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.10/dist/sweetalert2.all.min.js"
        integrity="sha256-73rO2g7JSErG8isZXCse39Kf5yGuePgjyvot/8cRCNQ="
        crossorigin="anonymous"></script>
<link rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/sweetalert2@11.10/dist/sweetalert2.min.css"
      integrity="sha256-h2Gkn+H33lnKlQTNntQyLXMWq7/9XI2rlPCsLsVcUBs=" crossorigin="anonymous">

<%--Modal dùng đẻ hiển thị cửa sổ popup thêm sản phẩm--%>

<script src="../assets/js/my-js/prod-mn.js"></script>
<script src="../assets/js/my-js/notify.js"></script>
<link rel="stylesheet" href="../assets/css/my-css/admin/prods-mn.css">


</html>
