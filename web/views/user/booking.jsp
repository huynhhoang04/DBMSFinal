<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chọn Ghế - PTIT Cinema</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=1">
</head>
<body>

<div class="booking-container">

    <div class="seat-map-section">
        <h2>Phòng Chiếu: ${roomInfo.roomName}</h2>
        <div class="screen">MÀN HÌNH CHÍNH</div>

        <div class="seats-grid" id="seatGrid"></div>

        <ul class="showcase">
            <li><div class="seat" style="color: transparent;"></div> Ghế Trống</li>
            <li><div class="seat selected" style="color: white;">A1</div> Đang Chọn</li>
            <li><div class="seat sold">X</div> Đã Bán</li>
        </ul>
    </div>

    <div class="checkout-section">
        <h3>Thông Tin Đặt Vé</h3>

        <c:if test="${not empty error}">
            <div class="error-msg">${error}</div>
        </c:if>

        <div class="info-row">
            <span>Giá vé:</span>
            <span><fmt:formatNumber value="${roomInfo.standardPrice}" pattern="#,###"/> VNĐ</span>
        </div>
        <div class="info-row">
            <span>Ghế đã chọn:</span>
            <span id="selectedSeatsText" style="color: #aaa; word-break: break-all;">Chưa chọn</span>
        </div>
        <div class="info-row" style="margin-top: 30px;">
            <span>Tổng tiền:</span>
            <span class="price-highlight" id="totalPriceText">0 VNĐ</span>
        </div>

        <form action="${pageContext.request.contextPath}/booking" method="POST" id="bookingForm">
            <input type="hidden" name="showtime_id" value="${showtimeId}">
            <input type="hidden" name="total_payment" id="totalPaymentInput" value="0">

            <div id="hiddenSeatsContainer"></div>

            <label for="paymentMethod">Phương thức thanh toán:</label>
            <select name="payment_method" id="paymentMethod">
                <option value="E_WALLET">Ví Điện Tử (Momo/ZaloPay)</option>
                <option value="TRANSFER">Chuyển Khoản Ngân Hàng</option>
                <option value="CARD">Thẻ ATM / Visa</option>
            </select>

            <button type="submit" id="btnSubmit" disabled>XÁC NHẬN ĐẶT VÉ</button>
        </form>
    </div>
</div>

<script>
    const BOOKED_SEATS = ${bookedSeatsJson};
    const TICKET_PRICE = ${roomInfo.standardPrice};
    const ROOM_CAPACITY = ${roomInfo.capacity};
</script>

<script src="${pageContext.request.contextPath}/assets/js/main.js?v=1"></script>

</body>
</html>