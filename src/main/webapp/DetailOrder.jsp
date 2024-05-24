<%@ page import="vn.hcmuaf.fit.drillsell.model.User" %>
<%@ page import="vn.hcmuaf.fit.drillsell.model.ProductCategorys" %>
<%@ page import="vn.hcmuaf.fit.drillsell.dao.ProductDAO" %>
<%@ page import="vn.hcmuaf.fit.drillsell.model.OrderItem" %>
<%@ page import="vn.hcmuaf.fit.drillsell.dao.CheckOutDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="vn.hcmuaf.fit.drillsell.model.Order" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <link rel="icon" type="image/png" sizes="96x96" href="assets/images/logo.png">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>

    <title>Đơn hàng của tôi</title>

    <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport'/>
    <meta name="viewport" content="width=device-width"/>


    <!-- Bootstrap core CSS     -->
    <link href="assets/css/my-css/admin/bootstrap.min.css" rel="stylesheet"/>

    <!-- Animation library for notifications   -->
    <link href="assets/css/my-css/admin/animate.min.css" rel="stylesheet"/>

    <!--  Paper Dashboard core CSS    -->
    <link href="assets/css/my-css/admin/paper-dashboard.css" rel="stylesheet"/>


    <!--  Fonts and icons     -->
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">
    <link href='https://fonts.googleapis.com/css?family=Muli:400,300' rel='stylesheet' type='text/css'>

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
                <a href="home.jsp" class="simple-text">
                    Máy khoan
                </a>
            </div>

            <ul class="nav">
                <li class="active">
                    <a href="profile.jsp">
                        <i class="ti-panel"></i>
                        <p>Tài khoản</p>
                    </a>
                </li>
                <li>
                    <a href="<%= request.getContextPath()%>/viewOrderCustomer">
                        <i class="ti-check-box"></i>
                        <p>Đơn hàng của tôi</p>
                    </a>
                </li>


            </ul>
        </div>
    </div>

    <div class="main-panel">
        <nav class="navbar navbar-default">
            <div class="container-fluid">
                <div class="header-nav animate-dropdown">
                    <div class="container">
                        <div class="yamm navbar navbar-default" role="navigation">
                            <!--                <div class="navbar-header">-->
                            <!--                    <button data-target="#mc-horizontal-menu-collapse" data-toggle="collapse"-->
                            <!--                            class="navbar-toggle collapsed"-->
                            <!--                            type="button">-->
                            <!--                        <span class="sr-only">Toggle navigation</span> <span class="icon-bar"></span> <span-->
                            <!--                            class="icon-bar"></span> <span class="icon-bar"></span></button>-->
                            <!--                </div>-->
                            <div class="nav-bg-class">
                                <div class="navbar-collapse collapse" id="mc-horizontal-menu-collapse"
                                >
                                    <div class="nav-outer">
                                        <ul class="nav navbar-nav">
                                            <li class="active  yamm-fw"><a href="home.jsp">Trang chủ</a></li>
                                            <li class="active  yamm-fw"><a
                                                    href="<%= request.getContextPath() %>/product.jsp"
                                            >Sản phẩm</a></li>
                                            <li class="dropdown active  ">
                                                <a class="dropdown-menu-left" data-hover="dropdown">Danh mục sản
                                                    phẩm</a>
                                                <ul class="dropdown-menu ">
                                                    <%for (ProductCategorys pc : ProductDAO.getInstance().getAllCategory()) {%>
                                                    <li>
                                                        <a href="<%= request.getContextPath() %>/load-by-category?category-id=<%=pc.getId()%>"
                                                           methods="post">
                                                            <%=pc.getNameCategory()%>
                                                        </a>

                                                    </li>
                                                    <%}%>

                                                </ul>
                                            </li>
                                            <li class="active  yamm-fw"><a href="contact.jsp">Liên hệ</a></li>

                                            <%

                                                User u = (User) session.getAttribute("auth");
                                                boolean logged = u != null;
                                                //Kiểm tra quyền người dùng, nếu là admin thì hiển thị thẻ Quản lý
                                                if (logged) {
                                                    if (u.isRoleUser()) {
                                            %>
                                            <li class="active yamm-fw"><a href="admin/dashboard.jsp">Quản lý</a>
                                            </li>
                                            <%
                                                    }
                                                }
                                            %>

                                        </ul>
                                        <!-- /.navbar-nav -->
                                        <div class="clearfix"></div>
                                    </div>
                                    <!-- /.nav-outer -->
                                </div>
                                <!-- /.navbar-collapse -->

                            </div>
                            <!-- /.nav-bg-class -->
                        </div>
                        <!-- /.navbar-default -->
                    </div>
                    <!-- /.container-class -->

                </div>

            </div>
        </nav>

        <form action="#">
            <section>
                <div class="main">
                    <%
                        Order order = (Order) request.getAttribute("detailOrder");
                        OrderItem item = order.getOrderItems().get(0);
                    %>
                    <div class="container">
                        <h3>Xem chi tiết đơn hàng</h3>
                        <div class="orderId">
                            <label>Mã khách hàng:</label>
                            <input name="" value="<%= item.getIdItem()%>">
                        </div>
                        <div class="nameCustomer">
                            <label>Tên khách hàng:</label>
                            <input name="" value="<%= order.getName()%>">
                        </div>
                        <div class="phone">
                            <label>Số điện thoại:</label>
                            <input name="" value="<%= order.getPhone()%>">
                        </div>
                        <div class="address">
                            <label>Địa chỉ:</label>
                            <input name="" value="<%= order.getAddress()%>">
                        </div>
                        <div class="nameProduct">
                            <label>Tên sản phẩm:</label>
                            <input name="" value="<%= item.getProductName()%>">
                        </div>
                        <div class="quantity">
                            <label>Số lượng:</label>
                            <input name="" value="<%= item.getQuantity()%>">
                        </div>
                        <div class="unitPrice">
                            <label>Đơn giá:</label>
                            <input name="" value="<%= item.getUnitPrice()%>">
                        </div>
                        <div class="totalPrice">
                            <label>Tổng tiền:</label>
                            <input name="" value="<%= item.getTotalPrice()%>">
                        </div>
                        <div class="status">
                            <label>Trạng thái:</label>
                            <input name="" value="<%= order.getStauss()%>">
                        </div>

                        <div class="cancel">
                            <input class="cancel" type="submit" value="Hủy đơn">
                        </div>
                    </div>

                </div>
            </section>
        </form>

    </div>
</div>
<style>
    .orderId, .cancel, .status, .totalPrice, .unitPrice, .quantity,
    .nameProduct, .address, .phone, .nameCustomer{
        margin-top: 30px;
    }

    body{
        font-family: Arial;
        font-size: 20px;
    }

    .main{
        width: 600px;
        height: 690px;
        border: 1px solid black;
        border-radius: 30px;
        margin-left: 420px;
        margin-top: 30px;
        background: white;

    }
    .main .container{
        width: 500px;
        height: 650px;
       margin: auto;
    }
    input{
        width: 300px;
        height: 40px;
        float: right;
        border-radius: 10px;
    }
    .cancel{
        background: #366ddb;
        border: none;
        width: 100px;
        margin-left: 200px;
        margin-top: 32px;
        color: white;
    }

</style>

</body>

<!--   Core JS Files   -->
<script src="assets/js/jquery-1.10.2.js" type="text/javascript"></script>
<script src="assets/js/bootstrap.min.js" type="text/javascript"></script>

<!--  Checkbox, Radio & Switch Plugins -->
<script src="assets/js/bootstrap-checkbox-radio.js"></script>

<!--  Charts Plugin -->
<script src="assets/js/chartist.min.js"></script>

<!--  Notifications Plugin    -->
<script src="assets/js/bootstrap-notify.js"></script>

<!--  Google Maps Plugin    -->
<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js"></script>

<!-- Paper Dashboard Core javascript and methods for Demo purpose -->
<script src="assets/js/paper-dashboard.js"></script>

<!-- Paper Dashboard DEMO methods, don't include it in your project! -->
<script src="assets/js/demo.js"></script>
<script>
    let toolbar = document.createElement('div');
    toolbar.innerHTML = '<b></b>';
    let addProdBtn = document.createElement('div')
    // Tạo nút thêm sản phẩm để khi nhấp vào sẽ xuất hiện cửa sổ pop-up
    addProdBtn.innerHTML = ' <button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#add-product">Thêm sản phẩm </button>'
    $(document).ready(function () {

        new DataTable('#myOrder', {
            layout: {
                topStart: toolbar,
                bottomStart: toolbar
            }
        });
    });

    // $(document).ready(function (){
    //     $('.delete').click(function (e){
    //         var deleteOrder = $(this);
    //         var idOrder = $(this).data('id');
    //         $.ajax({
    //             type: "post",
    //             url: "deleteList?id=" + idOrder,
    //             success: function (response){
    //                 deleteOrder.closest('tr').remove();
    //             },
    //             error: function (xhr, status, error) {
    //                 console.error("Error", error);
    //             }
    //         });
    //     })
    // })

</script>

</html>
