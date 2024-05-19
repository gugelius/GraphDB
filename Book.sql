USE master;
GO

DROP DATABASE IF EXISTS Book;
GO

CREATE DATABASE Book;
GO

USE Book;
--1. Создайте не менее трёх таблиц узлов. Например, однокласники, сокурсники (одногруппники), учебные дисциплины, книги (жанры книг), фильмы (жанры книг), города.
CREATE TABLE Book
(
id INT NOT NULL PRIMARY KEY,
title NVARCHAR(50) NOT NULL,
genre NVARCHAR(30) NOT NULL
) AS NODE;

CREATE TABLE Author
(
id INT NOT NULL PRIMARY KEY,
name NVARCHAR(50) NOT NULL
) AS NODE;

CREATE TABLE Publisher
(
id INT NOT NULL PRIMARY KEY,
name NVARCHAR(50) NOT NULL,
city NVARCHAR(30) NOT NULL
) AS NODE;
--2. Создайте не менее трёх таблиц рёбер. Например, дружит, проживает, списывает домашнее задание, рекомендует книгу или фильм (жанр).
CREATE TABLE Wrote AS EDGE; -- Связь автор написал книгу

CREATE TABLE Published AS EDGE; -- Связь издательство опубликовало книгу

CREATE TABLE Recommends AS EDGE; -- Связь автор рекомендует автора

ALTER TABLE Wrote
ADD CONSTRAINT EC_Wrote CONNECTION (Author TO Book);
GO

ALTER TABLE Published
ADD CONSTRAINT EC_Published CONNECTION (Publisher TO Book);
GO

ALTER TABLE Recommends
ADD CONSTRAINT EC_Recommends CONNECTION (Author TO Author);
GO
--3. Заполните для каждой таблиц узлов не менее 10 строк.
INSERT INTO Book (id, title, genre)
VALUES 
	(1, 'Война и мир', 'Роман'),--
	(2, 'Преступление и наказание', 'Роман'),
	(3, 'Мастер и Маргарита', 'Роман'),
	(4, 'Идиот', 'Роман'),
	(5, 'Братья Карамазовы', 'Роман'),
	(6, 'Метро2033','Постапокалипсис'),
	(7,'Гарри Поттер и Орден Феникса','Роман'),
	(8,'Ревизор','Комедия'),
	(9,'Мёртвые души','Роман'),
	(10,'Старик и море','Роман'),
	(11,'Война миров','Научная фантастика'),
	(12,'Герой нашего времени','Роман'),
	(13,'Отцы и дети','Роман'),
	(14,'Человек-невидимка','Научная фантастика'),
	(15,'Бежин луг','Фикшн');
GO

INSERT INTO Author (id, name)
VALUES
	(1, 'Лев Толстой'),
	(2, 'Фёдор Достоевский'),
	(3, 'Михаил Булгаков'),
	(4, 'Дмитрий Глуховский'),
	(5, 'Джоан Роулинг'),
	(6, 'Николай Гоголь'),
	(7, 'Эрнест Хемингуэй'),
	(8, 'Герберт Уэллс'),
	(9, 'Михаил Лермонтов'),
	(10, 'Иван Тургенев');
GO

INSERT INTO Publisher (id, name, city)
VALUES
	(1, 'АСТ', 'Москва'),
	(2, 'Эксмо', 'Москва'),
	(3, 'Просвещение', 'Москва'),
	(4, 'Росмэн', 'Москва'),
	(5, 'Азбука-Аттикус', 'Санкт-Петербург'),
	(6, 'Махаон', 'Москва'),
	(7, 'Альпина Паблишер', 'Москва'),
	(8, 'МИФ', 'Москва'),
	(9, 'Питер', 'Санкт-Петербург'),
	(10, 'Амфора', 'Санкт-Петербург');
GO
--4. Введите данные в таблицы рёбер для установлению нужной связи между узлами.
INSERT INTO Wrote ($from_id, $to_id)
VALUES 
	((SELECT $node_id FROM Author WHERE id = 1), (SELECT $node_id FROM Book WHERE id = 1)),
	((SELECT $node_id FROM Author WHERE id = 2), (SELECT $node_id FROM Book WHERE id = 2)),
	((SELECT $node_id FROM Author WHERE id = 2), (SELECT $node_id FROM Book WHERE id = 4)),
	((SELECT $node_id FROM Author WHERE id = 2), (SELECT $node_id FROM Book WHERE id = 5)),
	((SELECT $node_id FROM Author WHERE id = 3), (SELECT $node_id FROM Book WHERE id = 3)),
	((SELECT $node_id FROM Author WHERE id = 4), (SELECT $node_id FROM Book WHERE id = 6)),
	((SELECT $node_id FROM Author WHERE id = 5), (SELECT $node_id FROM Book WHERE id = 7)),
	((SELECT $node_id FROM Author WHERE id = 6), (SELECT $node_id FROM Book WHERE id = 8)),
	((SELECT $node_id FROM Author WHERE id = 6), (SELECT $node_id FROM Book WHERE id = 9)),
	((SELECT $node_id FROM Author WHERE id = 7), (SELECT $node_id FROM Book WHERE id = 10)),
	((SELECT $node_id FROM Author WHERE id = 8), (SELECT $node_id FROM Book WHERE id = 11)),
	((SELECT $node_id FROM Author WHERE id = 8), (SELECT $node_id FROM Book WHERE id = 14)),
	((SELECT $node_id FROM Author WHERE id = 9), (SELECT $node_id FROM Book WHERE id = 12)),
	((SELECT $node_id FROM Author WHERE id = 10), (SELECT $node_id FROM Book WHERE id = 13)),
	((SELECT $node_id FROM Author WHERE id = 10), (SELECT $node_id FROM Book WHERE id = 15));
GO

INSERT INTO Published ($from_id, $to_id)
VALUES 
((SELECT $node_id FROM Publisher WHERE id = 1), (SELECT $node_id FROM Book WHERE id = 1)),
((SELECT $node_id FROM Publisher WHERE id = 2), (SELECT $node_id FROM Book WHERE id = 2)),
((SELECT $node_id FROM Publisher WHERE id = 3), (SELECT $node_id FROM Book WHERE id = 3)),
((SELECT $node_id FROM Publisher WHERE id = 4), (SELECT $node_id FROM Book WHERE id = 4)),
((SELECT $node_id FROM Publisher WHERE id = 5), (SELECT $node_id FROM Book WHERE id = 5)),
((SELECT $node_id FROM Publisher WHERE id = 6), (SELECT $node_id FROM Book WHERE id = 6)),
((SELECT $node_id FROM Publisher WHERE id = 7), (SELECT $node_id FROM Book WHERE id = 7)),
((SELECT $node_id FROM Publisher WHERE id = 8), (SELECT $node_id FROM Book WHERE id = 8)),
((SELECT $node_id FROM Publisher WHERE id = 9), (SELECT $node_id FROM Book WHERE id = 9)),
((SELECT $node_id FROM Publisher WHERE id = 10), (SELECT $node_id FROM Book WHERE id = 10)),
((SELECT $node_id FROM Publisher WHERE id = 1), (SELECT $node_id FROM Book WHERE id = 11)),
((SELECT $node_id FROM Publisher WHERE id = 1), (SELECT $node_id FROM Book WHERE id = 12)),
((SELECT $node_id FROM Publisher WHERE id = 3), (SELECT $node_id FROM Book WHERE id = 13)),
((SELECT $node_id FROM Publisher WHERE id = 4), (SELECT $node_id FROM Book WHERE id = 14)),
((SELECT $node_id FROM Publisher WHERE id = 5), (SELECT $node_id FROM Book WHERE id = 15));
GO

INSERT INTO Recommends ($from_id, $to_id)
VALUES 
((SELECT $node_id FROM Author WHERE id = 1), (SELECT $node_id FROM Author WHERE id = 2)),
((SELECT $node_id FROM Author WHERE id = 1), (SELECT $node_id FROM Author WHERE id = 6)), 
((SELECT $node_id FROM Author WHERE id = 2), (SELECT $node_id FROM Author WHERE id = 10)),
((SELECT $node_id FROM Author WHERE id = 3), (SELECT $node_id FROM Author WHERE id = 6)), 
((SELECT $node_id FROM Author WHERE id = 4), (SELECT $node_id FROM Author WHERE id = 3)), 
((SELECT $node_id FROM Author WHERE id = 4), (SELECT $node_id FROM Author WHERE id = 6)),
((SELECT $node_id FROM Author WHERE id = 5), (SELECT $node_id FROM Author WHERE id = 7)),
((SELECT $node_id FROM Author WHERE id = 7), (SELECT $node_id FROM Author WHERE id = 1)), 
((SELECT $node_id FROM Author WHERE id = 9), (SELECT $node_id FROM Author WHERE id = 10)), 
((SELECT $node_id FROM Author WHERE id = 10), (SELECT $node_id FROM Author WHERE id = 1)); 
GO

--5. Используя функцию MATCH, напишите не менее 5 различных запросов к построенной графовой базе данных.
--Найти все книги, написанные автором с определенным именем:
SELECT Author1.name
 , Book1.title AS [book title]
FROM Author AS Author1
 , Wrote
 , Book AS Book1
WHERE MATCH(Author1-(Wrote)->Book1)
 AND Author1.name = N'Николай Гоголь';

 --Найти всех авторов, которые рекомендуют определенного автора:
SELECT Author1.name
 , Author2.name AS [recommended author]
FROM Author AS Author1
 , Recommends
 , Author AS Author2
WHERE MATCH(Author1-(Recommends)->Author2)
 AND Author1.name = N'Дмитрий Глуховский';

 --Найти все книги, опубликованные определенным издательством:
 SELECT Publisher1.name
 , Book1.title AS [book title]
FROM Publisher AS Publisher1
 , Published
 , Book AS Book1
WHERE MATCH(Publisher1-(Published)->Book1)
 AND Publisher1.name = N'АСТ';

 --Найти всех авторов, которые написали книги определенного жанра:
 SELECT Author1.name
 , Book1.genre AS [book genre]
FROM Author AS Author1
 , Wrote
 , Book AS Book1
WHERE MATCH(Author1-(Wrote)->Book1)
 AND Book1.genre = N'Роман';

 --Найти все книги, написанные авторами, которых рекомендует определенный автор:
 SELECT Book1.title AS [book title]
FROM Author AS Author1
 , Recommends
 , Author AS Author2
 , Wrote
 , Book AS Book1
WHERE MATCH(Author1-(Recommends)->Author2-(Wrote)->Book1)
 AND Author1.name = N'Лев Толстой';

 --6. Используя функцию SHORTEST_PATH, напишите не менее 2 различных запросов к построенной графовой базе данных (используйте как шаблон "+", так и "{1,n}").
--Запрос для поиска всех авторов, которых рекомендовал определенный автор:

SELECT 
    A1.name AS Author1Name,
    STRING_AGG(A2.name, '->') WITHIN GROUP (GRAPH PATH) AS RecommendedAuthors
FROM 
    Author AS A1,
	Author FOR PATH AS A2, 
	Recommends FOR PATH AS Recommends
WHERE MATCH(SHORTEST_PATH(A1(-(Recommends)->A2)+))
	and A1.name = N'Лев Толстой';

--Запрос для поиска всех авторов, которых рекомендовал определенный автор, с ограничением на глубину поиска до двух уровней:

SELECT 
    A1.name AS Author1Name,
    STRING_AGG(A2.name, '->') WITHIN GROUP (GRAPH PATH) AS RecommendedAuthors
FROM 
    Author AS A1,
	Author FOR PATH AS A2, 
	Recommends FOR PATH AS Recommends
WHERE MATCH(SHORTEST_PATH(A1(-(Recommends)->A2){1,2}))
	and A1.name = N'Лев Толстой';










