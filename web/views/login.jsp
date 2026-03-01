<%--
  Created by IntelliJ IDEA.
  User: huynh
  Date: 01/03/2026
  Time: 04:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:include page="/views/layouts/header.jsp" />

<h3>Đăng nhập hệ thống</h3>

<p style="color: red; font-weight: bold;">${errorMsg}</p>

<form action="${pageContext.request.contextPath}/login" method="post">
    Tài khoản: <br>
    <input type="text" name="txtUsername" required> <br><br>

    Mật khẩu: <br>
    <input type="password" name="txtPassword" required> <br><br>

    <button type="submit" style="padding: 5px 15px;">Đăng nhập ngay</button>
</form>

<jsp:include page="/views/layouts/footer.jsp" />
