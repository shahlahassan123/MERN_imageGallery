CREATE DATABASE  ASSIGNMENT_3;
USE ASSIGNMENT_3;

CREATE TABLE genre(
genre_id DECIMAL(12) NOT NULL PRIMARY KEY ,
genre_name VARCHAR(64) NOT NULL
);

CREATE TABLE creator(
creator_id DECIMAL(12) NOT NULL PRIMARY KEY ,
first_name VARCHAR(64) NOT NULL,
last_name VARCHAR(64) NOT NULL
);

CREATE TABLE movie_series(
movie_series_id DECIMAL(12) NOT NULL PRIMARY KEY,
genre_id DECIMAL(12) NOT NULL,
creator_id DECIMAL(12) NOT NULL,
series_name VARCHAR(255) NOT NULL,
suggested_price DECIMAL(8,2)  NULL,
FOREIGN KEY(genre_id) REFERENCES genre(genre_id),
FOREIGN KEY(creator_id) REFERENCES creator(creator_id)
);

CREATE TABLE movie(
movie_id DECIMAL(12) NOT NULL PRIMARY KEY,
movie_series_id DECIMAL(12) NOT NULL,
movie_name VARCHAR(64) NOT NULL ,
length_in_minutes DECIMAL(4),
FOREIGN KEY(movie_series_id) REFERENCES movie_series(movie_series_id) 
);

INSERT INTO genre (genre_id,genre_name) values (1, "Fantasy");
INSERT INTO genre (genre_id,genre_name) values (2, "Family Film");

INSERT INTO creator (creator_id,first_name,last_name) values (101, "George", "Lucas");
INSERT INTO creator (creator_id,first_name,last_name) values (102, "John", "Lasseter");
INSERT INTO creator (creator_id,first_name,last_name) values (103, "John", "Tolkien");

INSERT INTO movie_series (movie_series_id, genre_id,creator_id,series_name,suggested_price) 
values (1001, 1, 101,"Star Wars", 129.99);
INSERT INTO movie_series (movie_series_id, genre_id,creator_id,series_name,suggested_price) 
values (1002, 2, 102,"Toy Story", 22.13);
INSERT INTO movie_series (movie_series_id, genre_id,creator_id,series_name,suggested_price) 
values (1003, 1, 103,"Lord of the Rings", NULL);

INSERT INTO movie (movie_id, movie_series_id, movie_name,length_in_minutes) 
values (10001, 1001, "Episode I: The Phantom Menace", 136);
INSERT INTO movie (movie_id, movie_series_id, movie_name,length_in_minutes) 
values (10002, 1001, "Episode II: Attack of the Clones", 142);
INSERT INTO movie (movie_id, movie_series_id, movie_name,length_in_minutes) 
values (10003, 1001, "Episode III: Revenge of the Sith", 140);
INSERT INTO movie (movie_id, movie_series_id, movie_name,length_in_minutes) 
values (10004, 1001, "Episode IV: A New Hope", 121);

INSERT INTO movie (movie_id, movie_series_id, movie_name,length_in_minutes) 
values (10005, 1002, "Toy Story", 121);
INSERT INTO movie (movie_id, movie_series_id, movie_name,length_in_minutes) 
values (10006, 1002, "Toy Story 2", 135);
INSERT INTO movie (movie_id, movie_series_id, movie_name,length_in_minutes) 
values (10007, 1002, "Toy Story 3", 148);
INSERT INTO movie (movie_id, movie_series_id, movie_name,length_in_minutes) 
values (10008, 1003, "The Lord of the Rings: The Fellowship of the Ring", 228);
INSERT INTO movie (movie_id, movie_series_id, movie_name,length_in_minutes) 
values (10009, 1003, "The Lord of the Rings: The Two Towers", 235);
INSERT INTO movie (movie_id, movie_series_id, movie_name,length_in_minutes) 
values (10010, 1003, "The Lord of the Rings: The Return of the King", 200);


SELECT COUNT(*) AS NUMBER_OF_MOVIES FROM movie;

SELECT CONCAT('$', MIN(suggested_price)) AS LEAST_EXPENSIVE,
 CONCAT('$', MAX(suggested_price)) AS MOST_EXPENSIVE FROM movie_series;
 
 /* 2 SEPARATE QUERIES*/
SELECT CONCAT('$', MIN(suggested_price)) AS LEAST_EXPENSIVE FROM movie_series;
SELECT CONCAT('$', MAX(suggested_price)) AS MOST_EXPENSIVE FROM movie_series;


SELECT series_name AS SERIES,suggested_price AS PRICE_IN_DOLLARS, COUNT(movie.movie_series_id) AS NUMBER_OF_MOVIES
 FROM movie_series JOIN movie 
ON movie_series.movie_series_id = movie.movie_series_id GROUP BY
movie.movie_series_id;


INSERT INTO movie (movie_id, movie_series_id, movie_name,length_in_minutes) 
values (10011, 1001, "Episode V", 121);
INSERT INTO movie (movie_id, movie_series_id, movie_name,length_in_minutes) 
values (10012, 1001, "Episode VI", 121);
INSERT INTO movie (movie_id, movie_series_id, movie_name,length_in_minutes) 
values (10013, 1001, "Episode VII", 121);
INSERT INTO movie (movie_id, movie_series_id, movie_name,length_in_minutes) 
values (10014, 1001, "Episode VIII", 121);

SELECT genre_name FROM GENRE WHERE genre_id =(SELECT movie_series.genre_id
 FROM movie_series JOIN movie 
ON movie_series.movie_series_id = movie.movie_series_id GROUP BY
movie.movie_series_id HAVING COUNT(movie.movie_series_id) > 7);
/* */
SELECT genre_name FROM genre JOIN movie_series ON genre.genre_id = movie_series.genre_id where
movie_series.movie_series_id = (SELECT movie.movie_series_id
 FROM movie_series JOIN movie 
ON movie_series.movie_series_id = movie.movie_series_id GROUP BY
movie.movie_series_id having count(movie_series.movie_series_id) >7) ;

SELECT genre.genre_name , count(movie_series.movie_series_id )
 FROM  movie  JOIN movie_series 
ON  movie.movie_series_id = movie_series.movie_series_id 
GROUP BY
movie_series.movie_series_id  and count(movie_series.movie_series_id ) >7 
JOIN genre on movie_series.genre_id = movie_series.genre_id 



select movie_series.series_name, sum(length_in_minutes) as total_series_time  from movie join movie_series
on movie.movie_series_id = movie_series.movie_series_id 
group by movie.movie_series having total_series_time >=600 ;


-- select first_name , last_name, count() from creator join movie_series on creator.creator_id = movie_series.creator_id
-- where movie_series.genre_id = (Select genre_id from genre where genre_name = "Family Film");

SELECT * FROM creator JOIN movie_series on creator.creator_id = movie_series.creator_id;

SELECT creator.first_name,creator.last_name,count(movie.movie_id) AS Number_of_movies 
FROM movie_series JOIN movie on movie_series.movie_series_id = movie.movie_series_id
AND movie_series.genre_id = 2
RIGHT JOIN creator on creator.creator_id = movie_series.creator_id group by  creator.first_name,creator.last_name
order by Number_of_movies desc;

Select genre.genre_id,genre.genre_name, count(movie.movie_id) as Number_of_movies
 from genre join movie_series on genre.genre_id = movie_series.genre_id join 
movie on movie.movie_series_id = movie_series.movie_series_id group by movie.movie_series_id
 having count(movie.movie_id) >=7;