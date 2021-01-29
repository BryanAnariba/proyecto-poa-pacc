-- -----------------------------------------------------------Tabla tipobitacora------------------------------------------------------------

insert into `poa-pacc-bd`.`tipobitacora`(tipoBitacora,descripcion) values ('insert','Se ha insertado un nuevo dato');
insert into `poa-pacc-bd`.`tipobitacora`(tipoBitacora,descripcion) values ('update','Se ha modificado un dato existente');
insert into `poa-pacc-bd`.`tipobitacora`(tipoBitacora,descripcion) values ('delete','Se ha eliminado un dato existente');
insert into `poa-pacc-bd`.`tipobitacora`(tipoBitacora,descripcion) values ('update','Se ha registrado un cambio en la sesion');
insert into `poa-pacc-bd`.`tipobitacora`(tipoBitacora,descripcion) values ('update','Se ha registrado un cambio en credenciales');

-- -----------------------------------------------------------Tabla tipoactividad------------------------------------------------------------

set @valorf = JSON_OBJECT(
    'idTipoActividad',1,
    'TipoActividad','Recurrente'
);
INSERT INTO `tipoactividad` (`idTipoActividad`, `TipoActividad`) VALUES ('1', 'Recurrente');

set @valorf = JSON_OBJECT(
    'idTipoActividad',2,
    'TipoActividad','Programa / Proyecto 2018'
);
INSERT INTO `tipoactividad` (`idTipoActividad`, `TipoActividad`) VALUES ('2', 'Programa / Proyecto 2018');