<%--
  Created by IntelliJ IDEA.
  User: huynh
  Date: 01/03/2026
  Time: 04:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Cinema</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=1">
</head>
<body>
<header>
    <h2>Cinema</h2>
    <nav style="display: flex; align-items: center; justify-content: flex-end;">
        <a href="${pageContext.request.contextPath}/home">Trang Chủ</a>
        <div class="dropdown">
            <a href="#" class="dropbtn">Phim ▾</a>

            <div class="dropdown-content">
                <a href="${pageContext.request.contextPath}/movie?status=available&keyword=&tag=&page=1">Phim Đang Chiếu</a>
                <a href="${pageContext.request.contextPath}/movie?status=upcoming&keyword=&tag=&page=1">Phim Sắp Chiếu</a>
            </div>
        </div>
        <a href="${pageContext.request.contextPath}/theatre">Rạp Phim</a>
        <div class="header-auth-section"> <c:choose>
                <%-- ĐÃ ĐĂNG NHẬP --%>
            <c:when test="${not empty sessionScope.currentUser}">

            <div class="user-menu" style="display: flex; gap: 15px; align-items: center;">
                <a href="${pageContext.request.contextPath}/profile" style="color: #fff; text-decoration: none; font-weight: bold;">
                    👤 Xin chào, <span style="color: #e50914;">${sessionScope.currentUser.full_name}</span>
                </a>

                <a href="${pageContext.request.contextPath}/auth?action=logout"
                   style="color: #ccc; font-size: 0.9rem; text-decoration: none; padding-left: 15px; border-left: 1px solid #444;">
                    Đăng xuất
                </a>
            </div>

            </c:when>

                <%-- CHƯA ĐĂNG NHẬP --%>
            <c:otherwise>

            <a href="${pageContext.request.contextPath}/auth?action=login" style="color: white; text-decoration: none;">Đăng Nhập/Đăng Ký</a>

            </c:otherwise>
            </c:choose>
    </nav>
</header>

<hr>
<main style="padding: 0;">
