-- create
DROP DATABASE IF EXISTS basevolun;
CREATE DATABASE basevolun;
use basevolun;

CREATE TABLE Socios (
 NIF_Socio varchar(9) PRIMARY KEY,
 Nombre varchar(20) NOT NULL,
 Ap1 varchar(20) NOT NULL,
 Ap2 varchar(20),
 Dirección varchar(300) NOT NULL,
 Cod_P varchar(5) NOT NULL,
 Municipio varchar(30),
 Provincia varchar(30),
 Tlf varchar(9) NOT NULL,
 Correo varchar(50),
 CONSTRAINT Socios_NIF_ck CHECK(`NIF_Socio` REGEXP '^[0-9]{8}[TRWAGMYFPDXBNJZSQVHLCKE]'
   	OR `NIF_Socio` REGEXP'^[KLMXYZ][0-9]{7}[TRWAGMYFPDXBNJZSQVHLCKE]'
   	OR `NIF_Socio` REGEXP '^[TRWAGMYFPDXBNJZSQVHLCKE]{1}[0-9]{8}')
 );


CREATE TABLE Entrega_aceituna(
Num_entrega integer AUTO_INCREMENT,
Fecha_Hora timestamp NOT NULL,
NIF_Socio varchar(9),
 Cantidad integer NOT NULL,
 Tipo enum('Árbol','Suelo') NOT NULL,
 Parcela integer,
 Recinto integer, 
 CONSTRAINT Entrega_aceituna_pk PRIMARY KEY(Num_entrega),
 CONSTRAINT Entrega_NIF_Socio_fk FOREIGN KEY(NIF_Socio)
                             	REFERENCES Socios(NIF_Socio)
                             	ON UPDATE CASCADE
                             	ON DELETE NO ACTION,
 CONSTRAINT Entrega_aceituna_Cantidad_ck CHECK(Cantidad>0)
);


CREATE TABLE Producto (
 Cod_Producto varchar(4) PRIMARY KEY,
 Denominación enum('Aceite de oliva virgen extra','Aceite de oliva virgen','Aceite de orujo','Hueso de aceituna') NOT NULL,
 Precio float NOT NULL, -- Es un float porque el precio no tiene por qué ser entero, además, el precio de nuestros productos siempre corresponde al litro o kilo, (depende de si hablamos de sólido o líquido)
 CONSTRAINT Producto_Precio_ck CHECK(precio>0)
);




CREATE TABLE Ventas (
 Num_Factura integer AUTO_INCREMENT PRIMARY KEY,
 NIF_Socio varchar(9),
  Fecha_Hora timestamp NOT NULL,
 CONSTRAINT Ventas_NS_fk FOREIGN KEY(NIF_Socio)
                             	REFERENCES Socios(NIF_Socio)
                             	ON UPDATE CASCADE
                             	ON DELETE NO ACTION
);


CREATE TABLE Producto_Ventas(
 Num_Factura integer,
 Cod_Producto varchar(4),
 Cantidad integer NOT NULL,
 CONSTRAINT Producto_Ventas_pk PRIMARY KEY(Num_Factura, Cod_Producto),
 CONSTRAINT Producto_Ventas_NF_fk FOREIGN KEY(Num_Factura)
                             	REFERENCES Ventas(Num_Factura)
                             	ON UPDATE CASCADE
                             	ON DELETE NO ACTION,
 CONSTRAINT Producto_Ventas_CP_fk FOREIGN KEY(Cod_Producto)
                             	REFERENCES Producto(Cod_Producto)
                             	ON UPDATE CASCADE
                             	ON DELETE NO ACTION
);


INSERT INTO Producto VALUES ('1', 'Aceite de oliva virgen extra', '11.30');
INSERT INTO Producto VALUES ('2', 'Aceite de oliva virgen', '8.90');
INSERT INTO Producto VALUES ('3', 'Aceite de orujo', '5.40');
INSERT INTO Producto VALUES ('4', 'Hueso de aceituna', '4.50');

