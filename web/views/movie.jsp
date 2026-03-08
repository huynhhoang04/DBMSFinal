<%--
  Created by IntelliJ IDEA.
  User: huynh
  Date: 01/03/2026
  Time: 14:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--<%@ page import="java.net.URLEncoder" %>--%>
<jsp:include page="/views/layouts/header.jsp" />

<div class="movie-page-container">
    <h1 class="page-title">
        <c:choose>
            <c:when test="${param.status == 'available'}">PHIM ĐANG CHIẾU</c:when>
            <c:when test="${param.status == 'upcoming'}">PHIM SẮP CHIẾU</c:when>
            <c:otherwise>DANH SÁCH PHIM</c:otherwise>
        </c:choose>
    </h1>
    <div class="search-container" style="margin-bottom: 30px; text-align: right;">
        <form action="${pageContext.request.contextPath}/movie" method="GET" accept-charset="UTF-8">
            <input type="hidden" name="status" value="${param.status}">

            <select name="tag" style="padding: 10px; border-radius: 4px; background: #333; color: white; border: none; outline: none;">
                <option value="">-- Tất cả thể loại --</option>
                <option value="Âm Nhạc" ${param.tag == 'Âm Nhạc' ? 'selected' : ''}>Âm Nhạc</option>
                <option value="Bí ẩn" ${param.tag == 'Bí ẩn' ? 'selected' : ''}>Bí ẩn</option>
                <option value="Chiến Tranh" ${param.tag == 'Chiến Tranh' ? 'selected' : ''}>Chiến Tranh</option>
                <option value="Chính kịch" ${param.tag == 'Chính kịch' ? 'selected' : ''}>Chính kịch</option>
                <option value="Cổ Trang" ${param.tag == 'Cổ Trang' ? 'selected' : ''}>Cổ Trang</option>
                <option value="Đời Thường" ${param.tag == 'Đời Thường' ? 'selected' : ''}>Đời Thường</option>
                <option value="Gay Cấn" ${param.tag == 'Gay Cấn' ? 'selected' : ''}>Gay Cấn</option>
                <option value="Gia Đình" ${param.tag == 'Gia Đình' ? 'selected' : ''}>Gia Đình</option>
                <option value="Giả Tượng" ${param.tag == 'Giả Tượng' ? 'selected' : ''}>Giả Tượng</option>
                <option value="Hài Hước" ${param.tag == 'Hài Hước' ? 'selected' : ''}>Hài Hước</option>
                <option value="Hành Động" ${param.tag == 'Hành Động' ? 'selected' : ''}>Hành Động</option>
                <option value="Hình Sự" ${param.tag == 'Hình Sự' ? 'selected' : ''}>Hình Sự</option>
                <option value="Hoạt Hình" ${param.tag == 'Hoạt Hình' ? 'selected' : ''}>Hoạt Hình</option>
                <option value="Học Đường" ${param.tag == 'Học Đường' ? 'selected' : ''}>Học Đường</option>
                <option value="Khoa Học" ${param.tag == 'Khoa Học' ? 'selected' : ''}>Khoa Học</option>
                <option value="Viễn tưởng" ${param.tag == 'Viễn tưởng' ? 'selected' : ''}>Viễn tưởng</option>
                <option value="Kinh Dị" ${param.tag == 'Kinh Dị' ? 'selected' : ''}>Kinh Dị</option>
                <option value="Kỳ Ảo" ${param.tag == 'Kỳ Ảo' ? 'selected' : ''}>Kỳ Ảo</option>
                <option value="Lịch Sử" ${param.tag == 'Lịch Sử' ? 'selected' : ''}>Lịch Sử</option>
                <option value="Phiêu Lưu" ${param.tag == 'Phiêu Lưu' ? 'selected' : ''}>Phiêu Lưu</option>
                <option value="Tài Liệu" ${param.tag == 'Tài Liệu' ? 'selected' : ''}>Tài Liệu</option>
                <option value="Tâm Linh" ${param.tag == 'Tâm Linh' ? 'selected' : ''}>Tâm Linh</option>
                <option value="Tâm Lý" ${param.tag == 'Tâm Lý' ? 'selected' : ''}>Tâm Lý</option>
                <option value="Thần Thoại" ${param.tag == 'Thần Thoại' ? 'selected' : ''}>Thần Thoại</option>
                <option value="Thể Thao" ${param.tag == 'Thể Thao' ? 'selected' : ''}>Thể Thao</option>
                <option value="Tình Cảm" ${param.tag == 'Tình Cảm' ? 'selected' : ''}>Tình Cảm</option>
                <option value="Trẻ Em" ${param.tag == 'Trẻ Em' ? 'selected' : ''}>Trẻ Em</option>
                <option value="Trinh thám" ${param.tag == 'Trinh thám' ? 'selected' : ''}>Trinh thám</option>
                <option value="Võ Thuật" ${param.tag == 'Võ Thuật' ? 'selected' : ''}>Võ Thuật</option>
                <option value="P" ${param.tag == 'P' ? 'selected' : ''}>P (Mọi lứa tuổi)</option>
                <option value="K" ${param.tag == 'K' ? 'selected' : ''}>K (Dưới 13t xem cùng cha mẹ)</option>
                <option value="T13" ${param.tag == 'T13' ? 'selected' : ''}>T13 (Từ 13 tuổi)</option>
                <option value="T16" ${param.tag == 'T16' ? 'selected' : ''}>T16 (Từ 16 tuổi)</option>
                <option value="T18" ${param.tag == 'T18' ? 'selected' : ''}>T18 (Từ 18 tuổi)</option>
            </select>
            <input type="text" name="keyword" value="${param.keyword}"
                   placeholder="Nhập tên phim cần tìm..."
                   style="padding: 10px 15px; width: 300px; border-radius: 4px; border: none; background: #333; color: white; outline: none;">

            <input type="hidden" name="page" value="1" />
            <button type="submit" style="padding: 10px 20px; background: #e50914; color: white; border: none; border-radius: 4px; cursor: pointer; font-weight: bold;">
                Tìm Kiếm
            </button>
        </form>
    </div>

    <div class="movie-list">
        <c:forEach items="${movies}" var="movie">
            <div class="movie-card">

                <a href="${pageContext.request.contextPath}/movie-detail?id=${movie.movie_id}" style="text-decoration: none; color: inherit;">
                    <img src="${movie.poster_url}" alt="${movie.title}" class="movie-poster">

                    <div class="movie-info">
                        <h4>${movie.title}</h4>
                        <p style="color: #aaa; font-size: 14px;">Thời lượng: ${movie.duration} phút</p>
                    </div>
                </a>

            </div>
        </c:forEach>
    </div>

    <div class="pagination-container">
        <c:set var="currentPage" value="${empty param.page ? 1 : param.page}" />
        <c:if test="${currentPage > 1}">
            <a href="?status=${param.status}&tag=${param.tag}&keyword=${param.keyword}&page=${currentPage - 1}" class="pagination-link nav-btn">
                &laquo; Trước
            </a>
        </c:if>
        <c:forEach begin="1" end="${totalPage}" var="i">
            <a href="${pageContext.request.contextPath}/movie?status=${param.status}&tag=${param.tag}&keyword=${param.keyword}&page=${i}"
               class="page-link ${param.page == i ? 'active' : ''}">
                    ${i}
            </a>
        </c:forEach>
        <c:if test="${currentPage < totalPage}">
            <a href="?status=${param.status}&tag=${param.tag}&keyword=${param.keyword}&page=${currentPage + 1}" class="pagination-link nav-btn">
                Tiếp &raquo;
            </a>
        </c:if>
    </div>
</div>

<jsp:include page="/views/layouts/footer.jsp" />