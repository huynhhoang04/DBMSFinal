create or replace function get_top_7_movies()
    returns table (
                      movie_id INT,
                      title VARCHAR,
                      description TEXT,
                      poster_url VARCHAR,
                      trailer_url VARCHAR,
                      genre VARCHAR,
                      duration INT,
                      release_date DATE,
                      movie_status VARCHAR
                  )
    language plpgsql
as $$
begin
    return query
        select m.movie_id, m.title, m.description, m.poster_url, m.trailer_url, m.genre, m.duration, m.release_date, m.movie_status
        from movies as m
        where m.movie_status in ('AVAILABLE', 'UPCOMING')
        order by m.release_date desc
        limit 7;
end;
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

create or replace function get_movie_detail_by_id(in f_movie_id int)
    returns table
            (
                movie_id     INT,
                title        VARCHAR,
                description  TEXT,
                poster_url   VARCHAR,
                trailer_url  VARCHAR,
                genre        VARCHAR,
                duration     INT,
                release_date DATE,
                movie_status VARCHAR
            )
    language plpgsql
as
$$
begin
    return query
        select m.movie_id, m.title, m.description, m.poster_url, m.trailer_url, m.genre, m.duration, m.release_date, m.movie_status
        from movies as m
        where m.movie_id = f_movie_id;
end;
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

create or replace function get_movie_by_status_and_paging(in f_status varchar, in f_limit int, in f_offset int, in f_keyword varchar, in f_tag varchar)
    returns table
            (
                movie_id     INT,
                title        VARCHAR,
                description  TEXT,
                poster_url   VARCHAR,
                trailer_url  VARCHAR,
                genre        VARCHAR,
                duration     INT,
                release_date DATE,
                movie_status VARCHAR
            )
    language plpgsql
as
$$
begin
    return query
        select m.movie_id,
               m.title,
               m.description,
               m.poster_url,
               m.trailer_url,
               m.genre,
               m.duration,
               m.release_date,
               m.movie_status
        from movies as m
        where m.movie_status = f_status
          and m.title ilike '%' || f_keyword || '%'
          and m.genre ilike '%' || f_tag || '%'
        order by release_date desc
        limit f_limit
            offset f_offset;
end;
$$;

create or replace function count_movie_by_status(in f_status varchar, in f_keyword varchar, in f_tag varchar)
    returns int
    language plpgsql
as
$$
declare
    total int;
begin
    select count(*)
    into total
    from movies as m
    where m.movie_status = f_status
      and m.title ilike '%' || f_keyword || '%'
      and m.genre ilike '%' || f_tag || '%';

    return total;
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

