--1. количество исполнителей в каждом жанре
SELECT genre_name, COUNT(*) FROM artist_genre ag
  JOIN genre g ON ag.genre_id = g.id
 GROUP BY genre_name;

--2. количество треков, вошедших в альбомы 2019-2020 годов
SELECT COUNT (*) FROM track t
  JOIN album a ON t.album_id = a.id 
 WHERE year_of_release IN (2019, 2020);

--3. средняя продолжительность треков по каждому альбому
SELECT album_name, AVG(track_duration) FROM track t
  JOIN album a ON t.album_id = a.id 
 GROUP BY album_name; 

--4. Все исполнители, которые не выпустили альбомы в 2020 году 
SELECT artist_name FROM artist 
 WHERE artist_name NOT IN (
       SELECT artist_name FROM artist ar
         JOIN artist_album aa ON ar.id = aa.artist_id 
         JOIN album al ON aa.album_id = al.id 
        WHERE year_of_release = 2020
);

--5. названия сборников, в которых присутствует конкретный исполнитель (например, Вольфганг Амадей Моцарт)
SELECT collection_name FROM collection c
  JOIN collection_track ct ON c.id = ct.collection_id 
  JOIN track t ON ct.track_id = t.id 
  JOIN album al ON t.album_id  = al.id
  JOIN artist_album aa ON al.id = aa.album_id 
  JOIN artist ar ON aa.artist_id = ar.id
 WHERE artist_name LIKE '%Моцарт%'
 GROUP BY collection_name; 

--6. название альбомов, в которых присутствуют исполнители более 1 жанра
SELECT album_name FROM album al
  JOIN artist_album aa ON al.id = aa.album_id 
  JOIN artist ar ON aa.artist_id = ar.id 
  JOIN artist_genre ag ON ar.id = ag.artist_id 
  JOIN genre g ON ag.genre_id = g.id
 GROUP BY album_name
HAVING COUNT(DISTINCT genre_name) > 1;

--7. наименование треков, которые не входят в сборники
SELECT track_name, track_id FROM track t 
  LEFT JOIN collection_track ct ON t.id = ct.track_id 
 WHERE track_id IS NULL;

--8. исполнитель(-ли), написавший самый короткий по продолжительности трек
SELECT artist_name, track_name, track_duration FROM artist ar
  JOIN artist_album aa ON ar.id = aa.artist_id 
  JOIN album al ON aa.album_id = al.id 
  JOIN track t ON al.id = t.album_id 
 WHERE track_duration = (SELECT MIN(track_duration) FROM track); 

--9. названия альбомов, содержащих наименьшее количество треков
SELECT album_name FROM track t
  JOIN album a ON t.album_id = a.id 
 WHERE album_id IN (
       SELECT album_id FROM track
        GROUP BY album_id
       HAVING COUNT(id) = (
              SELECT COUNT(id) FROM track 
               GROUP BY album_id 
               ORDER BY count 
               LIMIT 1
)
);