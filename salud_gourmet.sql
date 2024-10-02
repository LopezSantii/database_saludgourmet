-- Crear la base de datos
CREATE DATABASE SaludGourmet;
USE SaludGourmet;

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

-- Tabla de hechos: Facturas
CREATE TABLE Factura (
    ID_Factura INT AUTO_INCREMENT PRIMARY KEY,
    ID_Pedido INT,
    Fecha DATE NOT NULL,
    Importe DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (ID_Pedido) REFERENCES Pedido(ID_Pedido)
);

-- Tabla transaccional: Transacción de Pago
CREATE TABLE Transaccion_Pago (
    ID_Transaccion INT AUTO_INCREMENT PRIMARY KEY,
    ID_Pedido INT,
    Fecha DATE NOT NULL,
    Monto DECIMAL(10, 2) NOT NULL,
    Metodo_Pago VARCHAR(50) NOT NULL,
    FOREIGN KEY (ID_Pedido) REFERENCES Pedido(ID_Pedido)
);

-- Tabla transaccional: Transacción de Envío
CREATE TABLE Transaccion_Envio (
    ID_Envio INT AUTO_INCREMENT PRIMARY KEY,
    ID_Pedido INT,
    Fecha_Envio DATE NOT NULL,
    Estado VARCHAR(50) NOT NULL,
    Direccion_Envio VARCHAR(255) NOT NULL,
    FOREIGN KEY (ID_Pedido) REFERENCES Pedido(ID_Pedido)
);

-- Tabla Categoría de Ingredientes
CREATE TABLE Categoria_Ingrediente (
    ID_Categoria INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL
);

-- Relación Ingrediente-Categoría
CREATE TABLE Ingrediente_Categoria (
    ID_Ingrediente INT,
    ID_Categoria INT,
    PRIMARY KEY (ID_Ingrediente, ID_Categoria),
    FOREIGN KEY (ID_Ingrediente) REFERENCES Ingrediente(ID_Ingrediente),
    FOREIGN KEY (ID_Categoria) REFERENCES Categoria_Ingrediente(ID_Categoria)
);

-- Tabla Promociones
CREATE TABLE Promocion (
    ID_Promocion INT AUTO_INCREMENT PRIMARY KEY,
    Descuento DECIMAL(5, 2) NOT NULL,
    Descripcion VARCHAR(255) NOT NULL
);

-- Relación Pedido-Promoción
CREATE TABLE Pedido_Promocion (
    ID_Pedido INT,
    ID_Promocion INT,
    PRIMARY KEY (ID_Pedido, ID_Promocion),
    FOREIGN KEY (ID_Pedido) REFERENCES Pedido(ID_Pedido),
    FOREIGN KEY (ID_Promocion) REFERENCES Promocion(ID_Promocion)
);

-- Tabla de proveedores
CREATE TABLE Proveedor (
    ID_Proveedor INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL,
    Telefono VARCHAR(20),
    Direccion VARCHAR(255)
);

-- Relación Proveedor-Ingrediente
CREATE TABLE Proveedor_Ingrediente (
    ID_Proveedor INT,
    ID_Ingrediente INT,
    PRIMARY KEY (ID_Proveedor, ID_Ingrediente),
    FOREIGN KEY (ID_Proveedor) REFERENCES Proveedor(ID_Proveedor),
    FOREIGN KEY (ID_Ingrediente) REFERENCES Ingrediente(ID_Ingrediente)
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

-- Pedidos
INSERT INTO Pedido (Fecha, Total, ID_Cliente)
VALUES ('2024-09-05', 14.5, 1);

INSERT INTO Pedido (Fecha, Total, ID_Cliente)
VALUES ('2024-09-06', 10.0, 2);

INSERT INTO Pedido (Fecha, Total, ID_Cliente)
VALUES ('2024-09-07', 12.5, 1);

INSERT INTO Pedido (Fecha, Total, ID_Cliente)
VALUES ('2024-09-08', 9.8, 3);

-- Relaciones de Platos e Ingredientes

INSERT INTO Plato_Ingrediente (ID_Plato, ID_Ingrediente)
VALUES (1, 3), (1, 4); 

INSERT INTO Plato_Ingrediente (ID_Plato, ID_Ingrediente)
VALUES (2, 2), (2, 1);


INSERT INTO Plato_Ingrediente (ID_Plato, ID_Ingrediente)
VALUES (3, 3), (3, 2), (3, 5); 


INSERT INTO Plato_Ingrediente (ID_Plato, ID_Ingrediente)
VALUES (4, 4), (4, 1), (4, 5); 

-- Factura
INSERT INTO Factura (ID_Pedido, Fecha, Importe) VALUES (1, '2024-09-01', 12.5);
INSERT INTO Factura (ID_Pedido, Fecha, Importe) VALUES (2, '2024-09-02', 8.0);

-- Transacciones de Pago
INSERT INTO Transaccion_Pago (ID_Pedido, Fecha, Monto, Metodo_Pago) 
VALUES (1, '2024-09-01', 12.5, 'Tarjeta de Crédito');

INSERT INTO Transaccion_Pago (ID_Pedido, Fecha, Monto, Metodo_Pago) 
VALUES (2, '2024-09-02', 8.0, 'PayPal');

-- Transacciones de Envío
INSERT INTO Transaccion_Envio (ID_Pedido, Fecha_Envio, Estado, Direccion_Envio)
VALUES (1, '2024-09-02', 'Entregado', 'Avenida Siempre Viva 456');

-- Categorías de Ingredientes
INSERT INTO Categoria_Ingrediente (Nombre) VALUES ('Vegetales');
INSERT INTO Categoria_Ingrediente (Nombre) VALUES ('Lácteos');

-- Ingredientes y Categorías
INSERT INTO Ingrediente_Categoria (ID_Ingrediente, ID_Categoria) VALUES (1, 1);
INSERT INTO Ingrediente_Categoria (ID_Ingrediente, ID_Categoria) VALUES (5, 2);

-- Proveedores
INSERT INTO Proveedor (Nombre, Telefono, Direccion) VALUES ('Proveedor A', '123456789', 'Calle Falsa 123');

-- Relación Proveedor-Ingrediente
INSERT INTO Proveedor_Ingrediente (ID_Proveedor, ID_Ingrediente) VALUES (1, 1);

-- Promociones
INSERT INTO Promocion (Descuento, Descripcion) VALUES (10, 'Promoción de Verano');
INSERT INTO Pedido_Promocion (ID_Pedido, ID_Promocion) VALUES (1, 1);

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

-- Platos Ingredientes 
CREATE VIEW VistaPlatosIngredientes AS
SELECT 
    Plato.Nombre AS Plato,
    Ingrediente.Nombre AS Ingrediente,
    Ingrediente.Precio
FROM Plato
JOIN Plato_Ingrediente ON Plato.ID_Plato = Plato_Ingrediente.ID_Plato
JOIN Ingrediente ON Ingrediente.ID_Ingrediente = Plato_Ingrediente.ID_Ingrediente;

-- Ingredientes Utilizados
CREATE VIEW VistaIngredientesUtilizados AS
SELECT 
    Ingrediente.Nombre AS Ingrediente,
    SUM(Pedido_Plato.Cantidad) AS Total_Utilizado
FROM Pedido_Plato
JOIN Plato_Ingrediente ON Pedido_Plato.ID_Plato = Plato_Ingrediente.ID_Plato
JOIN Ingrediente ON Plato_Ingrediente.ID_Ingrediente = Ingrediente.ID_Ingrediente
GROUP BY Ingrediente.Nombre;

-- PlatosMas Pedidos
CREATE VIEW VistaPlatosMasPedidos AS
SELECT 
    Plato.Nombre AS Plato,
    SUM(Pedido_Plato.Cantidad) AS Total_Pedido
FROM Pedido_Plato
JOIN Plato ON Pedido_Plato.ID_Plato = Plato.ID_Plato
GROUP BY Plato.Nombre
ORDER BY Total_Pedido DESC;

-- Pedidos Clientes Ingredientes
CREATE VIEW VistaPedidosClientesIngredientes AS
  SELECT 
      Cliente.Nombre AS Cliente,
      Cliente.Apellido AS Apellido,
      Pedido.ID_Pedido,
      Plato.Nombre AS Plato,
      Ingrediente.Nombre AS Ingrediente,
      Ingrediente.Precio
  FROM Pedido
  JOIN Cliente ON Pedido.ID_Cliente = Cliente.ID_Cliente
  JOIN Pedido_Plato ON Pedido.ID_Pedido = Pedido_Plato.ID_Pedido
  JOIN Plato ON Pedido_Plato.ID_Plato = Plato.ID_Plato
  JOIN Plato_Ingrediente ON Plato.ID_Plato = Plato_Ingrediente.ID_Plato
  JOIN Ingrediente ON Plato_Ingrediente.ID_Ingrediente = Ingrediente.ID_Ingrediente;
  
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

SELECT CalcularTotalPedido(1);  -- Calcula el costo para el plato con ID 1

-- Total del plato
DELIMITER //
CREATE FUNCTION CalcularCostoPlato(ID_Plato INT)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE CostoTotal DECIMAL(10, 2);

    SELECT SUM(i.Precio)
    INTO CostoTotal
    FROM Ingrediente i
    JOIN Plato_Ingrediente pi ON i.ID_Ingrediente = pi.ID_Ingrediente
    WHERE pi.ID_Plato = ID_Plato;

    RETURN CostoTotal;
END 
// DELIMITER ;

SELECT CalcularCostoPlato(1); -- Calcula el costo total de los ingredientes para el plato con ID 1


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

-- RegistrarNuevoClientePedido
DELIMITER //
CREATE PROCEDURE RegistrarNuevoClientePedido(
    IN NombreCliente VARCHAR(255),
    IN ApellidoCliente VARCHAR(255),
    IN DireccionCliente VARCHAR(255),
    IN TelefonoCliente VARCHAR(20),
    IN FechaPedido DATE,
    IN Plato1_ID INT, IN Plato1_Cantidad INT,
    IN Plato2_ID INT, IN Plato2_Cantidad INT,
    IN Plato3_ID INT, IN Plato3_Cantidad INT
)
BEGIN
    DECLARE ID_Cliente INT;
    DECLARE ID_Pedido INT;

    -- Insertar el cliente
    INSERT INTO Cliente (Nombre, Apellido, Dirección, Teléfono)
    VALUES (NombreCliente, ApellidoCliente, DireccionCliente, TelefonoCliente);
    
    SET ID_Cliente = LAST_INSERT_ID();

    -- Registrar el pedido
    CALL RegistrarPedido(FechaPedido, ID_Cliente, Plato1_ID, Plato1_Cantidad, Plato2_ID, Plato2_Cantidad, Plato3_ID, Plato3_Cantidad);
END
// DELIMITER ;

-- Triggers
-- ActualizarTotalDespuesDeInsertarPlato
DELIMITER //
CREATE TRIGGER ActualizarTotalDespuesDeInsertarPlato
AFTER INSERT ON Pedido_Plato
FOR EACH ROW
BEGIN
    DECLARE nuevo_total DECIMAL(10, 2);
    SET nuevo_total = (
        SELECT SUM(pi.Precio * pp.Cantidad)
        FROM Pedido_Plato pp
        JOIN Plato_Ingrediente pi ON pp.ID_Plato = pi.ID_Plato
        WHERE pp.ID_Pedido = NEW.ID_Pedido
    );
    UPDATE Pedido
    SET Total = nuevo_total
    WHERE ID_Pedido = NEW.ID_Pedido;
END;
// DELIMITER ;

-- ActualizarTotalDespuesDeEliminarPlato
DELIMITER //
CREATE TRIGGER ActualizarTotalDespuesDeEliminarPlato
AFTER DELETE ON Pedido_Plato
FOR EACH ROW
BEGIN
    DECLARE nuevo_total DECIMAL(10, 2);
    SET nuevo_total = (
        SELECT SUM(pi.Precio * pp.Cantidad)
        FROM Pedido_Plato pp
        JOIN Plato_Ingrediente pi ON pp.ID_Plato = pi.ID_Plato
        WHERE pp.ID_Pedido = OLD.ID_Pedido
    );
    UPDATE Pedido
    SET Total = nuevo_total
    WHERE ID_Pedido = OLD.ID_Pedido;
END;
// DELIMITER ;

-- Informes
-- Total de Ventas por Cliente
SELECT Cliente.Nombre, Cliente.Apellido, SUM(Pedido.Total) AS Total_Comprado
FROM Cliente
JOIN Pedido ON Cliente.ID_Cliente = Pedido.ID_Cliente
GROUP BY Cliente.ID_Cliente;

-- Cantidad de Pedidos por Día
SELECT Fecha, COUNT(*) AS Pedidos_Realizados
FROM Pedido
GROUP BY Fecha;

-- Ingredientes más Utilizados
SELECT Ingrediente.Nombre, COUNT(*) AS Veces_Usado
FROM Plato_Ingrediente
JOIN Ingrediente ON Plato_Ingrediente.ID_Ingrediente = Ingrediente.ID_Ingrediente
GROUP BY Ingrediente.ID_Ingrediente
ORDER BY Veces_Usado DESC;

