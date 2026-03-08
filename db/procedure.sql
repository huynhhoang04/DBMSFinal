create or replace procedure register_user(
    p_username varchar,
    p_password varchar,
    p_full_name varchar,
    p_email varchar
)
    language plpgsql
as $$
begin
    insert into users (username, password, full_name, email)
    values (p_username, p_password, p_full_name, p_email);
end;
$$;

create or replace procedure update_password(in p_password varchar, in p_user_id int)
    language plpgsql
as
$$
begin
    update users as u
    set password = p_password where u.user_id = p_user_id;
end;
$$;