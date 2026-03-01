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