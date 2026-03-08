package main.java.controller;

import main.java.dao.MovieDAO;
import main.java.dao.impl.MovieDAOImpl;
import main.java.dto.MovieThumnailDTO;
import main.java.service.MovieServices;
import main.java.service.impl.MovieServiesImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "Movie", value = "/movie")
public class Movie extends HttpServlet {
    private MovieServices movieServices;

    @Override
    public void init() {
        MovieDAO movieDAO = new MovieDAOImpl();

        this.movieServices = new MovieServiesImpl(movieDAO);
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        try {
            String status = request.getParameter("status");
            String pageRaw = request.getParameter("page");
            String keywordRaw = request.getParameter("keyword");
            String tagRaw = request.getParameter("tag");
            if(pageRaw != null && !pageRaw.isEmpty() && status != null && !status.isEmpty()){
                int page = Integer.parseInt(pageRaw);
                List<MovieThumnailDTO> movies = movieServices.getMovieByStatusAndPage(status, page, keywordRaw, tagRaw);
                int totalMovie = movieServices.countMovieByStatus(status, keywordRaw, tagRaw);
                int totalPage;
                if(totalMovie % 8 ==0){totalPage = totalMovie / 8;}
                else{totalPage = totalMovie / 8 + 1;}
                if(!movies.isEmpty()){
                    request.setAttribute("movies", movies);
                    request.setAttribute("totalPage", totalPage);
                    request.getRequestDispatcher("/views/movie.jsp").forward(request, response);
                }
                else {
                    response.sendRedirect(request.getContextPath() + "/home");
                }
            }
        } catch (NullPointerException e ) {
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }
}
