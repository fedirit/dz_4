-- ДЗ_4 Задание 2:
-- 1. Название и продолжительность самого длительного трека
-- v.1
select name name_max, duration duration_max from table_tracks
where duration =  (select max(duration) from table_tracks)

-- ДЗ_4 Задание 2:
-- 1. Название и продолжительность самого длительного трека
-- v.2
--select name, duration from table_tracks
--order by duration desc 
--limit 1

-- ДЗ_4 Задание 2:
-- 2. Название треков, продолжительность которых не менее 3,5 минут
select name from table_tracks
where duration >= 3.5 * 60

-- ДЗ_4 Задание 2:
-- 3. Названия сборников, вышедших в период с 2018 по 2020 год включительно
select "name" from table_collections
where release_year between 2018 and 2020

-- ДЗ_4 Задание 2:
-- 4. Исполнители, чьё имя состоит из одного слова
select nickname from table_performers tp
where not nickname like '% %'

-- ДЗ_4 Задание 2:
-- 5. Название треков, которые содержат слово «мой» или «my»
select name from table_tracks
where "name" like '%my%'  
	or "name" like '%мой%'
	
	
-- ДЗ_4 Задание 3:
-- 1. Количество исполнителей в каждом жанре
select table_genres.name as genre_name, count(table_performers.nickname) as count_of_performer from table_genres_and_performers 
	join table_genres on table_genres_and_performers.genre = table_genres.guid_genre 
	join table_performers on table_genres_and_performers.performer = table_performers.guid_performer
	group by genre_name
	order by count_of_performer
	
-- ДЗ_4 Задание 3:
-- 2. Количество треков, вошедших в альбомы 2019–2020 годов
select count(table_tracks.name) as count_track_2019_2020 from table_tracks
	join table_albums on table_albums.guid_album = table_tracks.album 
	where table_albums.year_release between 2019 and 2020
	
-- ДЗ_4 Задание 3:
-- 3.	Средняя продолжительность треков по каждому альбому
select table_albums.name as album_name, avg(table_tracks.duration) as avg_track_duration from table_tracks 
	join table_albums on table_albums.guid_album = table_tracks.album
	group by album_name
	
-- ДЗ_4 Задание 3:
-- 4.	Все исполнители, которые не выпустили альбомы в 2020 году
--select 
--	table_performers.nickname as performer_nickname, 
--	table_albums.name as album_name, 
--	table_albums.year_release as year_release1
--select distinct table_performers.nickname as performer_nickname 
--	from table_albums_and_performers 
--		join table_albums on table_albums.guid_album = table_albums_and_performers.album
--		join table_performers on table_performers.guid_performer = table_albums_and_performers.performer 
--			where year_release <> 2020
--				order by performer_nickname
--select distinct table_performers.nickname from table_albums_and_performers
--join table_albums on table_albums_and_performers.album = table_albums.guid_album
--join table_performers on table_albums_and_performers.performer = table_performers.guid_performer 
--where table_albums.name in  (select name from table_albums where year_release = 2020)

--доработка ДЗ_4 Задание 3:
SELECT nickname FROM table_performers
where nickname not in (select distinct table_performers.nickname from table_albums_and_performers
join table_albums on table_albums_and_performers.album = table_albums.guid_album
join table_performers on table_albums_and_performers.performer = table_performers.guid_performer 
where table_albums.name in (select name from table_albums where year_release = 2020))

				
-- ДЗ_4 Задание 3:
-- 5. Названия сборников, в которых присутствует конкретный исполнитель (выберите его сами)
--select table_collections.name as collection_name, table_tracks.name as track_name, table_albums.name as album, table_performers.nickname as performer from table_collections
select distinct  table_collections.name as collection_name, table_performers.nickname as performer from table_collections
	join table_collections_and_tracks on table_collections_and_tracks.collection = table_collections.guid_collection  
	join table_tracks on table_tracks.guid_track = table_collections_and_tracks.track
	join table_albums on table_albums.guid_album = table_tracks.album
	join table_albums_and_performers on table_albums_and_performers.album = table_albums.guid_album
	join table_performers on table_performers.guid_performer = table_albums_and_performers.performer
		where table_performers.nickname = 'Nyusha'
			order by collection_name