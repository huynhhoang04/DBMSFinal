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

            // XỬ LÝ MẶC ĐỊNH AN TOÀN
            if (status == null || status.isEmpty()) {
                status = "AVAILABLE"; // Mặc định là phim đang chiếu
            }
            int page = 1; // Mặc định là trang 1
            if (pageRaw != null && !pageRaw.isEmpty()) {
                page = Integer.parseInt(pageRaw);
            }

            // Gọi Service lấy dữ liệu
            List<MovieThumnailDTO> movies = movieServices.getMovieByStatusAndPage(status, page, keywordRaw, tagRaw);
            int totalMovie = movieServices.countMovieByStatus(status, keywordRaw, tagRaw);

            // Tính số trang nhanh gọn bằng Math.ceil
            int totalPage = (int) Math.ceil((double) totalMovie / 8);

            // Gửi dữ liệu xuống JSP
            request.setAttribute("movies", movies);
            request.setAttribute("totalPage", totalPage);
            request.setAttribute("currentPage", page);

            // Ép kiểu null thành chuỗi rỗng để JSP không bị hiện chữ "null" vào ô tìm kiếm
            request.setAttribute("currentStatus", status);
            request.setAttribute("currentKeyword", keywordRaw != null ? keywordRaw : "");
            request.setAttribute("currentTag", tagRaw != null ? tagRaw : "");

            request.getRequestDispatcher("/views/movie.jsp").forward(request, response);

        } catch (Exception e ) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }
}