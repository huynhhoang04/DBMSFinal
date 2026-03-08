<%--
  Created by IntelliJ IDEA.
  User: huynh
  Date: 03/03/2026
  Time: 10:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/views/layouts/header.jsp" />

<div class="theatre-detail-wrapper" style="background-image: url('${theatre.preview_url}');">

    <div class="theatre-content-box">

        <h1 class="theatre-title-large">${theatre.theatre_name}</h1>
        <div class="theatre-meta-info">
            <span style="margin-right: 20px;">📍 ${theatre.location}</span>
            <span class="status-badge ${theatre.theatre_status == 'OPEN' ? 'status-open' : 'status-close'}">
                Trạng thái: ${theatre.theatre_status}
            </span>
        </div>

        <div class="theatre-description" style="line-height: 1.8; color: #ddd; text-align: justify;">
            <p>${theatre.info}</p>
        </div>

        <div class="theatre-section">
            <h2 class="section-title">Bản đồ vị trí</h2>
            <div class="map-container">
                <iframe src="https://maps.google.com/maps?q=${theatre.coordinates}&hl=vi&z=16&output=embed" allowfullscreen></iframe>
            </div>
        </div>

        <div class="theatre-section">
            <h2 class="section-title">Danh sách phòng chiếu</h2>

            <div class="rooms-grid">
                <c:forEach var="room" items="${rooms}">
                    <div class="room-card">
                        <h4>${room.room_name}</h4>
                        <p style="color: #ccc; font-size: 0.9rem; margin-bottom: 10px;">
                            Sức chứa: ${room.capacity} ghế
                        </p>

                        <c:choose>
                            <c:when test="${room.room_type == 'PRO MAX'}">
                                <span class="room-type-tag tag-imax">${room.room_type}</span>
                            </c:when>
                            <c:when test="${room.room_type == 'VIP'}">
                                <span class="room-type-tag tag-vip">${room.room_type}</span>
                            </c:when>
                            <c:otherwise>
                                <span class="room-type-tag tag-standard">${room.room_type}</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:forEach>

                <c:if test="${empty rooms}">
                    <p style="color: #888; text-align: center; width: 100%;">Rạp này hiện chưa có phòng chiếu nào.</p>
                </c:if>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/views/layouts/footer.jsp" />