--	не менее 4 исполнителей
INSERT INTO table_performers(guid_performer, nickname)
VALUES(nextval('table_performers_guid_performer_seq'::regclass), 'Shaman'),
	(nextval('table_performers_guid_performer_seq'::regclass), 'Nyusha'),
	(nextval('table_performers_guid_performer_seq'::regclass), 'Лёша Свик'),
	(nextval('table_performers_guid_performer_seq'::regclass), 'Mary Gu'),
	(nextval('table_performers_guid_performer_seq'::regclass), 'FINIK'),
	(nextval('table_performers_guid_performer_seq'::regclass), 'Мохито'),
	(nextval('table_performers_guid_performer_seq'::regclass), 'Денис RiDer'),
	(nextval('table_performers_guid_performer_seq'::regclass), 'Родион Газманов')
--  или
--  ON CONFLICT (nickname) where nickname = 'Shaman' or ............ DO nothing;
ON CONFLICT (nickname) DO nothing;

--  не менее 3 жанров
INSERT INTO table_genres
(guid_genre, "name")
VALUES(nextval('table_genres_guid_genre_seq'::regclass), 'романс'),
	(nextval('table_genres_guid_genre_seq'::regclass), 'квартет'),
	(nextval('table_genres_guid_genre_seq'::regclass), 'симфония'),
	(nextval('table_genres_guid_genre_seq'::regclass), 'хардкор'),
	(nextval('table_genres_guid_genre_seq'::regclass), 'диско'),
	(nextval('table_genres_guid_genre_seq'::regclass), 'техно'),
	(nextval('table_genres_guid_genre_seq'::regclass), 'песня'),
	(nextval('table_genres_guid_genre_seq'::regclass), 'серенада')
ON CONFLICT (name) DO nothing;

--	не менее 3 альбомов
INSERT INTO table_albums
(guid_album, "name", year_release)
VALUES(nextval('table_albums_guid_album_seq'::regclass), 'Выбирать Чудо', 2016),
	(nextval('table_albums_guid_album_seq'::regclass), 'Заново', 2023),
	(nextval('table_albums_guid_album_seq'::regclass), 'Караван', 2020),
	(nextval('table_albums_guid_album_seq'::regclass), 'Фибрами', 2021)
ON CONFLICT (name) DO nothing;

--  не менее 6 треков
--INSERT INTO table_tracks
--(guid_track, "name", duration, album)
--VALUES(nextval('table_tracks_guid_track_seq'::regclass), 'Чудо', 150, 1),
--	(nextval('table_tracks_guid_track_seq'::regclass), 'Чудо-юдо', 151, 1),
--	(nextval('table_tracks_guid_track_seq'::regclass), 'Фибры от либры', 180, 4),
--	(nextval('table_tracks_guid_track_seq'::regclass), 'Караван верблюдов в пустыне', 208, 3),
--	(nextval('table_tracks_guid_track_seq'::regclass), 'Чебурашка на луне', 120, 2),
--	(nextval('table_tracks_guid_track_seq'::regclass), 'Позишен №2', 180, 4),
--	(nextval('table_tracks_guid_track_seq'::regclass), 'Карлсон берет интервью', 170, 1)
--ON CONFLICT (name) DO nothing;

WITH ins (guid_track, name, duration, album) AS
( VALUES
    (nextval('table_tracks_guid_track_seq'::regclass), 'Чудо',  150,  'Выбирать Чудо'),
    (nextval('table_tracks_guid_track_seq'::regclass), 'Чудо-юдо',  151,  'Выбирать Чудо'),
    (nextval('table_tracks_guid_track_seq'::regclass), 'Фибры от либры',  180,  'Фибрами'),
    (nextval('table_tracks_guid_track_seq'::regclass), 'Караван верблюдов в пустыне',  208,  'Караван'),
    (nextval('table_tracks_guid_track_seq'::regclass), 'Чебурашка на луне',  120,  'Заново'),
    (nextval('table_tracks_guid_track_seq'::regclass), 'Позишен №2',  180,  'Фибрами'),
    (nextval('table_tracks_guid_track_seq'::regclass), 'Карлсон берет интервью',  170,  'Выбирать Чудо'),
    (nextval('table_tracks_guid_track_seq'::regclass), 'Бейби ту найт',  370,  'Выбирать Чудо')
)
INSERT INTO table_tracks
   (guid_track, name, duration, album) 
SELECT 
    ins.guid_track, ins.name, ins.duration, table_albums.guid_album  
FROM 
  table_albums JOIN ins ON ins.album = table_albums.name 
ON CONFLICT (name) DO nothing;




-- 	не менее 4 сборников
INSERT INTO table_collections
(guid_collection, "name", release_year)
VALUES(nextval('table_collections_guid_collection_seq'::regclass), 'Сборник 1', 2016),
	(nextval('table_collections_guid_collection_seq'::regclass), 'Сборник 2', 2017),
	(nextval('table_collections_guid_collection_seq'::regclass), 'Сборник 3', 2018),
	(nextval('table_collections_guid_collection_seq'::regclass), 'Сборник 4', 2019),
	(nextval('table_collections_guid_collection_seq'::regclass), 'Сборник 5', 2020),
	(nextval('table_collections_guid_collection_seq'::regclass), 'Сборник 6', 2021),
	(nextval('table_collections_guid_collection_seq'::regclass), 'Сборник 7', 2022),
	(nextval('table_collections_guid_collection_seq'::regclass), 'Сборник 8', 2023)
ON CONFLICT (name) DO nothing;

-- 	и другие таблицы
--  table_collections_and_tracks
--  first variant
WITH ins (guid_genre_and_performer, collection, track) AS
( VALUES
    (nextval('table_collections_and_tracks_guid_genre_and_performer_seq'::regclass), 'Сборник 1',   'Чудо') ,
    (nextval('table_collections_and_tracks_guid_genre_and_performer_seq'::regclass), 'Сборник 1',   'Чудо-юдо'),
    (nextval('table_collections_and_tracks_guid_genre_and_performer_seq'::regclass), 'Сборник 2',   'Фибры от либры'),
    (nextval('table_collections_and_tracks_guid_genre_and_performer_seq'::regclass), 'Сборник 2',   'Караван верблюдов в пустыне'),
    (nextval('table_collections_and_tracks_guid_genre_and_performer_seq'::regclass), 'Сборник 3',   'Чебурашка на луне'),
    (nextval('table_collections_and_tracks_guid_genre_and_performer_seq'::regclass), 'Сборник 3',   'Позишен №2'),
    (nextval('table_collections_and_tracks_guid_genre_and_performer_seq'::regclass), 'Сборник 3',   'Карлсон берет интервью'),
    (nextval('table_collections_and_tracks_guid_genre_and_performer_seq'::regclass), 'Сборник 4',   'Чудо'),
    (nextval('table_collections_and_tracks_guid_genre_and_performer_seq'::regclass), 'Сборник 4',   'Чудо-юдо'),
    (nextval('table_collections_and_tracks_guid_genre_and_performer_seq'::regclass), 'Сборник 4',   'Фибры от либры'),
    (nextval('table_collections_and_tracks_guid_genre_and_performer_seq'::regclass), 'Сборник 5',   'Караван верблюдов в пустыне'),
    (nextval('table_collections_and_tracks_guid_genre_and_performer_seq'::regclass), 'Сборник 5',   'Чебурашка на луне'),
    (nextval('table_collections_and_tracks_guid_genre_and_performer_seq'::regclass), 'Сборник 6',   'Позишен №2'),
    (nextval('table_collections_and_tracks_guid_genre_and_performer_seq'::regclass), 'Сборник 6',   'Карлсон берет интервью'),
    (nextval('table_collections_and_tracks_guid_genre_and_performer_seq'::regclass), 'Сборник 7',   'Чудо'),
    (nextval('table_collections_and_tracks_guid_genre_and_performer_seq'::regclass), 'Сборник 7',   'Чудо-юдо'),
    (nextval('table_collections_and_tracks_guid_genre_and_performer_seq'::regclass), 'Сборник 8',   'Фибры от либры'),
    (nextval('table_collections_and_tracks_guid_genre_and_performer_seq'::regclass), 'Сборник 8',   'Караван верблюдов в пустыне')
)
INSERT INTO table_collections_and_tracks
   (guid_genre_and_performer, collection, track) 
SELECT 
    ins.guid_genre_and_performer, table_collections.guid_collection, table_tracks.guid_track
FROM 
  table_tracks JOIN ins ON ins.track = table_tracks.name 
  JOIN table_collections ON ins.collection = table_collections.name
ORDER BY table_collections.guid_collection, table_tracks.guid_track
ON CONFLICT (collection, track) DO nothing;

-- вариант 2
--WITH ins (collection, track) AS
--(VALUES
--    ('Сборник 1',   'Чудо') ,
--    ('Сборник 1',   'Чудо-юдо'),
--    ('',   '')
--)  
--INSERT INTO table_collections_and_tracks
--   (collection, track) 
--SELECT 
--    table_collections.guid_collection, table_tracks.guid_track
--FROM 
--  table_tracks JOIN ins ON ins.track = table_tracks.name 
--  JOIN table_collections ON ins.collection = table_collections.name
--ON CONFLICT (collection, track) DO nothing;

-- вариант 3
--INSERT INTO table_collections_and_tracks
--(guid_genre_and_performer, collection, track)
--VALUES(nextval('table_collections_and_tracks_guid_genre_and_performer_seq'::regclass), 1, (SELECT guid_track from public.table_tracks WHERE name='Чудо')),
--	(nextval('table_collections_and_tracks_guid_genre_and_performer_seq'::regclass), 1, (SELECT guid_track from public.table_tracks WHERE name='Чудо-юдо'))
--	(nextval('table_collections_and_tracks_guid_genre_and_performer_seq'::regclass), 1, 3)
--ON CONFLICT (collection, track) DO nothing;

--  table_albums_and_performers
WITH ins (guid_album_and_performer, album, performer) AS
( VALUES
    (nextval('table_albums_and_performers_guid_album_and_performer_seq'::regclass), 'Выбирать Чудо',   'Shaman'),
    (nextval('table_albums_and_performers_guid_album_and_performer_seq'::regclass), 'Заново',   		'Nyusha'),
    (nextval('table_albums_and_performers_guid_album_and_performer_seq'::regclass), 'Караван',   		'Лёша Свик'),
    (nextval('table_albums_and_performers_guid_album_and_performer_seq'::regclass), 'Фибрами',   		'Mary Gu'),
    (nextval('table_albums_and_performers_guid_album_and_performer_seq'::regclass), 'Выбирать Чудо',   	'FINIK'),
    (nextval('table_albums_and_performers_guid_album_and_performer_seq'::regclass), 'Заново',   		'Мохито'),
    (nextval('table_albums_and_performers_guid_album_and_performer_seq'::regclass), 'Караван',   		'Денис RiDer'),
    (nextval('table_albums_and_performers_guid_album_and_performer_seq'::regclass), 'Фибрами',   		'Родион Газманов'),
    (nextval('table_albums_and_performers_guid_album_and_performer_seq'::regclass), 'Выбирать Чудо',   	'Nyusha'),
    (nextval('table_albums_and_performers_guid_album_and_performer_seq'::regclass), 'Заново',   		'Лёша Свик'),
    (nextval('table_albums_and_performers_guid_album_and_performer_seq'::regclass), 'Караван',   		'Mary Gu'),
    (nextval('table_albums_and_performers_guid_album_and_performer_seq'::regclass), 'Фибрами',   		'FINIK'),
    (nextval('table_albums_and_performers_guid_album_and_performer_seq'::regclass), 'Выбирать Чудо',   	'Мохито'),
    (nextval('table_albums_and_performers_guid_album_and_performer_seq'::regclass), 'Заново',   		'Денис RiDer'),
    (nextval('table_albums_and_performers_guid_album_and_performer_seq'::regclass), 'Караван',   		'Родион Газманов'),
    (nextval('table_albums_and_performers_guid_album_and_performer_seq'::regclass), 'Фибрами',   		'Лёша Свик'),
    (nextval('table_albums_and_performers_guid_album_and_performer_seq'::regclass), 'Выбирать Чудо',   	'Mary Gu'),
    (nextval('table_albums_and_performers_guid_album_and_performer_seq'::regclass), 'Заново',   		'FINIK'),
    (nextval('table_albums_and_performers_guid_album_and_performer_seq'::regclass), 'Караван',   		'Мохито'),
    (nextval('table_albums_and_performers_guid_album_and_performer_seq'::regclass), 'Фибрами',   		'Денис RiDer')
)
INSERT INTO table_albums_and_performers
   (guid_album_and_performer, album, performer) 
SELECT 
    ins.guid_album_and_performer, table_albums.guid_album, table_performers.guid_performer
FROM 
  table_albums JOIN ins ON ins.album = table_albums.name 
  JOIN table_performers ON ins.performer = table_performers.nickname 
ORDER BY table_albums.guid_album, table_performers.guid_performer
ON CONFLICT (album, performer) DO nothing;

--  table_genres_and_performers
WITH ins (guid_genre_and_performer, performer, genre) AS
( VALUES
    (nextval('table_genres_and_performers_guid_genre_and_performer_seq'::regclass), 'Shaman',   'романс'),
    (nextval('table_genres_and_performers_guid_genre_and_performer_seq'::regclass), 'Nyusha',   'квартет'),
    (nextval('table_genres_and_performers_guid_genre_and_performer_seq'::regclass), 'Лёша Свик',   'симфония'),
    (nextval('table_genres_and_performers_guid_genre_and_performer_seq'::regclass), 'Mary Gu',   'хардкор'),
    (nextval('table_genres_and_performers_guid_genre_and_performer_seq'::regclass), 'FINIK',   'диско'),
    (nextval('table_genres_and_performers_guid_genre_and_performer_seq'::regclass), 'Мохито',   'симфония'),
    (nextval('table_genres_and_performers_guid_genre_and_performer_seq'::regclass), 'Денис RiDer',   'песня'),
    (nextval('table_genres_and_performers_guid_genre_and_performer_seq'::regclass), 'Родион Газманов',   'серенада'),
    (nextval('table_genres_and_performers_guid_genre_and_performer_seq'::regclass), 'Nyusha',   'романс'),
    (nextval('table_genres_and_performers_guid_genre_and_performer_seq'::regclass), 'Shaman',   'квартет'),
    (nextval('table_genres_and_performers_guid_genre_and_performer_seq'::regclass), 'Лёша Свик',   'хардкор'),
    (nextval('table_genres_and_performers_guid_genre_and_performer_seq'::regclass), 'Mary Gu',   'хардкор'),
    (nextval('table_genres_and_performers_guid_genre_and_performer_seq'::regclass), 'FINIK',   'серенада'),
    (nextval('table_genres_and_performers_guid_genre_and_performer_seq'::regclass), 'Мохито',   'техно'),
    (nextval('table_genres_and_performers_guid_genre_and_performer_seq'::regclass), 'Денис RiDer',   'хардкор'),
    (nextval('table_genres_and_performers_guid_genre_and_performer_seq'::regclass), 'Родион Газманов',   'хардкор'),
    (nextval('table_genres_and_performers_guid_genre_and_performer_seq'::regclass), 'Лёша Свик',   'романс'),
    (nextval('table_genres_and_performers_guid_genre_and_performer_seq'::regclass), 'Nyusha',   'квартет'),
    (nextval('table_genres_and_performers_guid_genre_and_performer_seq'::regclass), 'Shaman',   'симфония'),
    (nextval('table_genres_and_performers_guid_genre_and_performer_seq'::regclass), 'FINIK',   'хардкор'),
    (nextval('table_genres_and_performers_guid_genre_and_performer_seq'::regclass), 'Mary Gu',   'диско'),
    (nextval('table_genres_and_performers_guid_genre_and_performer_seq'::regclass), 'Родион Газманов',   'техно'),
    (nextval('table_genres_and_performers_guid_genre_and_performer_seq'::regclass), 'Мохито',   'песня'),
    (nextval('table_genres_and_performers_guid_genre_and_performer_seq'::regclass), 'Денис RiDer',   'серенада')
    -- видимо где-то повторzется, вносится строк меньше в таблицу
)
INSERT INTO table_genres_and_performers
   (guid_genre_and_performer, performer, genre) 
SELECT 
    ins.guid_genre_and_performer, table_performers.guid_performer, table_genres.guid_genre
FROM 
  table_performers JOIN ins ON ins.performer = table_performers.nickname 
  JOIN table_genres ON ins.genre = table_genres."name" 
ORDER BY table_performers.guid_performer, table_genres.guid_genre 
ON CONFLICT (performer, genre) DO nothing;