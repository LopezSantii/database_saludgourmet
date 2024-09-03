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


-- Vistas
-- Cliente Pedido
CREATE VIEW VistaClientesPedidos AS
SELECT 
	Cliente.Nombre,
    Cliente.Apellido,
    Pedido.ID_Pedido,
    Pedido.Fecha,
    Pedido.Total
FROM Cliente
JOIN Pedido ON Cliente.ID_Cliente = Pedido.ID_Cliente;

-- Platos Ingrediientes 
CREATE VIEW VistaPlatosIngredientes AS
SELECT 
    Plato.Nombre AS Plato,
    Ingrediente.Nombre AS Ingrediente,
    Ingrediente.Precio
FROM Plato
JOIN Plato_Ingrediente ON Plato.ID_Plato = Plato_Ingrediente.ID_Plato
JOIN Ingrediente ON Ingrediente.ID_Ingrediente = Plato_Ingrediente.ID_Ingrediente;


-- Funciones
-- Total del Pedido
DELIMITER //
CREATE FUNCTION CalcularTotalPedido(ID_Pedido INT) 
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE Total DECIMAL(10, 2);

    SELECT SUM(pp.Cantidad * i.Precio)
    INTO Total
    FROM Pedido_Plato pp
    JOIN Plato_Ingrediente pi ON pp.ID_Plato = pi.ID_Plato
    JOIN Ingrediente i ON pi.ID_Ingrediente = i.ID_Ingrediente
    WHERE pp.ID_Pedido = ID_Pedido;

    RETURN Total;
END 
// DELIMITER ;

-- Stored Procedures
-- RegistrarPedido
DELIMITER //
CREATE PROCEDURE RegistrarPedido(
     IN Fecha DATE,
     IN ID_Cliente INT,
     IN Plato1_ID INT, IN Plato1_Cantidad INT,
     IN Plato2_ID INT, IN Plato2_Cantidad INT,
     IN Plato3_ID INT, IN Plato3_Cantidad INT -- Puedes agregar más si es necesario
 )
 BEGIN
     DECLARE ID_Pedido INT;
     DECLARE Total DECIMAL(10, 2);
 
     -- Inserta el pedido
     INSERT INTO Pedido (Fecha, ID_Cliente, Total)
     VALUES (Fecha, ID_Cliente, 0);
 
     -- Obtener el ID del pedido recién insertado
     SET ID_Pedido = LAST_INSERT_ID();
 
     -- Insertar los platos asociados al pedido
     IF Plato1_ID IS NOT NULL AND Plato1_Cantidad > 0 THEN
         INSERT INTO Pedido_Plato (ID_Pedido, ID_Plato, Cantidad)
         VALUES (ID_Pedido, Plato1_ID, Plato1_Cantidad);
     END IF;
 
     IF Plato2_ID IS NOT NULL AND Plato2_Cantidad > 0 THEN
         INSERT INTO Pedido_Plato (ID_Pedido, ID_Plato, Cantidad)
         VALUES (ID_Pedido, Plato2_ID, Plato2_Cantidad);
     END IF;
 
     IF Plato3_ID IS NOT NULL AND Plato3_Cantidad > 0 THEN
         INSERT INTO Pedido_Plato (ID_Pedido, ID_Plato, Cantidad)
         VALUES (ID_Pedido, Plato3_ID, Plato3_Cantidad);
     END IF;
 
     -- Calcular y actualizar el total del pedido
     SET Total = (
         SELECT SUM(pi.Precio * pp.Cantidad)
         FROM Pedido_Plato pp
         JOIN Plato_Ingrediente pi ON pp.ID_Plato = pi.ID_Plato
         WHERE pp.ID_Pedido = ID_Pedido
     );
 
     UPDATE Pedido
     SET Total = Total
     WHERE ID_Pedido = ID_Pedido;
 END
// DELIMITER ;
