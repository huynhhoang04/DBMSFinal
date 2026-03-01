<%--
  Created by IntelliJ IDEA.
  User: huynh
  Date: 01/03/2026
  Time: 04:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Cinema</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
<header>
    <h2>Cinema</h2>
    <nav>
        <a href="${pageContext.request.contextPath}/home">Trang Chủ</a>
        <div class="dropdown">
            <a href="#" class="dropbtn">Phim ▾</a>

            <div class="dropdown-content">
                <a href="${pageContext.request.contextPath}/movie?status=available&page=1">Phim Đang Chiếu</a>
                <a href="${pageContext.request.contextPath}/movie?status=upcoming&page=1">Phim Sắp Chiếu</a>
            </div>
        </div>
        <a href="${pageContext.request.contextPath}/theatre">Rạp Phim</a>
        <a href="${pageContext.request.contextPath}/auth">Đăng Nhập/Đăng Ký</a>
    </nav>
</header>

<hr>
<main style="padding: 20px;">
