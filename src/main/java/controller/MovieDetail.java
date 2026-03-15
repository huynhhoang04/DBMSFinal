package main.java.controller;

import main.java.dao.MovieDAO;
import main.java.dao.ShowtimeDAO;
import main.java.dao.impl.MovieDAOImpl;
import main.java.dao.impl.ShowtimeDAOImpl;
import main.java.dto.MovieDetailDTO;
import main.java.service.MovieServices;
import main.java.service.ShowtimeServices;
import main.java.service.impl.MovieServiesImpl;
import main.java.service.impl.ShowtimeServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "Movie Detail", value = "/movie-detail")
public class MovieDetail extends HttpServlet {
    private MovieServices movieServices;
    private ShowtimeServices showtimeServices;

    @Override
    public void init() throws ServletException {
        MovieDAO movieDAO = new MovieDAOImpl();
        ShowtimeDAO showtimeDAO = new ShowtimeDAOImpl();

        this.movieServices = new MovieServiesImpl(movieDAO);
        this.showtimeServices = new ShowtimeServiceImpl(showtimeDAO);
    }

    @Override
    public void doGet(HttpServletRequest request,  HttpServletResponse response) throws ServletException, IOException {
        try {
            String idRaw = request.getParameter("id");

            if (idRaw != null && !idRaw.isEmpty()) {
                int movieId = Integer.parseInt(idRaw);
                MovieDetailDTO movie = movieServices.getMovieById(movieId);

                if (movie != null) {
                    request.setAttribute("movie", movie);
                    request.getRequestDispatcher("/views/movie-detail.jsp").forward(request, response);
                } else {
                    response.sendRedirect(request.getContextPath() + "/home");
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/home");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }
}
