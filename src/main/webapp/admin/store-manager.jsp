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
                    <a href="order-management.jsp">
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

                <form id="uploadForm" action="add-excel" method="post" enctype="multipart/form-data">
                    <input type="file" id="fileInput" name="excelFile" accept=".xlsx, .xls" style="display: none;" />
                    <label for="fileInput" class="btn-add-prod open-modal" onclick="openFilePickerAndUpload('add-excel')">Nhập kho</label>
                </form>

                <script>
                    function openFilePickerAndUpload(servletUrl) {
                        const fileInput = document.getElementById('fileInput');
                        fileInput.addEventListener('change', function(event) {
                            const file = event.target.files[0];
                            if (file) {
                                importProductsFromExcel(servletUrl, file);
                            }
                        });
                        fileInput.click();
                    }

                    function importProductsFromExcel(servletUrl, file) {
                        const formData = new FormData();
                        formData.append('excelFile', file);

                        // Gửi AJAX request tới servlet
                        $.ajax({
                            type: 'POST',
                            url: servletUrl,
                            data: formData,
                            contentType: false,
                            processData: false,
                            success: function(response) {
                                console.log('Đã gửi thành công:', response);
                                Toast.fire({
                                    icon: "success",
                                    title: response,
                                });
                            },
                            error: function(xhr, status, error) {
                                var errorMessage = xhr.responseText || "Đã xảy ra lỗi: " + error;
                                var data;
                                try {
                                    data = JSON.parse(xhr.responseText);
                                } catch (e) {
                                    data = {
                                        message: errorMessage,
                                        namePage: "OK",
                                        pageUrl: "home.jsp"
                                    };
                                }
                                // normalNotify()
                            }
                        });
                    }
                </script>


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

                                <table id="prod-mn" class="table table-striped">
                                    <thead>
                                    <tr>
                                        <th>Mã sản phẩm</th>
                                        <th>Tên sản phẩm</th>
                                        <th>Số lượng trong kho</th>
                                        <th>Hành động</th>
                                    </tr>
                                    </thead>
                                </table>

                            </div>
                        </div>

                    </div>


                </div>
            </div>
        </div>

        <%--Modal thêm sản phẩm--%>

        <div id="addProdModal" class="modal">
            <div class="modal-content">
                <span class="close-button">&times;</span>
                <h4>Thêm sản phẩm</h4>
                <div class="container">
                    <div class="center-block">

                        <form class="col-lg-6 center-block" id="formAddProd"
                              onsubmit="submitFormAndNotify(this,'add-prod')">
                            <div class="form-group center-block">
                                <img width="200px" height="200px" src="" class=" loadProdsImg img-thumbnail"
                                     alt="Ảnh sản phẩm" style="margin-left: 45%">
                            </div>
                            <div class="form-group">
                                <label for="imageUrlInput">Ảnh sản phẩm (URL hoặc tệp):</label>
                                <input type="text" id="imageUrlInput" class="form-control imageUrlInput" name="imageUrl"
                                       placeholder="Nhập URL ảnh">
                                <input type="button" class="btn btn-default" onclick="openCKFinder()" value="Chọn ảnh">
                            </div>

                            <div class="form-group">
                                <label for="productName">Tên sản phẩm</label>
                                <input type="text" class="form-control" id="productName" name="productName">
                            </div>
                            <div class="form-group">
                                <label for="describle">Mô tả</label>
                                <textarea class="form-control" id="describle" name="describle"
                                          rows="3"
                                ></textarea>
                            </div>
                            <div class="form-group">
                                <label for="specifions">Thông số kỹ thuật</label>
                                <textarea class="form-control" id="specifions" name="specifions"
                                          rows="3"
                                ></textarea>
                            </div>

                            <div class="form-group">
                                <label for="nameProducer">Nhà sản xuất</label>
                                <select class="form-control" id="nameProducer" name="nameProducer">
                                    <option value="">Chọn nhà sản xuất</option>
                                    <%for (String pdName : ProductDAO.getInstance().getAllProducers()) {%>
                                    <option value="<%=pdName%>"><%=pdName%>
                                    </option>
                                    <%}%>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="unitPrice">Giá bán</label>
                                <input type="number" class="form-control" id="unitPrice" name="unitPrice">
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
                            </div>

                            <button type="submit" class="btn btn-primary">Thêm</button>
                        </form>
                    </div>

                </div>
            </div>
        </div>
        <%--        Modal xem chi tiết và update sản phẩm--%>
        <div id="modalDetailProd" class="modal">
            <div class="modal-content">
                <span class="close-button">&times;</span>
                <h4>Chi tiết sản phẩm</h4>
                <div class="container">
                    <div class="center-block">

                        <form class="col-lg-6 center-block" id="formUpdateProd">
                            <div class="form-group center-block">
                                <img width="200px" height="200px" src="" class="loadProdsImg img-thumbnail"
                                     alt="Ảnh sản phẩm">
                            </div>
                            <div class="form-group">
                                <label for="imageUrlInputU">Ảnh sản phẩm (URL hoặc tệp):</label>
                                <input disabled type="text" id="imageUrlInputU" class="imageUrlInput form-control"
                                       name="imageUrl"
                                       placeholder="Nhập URL ảnh">
                                <input disabled type="button" class="btn btn-default" onclick="openCKFinder()"
                                       value="Chọn ảnh">
                            </div>

                            <div class="form-group">
                                <label for="productNameU">Tên sản phẩm</label>
                                <input disabled type="text" class="form-control" id="productNameU" name="productName">
                            </div>
                            <div class="form-group">
                                <label for="describleU">Mô tả</label>
                                <textarea disabled class="form-control" id="describleU" name="describle"
                                          rows="3"
                                ></textarea>
                            </div>
                            <div class="form-group">
                                <label for="specifionsU">Thông số kỹ thuật</label>
                                <textarea disabled class="form-control" id="specifionsU" name="specifions"
                                          rows="3"
                                ></textarea>
                            </div>

                            <div class="form-group">
                                <label for="nameProducerU">Nhà sản xuất</label>
                                <select class="form-control" id="nameProducerU" name="nameProducer" disabled>
                                    <option id="nameProducerUI" value="">Chọn nhà sản xuất</option>
                                    <%for (String pdName : ProductDAO.getInstance().getAllProducers()) {%>
                                    <option value="<%=pdName%>"><%=pdName%>
                                    </option>
                                    <%}%>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="unitPriceU">Giá bán</label>
                                <input type="number" class="form-control" id="unitPriceU" name="unitPrice" disabled>
                                <div class="form-group">
                                    <label for="categoryIdU">Danh mục sản phẩm</label>
                                    <select class="form-control" id="categoryIdU" name="categoryId" disabled>
                                        <option value="">Chọn danh mục sản phẩm</option>
                                        <%for (ProductCategorys ct : ProductDAO.getInstance().getAllCategory()) {%>
                                        <option value="<%=ct.getId()%>"><%=ct.getNameCategory()%>
                                        </option>
                                        <%}%>
                                    </select>
                                </div>
                            </div>

                            <button type="submit" class="btn btn-primary">Thay đổi thông tin sản phẩm</button>
                        </form>
                    </div>

                </div>
            </div>
        </div>
    </div>

</div>
</body>
<script !src="">


    $(document).ready(() => {


        submitFormAndNotify('#formAddProd', 'add-prod');
        submitFormAndNotify('#formUpdateProd', 'update-prod');
    })
</script>

<script src="../assets/js/my-js/prod-management/my-modal.js"></script>
<script src="../assets/js/my-js/notify.js"></script>
<script src="../assets/js/my-js/ajax-process.js"></script>
<script src="../assets/js/my-js/prod-management/load-img.js"></script>
<script src="../assets/js/my-js/prod-management/store-management.js"></script>

<style>

</style>
</html>
