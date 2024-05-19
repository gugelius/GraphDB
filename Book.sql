USE master;
GO

DROP DATABASE IF EXISTS Book;
GO

CREATE DATABASE Book;
GO

USE Book;
--1. �������� �� ����� ��� ������ �����. ��������, ������������, ���������� (�������������), ������� ����������, ����� (����� ����), ������ (����� ����), ������.
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
--2. �������� �� ����� ��� ������ ����. ��������, ������, ���������, ��������� �������� �������, ����������� ����� ��� ����� (����).
CREATE TABLE Wrote AS EDGE; -- ����� ����� ������� �����

CREATE TABLE Published AS EDGE; -- ����� ������������ ������������ �����

CREATE TABLE Recommends AS EDGE; -- ����� ����� ����������� ������

ALTER TABLE Wrote
ADD CONSTRAINT EC_Wrote CONNECTION (Author TO Book);
GO

ALTER TABLE Published
ADD CONSTRAINT EC_Published CONNECTION (Publisher TO Book);
GO

ALTER TABLE Recommends
ADD CONSTRAINT EC_Recommends CONNECTION (Author TO Author);
GO
--3. ��������� ��� ������ ������ ����� �� ����� 10 �����.
INSERT INTO Book (id, title, genre)
VALUES 
	(1, '����� � ���', '�����'),--
	(2, '������������ � ���������', '�����'),
	(3, '������ � ���������', '�����'),
	(4, '�����', '�����'),
	(5, '������ ����������', '�����'),
	(6, '�����2033','���������������'),
	(7,'����� ������ � ����� �������','�����'),
	(8,'�������','�������'),
	(9,'̸����� ����','�����'),
	(10,'������ � ����','�����'),
	(11,'����� �����','������� ����������'),
	(12,'����� ������ �������','�����'),
	(13,'���� � ����','�����'),
	(14,'�������-���������','������� ����������'),
	(15,'����� ���','�����');
GO

INSERT INTO Author (id, name)
VALUES
	(1, '��� �������'),
	(2, 'Ը��� �����������'),
	(3, '������ ��������'),
	(4, '������� ����������'),
	(5, '����� �������'),
	(6, '������� ������'),
	(7, '������ ���������'),
	(8, '������� �����'),
	(9, '������ ���������'),
	(10, '���� ��������');
GO

INSERT INTO Publisher (id, name, city)
VALUES
	(1, '���', '������'),
	(2, '�����', '������'),
	(3, '�����������', '������'),
	(4, '������', '������'),
	(5, '������-�������', '�����-���������'),
	(6, '������', '������'),
	(7, '������� ��������', '������'),
	(8, '���', '������'),
	(9, '�����', '�����-���������'),
	(10, '������', '�����-���������');
GO
--4. ������� ������ � ������� ���� ��� ������������ ������ ����� ����� ������.
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

--5. ��������� ������� MATCH, �������� �� ����� 5 ��������� �������� � ����������� �������� ���� ������.
--����� ��� �����, ���������� ������� � ������������ ������:
SELECT Author1.name
 , Book1.title AS [book title]
FROM Author AS Author1
 , Wrote
 , Book AS Book1
WHERE MATCH(Author1-(Wrote)->Book1)
 AND Author1.name = N'������� ������';

 --����� ���� �������, ������� ����������� ������������� ������:
SELECT Author1.name
 , Author2.name AS [recommended author]
FROM Author AS Author1
 , Recommends
 , Author AS Author2
WHERE MATCH(Author1-(Recommends)->Author2)
 AND Author1.name = N'������� ����������';

 --����� ��� �����, �������������� ������������ �������������:
 SELECT Publisher1.name
 , Book1.title AS [book title]
FROM Publisher AS Publisher1
 , Published
 , Book AS Book1
WHERE MATCH(Publisher1-(Published)->Book1)
 AND Publisher1.name = N'���';

 --����� ���� �������, ������� �������� ����� ������������� �����:
 SELECT Author1.name
 , Book1.genre AS [book genre]
FROM Author AS Author1
 , Wrote
 , Book AS Book1
WHERE MATCH(Author1-(Wrote)->Book1)
 AND Book1.genre = N'�����';

 --����� ��� �����, ���������� ��������, ������� ����������� ������������ �����:
 SELECT Book1.title AS [book title]
FROM Author AS Author1
 , Recommends
 , Author AS Author2
 , Wrote
 , Book AS Book1
WHERE MATCH(Author1-(Recommends)->Author2-(Wrote)->Book1)
 AND Author1.name = N'��� �������';

 --6. ��������� ������� SHORTEST_PATH, �������� �� ����� 2 ��������� �������� � ����������� �������� ���� ������ (����������� ��� ������ "+", ��� � "{1,n}").
--������ ��� ������ ���� �������, ������� ������������ ������������ �����:

SELECT 
    A1.name AS Author1Name,
    STRING_AGG(A2.name, '->') WITHIN GROUP (GRAPH PATH) AS RecommendedAuthors
FROM 
    Author AS A1,
	Author FOR PATH AS A2, 
	Recommends FOR PATH AS Recommends
WHERE MATCH(SHORTEST_PATH(A1(-(Recommends)->A2)+))
	and A1.name = N'��� �������';

--������ ��� ������ ���� �������, ������� ������������ ������������ �����, � ������������ �� ������� ������ �� ���� �������:

SELECT 
    A1.name AS Author1Name,
    STRING_AGG(A2.name, '->') WITHIN GROUP (GRAPH PATH) AS RecommendedAuthors
FROM 
    Author AS A1,
	Author FOR PATH AS A2, 
	Recommends FOR PATH AS Recommends
WHERE MATCH(SHORTEST_PATH(A1(-(Recommends)->A2){1,2}))
	and A1.name = N'��� �������';










