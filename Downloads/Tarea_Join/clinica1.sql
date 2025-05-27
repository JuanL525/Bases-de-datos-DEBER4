CREATE DATABASE IF NOT EXISTS Clinica1;
USE Clinica1;

-- Tabla de pacientes
CREATE TABLE pacientes (
    PacienteID INT PRIMARY KEY,
    Nombre VARCHAR(50),
    Apellido VARCHAR(50),
    Edad INT,
    Ciudad VARCHAR(50),
    Direccion VARCHAR(100)
);

-- Tabla de doctores
CREATE TABLE doctores (
    DoctorID INT PRIMARY KEY,
    Nombre VARCHAR(50),
    Apellido VARCHAR(50),
    Especialidad VARCHAR(50)
);

-- Tabla de medicamentos
CREATE TABLE medicamentos (
    MedicamentoID INT PRIMARY KEY,
    Nombre VARCHAR(50),
    Descripcion VARCHAR(100)
);

-- Tabla de consultas
CREATE TABLE consultas (
    ConsultaID INT PRIMARY KEY,
    PacienteID INT,
    DoctorID INT,
    Fecha DATE,
    FOREIGN KEY (PacienteID) REFERENCES pacientes(PacienteID),
    FOREIGN KEY (DoctorID) REFERENCES doctores(DoctorID)
);

-- Tabla de recetas
CREATE TABLE recetas (
    RecetaID INT PRIMARY KEY,
    PacienteID INT,
    MedicamentoID INT,
    DoctorID INT,
    Fecha DATE,
    FOREIGN KEY (PacienteID) REFERENCES pacientes(PacienteID),
    FOREIGN KEY (MedicamentoID) REFERENCES medicamentos(MedicamentoID),
    FOREIGN KEY (DoctorID) REFERENCES doctores(DoctorID)
);

INSERT INTO pacientes (PacienteID, Nombre, Apellido, Edad, Ciudad, Direccion) VALUES
(1, 'Ana', 'García', 30, 'Madrid', 'Calle Mayor 123'),
(2, 'Luis', 'Pérez', 45, 'Barcelona', 'Av. Diagonal 456'),
(3, 'Marta', 'López', 27, 'Valencia', 'Calle Ruzafa 789'),
(4, 'Carlos', 'Martínez', 52, 'Sevilla', 'Plaza Nueva 10');

INSERT INTO doctores (DoctorID, Nombre, Apellido, Especialidad) VALUES
(1, 'Laura', 'Sánchez', 'Cardiología'),
(2, 'Javier', 'Ruiz', 'Pediatría'),
(3, 'Elena', 'Morales', 'Dermatología');

INSERT INTO medicamentos (MedicamentoID, Nombre, Descripcion) VALUES
(1, 'Paracetamol', 'Analgésico y antipirético'),
(2, 'Ibuprofeno', 'Antiinflamatorio no esteroideo'),
(3, 'Amoxicilina', 'Antibiótico de amplio espectro');

INSERT INTO consultas (ConsultaID, PacienteID, DoctorID, Fecha) VALUES
(1, 1, 1, '2025-05-01'),
(2, 2, 2, '2025-05-02'),
(3, 3, 1, '2025-05-03'),
(4, 4, 3, '2025-05-04');

INSERT INTO recetas (RecetaID, PacienteID, MedicamentoID, DoctorID, Fecha) VALUES
(1, 1, 1, 1, '2025-05-01'),
(2, 2, 2, 2, '2025-05-02'),
(3, 3, 3, 1, '2025-05-03'),
(4, 4, 1, 3, '2025-05-04');

-- Inner Join
-- Relacionar pacientes con consultas cuando ambos estan registrados
SELECT 
    pacientes.PacienteID,
    pacientes.Nombre,
    pacientes.Apellido,
    consultas.ConsultaID,
    consultas.Fecha
FROM 
    pacientes
INNER JOIN 
    consultas ON pacientes.PacienteID = consultas.PacienteID;
    
-- Relacionar consultas con los doctores asignados
SELECT 
    consultas.ConsultaID,
    consultas.Fecha,
    doctores.DoctorID,
    doctores.Nombre,
    doctores.Apellido,
    doctores.Especialidad
FROM 
    consultas
INNER JOIN 
    doctores ON consultas.DoctorID = doctores.DoctorID;

-- Relacionar medicamentos recetados con los pacientes que los reciben
SELECT 
    recetas.RecetaID,
    pacientes.Nombre AS NombrePaciente,
    pacientes.Apellido AS ApellidoPaciente,
    medicamentos.Nombre AS NombreMedicamento,
    medicamentos.Descripcion,
    recetas.Fecha
FROM 
    recetas
INNER JOIN 
    pacientes ON recetas.PacienteID = pacientes.PacienteID
INNER JOIN 
    medicamentos ON recetas.MedicamentoID = medicamentos.MedicamentoID;
    
-- LEFT JOIN
-- Mostrar todos los pacientes, incluyendo aquellos que aún no tienen consultas agendadas
SELECT 
    pacientes.PacienteID,
    pacientes.Nombre,
    pacientes.Apellido,
    consultas.ConsultaID,
    consultas.Fecha
FROM 
    pacientes
LEFT JOIN 
    consultas ON pacientes.PacienteID = consultas.PacienteID;
    
-- Mostrar todas las consultas, incluyendo las que no tienen doctor asignado
SELECT 
    consultas.ConsultaID,
    consultas.Fecha,
    doctores.DoctorID,
    doctores.Nombre,
    doctores.Apellido
FROM 
    consultas
LEFT JOIN 
    doctores ON consultas.DoctorID = doctores.DoctorID;
    
-- Mostrar todos los pacientes, incluyendo aquellos que no reciben medicamentos
SELECT 
    pacientes.PacienteID,
    pacientes.Nombre,
    pacientes.Apellido,
    recetas.RecetaID,
    medicamentos.Nombre AS Medicamento,
    recetas.Fecha
FROM 
    pacientes
LEFT JOIN 
    recetas ON pacientes.PacienteID = recetas.PacienteID
LEFT JOIN 
    medicamentos ON recetas.MedicamentoID = medicamentos.MedicamentoID;
    
-- RIGHT JOIN
-- Mostrar todas las consultas, incluso aquellas que no están asignadas a un paciente
SELECT 
    pacientes.PacienteID,
    pacientes.Nombre,
    pacientes.Apellido,
    consultas.ConsultaID,
    consultas.Fecha
FROM 
    pacientes
RIGHT JOIN 
    consultas ON pacientes.PacienteID = consultas.PacienteID;
-- Mostrar todos los doctores, incluso aquellos que no tienen consultas asignadas
SELECT 
    doctores.DoctorID,
    doctores.Nombre,
    doctores.Apellido,
    doctores.Especialidad,
    consultas.ConsultaID,
    consultas.Fecha
FROM 
    consultas
RIGHT JOIN 
    doctores ON consultas.DoctorID = doctores.DoctorID;
    
-- Mostrar todos los medicamentos, incluso los que no han sido recetados
SELECT 
    medicamentos.MedicamentoID,
    medicamentos.Nombre,
    medicamentos.Descripcion,
    recetas.RecetaID,
    recetas.Fecha
FROM 
    recetas
RIGHT JOIN 
    medicamentos ON recetas.MedicamentoID = medicamentos.MedicamentoID;

-- FULL OUTER JOIN
-- Mostrar todos los pacientes y consultas, incluidas las que no están relacionadas entre sí
-- Pacientes con o sin consultas
SELECT 
    pacientes.PacienteID,
    pacientes.Nombre,
    pacientes.Apellido,
    consultas.ConsultaID,
    consultas.Fecha
FROM 
    pacientes
LEFT JOIN 
    consultas ON pacientes.PacienteID = consultas.PacienteID

UNION

-- Consultas sin pacientes (si las hay)
SELECT 
    pacientes.PacienteID,
    pacientes.Nombre,
    pacientes.Apellido,
    consultas.ConsultaID,
    consultas.Fecha
FROM 
    pacientes
RIGHT JOIN 
    consultas ON pacientes.PacienteID = consultas.PacienteID;

-- Mostrar todas las consultas y doctores, incluso las no relacionadas
-- Consultas con o sin doctor
SELECT 
    consultas.ConsultaID,
    consultas.Fecha,
    doctores.DoctorID,
    doctores.Nombre,
    doctores.Apellido
FROM 
    consultas
LEFT JOIN 
    doctores ON consultas.DoctorID = doctores.DoctorID

UNION

-- Doctores sin consultas
SELECT 
    consultas.ConsultaID,
    consultas.Fecha,
    doctores.DoctorID,
    doctores.Nombre,
    doctores.Apellido
FROM 
    consultas
RIGHT JOIN 
    doctores ON consultas.DoctorID = doctores.DoctorID;
    
-- Mostrar todos los pacientes y medicamentos, incluso los no relacionados entre sí
-- Pacientes con o sin medicamentos recetados
SELECT 
    pacientes.PacienteID,
    pacientes.Nombre,
    pacientes.Apellido,
    medicamentos.MedicamentoID,
    medicamentos.Nombre AS NombreMedicamento
FROM 
    pacientes
LEFT JOIN 
    recetas ON pacientes.PacienteID = recetas.PacienteID
LEFT JOIN 
    medicamentos ON recetas.MedicamentoID = medicamentos.MedicamentoID

UNION

-- Medicamentos no recetados
SELECT 
    pacientes.PacienteID,
    pacientes.Nombre,
    pacientes.Apellido,
    medicamentos.MedicamentoID,
    medicamentos.Nombre AS NombreMedicamento
FROM 
    pacientes
RIGHT JOIN 
    recetas ON pacientes.PacienteID = recetas.PacienteID
RIGHT JOIN 
    medicamentos ON recetas.MedicamentoID = medicamentos.MedicamentoID;
    













