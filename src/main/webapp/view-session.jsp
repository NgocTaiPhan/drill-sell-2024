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
</head>
<body>
<h1>Thông tin Session</h1>
<%
    Enumeration<String> attributeNames = session.getAttributeNames();
%>
<p>
    Session ID:  <%=session.getId()%>
</p><br>
<p>
    Creation Time: <%=new java.util.Date(session.getCreationTime())%>
</p><br>
<p>
    Last Accessed Time:  <%=new java.util.Date(session.getLastAccessedTime())%>
</p><br>
<p>
    Max Inactive Interval:  <%=session.getMaxInactiveInterval()%> + giây
</p><br>
<h2>Session Attributes</h2>
<%
    while (attributeNames.hasMoreElements()) {
        String attributeName = attributeNames.nextElement();
        Object attributeValue = session.getAttribute(attributeName);

%>
<p>" + <%=attributeName%> + ": " + <%=attributeValue%> + "</p>
<%}%>
</body>
</html>

