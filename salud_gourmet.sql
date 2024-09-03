CREATE TABLE Cliente (
    ID_Cliente INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL,
    Apellido VARCHAR(255) NOT NULL,
    Dirección VARCHAR(255) NOT NULL,
    Teléfono VARCHAR(20) NOT NULL
);

CREATE TABLE Ingrediente (
    ID_Ingrediente INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL,
    Precio DECIMAL(10, 2) NOT NULL
);

CREATE TABLE Plato (
    ID_Plato INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL
);

CREATE TABLE Pedido (
    ID_Pedido INT AUTO_INCREMENT PRIMARY KEY,
    Fecha DATE NOT NULL,
    Total DECIMAL(10, 2) NOT NULL,
    ID_Cliente INT,
    FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente)
);

CREATE TABLE Plato_Ingrediente (
    ID_Plato INT,
    ID_Ingrediente INT,
    PRIMARY KEY (ID_Plato, ID_Ingrediente),
    FOREIGN KEY (ID_Plato) REFERENCES Plato(ID_Plato),
    FOREIGN KEY (ID_Ingrediente) REFERENCES Ingrediente(ID_Ingrediente)
);

CREATE TABLE Pedido_Plato (
    ID_Pedido INT,
    ID_Plato INT,
    Cantidad INT NOT NULL,
    PRIMARY KEY (ID_Pedido, ID_Plato),
    FOREIGN KEY (ID_Pedido) REFERENCES Pedido(ID_Pedido),
    FOREIGN KEY (ID_Plato) REFERENCES Plato(ID_Plato)
);

-- Insercion de datos 

-- Clientes
INSERT INTO Cliente (Nombre, Apellido, Dirección, Teléfono)
VALUES ('María', 'Gómez', 'Avenida Siempre Viva 456', '987654321');

INSERT INTO Cliente (Nombre, Apellido, Dirección, Teléfono)
VALUES ('Pedro', 'López', 'Calle Los Álamos 789', '564738291');

INSERT INTO Cliente (Nombre, Apellido, Dirección, Teléfono)
VALUES ('Ana', 'Martínez', 'Boulevard Central 321', '112233445');

INSERT INTO Cliente (Nombre, Apellido, Dirección, Teléfono)
VALUES ('Lucas', 'Fernández', 'Calle del Sol 654', '998877665');

-- Ingredientes
INSERT INTO Ingrediente (Nombre, Precio)
VALUES ('Zanahoria', 0.4);

INSERT INTO Ingrediente (Nombre, Precio)
VALUES ('Pepino', 0.6);

INSERT INTO Ingrediente (Nombre, Precio)
VALUES ('Aceite de Oliva', 1.2);

INSERT INTO Ingrediente (Nombre, Precio)
VALUES ('Vinagre Balsámico', 0.8);

INSERT INTO Ingrediente (Nombre, Precio)
VALUES ('Queso Parmesano', 1.5);

-- Platos
INSERT INTO Plato (Nombre)
VALUES ('Ensalada César');

INSERT INTO Plato (Nombre)
VALUES ('Ensalada de Zanahoria y Pepino');

INSERT INTO Plato (Nombre)
VALUES ('Ensalada Caprese');

INSERT INTO Plato (Nombre)
VALUES ('Ensalada de Quinoa');

-- Plato_Ingrediente
-- Ensalada César
INSERT INTO Plato_Ingrediente (ID_Plato, ID_Ingrediente)
VALUES (1, 3), (1, 5);

-- Ensalada de Zanahoria y Pepino
INSERT INTO Plato_Ingrediente (ID_Plato, ID_Ingrediente)
VALUES (2, 1), (2, 2);

-- Ensalada Caprese
INSERT INTO Plato_Ingrediente (ID_Plato, ID_Ingrediente)
VALUES (3, 3), (3, 4), (3, 5);

-- Ensalada de Quinoa
INSERT INTO Plato_Ingrediente (ID_Plato, ID_Ingrediente)
VALUES (4, 5), (4, 3), (4, 4);

SELECT * FROM Plato_Ingrediente;


-- Pedidos
INSERT INTO Pedido (Fecha, Total, ID_Cliente)
VALUES ('2024-09-01', 12.5, 1);

INSERT INTO Pedido (Fecha, Total, ID_Cliente)
VALUES ('2024-09-02', 8.0, 2);

INSERT INTO Pedido (Fecha, Total, ID_Cliente)
VALUES ('2024-09-03', 10.5, 3);

INSERT INTO Pedido (Fecha, Total, ID_Cliente)
VALUES ('2024-09-04', 7.2, 4);

-- Pedido_Plato
-- Pedido de María Gómez
INSERT INTO Pedido_Plato (ID_Pedido, ID_Plato, Cantidad)
VALUES (1, 2, 1), (1, 3, 1);

-- Pedido de Pedro López
INSERT INTO Pedido_Plato (ID_Pedido, ID_Plato, Cantidad)
VALUES (2, 4, 2);

-- Pedido de Ana Martínez
INSERT INTO Pedido_Plato (ID_Pedido, ID_Plato, Cantidad)
VALUES (3, 2, 1), (3, 4, 1);

-- Pedido de Lucas Fernández
INSERT INTO Pedido_Plato (ID_Pedido, ID_Plato, Cantidad)
VALUES (4, 5, 1);
