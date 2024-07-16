<%@ page import="vn.hcmuaf.fit.drillsell.dao.ProductDAO" %>
<%@ page import="vn.hcmuaf.fit.drillsell.model.ProductCategorys" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <link rel="icon" type="image/png" sizes="96x96" href="../assets/images/logo.png">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>

    <title>Quản lý kho hàng</title>

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


    <!--  Paper Dashboard core CSS    -->
    <link href="../assets/css/my-css/admin/paper-dashboard.css" rel="stylesheet"/>


    <!--  Fonts and icons     -->
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">
    <link href='https://fonts.googleapis.com/css?family=Muli:400,300' rel='stylesheet' type='text/css'>

    <%--    Datatable--%>
    <link href="https://cdn.datatables.net/v/dt/jqc-1.12.4/dt-2.0.3/datatables.min.css" rel="stylesheet">
    <script src="https://cdn.datatables.net/v/dt/jqc-1.12.4/dt-2.0.3/datatables.min.js"></script>

    <link href="../assets/css/my-css/admin/prods-mn.css" rel="stylesheet">
    <link href="../assets/css/my-css/admin/store-mn.css" rel="stylesheet">
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
                    <a href="user-manager.jsp">
                        <i class="ti-user"></i>
                        <p>Quản lý người dùng</p>
                    </a>
                </li>
                <li>
                    <a href="products-management.jsp">
                        <i class="ti-check-box"></i>
                        <p>Quản lý kho</p>
                    </a>
                </li>
                <li>
                    <a href="viewOrderMa">
                        <i class="ti-shopping-cart"></i>
                        <p>Quản lý đơn hàng</p>
                    </a>
                </li>
                <li>
                    <a href="log_management.jsp">
                        <%--                        <i class="ti-shopping-cart"></i>--%>
                        <p>Quản lý log</p>
                    </a>
                </li>
                <li class="active">
                    <a href="store-manager.jsp">
                        <i class="ti-user"></i>
                        <p>Quản lý kho</p>
                    </a>
                </li>

            </ul>
        </div>
    </div>
    <div class="main-panel">
        <div class="main-header">
            <div class="main-title">

                <h3 class="title-uppercase">Quản lý kho</h3>
            </div>
            <div class="right-main-header ">

                <form id="uploadForm" enctype="multipart/form-data">
                    <input type="file" id="fileInput" name="excelFile" accept=".xlsx, .xls" style="display: none;" />
                    <label for="fileInput" class="btn-add-prod btn btn-primary open-modal"
                    >Nhập kho</label>
                </form>
            </div>
        </div>
        <div class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="content table-responsive table-full-width">
                                <div class="nav-bar">
                                    <div class="nav-item">
                                        <button class=" btn-add-prod  open-modal">
                                            Sản phẩm đã ẩn
                                        </button>
                                    </div>
                                    <div class="nav-item">
                                        <button class=" btn-add-prod  open-modal">
                                            Sản phẩm đã xóa
                                        </button>
                                    </div>

                                </div>

                                <table id="repo-mn" class="table table-striped display" style="width: 100%">
                                    <thead>
                                    <tr>
                                        <th>Mã sản phẩm</th>
                                        <th>Tên sản phẩm</th>
                                        <th>Ngày nhập</th>
                                        <th>Giá nhập</th>
                                        <th>Số lượng trong kho</th>
                                        <th></th>
                                    </tr>
                                    </thead>
                                </table>

                            </div>
                        </div>

                    </div>


                </div>
            </div>
        </div>


    </div>

</div>
</body>
<script !src="">

</script>

<script src="../assets/js/my-js/prod-management/my-modal.js"></script>
<script src="../assets/js/my-js/notify.js"></script>
<script src="../assets/js/my-js/ajax-process.js"></script>
<script src="../assets/js/my-js/prod-management/load-img.js"></script>
<script src="../assets/js/my-js/prod-management/store-management.js"></script>

<style>

</style>
</html>
