<%--
  Created by IntelliJ IDEA.
  User: huynh
  Date: 01/03/2026
  Time: 12:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/views/layouts/header.jsp" />

<div class="article-detail-container">
    <a href="${pageContext.request.contextPath}/home" class="btn-back">
        &#8592; Quay lại trang chủ
    </a>

    <h1 class="article-main-title">${article.title}</h1>

    <div class="article-meta-info">
        <span>📅 Ngày đăng: ${article.created_at}</span>
    </div>

    <div class="article-hero-image">
        <img src="${article.image_url}" alt="${article.title}">
    </div>

    <div class="article-full-content">
        ${article.content}
    </div>
</div>

<jsp:include page="/views/layouts/footer.jsp" />
