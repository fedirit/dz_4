CREATE TABLE IF NOT EXISTS table_performers (
	guid_performer SERIAL PRIMARY KEY,
	nickname VARCHAR(200) NOT null UNIQUE
);

CREATE TABLE IF NOT EXISTS table_albums (
	guid_album SERIAL PRIMARY KEY,
	name VARCHAR(300) NOT null UNIQUE,
	year_release INTEGER NOT null
);

CREATE TABLE IF NOT EXISTS table_genres (
	guid_genre SERIAL PRIMARY KEY,
	name VARCHAR(200) NOT null UNIQUE
);

CREATE TABLE IF NOT EXISTS table_collections (
	guid_collection SERIAL PRIMARY KEY,
	name VARCHAR(200) NOT null UNIQUE,
	release_year INTEGER NOT null
);

CREATE TABLE IF NOT EXISTS table_tracks (
	guid_track SERIAL PRIMARY KEY,
	name VARCHAR(200) NOT null UNIQUE,
	duration INTEGER NOT null,
	album INTEGER NOT NULL REFERENCES table_albums(guid_album) on delete Cascade
);

CREATE TABLE IF NOT EXISTS table_albums_and_performers (
	guid_album_and_performer SERIAL PRIMARY KEY,
	album INTEGER NOT NULL REFERENCES table_albums(guid_album) on delete Cascade,
	performer INTEGER NOT NULL REFERENCES table_performers(guid_performer) on delete Cascade,
	unique(album, performer)
);

CREATE TABLE IF NOT EXISTS table_genres_and_performers (
	guid_genre_and_performer SERIAL PRIMARY KEY,
	performer INTEGER NOT NULL REFERENCES table_performers(guid_performer) on delete Cascade,
	genre INTEGER NOT NULL REFERENCES table_genres(guid_genre)  on delete Cascade,
	unique(performer, genre)
);

CREATE TABLE IF NOT EXISTS table_collections_and_tracks (
	guid_genre_and_performer SERIAL PRIMARY KEY,
	collection INTEGER NOT NULL REFERENCES table_collections(guid_collection) on delete Cascade,
	track INTEGER NOT NULL REFERENCES table_tracks(guid_track) on delete Cascade,
	unique(collection, track)
);