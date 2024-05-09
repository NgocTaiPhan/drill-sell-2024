<%@ page import="vn.hcmuaf.fit.drillsell.model.Products" %>
<%@ page import="vn.hcmuaf.fit.drillsell.dao.ProductDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <link rel="icon" type="image/png" sizes="96x96" href="../assets/images/logo.png">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>

    <title>Quản lý sản phẩm</title>

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
                    <a href="user-management.jsp">
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
                    <a class="navbar-brand" href="#">Quản lý sản phẩm</a>
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
                                <table id="prod-mn" class="table table-striped">
                                    <thead>
                                    <th>Mã sản phẩm</th>
                                    <th>Tên sản phẩm</th>
                                    <th>Giá</th>
                                    <th>Số lượng đã bán</th>
                                    <th>Số lượng còn lại</th>
                                    <th>Hành động</th>
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
                                            <button type="button" class="btn btn-warning"
                                            >Sửa
                                            </button>
                                            <button type="button" class="btn btn-danger"
                                            >Xóa
                                            </button>
                                        </td>
                                    </tr>

                                    <%}%>

                                    </tbody>
                                </table>

                            </div>
                        </div>
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


    </div>
</div>


</body>


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
<script src="../assets/js/my-js/admin.js"></script>
</html>
