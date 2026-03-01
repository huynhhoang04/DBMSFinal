package dao;

import model.Articles;

import java.util.List;

public interface ArticleDAO {
    List<Articles> getTop3Articles();
    Articles getArticleDetailById(int id);
}
