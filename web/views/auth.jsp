<%--
  Created by IntelliJ IDEA.
  User: huynh
  Date: 03/03/2026
  Time: 17:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${param.action == 'register' ? 'Đăng Ký' : 'Đăng Nhập'} - PTIT Cinema</title>
    <style>
        /* Reset cơ bản */
        body, html {
            margin: 0; padding: 0; height: 100%;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #000; color: #fff;
        }

        /* Nền mờ phong cách rạp phim */
        .auth-wrapper {
            display: flex; justify-content: center; align-items: center;
            min-height: 100vh;
            /* Đổi link ảnh này thành ảnh rạp sếp thích nếu muốn */
            background-image: url('https://assets.nflxext.com/ffe/siteui/vlv3/9d3533b2-0e2b-40b2-95e0-eca79024afe0/en/VN-en-20240415-popsignuptwoweeks-perspective_alpha_website_large.jpg');
            background-size: cover; background-position: center; position: relative;
        }

        .auth-wrapper::before {
            content: ''; position: absolute;
            top: 0; left: 0; right: 0; bottom: 0;
            background: rgba(0, 0, 0, 0.6); /* Phủ đen 60% */
        }

        /* Cái thẻ Form ở giữa */
        .auth-box {
            position: relative; z-index: 1;
            background: rgba(0, 0, 0, 0.8);
            padding: 60px 68px 40px;
            border-radius: 8px; width: 100%; max-width: 450px;
            box-sizing: border-box;
            box-shadow: 0 15px 40px rgba(0,0,0,0.8);
        }

        .auth-box h2 {
            margin: 0 0 28px; font-size: 2rem; color: #fff;
        }

        /* Các ô nhập liệu */
        .input-group { margin-bottom: 16px; }

        .input-group input {
            width: 100%; padding: 16px 20px;
            border: 1px solid #333; border-radius: 4px;
            background: #333; color: white;
            box-sizing: border-box; font-size: 1rem;
            transition: 0.3s;
        }

        .input-group input:focus {
            outline: none; background: #444; border-color: #e50914;
        }

        /* Nút Submit */
        .btn-submit {
            width: 100%; padding: 16px;
            background: #e50914; color: white;
            border: none; border-radius: 4px;
            font-size: 1.05rem; font-weight: bold;
            cursor: pointer; margin-top: 24px; transition: 0.3s;
        }

        .btn-submit:hover { background: #f40612; }

        /* Chuyển form Đăng nhập / Đăng ký */
        .auth-switch {
            margin-top: 20px; color: #737373; font-size: 1rem;
        }

        .auth-switch a { color: #fff; text-decoration: none; font-weight: bold; }
        .auth-switch a:hover { text-decoration: underline; }

        /* Hiển thị lỗi từ Servlet ném sang */
        .error-msg {
            background-color: #e87c03; color: white;
            padding: 10px 15px; border-radius: 4px;
            font-size: 0.9rem; margin-bottom: 20px;
        }
    </style>
</head>
<body>

<div class="auth-wrapper">
    <div class="auth-box">
        <c:choose>
            <c:when test="${param.action == 'register'}">
                <h2>Đăng Ký</h2>

                <c:if test="${not empty error}">
                    <div class="error-msg">${error}</div>
                </c:if>

                <form action="${pageContext.request.contextPath}/auth" method="post">
                    <input type="hidden" name="action" value="register">

                    <div class="input-group">
                        <input type="text" name="fullName" placeholder="Họ và tên" required>
                    </div>
                    <div class="input-group">
                        <input type="text" name="username" placeholder="Tên đăng nhập (Username)" required>
                    </div>
                    <div class="input-group">
                        <input type="email" name="email" placeholder="Email" required>
                    </div>
                    <div class="input-group">
                        <input type="password" name="password" placeholder="Mật khẩu" required>
                    </div>
                    <div class="input-group">
                        <input type="password" name="confirmPassword" placeholder="Nhập lại mật khẩu" required>
                    </div>

                    <button type="submit" class="btn-submit">Đăng Ký</button>
                </form>

                <div class="auth-switch">
                    Đã có tài khoản? <a href="?action=login">Đăng nhập ngay</a>.
                </div>
            </c:when>

            <c:otherwise>
                <h2>Đăng Nhập</h2>

                <c:if test="${not empty error}">
                    <div class="error-msg">${error}</div>
                </c:if>
                <c:if test="${not empty message}">
                    <div class="error-msg" style="background-color: #28a745;">${message}</div>
                </c:if>

                <form action="${pageContext.request.contextPath}/auth" method="post">
                    <input type="hidden" name="action" value="login">

                    <div class="input-group">
                        <input type="email" name="email" placeholder="Email" required>
                    </div>
                    <div class="input-group">
                        <input type="password" name="password" placeholder="Mật khẩu" required>
                    </div>

                    <button type="submit" class="btn-submit">Đăng Nhập</button>
                </form>

                <div class="auth-switch">
                    Mới tham gia Cinema? <a href="?action=register">Đăng ký ngay</a>.
                </div>
            </c:otherwise>
        </c:choose>

    </div>
</div>

</body>
</html>
