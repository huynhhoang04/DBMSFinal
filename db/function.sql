CREATE OR REPLACE FUNCTION get_top_7_movies()
    RETURNS TABLE (
                      movie_id INT,
                      title VARCHAR,
                      description TEXT,
                      poster_url VARCHAR,
                      trailer_url VARCHAR,
                      duration INT,
                      release_date DATE,
                      movie_status VARCHAR,
                      genre TEXT
                  )
    LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
        SELECT
            m.movie_id,
            m.title,
            m.description,
            m.poster_url,
            m.trailer_url,
            m.duration,
            m.release_date,
            m.movie_status,
            COALESCE(STRING_AGG(g.genre_name, ', '), '')::TEXT AS genre
        FROM movies m
                 LEFT JOIN movie_genre mg ON m.movie_id = mg.movie_id
                 LEFT JOIN genres g ON mg.genre_id = g.genre_id
        GROUP BY m.movie_id
        ORDER BY m.release_date DESC
        LIMIT 7;
END;
$$;

create or replace function get_top_3_is_active_articles()
    returns table
            (
                article_id int,
                title      varchar,
                summary    text,
                content    text,
                image_url  varchar,
                created_at timestamp,
                is_active  boolean
            )
    language plpgsql
as
$$
begin
    return query
        select a.article_id, a.title, a.summary, a.content, a.image_url, a.created_at, a.is_active
        from articles as a
        where a.is_active = 'true'
        order by a.created_at desc
        limit 3;
end;
$$;

CREATE OR REPLACE FUNCTION get_movie_detail_by_id(p_movie_id INT)
    RETURNS TABLE (
                      movie_id INT, title VARCHAR, description TEXT, poster_url VARCHAR, trailer_url VARCHAR,
                      duration INT, release_date DATE, movie_status VARCHAR, series_id INT, series_name VARCHAR,
                      genre TEXT, directors TEXT, actors TEXT
                  )
    LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
        SELECT
            m.movie_id, m.title, m.description, m.poster_url, m.trailer_url,
            m.duration, m.release_date, m.movie_status, m.series_id, s.series_name,
            -- Gom Thể loại
            COALESCE(STRING_AGG(DISTINCT g.genre_name, ', '), '')::TEXT AS genre,
            -- Gom Đạo diễn
            COALESCE(STRING_AGG(DISTINCT d.director_name, ', '), '')::TEXT AS directors,
            -- Gom Diễn viên
            COALESCE(STRING_AGG(DISTINCT a.actor_name, ', '), '')::TEXT AS actors
        FROM movies m
                 LEFT JOIN series s ON m.series_id = s.series_id
                 LEFT JOIN movie_genre mg ON m.movie_id = mg.movie_id
                 LEFT JOIN genres g ON mg.genre_id = g.genre_id
                 LEFT JOIN movie_director md ON m.movie_id = md.movie_id
                 LEFT JOIN directors d ON md.director_id = d.director_id
                 LEFT JOIN movie_actor ma ON m.movie_id = ma.movie_id
                 LEFT JOIN actors a ON ma.actor_id = a.actor_id
        WHERE m.movie_id = p_movie_id
        GROUP BY m.movie_id, m.title, m.description, m.poster_url, m.trailer_url,
                 m.duration, m.release_date, m.movie_status, m.series_id, s.series_name;
END;
$$;


CREATE OR REPLACE FUNCTION get_movies_by_status_and_page(
    p_status VARCHAR,
    p_keyword VARCHAR,
    p_tag VARCHAR,
    p_limit INT,
    p_offset INT
)
    RETURNS TABLE (
                      movie_id INT, title VARCHAR, description TEXT, poster_url VARCHAR,
                      trailer_url VARCHAR, duration INT, release_date DATE,
                      movie_status VARCHAR, series_id INT, genre TEXT
                  )
    LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
        SELECT
            m.movie_id, m.title, m.description, m.poster_url, m.trailer_url,
            m.duration, m.release_date, m.movie_status, m.series_id,
            COALESCE(STRING_AGG(g.genre_name, ', '), '')::TEXT AS genre
        FROM movies m
                 LEFT JOIN movie_genre mg ON m.movie_id = mg.movie_id
                 LEFT JOIN genres g ON mg.genre_id = g.genre_id
        WHERE m.movie_status = p_status
          AND m.title ILIKE '%' || p_keyword || '%'
          AND (p_tag = '' OR m.movie_id IN (
            SELECT mg2.movie_id FROM movie_genre mg2
                                         JOIN genres g2 ON mg2.genre_id = g2.genre_id
            WHERE g2.genre_name ILIKE '%' || p_tag || '%'
        ))
        GROUP BY m.movie_id
        ORDER BY m.release_date DESC
        LIMIT p_limit OFFSET p_offset;
END;
$$;

-- Hàm 2: Đếm tổng số phim để phân trang
CREATE OR REPLACE FUNCTION count_movies_by_status(
    p_status VARCHAR,
    p_keyword VARCHAR,
    p_tag VARCHAR
)
    RETURNS INT
    LANGUAGE plpgsql
AS $$
DECLARE
    total_count INT;
BEGIN
    SELECT COUNT(DISTINCT m.movie_id) INTO total_count
    FROM movies m
    WHERE m.movie_status = p_status
      AND m.title ILIKE '%' || p_keyword || '%'
      AND (p_tag = '' OR m.movie_id IN (
        SELECT mg.movie_id FROM movie_genre mg
                                    JOIN genres g ON mg.genre_id = g.genre_id
        WHERE g.genre_name ILIKE '%' || p_tag || '%'
    ));
    RETURN total_count;
END;
$$;

create or replace function get_article_detail_by_id(in f_article_id int)
    returns table
            (
                article_id int,
                title      varchar,
                summary    text,
                content    text,
                image_url  varchar,
                created_at timestamp,
                is_active  boolean
            )
    language plpgsql
as
$$
begin
    return query
        select a.article_id, a.title, a.summary, a.content, a.image_url, a.created_at, a.is_active
        from articles as a
        where a.article_id = f_article_id;
end;
$$;



create or replace function get_active_cities()
    returns table (city_name varchar) language plpgsql as $$
begin
    return query
        select distinct t.city
        from theatre t
        where t.theatre_status = 'OPEN'
        order by t.city;
end;
$$;

create or replace function get_theatres_by_city(p_city varchar)
    returns table (theatre_id int, theatre_name varchar, location varchar, preview_url varchar, info text, theatre_status varchar, city varchar, coordinates varchar) language plpgsql as $$
begin
    return query
        select t.theatre_id, t.theatre_name, t.location, t.preview_url, t.info, t.theatre_status, t.city, t.coordinates
        from theatre t
        where t.city = p_city and t.theatre_status = 'OPEN'
        order by t.theatre_name;
end;
$$;

create or replace function get_theatre_detail_by_id(in f_theatre_id int)
    returns table(
                     theatre_id int,
                     theatre_name varchar,
                     location varchar,
                     preview_url varchar,
                     info text,
                     theatre_status varchar,
                     city varchar,
                     coordinates varchar
                 )
    language plpgsql
as $$
begin
    return query
        select t.theatre_id, t.theatre_name, t.location, t.preview_url, t.info, t.theatre_status, t.city, t.coordinates
        from theatre as t
        where t.theatre_id = f_theatre_id;
end;
$$;

create or replace function get_theatre_room(in f_theatre_id int)
    returns table(
                     room_id int,
                     room_name varchar,
                     room_type varchar,
                     capacity int,
                     room_status varchar
                 )
    language plpgsql
as $$
begin
    return query
        select r.room_id, r.room_name, r.room_type, r.capacity, r.room_status
        from room as r
        where theatre_id = f_theatre_id;
end;
$$;

create or replace function get_user_for_login(p_account varchar)
    returns table(
                     user_id int,
                     username varchar,
                     password varchar,
                     full_name varchar,
                     email varchar,
                     role varchar
                 )
    language plpgsql
as $$
begin
    return query
        select u.user_id, u.username, u.password, u.full_name, u.email, u.role
        from users as u
        where (u.username = p_account or u.email = p_account);
end;
$$;

create or replace function check_user_exists(p_username varchar, p_email varchar)
    returns boolean
    language plpgsql
as $$
declare
    is_exist boolean;
begin
    select exists(
        select 1 from users
        where username = p_username or email = p_email
    ) into is_exist;

    return is_exist;
end;
$$;

create or replace function get_password_by_id(in f_user_id int)
    returns table
            (
                password varchar
            )
    language plpgsql
as
$$
begin
    return query
        select u.password
        from users as u
        where u.user_id = f_user_id;
end;
$$;

create or replace function get_showtime_for_movie_by_date(in f_date date, in f_movie_id int, in f_city varchar)
    returns table(
                     showtime_id int,
                     start_at timestamp,
                     price numeric,
                     room_name varchar,
                     room_type varchar,
                     theatre_name varchar,
                     room_id int,
                     theatre_id int,
                     movie_id int,
                     seat_remain bigint
                 )
    language plpgsql
as $$
begin
    return query
        select
            s.showtime_id,
            s.start_at,
            s.price,
            r.room_name,
            r.room_type,
            t.theatre_name,
            r.room_id,
            t.theatre_id,
            s.movie_id,
            (r.capacity - count(tk.ticket_id)) as seat_remain
        from showtime as s
                 join room r on r.room_id = s.room_id
                 join theatre t on t.theatre_id = r.theatre_id
                 left join tickets tk on tk.showtime_id = s.showtime_id
        where s.movie_id = f_movie_id
          and t.city = f_city
          and date(s.start_at) = f_date
          and s.start_at > current_timestamp
        group by
            s.showtime_id, s.start_at, s.price, r.room_name, r.room_type,
            t.theatre_name, r.room_id, t.theatre_id, s.movie_id, r.capacity
        order by t.theatre_name, s.start_at asc;
end;
$$;

create or replace function get_room_capacity(in f_showtime_id int)
    returns table(room_name varchar,
                  capacity int,
                  standard_price numeric)
    language plpgsql
as $$
begin
    return query
        select r.room_name, r.capacity, s.price
        from showtime as s
                 join room r on r.room_id = s.room_id
        where s.showtime_id = f_showtime_id;
end;
$$;

create or replace function get_unavailable_seat(in f_showtime_id int)
    returns table(seat_number varchar)
    language plpgsql
as $$
begin
    return query
        select t.seat_number
        from tickets as t
                 join bookings b on t.booking_id = b.booking_id
        where t.showtime_id = f_showtime_id
          and b.payment_status != 'CANCEL';
end;
$$;

