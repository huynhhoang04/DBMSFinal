package controller;

import dao.ArticleDAO;
import dao.MovieDAO;
import dao.impl.ArticleDAOImpl;
import dao.impl.MovieDAOImpl;
import dto.ArticleThumnailDTO;
import dto.MovieThumnailDTO;
import model.Movie;
import service.ArticleSevrvices;
import service.MovieServices;
import service.impl.ArticleServicesImpl;
import service.impl.MovieServiesImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "Home", value = "/home")
public class Home extends HttpServlet {
    private MovieServices movieServices;
    private ArticleSevrvices articleServices;

    @Override
    public void init() throws ServletException {
        MovieDAO movieDAO = new MovieDAOImpl();
        ArticleDAO articleDAO = new ArticleDAOImpl();

        this.movieServices = new MovieServiesImpl(movieDAO);
        this.articleServices = new ArticleServicesImpl(articleDAO);
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        List<MovieThumnailDTO> movieDtos = movieServices.getTop7NewestMovies();
        List<ArticleThumnailDTO> articlesDtos = articleServices.getTop3Articles();
        request.setAttribute("topMovies", movieDtos);
        request.setAttribute("topArticles", articlesDtos);
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
}
