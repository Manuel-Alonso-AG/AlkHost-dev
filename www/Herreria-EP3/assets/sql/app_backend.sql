CREATE DATABASE app_backend;
USE app_backend;

CREATE TABLE Usuarios (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(10) NOT NULL,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Productos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(150) NOT NULL,
    categoria ENUM('Puertas', 'Ventanas', 'Rejas', 'Portones', 'Escaleras', 'Barandales', 'Otros') NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10,2) NOT NULL,
    tiempo_elaboracion VARCHAR(50),
    material VARCHAR(100),
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO Usuarios (nombre, email, password) 
VALUES ('Administrador', 'admin@herreria.com', '1234567890');

INSERT INTO Productos (nombre, categoria, descripcion, precio, tiempo_elaboracion, material) VALUES
('Puerta Principal Modelo A', 'Puertas', 'Puerta de herrería con diseño clásico, incluye marco y chapa', 8500.00, '7-10 días', 'Hierro forjado'),
('Reja de Ventana 1.5x1m', 'Rejas', 'Reja de seguridad para ventana con diseño de barrotes verticales', 2500.00, '3-5 días', 'Varilla de 1/2'),
('Portón Corredizo 3m', 'Portones', 'Portón corredizo automático con riel y motor incluido', 15000.00, '15-20 días', 'Tubo rectangular'),
('Escalera Caracol', 'Escaleras', 'Escalera en espiral de 2.5m de altura', 12000.00, '10-12 días', 'Acero estructural'),
('Barandal Balcón 5m', 'Barandales', 'Barandal moderno para balcón con pasamanos', 6500.00, '5-7 días', 'Tubo redondo');
