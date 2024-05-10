DROP DATABASE IF EXISTS youtube;
CREATE DATABASE youtube CHARACTER SET utf8mb4;
USE youtube;

CREATE TABLE usuario (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    nombre VARCHAR(30) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    sexo VARCHAR(60),
    pais VARCHAR(20) NOT NULL,
    codigo_postal VARCHAR(20) NOT NULL
);

CREATE TABLE canal (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    descripcion VARCHAR(150) NOT NULL,
    fecha_creacion DATE NOT NULL,
    id_usuario INT UNSIGNED,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id)
);

CREATE TABLE video (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    descripcion VARCHAR(200) NULL,
    volumen INT NOT NULL,
    nombre_archivo VARCHAR(30) NOT NULL,
    duracion_minutos INT NOT NULL,
    thumbnail BLOB NOT NULL,
    reproducciones INT NOT NULL,
    likes INT UNSIGNED NOT NULL,
    dislikes INT UNSIGNED NOT NULL,
    estado ENUM("público", "oculto", "privado"),
    fecha_publicado DATETIME NOT NULL,
	id_usuario INT UNSIGNED NOT NULL,
    id_canal INT UNSIGNED NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id),
    FOREIGN KEY (id_canal) REFERENCES canal(id)
);

CREATE TABLE etiqueta (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30),
    id_video INT UNSIGNED NOT NULL,
    FOREIGN KEY (id_video) REFERENCES video(id)
);

CREATE TABLE subscriptores (
	id_subscriptor INT UNSIGNED NOT NULL,
    id_canal INT UNSIGNED NOT NULL,
    FOREIGN KEY (id_subscriptor) REFERENCES usuario(id),
    FOREIGN KEY (id_canal) REFERENCES canal(id)
);

CREATE TABLE video_likes (
	id_usuario INT UNSIGNED NOT NULL,
    id_video INT UNSIGNED NOT NULL,
    tipo ENUM("like", "dislike") NOT NULL,
    fecha_hora DATETIME NOT NULL,
	FOREIGN KEY (id_usuario) REFERENCES usuario(id),
    FOREIGN KEY (id_video) REFERENCES video(id)
);

CREATE TABLE playlist (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    fecha_creacion DATE NOT NULL,
    estado ENUM("publica", "privada"),
    id_usuario INT UNSIGNED NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id)
);

CREATE TABLE playlist_video (
	id_playlist INT UNSIGNED NOT NULL,
    id_video INT UNSIGNED NOT NULL,
    FOREIGN KEY (id_playlist) REFERENCES playlist(id),
    FOREIGN KEY (id_video) REFERENCES video(id)
);

CREATE TABLE comentario (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    texto VARCHAR(500) NOT NULL,
    fecha_hora_creacion DATETIME NOT NULL
);

CREATE TABLE comentario_likes (
	id_comentario INT UNSIGNED,
    id_usuario INT UNSIGNED,
	tipo ENUM("like", "dislike") NOT NULL,
    fecha_hora DATETIME NOT NULL,
    FOREIGN KEY (id_comentario) REFERENCES comentario(id),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id)
);