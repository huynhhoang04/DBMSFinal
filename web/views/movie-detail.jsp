<%--
  Created by IntelliJ IDEA.
  User: huynh
  Date: 01/03/2026
  Time: 10:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/views/layouts/header.jsp" />

<div class="container-detail">
    <div class="movie-hero">
        <div class="movie-poster-large">
            <img src="${movie.poster_url}" alt="${movie.title}">
        </div>

        <div class="movie-info-detail">
            <h1 class="movie-title-large">${movie.title}</h1>

            <div class="movie-meta">
                <span class="info-item"><strong>Thể loại:</strong> ${movie.genre}</span>
                <span class="info-item"><strong>Thời lượng:</strong> ${movie.duration} phút</span>
                <span class="info-item"><strong>Khởi chiếu:</strong> ${movie.release_date}</span>
            </div>

            <div class="movie-description">
                <h3>Nội dung phim</h3>
                <p>${movie.description}</p>
            </div>

            <div class="movie-actions">
                <button onclick="openBookingModal(${movie.movie_id})" class="btn-booking" style="border: none; cursor: pointer; font-family: inherit; font-size: 1.1rem;">
                    🎟️ ĐẶT VÉ NGAY
                </button>
            </div>
        </div>
    </div>

    <c:if test="${not empty movie.trailer_url}">
        <div class="movie-trailer-section">
            <h2 class="section-title">Trailer</h2>
            <div class="video-container">
                <iframe src="${movie.trailer_url}" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
            </div>
        </div>
    </c:if>
</div>

<div id="bookingModal" class="booking-modal">
    <div class="booking-modal-content">
        <span class="close-modal-btn" onclick="closeBookingModal()">&times;</span>
        <h2 class="modal-header-title">Lịch Chiếu: ${movie.title}</h2>

        <div class="date-list" id="dateListContainer">
        </div>

        <div class="city-list" id="cityListContainer">
            <div class="city-item active" onclick="selectCity(this, 'Hà Nội')">Hà Nội</div>
            <div class="city-item" onclick="selectCity(this, 'TP. Hồ Chí Minh')">TP. Hồ Chí Minh</div>
        </div>

        <div class="theatre-list" id="theatreListContainer">
            <div style="text-align:center; color:#888; padding: 20px;">
                Đang tải lịch chiếu...
            </div>
        </div>
    </div>
</div>


<jsp:include page="/views/layouts/footer.jsp" />
