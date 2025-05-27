CREATE DATABASE IF NOT EXISTS redes_sociales;
USE redes_sociales;

-- Tabla de usuarios
CREATE TABLE usuarios (
    UsuarioID INT PRIMARY KEY,
    Nombre VARCHAR(50),
    Apellido VARCHAR(50),
    Edad INT,
    Ciudad VARCHAR(50),
    Seguidores INT,
    FotosPublicadas INT
);

-- Tabla de fotos
CREATE TABLE fotos (
    FotoID INT PRIMARY KEY,
    UsuarioID INT,
    Descripcion VARCHAR(255),
    Fecha DATE,
    MeGusta INT,
    FOREIGN KEY (UsuarioID) REFERENCES usuarios(UsuarioID)
);

-- Tabla de comentarios
CREATE TABLE comentarios (
    ComentarioID INT PRIMARY KEY,
    FotoID INT,
    UsuarioID INT,
    Comentario TEXT,
    Fecha DATE,
    FOREIGN KEY (FotoID) REFERENCES fotos(FotoID),
    FOREIGN KEY (UsuarioID) REFERENCES usuarios(UsuarioID)
);

-- Datos para usuarios
INSERT INTO usuarios (UsuarioID, Nombre, Apellido, Edad, Ciudad, Seguidores, FotosPublicadas) VALUES
(1, 'Sofía', 'López', 25, 'Madrid', 1200, 5),
(2, 'Andrés', 'García', 30, 'Barcelona', 800, 3),
(3, 'Valeria', 'Martínez', 22, 'Valencia', 950, 4);

-- Datos para fotos
INSERT INTO fotos (FotoID, UsuarioID, Descripcion, Fecha, MeGusta) VALUES
(1, 1, 'Atardecer en la playa', '2025-04-01', 250),
(2, 1, 'Desayuno saludable', '2025-04-03', 180),
(3, 2, 'Montañas nevadas', '2025-04-02', 300),
(4, 3, 'Retrato artístico', '2025-04-05', 210);

-- Datos para comentarios
INSERT INTO comentarios (ComentarioID, FotoID, UsuarioID, Comentario, Fecha) VALUES
(1, 1, 2, '¡Qué bonito paisaje!', '2025-04-01'),
(2, 1, 3, 'Me encanta el color del cielo.', '2025-04-02'),
(3, 2, 3, 'Muy saludable, me encanta.', '2025-04-03'),
(4, 3, 1, 'Hermosa vista', '2025-04-04'),
(5, 4, 2, '¡Muy buen retrato!', '2025-04-05');

-- INNER JOIN
-- Relacionar usuarios con sus fotos publicadas
SELECT 
    usuarios.UsuarioID,
    usuarios.Nombre,
    usuarios.Apellido,
    fotos.FotoID,
    fotos.Descripcion,
    fotos.Fecha,
    fotos.MeGusta
FROM usuarios
INNER JOIN fotos ON usuarios.UsuarioID = fotos.UsuarioID;

-- Relacionar fotos con los comentarios recibidos
SELECT 
    fotos.FotoID,
    fotos.Descripcion,
    comentarios.ComentarioID,
    comentarios.UsuarioID AS UsuarioQueComento,
    comentarios.Comentario,
    comentarios.Fecha AS FechaComentario
FROM fotos
INNER JOIN comentarios ON fotos.FotoID = comentarios.FotoID;

-- Relacionar usuarios con sus comentarios realizados
SELECT 
    usuarios.UsuarioID,
    usuarios.Nombre,
    usuarios.Apellido,
    comentarios.ComentarioID,
    comentarios.FotoID,
    comentarios.Comentario,
    comentarios.Fecha
FROM usuarios
INNER JOIN comentarios ON usuarios.UsuarioID = comentarios.UsuarioID;

-- LEFT JOIN
-- Mostrar todos los usuarios, incluyendo aquellos que no han subido ninguna foto
SELECT 
    usuarios.UsuarioID,
    usuarios.Nombre,
    usuarios.Apellido,
    fotos.FotoID,
    fotos.Descripcion,
    fotos.Fecha,
    fotos.MeGusta
FROM usuarios
LEFT JOIN fotos ON usuarios.UsuarioID = fotos.UsuarioID;

-- Mostrar todas las fotos, incluyendo las que no tienen comentarios
SELECT 
    fotos.FotoID,
    fotos.Descripcion,
    fotos.Fecha,
    fotos.MeGusta,
    comentarios.ComentarioID,
    comentarios.UsuarioID AS UsuarioQueComento,
    comentarios.Comentario,
    comentarios.Fecha AS FechaComentario
FROM fotos
LEFT JOIN comentarios ON fotos.FotoID = comentarios.FotoID;

-- Mostrar todos los usuarios, incluyendo aquellos que no han realizado ningún comentario
SELECT 
    usuarios.UsuarioID,
    usuarios.Nombre,
    usuarios.Apellido,
    comentarios.ComentarioID,
    comentarios.FotoID,
    comentarios.Comentario,
    comentarios.Fecha
FROM usuarios
LEFT JOIN comentarios ON usuarios.UsuarioID = comentarios.UsuarioID;

-- RIGHT JOIN
-- Mostrar todas las fotos, incluso las que no están asociadas a ningún usuario
SELECT 
    usuarios.UsuarioID,
    usuarios.Nombre,
    usuarios.Apellido,
    fotos.FotoID,
    fotos.Descripcion,
    fotos.Fecha,
    fotos.MeGusta
FROM usuarios
RIGHT JOIN fotos ON usuarios.UsuarioID = fotos.UsuarioID;

-- Mostrar todos los comentarios, incluso los que no están asociados a ninguna foto
SELECT 
    fotos.FotoID,
    fotos.Descripcion,
    comentarios.ComentarioID,
    comentarios.UsuarioID,
    comentarios.Comentario,
    comentarios.Fecha
FROM fotos
RIGHT JOIN comentarios ON fotos.FotoID = comentarios.FotoID;

-- Mostrar todos los comentarios, incluso los que no están asociados a ningún usuario
SELECT 
    usuarios.UsuarioID,
    usuarios.Nombre,
    usuarios.Apellido,
    comentarios.ComentarioID,
    comentarios.FotoID,
    comentarios.Comentario,
    comentarios.Fecha
FROM usuarios
RIGHT JOIN comentarios ON usuarios.UsuarioID = comentarios.UsuarioID;

-- FULL OUTER JOIN
-- Mostrar todos los usuarios y fotos, incluidas las que no tienen relación entre sí
SELECT 
    usuarios.UsuarioID,
    usuarios.Nombre,
    usuarios.Apellido,
    fotos.FotoID,
    fotos.Descripcion,
    fotos.Fecha,
    fotos.MeGusta
FROM usuarios
LEFT JOIN fotos ON usuarios.UsuarioID = fotos.UsuarioID

UNION

SELECT 
    usuarios.UsuarioID,
    usuarios.Nombre,
    usuarios.Apellido,
    fotos.FotoID,
    fotos.Descripcion,
    fotos.Fecha,
    fotos.MeGusta
FROM usuarios
RIGHT JOIN fotos ON usuarios.UsuarioID = fotos.UsuarioID;

-- Mostrar todas las fotos y comentarios, incluidos los no relacionados entre sí
SELECT 
    fotos.FotoID,
    fotos.Descripcion,
    comentarios.ComentarioID,
    comentarios.UsuarioID AS UsuarioQueComento,
    comentarios.Comentario,
    comentarios.Fecha AS FechaComentario
FROM fotos
LEFT JOIN comentarios ON fotos.FotoID = comentarios.FotoID

UNION

SELECT 
    fotos.FotoID,
    fotos.Descripcion,
    comentarios.ComentarioID,
    comentarios.UsuarioID AS UsuarioQueComento,
    comentarios.Comentario,
    comentarios.Fecha AS FechaComentario
FROM fotos
RIGHT JOIN comentarios ON fotos.FotoID = comentarios.FotoID;

-- Mostrar todos los usuarios y comentarios, incluidos los no relacionados entre sí
SELECT 
    usuarios.UsuarioID,
    usuarios.Nombre,
    usuarios.Apellido,
    comentarios.ComentarioID,
    comentarios.FotoID,
    comentarios.Comentario,
    comentarios.Fecha
FROM usuarios
LEFT JOIN comentarios ON usuarios.UsuarioID = comentarios.UsuarioID

UNION

SELECT 
    usuarios.UsuarioID,
    usuarios.Nombre,
    usuarios.Apellido,
    comentarios.ComentarioID,
    comentarios.FotoID,
    comentarios.Comentario,
    comentarios.Fecha
FROM usuarios
RIGHT JOIN comentarios ON usuarios.UsuarioID = comentarios.UsuarioID;











