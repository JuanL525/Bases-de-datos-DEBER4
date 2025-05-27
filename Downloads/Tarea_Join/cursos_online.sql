CREATE DATABASE IF NOT EXISTS cursos_online;
USE cursos_online;

-- Tabla de instructores
CREATE TABLE instructores (
    InstructorID INT PRIMARY KEY,
    Nombre VARCHAR(100),
    Especialidad VARCHAR(100)
);

-- Tabla de cursos
CREATE TABLE cursos (
    CursoID INT PRIMARY KEY,
    NombreCurso VARCHAR(100),
    FechaInscripcion DATE,
    InstructorID INT,
    FOREIGN KEY (InstructorID) REFERENCES instructores(InstructorID)
);

-- Tabla de estudiantes
CREATE TABLE estudiantes (
    EstudianteID INT PRIMARY KEY,
    NombreEstudiante VARCHAR(100),
    FechaInscripcion DATE
);

-- Tabla de inscripciones
CREATE TABLE inscripciones (
    InscripcionID INT PRIMARY KEY,
    EstudianteID INT,
    CursoID INT,
    FOREIGN KEY (EstudianteID) REFERENCES estudiantes(EstudianteID),
    FOREIGN KEY (CursoID) REFERENCES cursos(CursoID)
);

-- Tabla de lecciones completadas
CREATE TABLE leccionescompletadas (
    LeccionID INT PRIMARY KEY,
    EstudianteID INT,
    CursoID INT,
    LeccionesCompletadas INT,
    FOREIGN KEY (EstudianteID) REFERENCES estudiantes(EstudianteID),
    FOREIGN KEY (CursoID) REFERENCES cursos(CursoID)
);

-- Datos para instructores
INSERT INTO instructores (InstructorID, Nombre, Especialidad) VALUES
(1, 'Laura Gómez', 'Programación'),
(2, 'Pedro Sánchez', 'Diseño Gráfico'),
(3, 'Ana Torres', 'Marketing Digital');

-- Datos para cursos
INSERT INTO cursos (CursoID, NombreCurso, FechaInscripcion, InstructorID) VALUES
(1, 'Introducción a Python', '2025-04-01', 1),
(2, 'Photoshop Básico', '2025-04-05', 2),
(3, 'Estrategias de Marketing', '2025-04-10', 3);

-- Datos para estudiantes
INSERT INTO estudiantes (EstudianteID, NombreEstudiante, FechaInscripcion) VALUES
(1, 'Carlos Martínez', '2025-04-02'),
(2, 'Lucía Fernández', '2025-04-03'),
(3, 'David Romero', '2025-04-04');

-- Datos para inscripciones
INSERT INTO inscripciones (InscripcionID, EstudianteID, CursoID) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 2, 1),
(4, 3, 3);

-- Datos para lecciones completadas
INSERT INTO leccionescompletadas (LeccionID, EstudianteID, CursoID, LeccionesCompletadas) VALUES
(1, 1, 1, 10),
(2, 1, 2, 5),
(3, 2, 1, 8),
(4, 3, 3, 12);

-- INNER JOIN
-- Relacionar estudiantes con cursos en los que están inscritos
SELECT 
    estudiantes.EstudianteID,
    estudiantes.NombreEstudiante,
    cursos.CursoID,
    cursos.NombreCurso,
    inscripciones.InscripcionID
FROM 
    estudiantes
INNER JOIN 
    inscripciones ON estudiantes.EstudianteID = inscripciones.EstudianteID
INNER JOIN 
    cursos ON inscripciones.CursoID = cursos.CursoID;
    
-- Relacionar cursos con sus instructores
SELECT 
    cursos.CursoID,
    cursos.NombreCurso,
    instructores.InstructorID,
    instructores.Nombre AS NombreInstructor,
    instructores.Especialidad
FROM 
    cursos
INNER JOIN 
    instructores ON cursos.InstructorID = instructores.InstructorID;

-- Relacionar estudiantes con lecciones completadas
SELECT 
    estudiantes.EstudianteID,
    estudiantes.NombreEstudiante,
    leccionescompletadas.CursoID,
    leccionescompletadas.LeccionesCompletadas
FROM 
    estudiantes
INNER JOIN 
    leccionescompletadas ON estudiantes.EstudianteID = leccionescompletadas.EstudianteID;
    
-- LEFT JOIN
-- Mostrar todos los estudiantes, incluso aquellos que no están inscritos en ningún curso
SELECT 
    estudiantes.EstudianteID,
    estudiantes.NombreEstudiante,
    inscripciones.CursoID,
    inscripciones.InscripcionID
FROM 
    estudiantes
LEFT JOIN 
    inscripciones ON estudiantes.EstudianteID = inscripciones.EstudianteID;

-- Mostrar todos los cursos, incluyendo aquellos sin instructor asignado
SELECT 
    cursos.CursoID,
    cursos.NombreCurso,
    instructores.InstructorID,
    instructores.Nombre AS NombreInstructor
FROM 
    cursos
LEFT JOIN 
    instructores ON cursos.InstructorID = instructores.InstructorID;
    
-- Mostrar todos los estudiantes, incluso aquellos que no han completado ninguna lección
SELECT 
    estudiantes.EstudianteID,
    estudiantes.NombreEstudiante,
    leccionescompletadas.CursoID,
    leccionescompletadas.LeccionesCompletadas
FROM 
    estudiantes
LEFT JOIN 
    leccionescompletadas ON estudiantes.EstudianteID = leccionescompletadas.EstudianteID;
    
-- Mostrar todos los cursos, incluso aquellos que no tienen estudiantes inscritos
SELECT 
    cursos.CursoID,
    cursos.NombreCurso,
    inscripciones.EstudianteID
FROM inscripciones
RIGHT JOIN cursos ON inscripciones.CursoID = cursos.CursoID;

-- Mostrar todos los instructores, incluso aquellos que no tienen cursos a su cargo
SELECT 
    instructores.InstructorID,
    instructores.Nombre,
    cursos.CursoID,
    cursos.NombreCurso
FROM cursos
RIGHT JOIN instructores ON cursos.InstructorID = instructores.InstructorID;

-- Mostrar todas las lecciones, incluyendo las que no han sido completadas por ningún estudiante
SELECT 
    cursos.CursoID,
    cursos.NombreCurso,
    leccionescompletadas.EstudianteID,
    leccionescompletadas.LeccionesCompletadas
FROM leccionescompletadas
RIGHT JOIN cursos ON leccionescompletadas.CursoID = cursos.CursoID;

-- FULL OUTER JOIN
-- Mostrar todos los estudiantes y cursos, incluso los no relacionados entre sí
SELECT 
    estudiantes.EstudianteID,
    estudiantes.NombreEstudiante,
    cursos.CursoID,
    cursos.NombreCurso
FROM estudiantes
LEFT JOIN inscripciones ON estudiantes.EstudianteID = inscripciones.EstudianteID
LEFT JOIN cursos ON inscripciones.CursoID = cursos.CursoID

UNION

SELECT 
    estudiantes.EstudianteID,
    estudiantes.NombreEstudiante,
    cursos.CursoID,
    cursos.NombreCurso
FROM cursos
LEFT JOIN inscripciones ON cursos.CursoID = inscripciones.CursoID
LEFT JOIN estudiantes ON inscripciones.EstudianteID = estudiantes.EstudianteID;

-- Mostrar todos los cursos y instructores, incluidos los no relacionados entre sí
SELECT 
    cursos.CursoID,
    cursos.NombreCurso,
    instructores.InstructorID,
    instructores.Nombre
FROM cursos
LEFT JOIN instructores ON cursos.InstructorID = instructores.InstructorID

UNION

SELECT 
    cursos.CursoID,
    cursos.NombreCurso,
    instructores.InstructorID,
    instructores.Nombre
FROM instructores
LEFT JOIN cursos ON instructores.InstructorID = cursos.InstructorID;

-- Mostrar todos los estudiantes y lecciones, incluso las no relacionadas entre sí
SELECT 
    estudiantes.EstudianteID,
    estudiantes.NombreEstudiante,
    leccionescompletadas.LeccionID,
    leccionescompletadas.LeccionesCompletadas
FROM estudiantes
LEFT JOIN leccionescompletadas ON estudiantes.EstudianteID = leccionescompletadas.EstudianteID

UNION

SELECT 
    estudiantes.EstudianteID,
    estudiantes.NombreEstudiante,
    leccionescompletadas.LeccionID,
    leccionescompletadas.LeccionesCompletadas
FROM leccionescompletadas
LEFT JOIN estudiantes ON leccionescompletadas.EstudianteID = estudiantes.EstudianteID;







