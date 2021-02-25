INSERT INTO `poa-pacc-bd`.`genero`  (`genero`, `abrev`) VALUES ('Masculino','M');
INSERT INTO `poa-pacc-bd`.`genero`  (`genero`, `abrev`) VALUES ('Femenino','F');
INSERT INTO `poa-pacc-bd`.`genero`  (`genero`, `abrev`) VALUES ('Otro','O');

INSERT INTO `poa-pacc-bd`.`EstadoDCDUOAO` (`estado`) VALUES ('Activo');
INSERT INTO `poa-pacc-bd`.`EstadoDCDUOAO` (`estado`) VALUES ('Inactivo');

INSERT INTO `poa-pacc-bd`.`tipousuario` (`tipoUsuario`,`abrev`) VALUES ('Super Administrador', 'SU_AD');
INSERT INTO `poa-pacc-bd`.`tipousuario` (`tipoUsuario`,`abrev`) VALUES ('Jefe Departamento', 'J_D');
INSERT INTO `poa-pacc-bd`.`tipousuario` (`tipoUsuario`,`abrev`) VALUES ('Coordinador Departamento', 'C_D');
INSERT INTO `poa-pacc-bd`.`tipousuario` (`tipoUsuario`,`abrev`) VALUES ('Decano', 'D_F');
INSERT INTO `poa-pacc-bd`.`tipousuario` (`tipoUsuario`,`abrev`) VALUES ('Usuario Estratega', 'U_E');
INSERT INTO `poa-pacc-bd`.`tipousuario` (`tipoUsuario`,`abrev`) VALUES ('Secretaria Administrativa', 'SE_AD');
INSERT INTO `poa-pacc-bd`.`tipousuario` (`tipoUsuario`,`abrev`) VALUES ('Secretaria Academica', 'S_AC');
update `poa-pacc-bd`.`tipoUsuario` set tipoUsuario = 'Coordinador Carrera' , abrev = 'C_C' WHERE idTIpoUsuario = 3;

INSERT INTO `poa-pacc-bd`.`departamento` (`idEstadoDepartamento`,`nombreDepartamento`,`abrev`,`telefonoDepartamento`, `correoDepartamento`) VALUES (
1,
'Ingenieria en Sistemas',
'IS',
'2216-6100',
'testIS@unah.hn');

INSERT INTO `poa-pacc-bd`.`departamento` (`idEstadoDepartamento`,`nombreDepartamento`,`abrev`,`telefonoDepartamento`, `correoDepartamento`) VALUES (
1,
'Ingenieria Industrial',
'II','2216-3014',
'testII@unah.hn');

INSERT INTO `poa-pacc-bd`.`departamento` (`idEstadoDepartamento`,`nombreDepartamento`,`abrev`,`telefonoDepartamento`, `correoDepartamento`) VALUES (
1,
'Ingenieria Mecanica',
'IM',
'2216-5100',
'testIM@unah.hn');

INSERT INTO `poa-pacc-bd`.`departamento` (`idEstadoDepartamento`,`nombreDepartamento`,`abrev`,`telefonoDepartamento`, `correoDepartamento`) VALUES (
1,
'Ingenieria Electrica',
'IE',
'2216-5155',
'testIE@unah.hn');

INSERT INTO `poa-pacc-bd`.`departamento` (`idEstadoDepartamento`,`nombreDepartamento`,`abrev`,`telefonoDepartamento`, `correoDepartamento`) VALUES (
2,
'Ingenieria Inactiva',
'IA',
'2216-2216',
'testIA@unah.hn');




INSERT INTO `poa-pacc-bd`.`tipolugar` (`tipoLugar`) VALUES ('Pais');
INSERT INTO `poa-pacc-bd`.`tipolugar` (`tipoLugar`) VALUES ('Departamento');
INSERT INTO `poa-pacc-bd`.`tipolugar` (`tipoLugar`) VALUES ('Municipio');



INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`)
VALUES ('1',null,'Honduras');

INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES ('1',null,'El Salvador');


INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES ('1',null,'Nicaragua');


INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES ('1',null,'Costa Rica');


INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES ('1',null,'Panama');

INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES ('1',null,'Guatemala');

INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES ('1',null,'Estados Unidos');


INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (2, 1, 'Francisco Morazan');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (2, 1, 'Comayagua');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (2, 1, 'Atlantida');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (2, 1, 'Colon');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (2, 1, 'Cortes');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (2, 1, 'Copan');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (2, 1, 'El Paraiso');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (2, 1, 'Gracias a Dios');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (2, 1, 'Intibuca');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (2, 1, 'Islas de la Bahia');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (2, 1, 'La paz');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (2, 1, 'Lempira');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (2, 1, 'Ocotepeque');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (2, 1, 'Olancho');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (2, 1, 'Santa Barbara');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (2, 1, 'Valle');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (2, 1, 'Yoro');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (2, 1, 'Choluteca');

INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 8, 'Distrito Central');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 8, 'Alubarén');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 8, 'Cedros');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 8, 'Curarén');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 8, 'El Porvenir');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 8, 'Guaimaca');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 8, 'La Libertad');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 8, 'La Venta');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 8, 'Lepaterique');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 8, 'Maraita');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 8, 'Marale');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 8, 'Nueva Armenia');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 8, 'Ojojona');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 8, 'Orica');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 8, 'Reitoca');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 8, 'Sabanagrande');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 8, 'San Antonio de Oriente');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 8, 'San Buenaventura');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 8, 'San Ignacio');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 8, 'San Juan de Flores');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 8, 'San Miguelito');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 8, 'Santa Ana');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 8, 'Santa Lucía');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 8, 'Talanga');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 8, 'Tatumbla');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 8, 'Valle de Ángeles');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 8, 'Villa de San Francisco');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 8, 'Vallecillo');

INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 9, 'Comayagua');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 9, 'Ajuterique');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 9, 'El Rosario');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 9, 'Esquías');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 9, 'Humuya');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 9, 'La libertad');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 9, 'Lamaní');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 9, 'La Trinidad');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 9, 'Lejamani');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 9, 'Meambar');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 9, 'Minas de Oro');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 9, 'Ojos de Agua');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 9, 'San Jerónimo');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 9, 'San José de Comayagua');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 9, 'San José del Potrero');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 9, 'San Luis');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 9, 'San Sebastián');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 9, 'Siguatepeque');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 9, 'Villa de San Antonio');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 9, 'Las Lajas');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 9, 'Taulabé');

INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 10, 'La Ceiba');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 10, 'Tela');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 10, 'Jutiapa');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 10, 'La Masica');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 10, 'San Francisco');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 10, 'Arizona');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 10, 'Esparta');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 10, 'El Porvenir');

INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 11, 'Trujillo');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 11, 'Balfate');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 11, 'Iriona');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 11, 'Limón');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 11, 'Sabá');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 11, 'Santa Fe');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 11, 'Santa Rosa de Aguán');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 11, 'Sonaguera');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 11, 'Tocoa');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 11, 'Bonito Oriental');


INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 12, 'San Pedro Sula');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 12, 'Choloma');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 12, 'Omoa');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 12, 'Pimienta');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 12, 'Potrerillos');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 12, 'Puerto Cortés');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 12, 'San Antonio de Cortés');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 12, 'San Francisco de Yojoa');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 12, 'San Manuel');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 12, 'Santa Cruz de Yojoa');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 12, 'Villanueva');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 12, 'La Lima');

INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 13, 'Santa Rosa de Copán');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 13, 'Cabañas');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 13, 'Concepción');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 13, 'Copán Ruinas');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 13, 'Corquín');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 13, 'Cucuyagua');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 13, 'Dolores');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 13, 'Dulce Nombre');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 13, 'El Paraíso');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 13, 'Florida');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 13, 'La Jigua');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 13, 'La Unión');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 13, 'Nueva Arcadia');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 13, 'San Agustín');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 13, 'San Antonio');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 13, 'San Jerónimo');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 13, 'San José');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 13, 'San Juan de Opoa');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 13, 'San Nicolás');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 13, 'San Pedro');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 13, 'Santa Rita');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 13, 'Trinidad de Copán');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 13, 'Veracruz');


INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 14, 'Yuscarán');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 14, 'Alauca');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 14, 'Danlí');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 14, 'El Paraíso');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 14, 'Güinope');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 14, 'Jacaleapa');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 14, 'Liure');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 14, 'Morocelí');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 14, 'Oropolí');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 14, 'Potrerillos');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 14, 'San Antonio de Flores');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 14, 'San Lucas');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 14, 'San Matías');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 14, 'Soledad');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 14, 'Teupasenti');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 14, 'Texiguat');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 14, 'Vado Ancho');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 14, 'Yauyupe');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 14, 'Trojes');


INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 15, 'Puerto Lempira');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 15, 'Brus Laguna');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 15, 'Ahuas');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 15, 'Juan Francisco Bulnes');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 15, 'Ramón Villeda Morales');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 15, 'Wampusirpe');

INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 16, 'La Esperanza');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 16, 'Camasca');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 16, 'Colomoncagua');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 16, 'Concepción');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 16, 'Dolores');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 16, 'Intibucá');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 16, 'Jesús de Otoro');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 16, 'Magdalena');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 16, 'Masaguara');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 16, 'San Antonio');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 16, 'San Isidro');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 16, 'San Juan');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 16, 'San Marcos de la Sierra');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 16, 'San Miguel Guancapla');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 16, 'Santa Lucía');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 16, 'Yamaranguila');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 16, 'San Francisco de Opalaca');

INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 17, 'Roatán');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 17, 'Guanaja');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 17, 'José Santos Guardiola');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 17, 'Utila');

INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 18, 'La Paz');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 18, 'Aguanqueterique');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 18, 'Cabañas');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 18, 'Cane');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 18, 'Chinacla');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 18, 'Guajiquiro');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 18, 'Lauterique');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 18, 'Marcala');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 18, 'Mercedes de Oriente');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 18, 'Opatoro');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 18, 'San Antonio del Norte');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 18, 'San José');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 18, 'San Juan');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 18, 'San Pedro de Tutule');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 18, 'Santa Ana');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 18, 'Santa Elena');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 18, 'Santa María');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 18, 'Santiago de Puringla');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 18, 'Yarula');

INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 19, 'Gracias');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 19, 'Belén');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 19, 'Candelaria');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 19, 'Cololaca');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 19, 'Erandique');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 19, 'Gualcince');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 19, 'Guarita');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 19, 'La Campa');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 19, 'La Iguala');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 19, 'Las Flores');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 19, 'La Unión');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 19, 'La Virtud');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 19, 'Lepaera');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 19, 'Mapulaca');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 19, 'Piraera');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 19, 'San Andrés');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 19, 'San Francisco');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 19, 'San Juan Guarita');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 19, 'San Manuel Colohete');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 19, 'San Rafael');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 19, 'San Sebastián');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 19, 'Santa Cruz');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 19, 'Talgua');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 19, 'Tambla');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 19, 'Tomalá');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 19, 'Valladolid');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 19, 'Virginia');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 19, 'San Marcos de Caiquín');


INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 20, 'Ocotepeque');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 20, 'Belén Gualcho');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 20, 'Concepción');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 20, 'Dolores Merendón');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 20, 'Fraternidad');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 20, 'La Encarnación');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 20, 'La Labor');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 20, 'Lucerna');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 20, 'Mercedes');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 20, 'San Fernando');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 20, 'San Francisco del Valle');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 20, 'San Jorge');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 20, 'San Marcos');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 20, 'Santa Fe');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 20, 'Sensenti');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 20, 'Sinuapa');


INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 21, 'Juticalpa');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 21, 'Campamento');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 21, 'Catacamas');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 21, 'Concordia');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 21, 'Dulce Nombre de Culmí');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 21, 'El Rosario');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 21, 'Esquipulas del Norte');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 21, 'Gualaco');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 21, 'Guarizama');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 21, 'Guata');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 21, 'Guayape');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 21, 'Jano');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 21, 'La Unión');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 21, 'Mangulile');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 21, 'Manto');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 21, 'Salamá');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 21, 'San Esteban');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 21, 'San Francisco de Becerra');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 21, 'San Francisco de la Paz');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 21, 'Santa María del Real');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 21, 'Silca');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 21, 'Yocón');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 21, 'Patuca');

INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 22, 'Santa Bárbara');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 22, 'Arada');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 22, 'Atima');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 22, 'Azacualpa');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 22, 'Ceguaca');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 22, 'Concepción del Norte');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 22, 'Concepción del Sur');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 22, 'Chinda');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 22, 'El Níspero');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 22, 'Gualala');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 22, 'Ilama');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 22, 'Las Vegas');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 22, 'Macuelizo');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 22, 'Naranjito');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 22, 'Nuevo Celilac');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 22, 'Nueva Frontera');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 22, 'Petoa');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 22, 'Protección');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 22, 'Quimistán');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 22, 'San Francisco de Ojuera');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 22, 'San José de las Colinas');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 22, 'San Luis');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 22, 'San Marcos');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 22, 'San Nicolás');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 22, 'San Pedro Zacapa');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 22, 'San Vicente Centenario');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 22, 'Santa Rita');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 22, 'Trinidad');

INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 23, 'Nacaome');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 23, 'Alianza');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 23, 'Amapala');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 23, 'Aramecina');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 23, 'Caridad');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 23, 'Goascorán');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 23, 'Langue');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 23, 'San Francisco de Coray');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 23, 'San Lorenzo');

INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 24, 'Yoro');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 24, 'Arenal');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 24, 'El Negrito');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 24, 'El Progreso');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 24, 'Jocón');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 24, 'Morazán');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 24, 'Olanchito');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 24, 'Santa Rita');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 24, 'Sulaco');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 24, 'Victoria');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 24, 'Yorito');

INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 25, 'Choluteca');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 25, 'Apacilagua');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 25, 'Concepción de María');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 25, 'Duyure');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 25, 'El Corpus');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 25, 'El Triunfo');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 25, 'Marcovia');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 25, 'Morolica');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 25, 'Namasigue');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 25, 'Orocuina');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 25, 'Pespire');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 25, 'San Antonio de Flores');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 25, 'San Isidro');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 25, 'San José');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 25, 'San Marcos de Colón');
INSERT INTO `poa-pacc-bd`.`lugar` (`idTipoLugar`,`idLugarPadre`,`nombreLugar`) VALUES (3, 25, 'Santa Ana de Yusguare');

INSERT INTO controlPresupuestoActividad(presupuestoAnual, fechaPresupuestoAnual, idEstadoPresupuestoAnual, estadoLlenadoActividades) 
VALUES 
(800000.00, '2020-12-31 13:55:30', 1, 0);

INSERT INTO `poa-pacc-bd`.`tipoactividad`(`TipoActividad`) VALUES ("Sin Costo");
INSERT INTO `poa-pacc-bd`.`tipoactividad`(`TipoActividad`) VALUES ("Con Costo");

INSERT INTO `poa-pacc-bd`.`tipopresupuesto`
(`idTipoPresupuesto`,
`tipoPresupuesto`)
VALUES
(1,
'Recurrente');

INSERT INTO `poa-pacc-bd`.`tipopresupuesto`
(`idTipoPresupuesto`,
`tipoPresupuesto`)
VALUES
(2,
'Programa/Proyecto');

INSERT INTO EstadoActividad (EstadoActividad) VALUES ('Pendiente');
INSERT INTO EstadoActividad (EstadoActividad) VALUES ('Hecha');



-- insertando datos en la tabla TIPOSOLICITUDSALIDA
INSERT INTO `tiposolicitudsalida` (`idTipoSolicitudSalida`, `tipoSolicitudSalida`) 
VALUES ('1', 'Permisos Personales'), ('2', 'Vacaciones');

-- insertando datos en la tabla TIPOESTADOSOLICITUD
INSERT INTO `tipoestadosolicitudsalida` (`idTipoEstadoSolicitud`, 
                                        `TipoEstadoSolicitudSalida`) 
VALUES ('1', 'Pendiente'), 
        ('2', 'Aceptado'), 
        ('3', 'Parcial'), 
        ('4', 'Denegado');


-- insertando datos en la tabla EstadoInforme
INSERT INTO `estadoinforme` (`idEstadoInforme`, `Estado`) 
VALUES (NULL, 'Pendiente'), (NULL, 'Aprobado');

-- insertado tabla trimestre
INSERT INTO `Trimestre` (`nombreTrimeste`) 
VALUES ('Trimestre 1'), ('Trimestre 2'), ('Trimestre 3'), ('Trimestre 4');