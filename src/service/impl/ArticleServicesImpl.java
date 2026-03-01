package service.impl;

import dao.ArticleDAO;
import dto.ArticleDetailDTO;
import dto.ArticleThumnailDTO;
import model.Articles;
import service.ArticleSevrvices;

import java.util.ArrayList;
import java.util.List;

public class ArticleServicesImpl implements ArticleSevrvices {
    private final ArticleDAO articleDAO;

    public ArticleServicesImpl(ArticleDAO articleDAO) {
        this.articleDAO = articleDAO;
    }


    @Override
    public List<ArticleThumnailDTO> getTop3Articles() {
        List<Articles> articles = articleDAO.getTop3Articles();
        List<ArticleThumnailDTO> dtos = new ArrayList<>();
        articles.forEach(article -> {
            dtos.add(new  ArticleThumnailDTO(article.getArticle_id(), article.getTitle(), article.getSummary(), article.getImage_url()));
        });
        return dtos;
    }

    @Override
    public ArticleDetailDTO getArticleById(int id) {
        Articles articles = articleDAO.getArticleDetailById(id);
        ArticleDetailDTO articleDetailDTO = new ArticleDetailDTO(articles.getArticle_id(), articles.getTitle(), articles.getContent(), articles.getImage_url(), articles.getCreated_at());
        return articleDetailDTO;
    }
}
