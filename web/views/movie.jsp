<%--
  Created by IntelliJ IDEA.
  User: huynh
  Date: 01/03/2026
  Time: 14:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/views/layouts/header.jsp" />

<div class="movie-page-container">
    <h1 class="page-title" style="text-align: center; margin-bottom: 20px; color: #fff;">
        <c:choose>
            <c:when test="${currentStatus == 'AVAILABLE'}">PHIM ĐANG CHIẾU</c:when>
            <c:when test="${currentStatus == 'UPCOMING'}">PHIM SẮP CHIẾU</c:when>
            <c:otherwise>DANH SÁCH PHIM</c:otherwise>
        </c:choose>
    </h1>

    <div class="search-container" style="margin-bottom: 40px; text-align: center;">
        <form action="${pageContext.request.contextPath}/movie" method="GET" accept-charset="UTF-8" style="display: inline-flex; gap: 10px; flex-wrap: wrap; justify-content: center;">
            <input type="hidden" name="status" value="${currentStatus}">
            <input type="hidden" name="page" value="1" />

            <select name="tag" style="padding: 12px; border-radius: 6px; background: #222; color: #fff; border: 1px solid #444; outline: none; font-size: 1rem;">
                <option value="">-- Tất cả phân loại --</option>
                <optgroup label="Thể loại phim">
                    <option value="Hành Động" ${currentTag == 'Hành Động' ? 'selected' : ''}>Hành Động</option>
                    <option value="Hài Hước" ${currentTag == 'Hài Hước' ? 'selected' : ''}>Hài Hước</option>
                    <option value="Kinh Dị" ${currentTag == 'Kinh Dị' ? 'selected' : ''}>Kinh Dị</option>
                    <option value="Viễn tưởng" ${currentTag == 'Viễn tưởng' ? 'selected' : ''}>Viễn tưởng</option>
                    <option value="Tâm Lý" ${currentTag == 'Tâm Lý' ? 'selected' : ''}>Tâm Lý</option>
                    <option value="Hoạt Hình" ${currentTag == 'Hoạt Hình' ? 'selected' : ''}>Hoạt Hình</option>
                </optgroup>
                <optgroup label="Phân loại độ tuổi">
                    <option value="P" ${currentTag == 'P' ? 'selected' : ''}>P (Mọi lứa tuổi)</option>
                    <option value="K" ${currentTag == 'K' ? 'selected' : ''}>K (Dưới 13t cần cha mẹ)</option>
                    <option value="T13" ${currentTag == 'T13' ? 'selected' : ''}>T13 (Từ 13 tuổi)</option>
                    <option value="T16" ${currentTag == 'T16' ? 'selected' : ''}>T16 (Từ 16 tuổi)</option>
                    <option value="T18" ${currentTag == 'T18' ? 'selected' : ''}>T18 (Từ 18 tuổi)</option>
                </optgroup>
            </select>

            <input type="text" name="keyword" value="${currentKeyword}"
                   placeholder="Nhập tên phim cần tìm..."
                   style="padding: 12px 15px; width: 350px; border-radius: 6px; border: 1px solid #444; background: #222; color: white; outline: none; font-size: 1rem;">

            <button type="submit" style="padding: 12px 25px; background: #e50914; color: white; border: none; border-radius: 6px; cursor: pointer; font-weight: bold; font-size: 1rem; transition: 0.3s;">
                🔍 Tìm Kiếm
            </button>
        </form>
    </div>

    <c:if test="${empty movies}">
        <div style="text-align: center; color: #888; padding: 50px; font-size: 1.2rem;">
            Không tìm thấy bộ phim nào phù hợp với yêu cầu của bạn! 🎬
        </div>
    </c:if>

    <div class="movie-list">
        <c:forEach items="${movies}" var="movie">
            <div class="movie-card">
                <a href="${pageContext.request.contextPath}/movie-detail?id=${movie.movie_id}" style="text-decoration: none; color: inherit;">
                    <img src="${movie.poster_url}" alt="${movie.title}" class="movie-poster">
                    <div class="movie-info">
                        <h4>${movie.title}</h4>
                        <p style="color: #aaa; font-size: 14px;">⏳ ${movie.duration} phút</p>
                    </div>
                </a>
            </div>
        </c:forEach>
    </div>

    <c:if test="${totalPage > 1}">
        <div class="pagination-container" style="text-align: center; margin-top: 40px;">
            <c:if test="${currentPage > 1}">
                <a href="?status=${currentStatus}&tag=${currentTag}&keyword=${currentKeyword}&page=${currentPage - 1}" class="pagination-link nav-btn">&laquo; Trước</a>
            </c:if>

            <c:forEach begin="1" end="${totalPage}" var="i">
                <a href="?status=${currentStatus}&tag=${currentTag}&keyword=${currentKeyword}&page=${i}"
                   class="page-link ${currentPage == i ? 'active' : ''}"
                   style="${currentPage == i ? 'background: #e50914; color: white;' : 'background: #333; color: #fff;'} padding: 8px 15px; margin: 0 5px; border-radius: 4px; text-decoration: none;">
                        ${i}
                </a>
            </c:forEach>

            <c:if test="${currentPage < totalPage}">
                <a href="?status=${currentStatus}&tag=${currentTag}&keyword=${currentKeyword}&page=${currentPage + 1}" class="pagination-link nav-btn">Tiếp &raquo;</a>
            </c:if>
        </div>
    </c:if>
</div>

<jsp:include page="/views/layouts/footer.jsp" />