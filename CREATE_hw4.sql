CREATE TABLE IF NOT EXISTS genre (
    id SERIAL PRIMARY KEY,
    genre_name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS artist (
    id SERIAL PRIMARY KEY,
    artist_name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS artist_genre (
    genre_id INTEGER REFERENCES genre(id),
    artist_id INTEGER REFERENCES artist(id),
    CONSTRAINT pk PRIMARY KEY (genre_id, artist_id)
);

CREATE TABLE IF NOT EXISTS album (
    id SERIAL PRIMARY KEY,
    album_name VARCHAR(50) UNIQUE NOT NULL,
    year_of_release INTEGER CHECK (year_of_release > 1900)
);

CREATE TABLE IF NOT EXISTS artist_album (
    album_id INTEGER REFERENCES album(id),
    artist_id INTEGER REFERENCES artist(id),
    CONSTRAINT pk2 PRIMARY KEY (album_id, artist_id)
);

CREATE TABLE IF NOT EXISTS track (
    id SERIAL PRIMARY KEY,
    album_id INTEGER NOT NULL REFERENCES album(id),
    track_name VARCHAR(50) UNIQUE NOT NULL,
    track_duration INTERVAL MINUTE TO SECOND NOT NULL
);

CREATE TABLE IF NOT EXISTS collection (
    id SERIAL PRIMARY KEY,
    collection_name VARCHAR(50) UNIQUE NOT NULL,
    year_of_release INTEGER CHECK (year_of_release > 1900)
);

CREATE TABLE IF NOT EXISTS collection_track (
    track_id INTEGER REFERENCES track(id),
    collection_id INTEGER REFERENCES collection(id),
    CONSTRAINT pk3 PRIMARY KEY (track_id, collection_id)
);