create table users
(
    user_id   serial,
    username  varchar(50)         not null,
    password  varchar(100)        not null,
    full_name varchar(100),
    email     varchar(100) unique not null,
    role      varchar(100)        not null check ( role in ('ADMIN', 'USER') ) default 'USER',

    primary key (user_id)
);

create table movies
(
    movie_id     serial,
    title        varchar(255) not null,
    description  text,
    poster_url   varchar(255) not null,
    trailer_url  varchar(255) not null,
    genre        varchar(100) not null,
    duration     int          not null,
    release_date date,
    movie_status varchar(100) not null check ( movie_status in ('AVAILABLE', 'UPCOMING', 'UNAVAILABLE') ) default 'UNAVAILABLE',

    primary key (movie_id)
);

create table theatre
(
    theatre_id     serial,
    theatre_name   varchar(100) not null,
    location       varchar(100) not null,
    preview_url    varchar(255) not null,
    info           text,
    theatre_status varchar(100) not null check ( theatre_status in ('MAINTENANCE', 'OPEN', 'CLOSE') ),

    primary key (theatre_id)
);

create table room
(
    room_id     serial,
    room_name   varchar(100) not null,
    room_type   varchar(100) not null check ( room_type in ('NORMAL', 'VIP') ),
    capacity    int          not null,
    theatre_id  int,
    room_status varchar(100) not null check ( room_status in ('MAINTENANCE', 'AVAILABLE', 'UNAVAILABLE')) default 'AVAILABLE',

    primary key (room_id),
    foreign key (theatre_id) references theatre (theatre_id)
);

create table showtime
(
    showtime_id serial,
    movie_id    int,
    room_id     int,
    start_at    timestamp      not null,
    price       decimal(10, 2) not null check ( price > 0 ),

    primary key (showtime_id),
    foreign key (movie_id) references movies (movie_id),
    foreign key (room_id) references room (room_id)
);

create table bookings
(
    booking_id     serial,
    user_id        int,
    booking_date   timestamp      default current_timestamp,
    total_payment  decimal(10, 2) default 0,
    payment_status varchar(50) not null check ( payment_status in ('PENDING', 'CANCEL', 'COMPLETED') ),
    payment_method varchar(50) not null check ( payment_method in ('E_WALLET', 'TRANSFER', 'CARD') ),

    primary key (booking_id),
    foreign key (user_id) references users (user_id)
);

create table tickets
(
    ticket_id   serial,
    booking_id  int,
    showtime_id int,
    seat_number varchar(10) not null,

    unique (showtime_id, seat_number),
    primary key (ticket_id),
    foreign key (booking_id) references bookings (booking_id),
    foreign key (showtime_id) references showtime (showtime_id)
);

create table articles
(
    article_id serial,
    title      varchar(255) not null,
    summary    text         not null,
    content    text         not null,
    image_url  varchar(255) not null,
    created_at timestamp default current_timestamp,
    is_active  boolean   default true,

    primary key (article_id)
);



