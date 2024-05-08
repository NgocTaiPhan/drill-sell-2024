<%--<%@ page import="vn.hcmuaf.fit.drillsell.model.Order" %>--%>
<%--<%@ page import="java.util.List" %>--%>
<%--<%@ page import="vn.hcmuaf.fit.drillsell.dao.OrderDAO" %>--%>
<%--<%@ page import="java.text.NumberFormat" %>--%>
<%--<%@ page import="java.util.Locale" %>--%>
<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<html>--%>
<%--<head>--%>

<%--    <title>Title</title>--%>
<%--</head>--%>
<%--<body>--%>
<%--<div id="err" style="color:red; <%if(request.getAttribute("err") == null){%> display: none <%}%>"> <%=request.getAttribute("err")%></div>--%>
<%--<table id="order" class="table table-bordered table-striped">--%>
<%--    <thead>--%>
<%--    <tr>--%>
<%--        <th>Mã đơn hàng</th>--%>
<%--        <th>Tên sản phẩm</th>--%>
<%--        <th>Số lượng</th>--%>
<%--        <th>Giá tiền</th>--%>
<%--        <th>Tên khách hàng</th>--%>
<%--        <th>Số điện thoại</th>--%>
<%--        <th>Địa chỉ</th>--%>
<%--        <th>Trạng thái</th>--%>
<%--        <th>Sửa</th>--%>

<%--    </tr>--%>
<%--    </thead>--%>
<%--    <form action="viewEdit" method="post">--%>
<%--        <% List<Order> orders = (List<Order>) session.getAttribute("order");--%>
<%--            if (orders != null) {--%>
<%--                for(Order s: orders) {--%>
<%--                    NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));--%>
<%--                    String formattedPrice = currencyFormat.format(s.getTotalPrice() * 1000);--%>
<%--        %>--%>
<%--        <tr>--%>
<%--            <!-- Thêm trường ẩn để chứa id của đơn hàng -->--%>
<%--            <td><input type="hidden" name="id" value="<%=s.getId()%>"><%=s.getId()%></td>--%>
<%--            <td><input name="productName" value="<%=s.getProductName()%>"></td>--%>
<%--            <td><input name="quantity" value="<%=s.getQuantity()%>"></td>--%>
<%--            <td><input name="price" value="<%=formattedPrice %> " ></td>--%>
<%--            <td><input name="nameCustomer" value="<%=s.getNameCustom()%>"></td>--%>
<%--            <td><input name="phone" value="<%=s.getPhone()%>"></td>--%>
<%--            <td><input name="address" value="<%=s.getAddress()%>"></td>--%>
<%--            <td><input type="text" name="statuss" value="<%=s.getStauss()%>" list="status">--%>
<%--                <datalist id="status">--%>
<%--                    <option value="Đang xử lý">Đang xử lý</option>--%>
<%--                    <option value="Đã xác nhận">Đã xác nhận</option>--%>
<%--                    <option value="Người bán đang chuẩn bị hàng">Người bán đang--%>
<%--                        chuấn bị hàng--%>
<%--                    </option>--%>
<%--                    <option value="Đã hủy">Đã hủy</option>--%>
<%--                    <option value="Đã bàn giao cho đơn vị vận chuyển GHTK">Đã--%>
<%--                        bàn giao cho đơn vị vận chuyển GHTK--%>
<%--                    </option>--%>
<%--                    <option value="Đang giao hàng">Đang giao hàng</option>--%>
<%--                    <option value="Đã giao hàng">Đã giao hàng</option>--%>
<%--                    <option value="Đã hoàn trả">Đã hoàn trả</option>--%>
<%--                </datalist>--%>
<%--            </td>--%>
<%--            <td> <input type="submit" value="Cập nhật"></td>--%>
<%--        </tr>--%>
<%--        <%}}%>--%>
<%--    </form>--%>
<%--</table>--%>
<%--</body>--%>
<%--</html>--%>
