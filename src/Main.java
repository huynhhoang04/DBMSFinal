import dao.MovieDAO;
import dao.impl.MovieDAOImpl;
import dto.MovieThumnailDTO;
import service.impl.MovieServiesImpl;

import java.util.List;

public class Main {
    public static void main(String[] args) {
        MovieDAOImpl movieDAO = new MovieDAOImpl();
        MovieServiesImpl movieServies = new MovieServiesImpl(movieDAO);

        List<MovieThumnailDTO> dtos = movieServies.getTop7NewestMovies();
        dtos.forEach(movieThumnailDTO -> {
            System.out.println(movieThumnailDTO.getTitle());
        });
    }
}
