DROP DATABASE IF EXISTS basevolun;
CREATE DATABASE basevolun;
use basechocas;

CREATE TABLE OfcParo(
DNI varchar(9) NOT NULL,
Edad varchar(3) NOT NULL,
ÚltOficio varchar(50),
CONSTRAINT OfcParo_pk PRIMARY KEY(DNI),
);

