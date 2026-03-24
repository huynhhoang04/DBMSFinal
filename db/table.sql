CREATE TABLE IF NOT EXISTS public.actors
(
    actor_id serial NOT NULL,
    actor_name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    avatar_url character varying(255) COLLATE pg_catalog."default",
    bio text COLLATE pg_catalog."default",
    CONSTRAINT actors_pkey PRIMARY KEY (actor_id)
);

CREATE TABLE IF NOT EXISTS public.articles
(
    article_id serial NOT NULL,
    title character varying(255) COLLATE pg_catalog."default" NOT NULL,
    summary text COLLATE pg_catalog."default" NOT NULL,
    content text COLLATE pg_catalog."default" NOT NULL,
    image_url character varying(255) COLLATE pg_catalog."default" NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    is_active boolean DEFAULT true,
    CONSTRAINT articles_pkey PRIMARY KEY (article_id)
);

CREATE TABLE IF NOT EXISTS public.bookings
(
    booking_id serial NOT NULL,
    user_id integer,
    booking_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    total_payment numeric(10, 2) DEFAULT 0,
    payment_status character varying(50) COLLATE pg_catalog."default" NOT NULL,
    payment_method character varying(50) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT bookings_pkey PRIMARY KEY (booking_id)
);

CREATE TABLE IF NOT EXISTS public.directors
(
    director_id serial NOT NULL,
    director_name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    avatar_url character varying(255) COLLATE pg_catalog."default",
    bio text COLLATE pg_catalog."default",
    CONSTRAINT directors_pkey PRIMARY KEY (director_id)
);

CREATE TABLE IF NOT EXISTS public.genres
(
    genre_id serial NOT NULL,
    genre_name character varying(100) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT genres_pkey PRIMARY KEY (genre_id),
    CONSTRAINT genres_genre_name_key UNIQUE (genre_name)
);

CREATE TABLE IF NOT EXISTS public.movie_actor
(
    movie_id integer NOT NULL,
    actor_id integer NOT NULL,
    character_name character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT movie_actor_pkey PRIMARY KEY (movie_id, actor_id)
);

CREATE TABLE IF NOT EXISTS public.movie_director
(
    movie_id integer NOT NULL,
    director_id integer NOT NULL,
    CONSTRAINT movie_director_pkey PRIMARY KEY (movie_id, director_id)
);

CREATE TABLE IF NOT EXISTS public.movie_genre
(
    movie_id integer NOT NULL,
    genre_id integer NOT NULL,
    CONSTRAINT movie_genre_pkey PRIMARY KEY (movie_id, genre_id)
);

CREATE TABLE IF NOT EXISTS public.movies
(
    movie_id serial NOT NULL,
    title character varying(255) COLLATE pg_catalog."default" NOT NULL,
    description text COLLATE pg_catalog."default",
    poster_url character varying(255) COLLATE pg_catalog."default" NOT NULL,
    trailer_url character varying(255) COLLATE pg_catalog."default" NOT NULL,
    duration integer NOT NULL,
    release_date date,
    movie_status character varying(100) COLLATE pg_catalog."default" NOT NULL DEFAULT 'UNAVAILABLE'::character varying,
    series_id integer,
    CONSTRAINT movies_pkey PRIMARY KEY (movie_id)
);

CREATE TABLE IF NOT EXISTS public.room
(
    room_id serial NOT NULL,
    room_name character varying(100) COLLATE pg_catalog."default" NOT NULL,
    room_type character varying(100) COLLATE pg_catalog."default" NOT NULL,
    capacity integer NOT NULL,
    theatre_id integer,
    room_status character varying(100) COLLATE pg_catalog."default" NOT NULL DEFAULT 'AVAILABLE'::character varying,
    CONSTRAINT room_pkey PRIMARY KEY (room_id)
);

CREATE TABLE IF NOT EXISTS public.series
(
    series_id serial NOT NULL,
    series_name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    description text COLLATE pg_catalog."default",
    CONSTRAINT series_pkey PRIMARY KEY (series_id)
);

CREATE TABLE IF NOT EXISTS public.showtime
(
    showtime_id serial NOT NULL,
    movie_id integer,
    room_id integer,
    start_at timestamp without time zone NOT NULL,
    price numeric(10, 2) NOT NULL,
    CONSTRAINT showtime_pkey PRIMARY KEY (showtime_id)
);

CREATE TABLE IF NOT EXISTS public.theatre
(
    theatre_id serial NOT NULL,
    theatre_name character varying(100) COLLATE pg_catalog."default" NOT NULL,
    location character varying(100) COLLATE pg_catalog."default" NOT NULL,
    preview_url character varying(255) COLLATE pg_catalog."default" NOT NULL,
    info text COLLATE pg_catalog."default",
    theatre_status character varying(100) COLLATE pg_catalog."default" NOT NULL,
    city character varying(50) COLLATE pg_catalog."default",
    coordinates character varying(100) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT theatre_pkey PRIMARY KEY (theatre_id)
);

CREATE TABLE IF NOT EXISTS public.tickets
(
    ticket_id serial NOT NULL,
    booking_id integer,
    showtime_id integer,
    seat_number character varying(10) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT tickets_pkey PRIMARY KEY (ticket_id),
    CONSTRAINT tickets_showtime_id_seat_number_key UNIQUE (showtime_id, seat_number)
);

CREATE TABLE IF NOT EXISTS public.users
(
    user_id serial NOT NULL,
    username character varying(50) COLLATE pg_catalog."default" NOT NULL,
    password character varying(100) COLLATE pg_catalog."default" NOT NULL,
    full_name character varying(100) COLLATE pg_catalog."default",
    email character varying(100) COLLATE pg_catalog."default" NOT NULL,
    role character varying(100) COLLATE pg_catalog."default" NOT NULL DEFAULT 'USER'::character varying,
    CONSTRAINT users_pkey PRIMARY KEY (user_id),
    CONSTRAINT unique_username UNIQUE (username),
    CONSTRAINT users_email_key UNIQUE (email)
);

ALTER TABLE IF EXISTS public.bookings
    ADD CONSTRAINT bookings_user_id_fkey FOREIGN KEY (user_id)
        REFERENCES public.users (user_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.movie_actor
    ADD CONSTRAINT movie_actor_actor_id_fkey FOREIGN KEY (actor_id)
        REFERENCES public.actors (actor_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE;


ALTER TABLE IF EXISTS public.movie_actor
    ADD CONSTRAINT movie_actor_movie_id_fkey FOREIGN KEY (movie_id)
        REFERENCES public.movies (movie_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE;


ALTER TABLE IF EXISTS public.movie_director
    ADD CONSTRAINT movie_director_director_id_fkey FOREIGN KEY (director_id)
        REFERENCES public.directors (director_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE;


ALTER TABLE IF EXISTS public.movie_director
    ADD CONSTRAINT movie_director_movie_id_fkey FOREIGN KEY (movie_id)
        REFERENCES public.movies (movie_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE;


ALTER TABLE IF EXISTS public.movie_genre
    ADD CONSTRAINT movie_genre_genre_id_fkey FOREIGN KEY (genre_id)
        REFERENCES public.genres (genre_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE;


ALTER TABLE IF EXISTS public.movie_genre
    ADD CONSTRAINT movie_genre_movie_id_fkey FOREIGN KEY (movie_id)
        REFERENCES public.movies (movie_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE;


ALTER TABLE IF EXISTS public.movies
    ADD CONSTRAINT movies_series_id_fkey FOREIGN KEY (series_id)
        REFERENCES public.series (series_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.room
    ADD CONSTRAINT room_theatre_id_fkey FOREIGN KEY (theatre_id)
        REFERENCES public.theatre (theatre_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.showtime
    ADD CONSTRAINT showtime_movie_id_fkey FOREIGN KEY (movie_id)
        REFERENCES public.movies (movie_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.showtime
    ADD CONSTRAINT showtime_room_id_fkey FOREIGN KEY (room_id)
        REFERENCES public.room (room_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.tickets
    ADD CONSTRAINT tickets_booking_id_fkey FOREIGN KEY (booking_id)
        REFERENCES public.bookings (booking_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.tickets
    ADD CONSTRAINT tickets_showtime_id_fkey FOREIGN KEY (showtime_id)
        REFERENCES public.showtime (showtime_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION;
