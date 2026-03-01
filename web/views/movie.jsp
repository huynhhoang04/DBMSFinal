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
    <h1 class="page-title">
        <c:choose>
            <c:when test="${param.status == 'available'}">PHIM ĐANG CHIẾU</c:when>
            <c:when test="${param.status == 'upcoming'}">PHIM SẮP CHIẾU</c:when>
            <c:otherwise>DANH SÁCH PHIM</c:otherwise>
        </c:choose>
    </h1>

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
            <a href="?status=${param.status}&page=${currentPage - 1}" class="pagination-link nav-btn">
                &laquo; Trước
            </a>
        </c:if>
        <c:forEach begin="1" end="${totalPage}" var="i">
            <a href="${pageContext.request.contextPath}/movie?status=${param.status}&page=${i}"
               class="page-link ${param.page == i ? 'active' : ''}">
                    ${i}
            </a>
        </c:forEach>
        <c:if test="${currentPage < totalPage}">
            <a href="?status=${param.status}&page=${currentPage + 1}" class="pagination-link nav-btn">
                Tiếp &raquo;
            </a>
        </c:if>
    </div>
</div>

<jsp:include page="/views/layouts/footer.jsp" />