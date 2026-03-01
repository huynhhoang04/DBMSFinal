package controller;

import dao.MovieDAO;
import dao.impl.MovieDAOImpl;
import dto.MovieThumnailDTO;
import service.MovieServices;
import service.impl.MovieServiesImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
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
        try {
            String status = request.getParameter("status");
            String pageRaw = request.getParameter("page");
            if(pageRaw != null && !pageRaw.isEmpty() && status != null && !status.isEmpty()){
                int page = Integer.parseInt(pageRaw);
                List<MovieThumnailDTO> movies = movieServices.getMovieByStatusAndPage(status, page);
                int totalMovie = movieServices.countMovieByStatus(status);
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
