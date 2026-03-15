package main.java.controller;


import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import main.java.dao.ShowtimeDAO;
import main.java.dao.impl.ShowtimeDAOImpl;
import main.java.dto.ShowtimeDetailDTO;
import main.java.service.ShowtimeServices;
import main.java.service.impl.ShowtimeServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet(name = "MoviwShowtimeAPI", value = "/api/movie/showtimes")
public class MovieShowtimeAPI extends HttpServlet {
    private ShowtimeServices showtimeServices;

    @Override
    public void init() throws ServletException {
        ShowtimeDAO showtimeDAO = new ShowtimeDAOImpl();
        this.showtimeServices = new ShowtimeServiceImpl(showtimeDAO);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            int movieId = Integer.parseInt(request.getParameter("id"));
            String dateRaw = request.getParameter("date");
            String city = request.getParameter("city");
            Date date = new SimpleDateFormat("yyyy-MM-dd").parse(dateRaw);
            List<ShowtimeDetailDTO> showtimes = showtimeServices.getMovieShowtimes(date, movieId, city);

            Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
            String jsonOutput = gson.toJson(showtimes);
            System.out.println(jsonOutput);

            response.getWriter().write(jsonOutput);
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\": \"Lỗi\"}");
        }
    }
}
