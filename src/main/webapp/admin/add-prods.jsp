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

    <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport'/>
    <meta name="viewport" content="width=device-width"/>


    <!-- Bootstrap core CSS     -->
    <link href="../assets/css/my-css/admin/bootstrap.min.css" rel="stylesheet"/>

    <!-- Animation library for notifications   -->
    <link href="../assets/css/my-css/admin/animate.min.css" rel="stylesheet"/>

    <!--  Paper Dashboard core CSS    -->
    <link href="../assets/css/my-css/admin/paper-dashboard.css" rel="stylesheet"/>


</head>
<body>


<div class="container " style="margin-left:40%">
    <div class=" center-block">
        <h2 >Thêm sản phẩm</h2>
        <form class="col-lg-6 center-block" action="add-products" method="post" enctype="multipart/form-data">
            <div class="form-group" style="margin: 0 auto">
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
                <input type="text" class="form-control" id="productName" name="productName" required>
            </div>
            <div class="form-group">
                <label for="productDescription">Mô tả</label>
                <textarea class="form-control" id="productDescription" name="productDescription"
                          rows="3"
                          required></textarea>
            </div>
            <div class="form-group">
                <label for="specifications">Thông số kỹ thuật</label>
                <textarea class="form-control" id="specifications" name="specifications"
                          rows="3"
                          required></textarea>
            </div>
            <div class="form-group">
                <label for="productPrice">Giá bán</label>
                <input type="number" class="form-control" id="productPrice" name="productPrice"
                       required>
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

</body>
<script src="../assets/js/my-js/admin.js"></script>
</html>