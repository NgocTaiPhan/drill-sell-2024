<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 11/06/2024
  Time: 2:33 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Xác nhận mã</title>
</head>
<body>
<h1>Xác nhận mã</h1>
<form action="confirm" method="get">
    <label for="code">Nhập mã xác nhận:</label>
    <input type="text" id="code" name="code" required>
    <button type="submit">Xác nhận</button>
</form>
</body>
</html>
