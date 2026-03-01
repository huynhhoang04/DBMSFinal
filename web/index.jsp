<%--
  Created by IntelliJ IDEA.
  User: huynh
  Date: 01/03/2026
  Time: 04:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/views/layouts/header.jsp" />

<h2>Phim Hot!</h2>
<div class="movie-list">
    <c:forEach items="${topMovies}" var="movie">
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
<h2>Bài Viết Mới!!</h2>
<div class="article-list">
    <c:forEach items="${topArticles}" var="article">
        <div class="article-card">
            <a href="${pageContext.request.contextPath}/article-detail?id=${article.article_id}" class="article-link">
                <div class="article-image">
                    <img src="${article.image_url}" alt="${article.title}">
                </div>
                <div class="article-content">
                    <h3 class="article-title">${article.title}</h3>
                    <p class="article-summary">${article.summary}</p>
                </div>
            </a>
        </div>
    </c:forEach>
</div>
<jsp:include page="/views/layouts/footer.jsp" />
