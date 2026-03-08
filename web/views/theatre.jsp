<%--
  Created by IntelliJ IDEA.
  User: huynh
  Date: 02/03/2026
  Time: 12:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/views/layouts/header.jsp" />
<div class="city-tabs-container" style="text-align: left; margin-bottom: 40px; margin-top: 30px;">
    <h2 style="color: white; margin-bottom: 20px; text-transform: uppercase;">Hệ Thống Rạp Cinema</h2>

    <div class="city-buttons" style="display: flex; justify-content: center; gap: 15px; flex-wrap: wrap;">
        <c:forEach var="city" items="${cities}">
            <a href="?city=${city}"
               class="city-tab-btn ${city == selectedCity ? 'active' : ''}">
                    ${city}
            </a>
        </c:forEach>
    </div>
</div>
<div class="theatre-grid" style="display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 30px; max-width: 1200px; margin: 0 auto; padding: 0 20px;">
    <c:forEach var="t" items="${theatres}">
        <div class="theatre-card" style="background: #1a1a1a; border-radius: 12px; overflow: hidden; transition: 0.3s; border: 1px solid #333;">
            <div class="theatre-img" style="height: 200px; width: 100%;">
                <img src="${t.preview_url}" alt="${t.theatre_name}" style="width: 100%; height: 100%; object-fit: cover;">
            </div>
            <div class="theatre-info" style="padding: 20px;">
                <h3 style="color: #e50914; margin-bottom: 10px;">${t.theatre_name}</h3>
                <p style="color: #ccc; font-size: 14px; margin-bottom: 15px;">📍 ${t.location}</p>
                <a href="${pageContext.request.contextPath}/theatre-detail?id=${t.theatre_id}"
                   class="btn-view-theatre" style="display: block; text-align: center; background: #333; color: white; padding: 10px; border-radius: 6px; text-decoration: none; font-weight: bold; transition: 0.3s;">
                    Xem Lịch Chiếu
                </a>
            </div>
        </div>
    </c:forEach>
</div>
<jsp:include page="/views/layouts/footer.jsp" />
