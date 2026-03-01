package service;

import dto.ArticleDetailDTO;
import dto.ArticleThumnailDTO;

import java.util.List;

public interface ArticleSevrvices {
    List<ArticleThumnailDTO> getTop3Articles();
    ArticleDetailDTO getArticleById(int id);
}
