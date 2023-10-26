-- получение всех фильмов
SELECT
    *
FROM
    films

-- получение фильма по идентификатору
SELECT
    *
FROM
    film
WHERE
    films_id = $1

-- N наиболее популярных фильмов
SELECT
    film.*
FROM
    (SELECT film_id 
        FROM user_likes 
        GROUP BY film_id 
        ORDER BY COUNT(user_id) DESC 
        LIMIT N) AS top_popular_films
    INNER JOIN film
    ON top_popular_films.film_id = film.film_id

--  все пользователи
SELECT
    *
FROM 
    users

-- получение пользователя по идентификатору
SELECT
    *
FROM 
    users
WHERE
    user_id = $1

-- получение всех друзей пользователя
SELECT
    u.*
FROM
    (SELECT
        f.friend_two AS friend
    FROM
        user_friendships AS f
        INNER JOIN friendship_status as s
        ON f.status = s.status_id
            AND s.title = 'подтвержденный'
    WHERE
        f.friend_one = $1
    UNION
    SELECT
        f.friend_one
    FROM
        user_friendships AS f
        INNER JOIN friendship_status as s
        ON f.status = s.status_id
            AND s.title = 'подтвержденный'
    WHERE
        f.friend_two = $1) AS user_friends
    INNER JOIN user AS u
    ON user_friends.friend = u.user_id

-- получение общих друзей между пользователями
SELECT
    u.*
FROM
    (SELECT
        f.friend_two AS friend
    FROM
        user_friendships AS f
        INNER JOIN friendship_status as s
        ON f.status = s.status_id
            AND s.title = 'подтвержденный'
    WHERE
        f.friend_one = $1
    UNION
    SELECT
        f.friend_one
    FROM
        user_friendships AS f
        INNER JOIN friendship_status as s
        ON f.status = s.status_id
            AND s.title = 'подтвержденный'
    WHERE
        f.friend_two = $1) AS user_friends_1
    INNER JOIN 
        (SELECT
            f.friend_two AS friend
        FROM
            user_friendships AS f
            INNER JOIN friendship_status as s
            ON f.status = s.status_id
                AND s.title = 'подтвержденный'
        WHERE
            f.friend_one = $2
        UNION
        SELECT
            f.friend_one
        FROM
            user_friendships AS f
            INNER JOIN friendship_status as s
            ON f.status = s.status_id
                AND s.title = 'подтвержденный'
        WHERE
            f.friend_two = $2) AS user_friends_2
    ON user_friends_1.friend = user_friends_2.friend
    INNER JOIN users AS u
    ON user_friends_1.friend = u.user_id