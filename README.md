## Descripción de la temática de la base de datos
La base de datos está diseñada para **Salud Gourmet**, una empresa que vende comida saludable por internet. Su objetivo es gestionar la información relacionada con los clientes, los platos saludables ofrecidos, los ingredientes utilizados en cada plato y los pedidos realizados por los clientes. La base de datos permite almacenar y organizar datos de manera eficiente para facilitar la gestión de pedidos, la preparación de platos saludables y el seguimiento de los ingredientes.

## Diagramas de entidad-relación de la base de datos
![Diagrama de relación de entidad - Marco 1](https://github.com/user-attachments/assets/8d04901a-af36-47e9-912e-0f0c7594867a)


### Relaciones:
* Un **Cliente** puede realizar muchos **Pedidos**.
* Un **Pedido** puede contener muchos **Platos**.
* Un **Plato** puede estar en **muchos Pedidos**.
* Un **Plato** puede tener muchos **Ingredientes**.
* Un **Ingrediente** puede estar en muchos **Platos**.

## Listado de las tablas que comprenden la base de datos
Las relaciones N:M generaron nuevas tablas y el diagrama quedo algo asi:
![image](https://github.com/user-attachments/assets/cbc3634c-40d8-4dea-b666-548587f82eda)
#### Enlaces
* [Diagrama](https://miro.com/welcomeonboard/cVFEd1FPSjJFVU8xNTEwbFQ3OXlGcUtvNnEzdE53SzI2NERIZ3BEMkNGWHVEMU5vaEh6Nk42UDRpTFU0dG5EeXwzNDU4NzY0NTk1NDcwNzUxMzY1fDI=?share_link_id=974823417710)

### Cliente
* Descripción: Almacena la información de los clientes.
* Campos:
  * ID_Cliente (INT, PK): Identificador único del cliente.
  * Nombre (VARCHAR(255)): Nombre del cliente.}
  * Apellido (VARCHAR(255)): Apellido del cliente.
  * Dirección (VARCHAR(255)): Dirección del cliente.
  * Tel (VARCHAR(20)): Teléfono del cliente.

``` sql
 CREATE TABLE Cliente (
   ID_Cliente INT AUTO_INCREMENT PRIMARY KEY,
   Nombre VARCHAR(255) NOT NULL,
   Apellido VARCHAR(255) NOT NULL,
   Dirección VARCHAR(255) NOT NULL,
   Teléfono VARCHAR(20) NOT NULL
 );
```

### Ingrediente
* Descripción: Almacena la información de los ingredientes.
* Campos:
  * ID_Ingrediente (INT, PK): Identificador único del ingrediente.
  * Nombre (VARCHAR(255)): Nombre del ingrediente.
  * Precio (DECIMAL(10)): Precio del ingrediente.

``` sql
 CREATE TABLE Ingrediente (
   ID_Ingrediente INT AUTO_INCREMENT PRIMARY KEY,
   Nombre VARCHAR(255) NOT NULL,
   Precio DECIMAL(10, 2) NOT NULL
 );
```

### Plato
* Descripción: Almacena la información de los platos.
* Campos:
  * ID_Plato (INT, PK): Identificador único del plato.
  * Nombre (VARCHAR(255)): Nombre del plato.

``` sql
 CREATE TABLE Plato (
   ID_Plato INT AUTO_INCREMENT PRIMARY KEY,
   Nombre VARCHAR(255) NOT NULL
 );
```

### Pedido
* Descripción: Almacena la información de los pedidos realizados por los clientes.
* Campos:
  * ID_Pedido (INT, PK): Identificador único del pedido.
  * Fecha (DATE): Fecha del pedido.
  * Total (DECIMAL(10)): Total del pedido.
  * ID_Cliente (INT, FK): Identificador del cliente que realizó el pedido.
  
``` sql
 CREATE TABLE Pedido (
   ID_Pedido INT AUTO_INCREMENT PRIMARY KEY,
   Fecha DATE NOT NULL,
   Total DECIMAL(10, 2) NOT NULL,
   ID_Cliente INT,
   FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente)
 );
```

### Plato_Ingrediente
* Descripción: Relaciona los platos con sus ingredientes.
* Campos:
  * ID_Plato (INT, PK, FK): Identificador del plato.
  *  ID_Ingrediente (INT, PK, FK): Identificador del ingrediente.

``` sql 
 CREATE TABLE Plato_Ingrediente (
   ID_Plato INT,
   ID_Ingrediente INT,
   PRIMARY KEY (ID_Plato, ID_Ingrediente),
   FOREIGN KEY (ID_Plato) REFERENCES Plato(ID_Plato),
   FOREIGN KEY (ID_Ingrediente) REFERENCES Ingrediente(ID_Ingrediente)
 );
```

### Pedido_Plato
* Descripción: Relaciona los pedidos con los platos incluidos en ellos.
* Campos:
  * ID_Pedido (INT, PK, FK): Identificador del pedido.
  * ID_Plato (INT, PK, FK): Identificador del plato.
  * Cantidad (INT): Cantidad del plato en el pedido.

``` sql
 CREATE TABLE Pedido_Plato (
   ID_Pedido INT,
   ID_Plato INT,
   Cantidad INT NOT NULL,
   PRIMARY KEY (ID_Pedido, ID_Plato),
   FOREIGN KEY (ID_Pedido) REFERENCES Pedido(ID_Pedido),
   FOREIGN KEY (ID_Plato) REFERENCES Plato(ID_Plato)
 );
```
## Listado de Vistas
### VistaClientesPedidos
* Descripción: Muestra la lista de clientes junto con los pedidos que han realizado.
* Objetivo: Facilitar la consulta rápida de los pedidos asociados a cada cliente, lo cual es útil para el análisis de comportamiento de compra y la gestión de relaciones con los clientes.
* Tablas Involucradas: Cliente, Pedido.
  
``` sql
  CREATE VIEW VistaClientesPedidos AS
  SELECT 
    Cliente.Nombre,
    Cliente.Apellido,
    Pedido.ID_Pedido,
    Pedido.Fecha,
    Pedido.Total
  FROM Cliente
  JOIN Pedido ON Cliente.ID_Cliente = Pedido.ID_Cliente;
```
### VistaPlatosIngredientes
* Descripción: Muestra los platos ofrecidos junto con los ingredientes que los componen.
* Objetivo: Proporcionar una visión clara de la composición de cada plato, útil para la gestión de recetas y control de inventario.
* Tablas Involucradas: Plato, Ingrediente, Plato_Ingrediente.
  
``` sql
  CREATE VIEW VistaPlatosIngredientes AS
  SELECT 
    Plato.Nombre AS Plato,
    Ingrediente.Nombre AS Ingrediente,
    Ingrediente.Precio
  FROM Plato
  JOIN Plato_Ingrediente ON Plato.ID_Plato = Plato_Ingrediente.ID_Plato
  JOIN Ingrediente ON Ingrediente.ID_Ingrediente = Plato_Ingrediente.ID_Ingrediente;
```

### VistaPedidosClientesIngredientes
* Descripción: Muestra los pedidos realizados por los clientes, junto con los platos e ingredientes asociados.
* Objetivo: Ofrecer un desglose detallado de cada pedido para ayudar en el análisis de ventas y en la gestión de los ingredientes.
* Tablas Involucradas: Cliente, Pedido, Plato, Ingrediente, Plato_Ingrediente, Pedido_Plato.
``` sql
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
```
### VistaIngredientesUtilizados
* Descripción: Muestra la cantidad total de cada ingrediente utilizado en todos los pedidos.
* Objetivo: Facilitar el control de inventarios y las compras de ingredientes según su consumo.
* Tablas Involucradas: Ingrediente, Plato_Ingrediente, Pedido_Plato.
``` sql
  CREATE VIEW VistaIngredientesUtilizados AS
  SELECT 
      Ingrediente.Nombre AS Ingrediente,
      SUM(Pedido_Plato.Cantidad) AS Total_Utilizado
  FROM Pedido_Plato
  JOIN Plato_Ingrediente ON Pedido_Plato.ID_Plato = Plato_Ingrediente.ID_Plato
  JOIN Ingrediente ON Plato_Ingrediente.ID_Ingrediente = Ingrediente.ID_Ingrediente
  GROUP BY Ingrediente.Nombre;
```

### VistaPlatosMasPedidos
* Descripción: Muestra los platos más solicitados en todos los pedidos realizados.
* Objetivo: Permitir la identificación de los platos más populares, útil para la optimización del menú y el marketing.
* Tablas Involucradas: Plato, Pedido_Plato.
``` sql
  CREATE VIEW VistaPlatosMasPedidos AS
  SELECT 
      Plato.Nombre AS Plato,
      SUM(Pedido_Plato.Cantidad) AS Total_Pedido
  FROM Pedido_Plato
  JOIN Plato ON Pedido_Plato.ID_Plato = Plato.ID_Plato
  GROUP BY Plato.Nombre
  ORDER BY Total_Pedido DESC;
```

## Listado de Funciones
### CalcularTotalPedido
* Descripción: Calcula el total de un pedido sumando el costo de los platos en función de sus ingredientes y la cantidad ordenada.
* Objetivo: Automatizar el cálculo del total de un pedido para garantizar precisión en la facturación.
* Tablas Involucradas: Pedido_Plato, Plato_Ingrediente, Ingrediente.
``` sql
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
```

Se la puede invocar de la siguiente forma:

``` sql
SELECT CalcularTotalPedido(1);
```

### CalcularCostoPlato
* Descripción: Calcula el costo total de los ingredientes utilizados para un plato. 
* Objetivo: Proporcionar una manera rápida de obtener el costo de los ingredientes asociados a un plato para el análisis de márgenes y precios de los platos.
* Tablas Involucradas: Plato, Ingrediente, Plato_Ingrediente.

``` sql
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
```

Se la puede invocar de la siguiente forma:

``` sql
SELECT CalcularCostoPlato(1);
```

## Listado de Triggers
### ActualizarTotalDespuesDeInsertarPlato
* Descripción: Actualiza el total de un pedido cuando se inserta un nuevo plato en la tabla Pedido_Plato.
* Objetivo: Mantener actualizado automáticamente el total del pedido tras agregar un plato.
* Tablas Involucradas: Pedido, Pedido_Plato, Plato_Ingrediente, Ingrediente.

``` sql
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
```

### ActualizarTotalDespuesDeEliminarPlato
* Descripción: Actualiza el total de un pedido cuando se elimina un plato de la tabla Pedido_Plato.
* Objetivo: Mantener actualizado automáticamente el total del pedido tras eliminar un plato.
* Tablas Involucradas: Pedido, Pedido_Plato, Plato_Ingrediente, Ingrediente.

``` sql
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
```

## Listado de Stored Procedures
### RegistrarPedido
* Descripción: Inserta un nuevo pedido en la base de datos, asignando un cliente, registrando los platos asociados y calculando el total automáticamente.
* Objetivo: Facilitar el registro de nuevos pedidos y asegurar que todos los datos relacionados se gestionen de forma coherente y eficiente.
* Tablas Involucradas: Pedido, Pedido_Plato, Plato_Ingrediente.

``` sql
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
```
Se lo puede invocar de la siguiente forma:

``` sql
 CALL RegistrarPedido('2024-09-05', 1, 2, 2, 3, 1, NULL, NULL);
```

Este ejemplo inserta dos platos en el pedido. Si no hay un tercer plato, puedes pasar NULL para Plato3_ID y Plato3_Cantidad.

### RegistrarNuevoClientePedido
* Descripción: Registra un nuevo cliente y su pedido asociado en una sola transacción.
* Objetivo: Facilitar el registro de clientes nuevos junto con su pedido en un solo paso.
* Tablas Involucradas: Cliente, Pedido, Pedido_Plato, Plato, Plato_Ingrediente.
``` sql
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
```
Se lo puede invocar de la siguiente forma:

``` sql
 CALL RegistrarNuevoClientePedido(
  'Juan', 'Pérez', 'Calle 123', '123456789', 
  '2024-09-05', 1, 2, 2, 1, NULL, NULL
 );
```

Este ejemplo inserta un nuevo cliente llamado Juan Pérez y registra un pedido con dos platos. Si no hay un tercer plato, puedes pasar NULL para Plato3_ID y Plato3_Cantidad.

## Informes
### Total de Ventas por Cliente
``` sql
 SELECT Cliente.Nombre, Cliente.Apellido, SUM(Pedido.Total) AS Total_Comprado
 FROM Cliente
 JOIN Pedido ON Cliente.ID_Cliente = Pedido.ID_Cliente
 GROUP BY Cliente.ID_Cliente;
```

### Cantidad de Pedidos por Día
``` sql
 SELECT Fecha, COUNT(*) AS Pedidos_Realizados
 FROM Pedido
 GROUP BY Fecha;
```

### Ingredientes más Utilizados
``` sql
 SELECT Ingrediente.Nombre, COUNT(*) AS Veces_Usado
 FROM Plato_Ingrediente
 JOIN Ingrediente ON Plato_Ingrediente.ID_Ingrediente = Ingrediente.ID_Ingrediente
 GROUP BY Ingrediente.ID_Ingrediente
 ORDER BY Veces_Usado DESC;
```
