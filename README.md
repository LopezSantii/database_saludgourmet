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

### 1. Cliente
#### Descripción: 
Almacena la información de los clientes.
#### Campos:
* ID_Cliente (INT, PK): Identificador único del cliente.
* Nombre (VARCHAR(255)): Nombre del cliente.}
* Apellido (VARCHAR(255)): Apellido del cliente.
* Dirección (VARCHAR(255)): Dirección del cliente.
* Tel (VARCHAR(20)): Teléfono del cliente.

### 2. Ingrediente
#### Descripción: 
Almacena la información de los ingredientes.
#### Campos:
* ID_Ingrediente (INT, PK): Identificador único del ingrediente.
* Nombre (VARCHAR(255)): Nombre del ingrediente.
* Precio (DECIMAL(10)): Precio del ingrediente.

### 3. Plato
#### Descripción: 
Almacena la información de los platos.
#### Campos:
* ID_Plato (INT, PK): Identificador único del plato.
* Nombre (VARCHAR(255)): Nombre del plato.

### 4. Pedido
#### Descripción: 
Almacena la información de los pedidos realizados por los clientes.
#### Campos:
* ID_Pedido (INT, PK): Identificador único del pedido.
* Fecha (DATE): Fecha del pedido.
* Total (DECIMAL(10)): Total del pedido.
* ID_Cliente (INT, FK): Identificador del cliente que realizó el pedido.

### 5. Plato_Ingrediente
#### Descripción: 
Relaciona los platos con sus ingredientes.
#### Campos:
* ID_Plato (INT, PK, FK): Identificador del plato.
* ID_Ingrediente (INT, PK, FK): Identificador del ingrediente.

### 6. Pedido_Plato
#### Descripción: 
Relaciona los pedidos con los platos incluidos en ellos.
#### Campos:
* ID_Pedido (INT, PK, FK): Identificador del pedido.
* ID_Plato (INT, PK, FK): Identificador del plato.
* Cantidad (INT): Cantidad del plato en el pedido.

## Enlaces
* [Diagrama](https://miro.com/welcomeonboard/cVFEd1FPSjJFVU8xNTEwbFQ3OXlGcUtvNnEzdE53SzI2NERIZ3BEMkNGWHVEMU5vaEh6Nk42UDRpTFU0dG5EeXwzNDU4NzY0NTk1NDcwNzUxMzY1fDI=?share_link_id=974823417710)
