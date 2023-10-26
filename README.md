# filmorate_ER_diagram
ER-диаграмма для задачи filmorate
![ER-diagram](https://github.com/Kirill495/filmorate_ER_diagram/blob/main/Filmorate_ER.png)
## Сущности
### user
хранит сведения о пользователях системы
### friendship_status
статусы связи между пользователями. 2 варианта: подтвержденная и неподтвержденная
### user_friendships
сведения в "друзьях" и заявках в "друзья" в сети
### film
хранит данные о фильмах
### user_likes
отметки фильмам от пользователей
### genre
жанры фильмов
### films_genres
сведения о жанрах фильмов
### MPA_rating
рейтинг фильма по версии MPA (G, PG, PG-13, R, NC-17)
