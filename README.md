## Descripción de la temática de la base de datos
La base de datos está diseñada para **Salud Gourmet**, una empresa que vende comida saludable por internet. Su objetivo es gestionar la información relacionada con los clientes, los platos saludables ofrecidos, los ingredientes utilizados en cada plato y los pedidos realizados por los clientes. La base de datos permite almacenar y organizar datos de manera eficiente para facilitar la gestión de pedidos, la preparación de platos saludables y el seguimiento de los ingredientes.

## Diagramas de entidad-relación de la base de datos
![image](https://github.com/user-attachments/assets/c26fadec-009b-4232-8eac-b91ba4120b3a)

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
* Tablas Compuestas: Cliente, Pedido.
  
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
* Tablas Compuestas: Plato, Ingrediente, Plato_Ingrediente.
  
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

## Listado de Funciones
### CalcularTotalPedido
* Descripción: Calcula el total de un pedido sumando el costo de los platos en función de sus ingredientes y la cantidad ordenada.
* Objetivo: Automatizar el cálculo del total de un pedido para garantizar precisión en la facturación.
* Tablas Manipuladas: Pedido_Plato, Plato_Ingrediente, Ingrediente.

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
