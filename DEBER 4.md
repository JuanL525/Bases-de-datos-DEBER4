-- Crear base de datos y seleccionarla
CREATE DATABASE IF NOT EXISTS libreria;
USE libreria;
DROP TABLE IF EXISTS venta;
DROP TABLE IF EXISTS libro;
DROP TABLE IF EXISTS cliente;
DROP TABLE IF EXISTS autor;

-- Crear tabla autor
CREATE TABLE autor (
    id_autor INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    nacionalidad VARCHAR(50),
    fechaNacimiento date
);

-- Crear tabla libro
CREATE TABLE libro (
    id_libro INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(150),
    precio decimal (10,2) NOT NULL,
    fechaPublicacion date,
    id_autor INT,
    FOREIGN KEY (id_autor) REFERENCES autor(id_autor)
);

-- Crear tabla cliente
CREATE TABLE cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido varchar(100) NOT NULL,
    fechaNacimiento DATE NOT NULL,
    email VARCHAR(100) unique,
    direccion VARCHAR(255),
    telefono VARCHAR(20)
);

-- Crear tabla venta (con FK a libro y cliente)
CREATE TABLE venta (
    id_venta INT AUTO_INCREMENT PRIMARY KEY,
    fecha DATE,
    cantidad INT,
    id_libro INT,
    id_cliente INT,
    FOREIGN KEY (id_libro) REFERENCES libro(id_libro),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);


-- Insertar registros en autor
INSERT INTO autor (nombre, apellido, nacionalidad, fechaNacimiento) VALUES
('Mario', 'Vargas Llosa', 'Peruano', '1936-03-28'),
('Laura', 'Esquivel', 'Mexicana', '1950-09-30'),
('Stephen', 'King', 'Estadounidense', '1947-09-21'),
('Haruki', 'Murakami', 'Japonés', '1949-01-12'),
('Jane', 'Austen', 'Británica', '1775-12-16');

-- Insertar registros en libro
INSERT INTO libro (titulo, precio, fechaPublicacion, id_autor) VALUES
('La ciudad y los perros', 39.90, '1963-10-01', 1),
('Como agua para chocolate', 29.50, '1989-01-01', 2),
('It', 45.99, '1986-09-15', 3),
('Tokio Blues', 34.80, '1987-04-06', 4),
('Orgullo y prejuicio', 22.00, '1813-01-28', 5);

-- Insertar registros en cliente
INSERT INTO cliente (nombre, apellido, fechaNacimiento, email, direccion, telefono) VALUES
('Andrés', 'Lopez', '1990-05-12', 'andres.lopez@email.com', 'Av. Siempre Viva 123', '555-1234'),
('Carla', 'Ramírez', '1985-08-22', 'carla.ramirez@email.com', 'Calle Luna 456', '555-5678'),
('Miguel', 'Sánchez', '1992-03-15', 'miguel.sanchez@email.com', 'Pje. Sol 789', '555-9101'),
('Lucía', 'Pérez', '1988-11-30', 'lucia.perez@email.com', 'Av. Central 321', '555-3141'),
('Diego', 'Fernández', '1995-07-04', 'diego.fernandez@email.com', 'Calle Norte 654', '555-1818');

-- Insertar registros en venta
INSERT INTO venta (fecha, cantidad, id_libro, id_cliente) VALUES
('2025-05-01', 1, 1, 1),
('2025-05-02', 2, 2, 2),
('2025-05-03', 1, 3, 3),
('2025-05-04', 3, 4, 4),
('2025-05-05', 2, 5, 5);
