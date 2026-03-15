<%--
  Created by IntelliJ IDEA.
  User: huynh
  Date: 10/03/2026
  Time: 18:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thanh Toán - PTIT Cinema</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=2">
</head>
<body>

<div class="payment-container">
    <div class="payment-card">

        <c:if test="${not empty error}">
            <div class="alert alert-error">
                <strong>⚠️ Cảnh báo:</strong> ${error}
            </div>
        </c:if>

        <c:if test="${not empty successMessage}">
            <div class="alert alert-success">
                <div class="success-icon">✓</div>
                <h3>Giao dịch thành công!</h3>
                <p>${successMessage}</p>
                <a href="${pageContext.request.contextPath}/profile?tab=history" class="btn btn-primary mt-20">
                    Xem Vé Của Tôi
                </a>
            </div>
        </c:if>

        <c:if test="${empty successMessage}">
            <div class="qr-header">
                <h2>Thanh Toán Hóa Đơn</h2>
                <p>Mã đơn hàng: <strong>#${bookingId}</strong></p>
            </div>

            <div class="qr-body">
                <p class="instruction">Vui lòng dùng App Ngân hàng hoặc Momo quét mã QR bên dưới để thanh toán.</p>

                <div class="qr-image-wrapper">
                    <img src="assets/img/payQR.png" alt="Mã QR Thanh Toán">
                </div>
            </div>

            <form action="${pageContext.request.contextPath}/pay" method="POST" id="payForm" class="qr-footer">
                <input type="hidden" name="booking_id" value="${bookingId}">

                <button type="submit" class="btn btn-success" id="btnConfirmPay">
                    TÔI ĐÃ CHUYỂN KHOẢN
                </button>

                <a href="${pageContext.request.contextPath}/profile?tab=history" class="btn-cancel">
                    Thanh toán sau
                </a>
            </form>
        </c:if>

    </div>
</div>

<script src="${pageContext.request.contextPath}/assets/js/main.js?v=2"></script>
</body>
</html>
