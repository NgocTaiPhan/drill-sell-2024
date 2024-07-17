<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 05/07/2024
  Time: 3:24 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thông tin Session</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"
            integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"
            integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF"
            crossorigin="anonymous"></script>
</head>
<body>
<h1>Thông tin Session</h1>
<%
    Enumeration<String> attributeNames = session.getAttributeNames();
%>
<table class="table">
    <thead>
    <tr>
        <th scope="col">Tên session</th>
        <th scope="col">Giá trị</th>

    </tr>
    </thead>
    <tbody>
    <%
        while (attributeNames.hasMoreElements()) {
            String attributeName = attributeNames.nextElement();
            Object attributeValue = session.getAttribute(attributeName);

    %>
    <tr>
        <th scope="row"><%=attributeName%></th>
        <td> <%=attributeValue%></td>
    </tr>
    <%}%>
    </tbody>
</table>
<table class="table">
    <thead>
    <tr>
        <th scope="col">Tên thuộc tính</th>
        <th scope="col">Giá trị</th>
    </tr>
    </thead>
    <tbody>
    <%
        java.util.Enumeration<String> attributeNamesReq = request.getAttributeNames();
        while (attributeNamesReq.hasMoreElements()) {
            String attributeName = attributeNames.nextElement();
            Object attributeValue = request.getAttribute(attributeName);
    %>
    <tr>
        <th scope="row"><%= attributeName %></th>
        <td><%= attributeValue %></td>
    </tr>
    <%
        }
    %>
    </tbody>
</table>





</body>
</html>

