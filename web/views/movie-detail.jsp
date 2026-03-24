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

<div class="container-detail" style="padding: 40px 20px; max-width: 1200px; margin: auto;">
    <div class="movie-hero" style="display: flex; gap: 40px; align-items: flex-start; margin-bottom: 50px; flex-wrap: wrap;">
        <div class="movie-poster-large" style="flex: 1; min-width: 300px; max-width: 400px;">
            <img src="${movie.poster_url}" alt="${movie.title}" style="width: 100%; border-radius: 12px; box-shadow: 0 10px 30px rgba(0,0,0,0.5);">
        </div>

        <div class="movie-info-detail" style="flex: 2; min-width: 300px; color: #fff;">
            <h1 class="movie-title-large" style="font-size: 2.5rem; margin-bottom: 20px; color: #e50914; text-transform: uppercase;">
                ${movie.title}
            </h1>

            <div class="movie-meta" style="background: rgba(255,255,255,0.05); padding: 25px; border-radius: 8px; margin-bottom: 25px; display: flex; flex-direction: column; gap: 12px; border: 1px solid rgba(255,255,255,0.1);">
                <span class="info-item" style="font-size: 1.1rem;">🎬 <strong>Thể loại:</strong> <span style="color: #aaa;">${movie.genre}</span></span>

                <c:if test="${not empty movie.directors}">
                    <span class="info-item" style="font-size: 1.1rem;">🎥 <strong>Đạo diễn:</strong> <span style="color: #58a6ff; font-weight: bold;">${movie.directors}</span></span>
                </c:if>

                <c:if test="${not empty movie.actors}">
                    <span class="info-item" style="font-size: 1.1rem;">🌟 <strong>Diễn viên:</strong> <span style="color: #aaa;">${movie.actors}</span></span>
                </c:if>

                <c:if test="${not empty movie.seriesName}">
                    <span class="info-item" style="font-size: 1.1rem;">🌌 <strong>Thuộc series:</strong> <span style="color: #2ea043; font-weight: bold; text-decoration: underline;">${movie.seriesName}</span></span>
                </c:if>

                <span class="info-item" style="font-size: 1.1rem;">⏳ <strong>Thời lượng:</strong> <span style="color: #aaa;">${movie.duration} phút</span></span>
                <span class="info-item" style="font-size: 1.1rem;">📅 <strong>Khởi chiếu:</strong> <span style="color: #aaa;">${movie.release_date}</span></span>
            </div>

            <div class="movie-description" style="margin-bottom: 30px;">
                <h3 style="border-bottom: 2px solid #e50914; display: inline-block; padding-bottom: 5px; margin-bottom: 15px;">Nội dung phim</h3>
                <p style="line-height: 1.8; color: #ccc; font-size: 1.05rem; text-align: justify;">${movie.description}</p>
            </div>

            <div class="movie-actions">
                <button onclick="openBookingModal(${movie.movie_id})" class="btn-booking"
                        style="border: none; cursor: pointer; font-family: inherit; font-size: 1.2rem; background: linear-gradient(90deg, #e50914, #b20710); color: white; padding: 15px 40px; border-radius: 8px; font-weight: bold; box-shadow: 0 4px 15px rgba(229, 9, 20, 0.4); transition: transform 0.2s;">
                    🎟️ ĐẶT VÉ NGAY
                </button>
            </div>
        </div>
    </div>

    <c:if test="${not empty movie.trailer_url}">
        <div class="movie-trailer-section" style="margin-top: 50px;">
            <h2 class="section-title" style="color: #fff; border-left: 5px solid #e50914; padding-left: 15px; margin-bottom: 20px;">🎬 Trailer Chính Thức</h2>
            <div class="video-container" style="position: relative; padding-bottom: 56.25%; height: 0; overflow: hidden; border-radius: 12px; box-shadow: 0 10px 30px rgba(0,0,0,0.5);">
                <iframe src="${movie.trailer_url}"
                        style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; border: none;"
                        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen>
                </iframe>
            </div>
        </div>
    </c:if>
</div>

<div id="bookingModal" class="booking-modal">
    <div class="booking-modal-content">
        <span class="close-modal-btn" onclick="closeBookingModal()">&times;</span>
        <h2 class="modal-header-title">Lịch Chiếu: ${movie.title}</h2>

        <div class="date-list" id="dateListContainer"></div>

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
