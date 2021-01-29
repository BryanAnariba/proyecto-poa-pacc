-- -----------------------------------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------Nota-----------------------------------------------------------------------
-- -----------------------------------------------------------------------------------------------------------------------------------
-- Necesario para agregar,modificar o eliminar de una tabla(Considerar esto al momento de eliminar directamente desde la bd):       --
--                                                                                                                                  --
--     *  Set @persona = <<id del usuario que esta eliminando>>                                                                     --
--                                                                                                                                  --
-- Necesario para agregar y modif de una tabla:                                                                                     --
--     *  Set @valorI y @valorF, siendo estos los json valor inicial y nuevo valor de los datos de la tambla.                       --
--        Ej: @valorI='{}';                                                                                                         --
--            @valorF=json_object("nombre",valor,...)                                                                               --    
--     *  Definir para las modificaciones en la tabla usuario la variable @tipoBitacora igual a:                                    --
--       1) '3', siendo este por cambio en la session.                                                                              --
--       2) '4', siendo este por cambio en las credenciales de acceso al sistema.                                                   --
--                                                                                                                                  --                                                                                                                    --
-- -----------------------------------------------------------------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------------------------------------------------------

-- -------------------------------------------Triggers carreras-----------------------------------------------------------------------
drop trigger if exists `insertarCarrera`;
DELIMITER //
create trigger `insertarCarrera` 
	after insert on `carrera`
    for each row 
begin
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = @valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,@valorI,@valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarCarrera`;
DELIMITER //
create trigger `modificarCarrera` 
	after update on `carrera`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idCarrera', old.idCarrera ,'carrera',old.carrera,'abrev',old.abrev, 'idDepartamento', old.idDepartamento, 'idEstadoCarrera',old.idEstadoCarrera);
    set nuevo = JSON_OBJECT('idCarrera', new.idCarrera ,'carrera',new.carrera,'abrev',new.abrev, 'idDepartamento', new.idDepartamento, 'idEstadoCarrera',new.idEstadoCarrera);

    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//
 
drop trigger if exists `eliminarCarreraBefore`;
DELIMITER //
create trigger `eliminarCarreraBefore` 
	before delete on `carrera`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idCarrera,JSON_OBJECT('idCarrera', idCarrera ,'carrera',carrera,'abrev',abrev, 'idDepartamento', idDepartamento, 'idEstadoCarrera',idEstadoCarrera))) as json FROM carrera);
    set cont = (SELECT count(*) FROM carrera);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total Carreras',cont),temp);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarCarreraAfter`;
DELIMITER //
create trigger `eliminarCarreraAfter` 
	after delete on `carrera`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idCarrera,JSON_OBJECT('idCarrera', idCarrera ,'carrera',carrera,'abrev',abrev, 'idDepartamento', idDepartamento, 'idEstadoCarrera',idEstadoCarrera)))  FROM carrera);
    set cont2 = (SELECT count(*) FROM carrera);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total Carreras',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM bitacora);
    
    UPDATE `poa-pacc-bd`.`bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//

-- -------------------------------------------Triggers objetos del gasto-----------------------------------------------------------------------
drop trigger if exists `insertarObjetoGasto`;
DELIMITER //
create trigger `insertarObjetoGasto` 
	after insert on `objetogasto`
    for each row 
begin
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = @valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,@valorI,@valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarObjetoGasto`;
DELIMITER //
create trigger `modificarObjetoGasto` 
	after update on `objetogasto`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idObjetoGasto', old.idObjetoGasto ,'DescripcionCuenta',old.DescripcionCuenta,'abrev',old.abrev, 'codigoObjetoGasto',old.codigoObjetoGasto, 'idEstadoObjetoGasto',old.idEstadoObjetoGasto);
    set nuevo = JSON_OBJECT('idObjetoGasto', new.idObjetoGasto ,'DescripcionCuenta',new.DescripcionCuenta,'abrev',new.abrev, 'codigoObjetoGasto',new.codigoObjetoGasto, 'idEstadoObjetoGasto',new.idEstadoObjetoGasto);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 

//
drop trigger if exists `eliminarObjetoGastoBefore`;
DELIMITER //
create trigger `eliminarObjetoGastoBefore` 
	before delete on `objetogasto`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idObjetoGasto,JSON_OBJECT('idObjetoGasto', idObjetoGasto ,'DescripcionCuenta',DescripcionCuenta,'abrev',abrev, 'codigoObjetoGasto',codigoObjetoGasto, 'idEstadoObjetoGasto',idEstadoObjetoGasto))) as json FROM objetogasto);
    set cont = (SELECT count(*) FROM objetogasto);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total Objeto de Gasto',cont),temp);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarObjetoGastoAfter`;
DELIMITER //
create trigger `eliminarObjetoGastoAfter` 
	after delete on `objetogasto`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idObjetoGasto,JSON_OBJECT('idObjetoGasto', idObjetoGasto ,'DescripcionCuenta',DescripcionCuenta,'abrev',abrev, 'codigoObjetoGasto',codigoObjetoGasto, 'idEstadoObjetoGasto',idEstadoObjetoGasto))) as json FROM objetogasto);
    set cont2 = (SELECT count(*) FROM objetogasto);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total Objeto de Gasto',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM bitacora);
    
    UPDATE `poa-pacc-bd`.`bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//

-- -------------------------------------------Triggers departamento-----------------------------------------------------------------------
drop trigger if exists `insertarDepartamento`;
DELIMITER //
create trigger `insertarDepartamento` 
	after insert on `departamento`
    for each row 
begin
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = @valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,@valorI,@valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarDepartamento`;
DELIMITER //
create trigger `modificarDepartamento` 
	after update on `departamento`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idDepartamento', old.idDepartamento ,'idEstadoDepartamento',old.idEstadoDepartamento,'nombreDepartamento',old.nombreDepartamento, 'telefonoDepartamento',old.telefonoDepartamento, 'abrev',old.abrev,'correoDepartamento', old.correoDepartamento);
    set nuevo = JSON_OBJECT('idDepartamento', new.idDepartamento ,'idEstadoDepartamento',new.idEstadoDepartamento,'nombreDepartamento',new.nombreDepartamento, 'telefonoDepartamento',new.telefonoDepartamento, 'abrev',new.abrev,'correoDepartamento', new.correoDepartamento);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarDepartamentoBefore`;
DELIMITER //
create trigger `eliminarDepartamentoBefore` 
	before delete on `departamento`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idDepartamento,JSON_OBJECT('idDepartamento', idDepartamento ,'idEstadoDepartamento',idEstadoDepartamento,'nombreDepartamento',nombreDepartamento, 'telefonoDepartamento',telefonoDepartamento, 'abrev',abrev,'correoDepartamento', correoDepartamento))) as json FROM departamento);
    set cont = (SELECT count(*) FROM departamento);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total Objeto de Gasto',cont),temp);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarDepartamentoAfter`;
DELIMITER //
create trigger `eliminarDepartamentoAfter` 
	after delete on `departamento`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idDepartamento,JSON_OBJECT('idDepartamento', idDepartamento ,'idEstadoDepartamento',idEstadoDepartamento,'nombreDepartamento',nombreDepartamento, 'telefonoDepartamento',telefonoDepartamento, 'abrev',abrev,'correoDepartamento', correoDepartamento))) as json FROM departamento);
    set cont2 = (SELECT count(*) FROM departamento);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total Objeto de Gasto',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM bitacora);
    
    UPDATE `poa-pacc-bd`.`bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//

-- -------------------------------------------Triggers dimensionEstrategica-----------------------------------------------------------------------
drop trigger if exists `insertarDimensionEstrategica`;
DELIMITER //
create trigger `insertarDimensionEstrategica` 
	after insert on `dimensionestrategica`
    for each row 
begin
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = @valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,@valorI,@valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarDimensionEstrategica`;
DELIMITER //
create trigger `modificarDimensionEstrategica` 
	after update on `dimensionestrategica`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idDimension', old.idDimension ,'idEstadoDimension',old.idEstadoDimension,'dimensionEstrategica',old.dimensionEstrategica);
    set nuevo = JSON_OBJECT('idDimension', new.idDimension ,'idEstadoDimension',new.idEstadoDimension,'dimensionEstrategica',new.dimensionEstrategica);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//
 
drop trigger if exists `eliminarDimensionEstrategicaBefore`;
DELIMITER //
create trigger `eliminarDimensionEstrategicaBefore` 
	before delete on `dimensionestrategica`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idDimension,JSON_OBJECT('idDimension', idDimension ,'idEstadoDimension',idEstadoDimension,'dimensionEstrategica',dimensionEstrategica))) as json FROM dimensionestrategica);
    set cont = (SELECT count(*) FROM dimensionestrategica);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total dimension estrategica',cont),temp);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarDimensionEstrategicaAfter`;
DELIMITER //
create trigger `eliminarDimensionEstrategicaAfter` 
	after delete on `dimensionestrategica`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idDimension,JSON_OBJECT('idDimension', idDimension ,'idEstadoDimension',idEstadoDimension,'dimensionEstrategica',dimensionEstrategica))) as json FROM dimensionestrategica);
    set cont2 = (SELECT count(*) FROM dimensionestrategica);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total dimension estrategica',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM bitacora);
    
    UPDATE `poa-pacc-bd`.`bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//
-- -------------------------------------------Triggers objetivoinstitucional-----------------------------------------------------------------------
drop trigger if exists `insertarObjetivoInstitucional`;
DELIMITER //
create trigger `insertarObjetivoInstitucional` 
	after insert on `objetivoinstitucional`
    for each row 
begin
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = @valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,@valorI,@valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarObjetivoInstitucional`;
DELIMITER //
create trigger `modificarObjetivoInstitucional` 
	after update on `objetivoinstitucional`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idObjetivoInstitucional', old.idObjetivoInstitucional ,'idDimensionEstrategica',old.idDimensionEstrategica,'idEstadoObjetivoInstitucional',old.idEstadoObjetivoInstitucional,'objetivoInstitucional',old.objetivoInstitucional);
    set nuevo = JSON_OBJECT('idObjetivoInstitucional', new.idObjetivoInstitucional ,'idDimensionEstrategica',new.idDimensionEstrategica,'idEstadoObjetivoInstitucional',new.idEstadoObjetivoInstitucional,'objetivoInstitucional',new.objetivoInstitucional);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarObjetivoInstitucionalBefore`;
DELIMITER //
create trigger `eliminarObjetivoInstitucionalBefore` 
	before delete on `objetivoinstitucional`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idObjetivoInstitucional,JSON_OBJECT('idObjetivoInstitucional', idObjetivoInstitucional ,'idDimensionEstrategica',idDimensionEstrategica,'idEstadoObjetivoInstitucional',idEstadoObjetivoInstitucional,'objetivoInstitucional',objetivoInstitucional))) as json FROM objetivoinstitucional);
    set cont = (SELECT count(*) FROM objetivoinstitucional);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total objetivo institucional',cont),temp);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//

drop trigger if exists `eliminarObjetivoInstitucionalAfter`;
DELIMITER //
create trigger `eliminarObjetivoInstitucionalAfter` 
	after delete on `objetivoinstitucional`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idObjetivoInstitucional,JSON_OBJECT('idObjetivoInstitucional', idObjetivoInstitucional ,'idDimensionEstrategica',idDimensionEstrategica,'idEstadoObjetivoInstitucional',idEstadoObjetivoInstitucional,'objetivoInstitucional',objetivoInstitucional))) as json FROM objetivoinstitucional);
    set cont2 = (SELECT count(*) FROM objetivoinstitucional);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total objetivo institucional',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM bitacora);
    
    UPDATE `poa-pacc-bd`.`bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//
-- -------------------------------------------Triggers areaestrategica-----------------------------------------------------------------------
drop trigger if exists `insertarAreaEstrategica`;
DELIMITER //
create trigger `insertarAreaEstrategica` 
	after insert on `areaestrategica`
    for each row 
begin
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = @valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,@valorI,@valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarAreaEstrategica`;
DELIMITER //
create trigger `modificarAreaEstrategica` 
	after update on `areaestrategica`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idAreaEstrategica',old.idAreaEstrategica ,'idEstadoAreaEstrategica',old.idEstadoAreaEstrategica,'idObjetivoInstitucional',old.idObjetivoInstitucional,'areaEstrategica',old.areaEstrategica);
    set nuevo = JSON_OBJECT('idAreaEstrategica',new.idAreaEstrategica ,'idEstadoAreaEstrategica',new.idEstadoAreaEstrategica,'idObjetivoInstitucional',new.idObjetivoInstitucional,'areaEstrategica',new.areaEstrategica);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//
 
drop trigger if exists `eliminarAreaEstrategicaBefore`;
DELIMITER //
create trigger `eliminarAreaEstrategicaBefore` 
	before delete on `areaestrategica`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idAreaEstrategica,JSON_OBJECT('idAreaEstrategica',idAreaEstrategica ,'idEstadoAreaEstrategica',idEstadoAreaEstrategica,'idObjetivoInstitucional',idObjetivoInstitucional,'areaEstrategica',areaEstrategica))) as json FROM areaestrategica);
    set cont = (SELECT count(*) FROM areaestrategica);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total area estrategica',cont),temp);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//

drop trigger if exists `eliminarAreaEstrategicaAfter`;
DELIMITER //
create trigger `eliminarAreaEstrategicaAfter` 
	after delete on `areaestrategica`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idAreaEstrategica,JSON_OBJECT('idAreaEstrategica',idAreaEstrategica ,'idEstadoAreaEstrategica',idEstadoAreaEstrategica,'idObjetivoInstitucional',idObjetivoInstitucional,'areaEstrategica',areaEstrategica))) as json FROM areaestrategica);
    set cont2 = (SELECT count(*) FROM areaestrategica);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total area estrategica',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM bitacora);
    
    UPDATE `poa-pacc-bd`.`bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//

-- -------------------------------------------Triggers resultadoinstitucional-----------------------------------------------------------------------
drop trigger if exists `insertarResultadoInstitucional`;
DELIMITER //
create trigger `insertarResultadoInstitucional` 
	after insert on `resultadoinstitucional`
    for each row 
begin
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = @valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,@valorI,@valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarResultadoInstitucional`;
DELIMITER //
create trigger `modificarResultadoInstitucional` 
	after update on `resultadoinstitucional`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idResultadoInstitucional',old.idResultadoInstitucional ,'idAreaEstrategica',old.idAreaEstrategica,'idEstadoResultadoInstitucional',old.idEstadoResultadoInstitucional,'resultadoInstitucional',old.resultadoInstitucional);
    set nuevo = JSON_OBJECT('idResultadoInstitucional',new.idResultadoInstitucional ,'idAreaEstrategica',new.idAreaEstrategica,'idEstadoResultadoInstitucional',new.idEstadoResultadoInstitucional,'resultadoInstitucional',new.resultadoInstitucional);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarResultadoInstitucionalBefore`;
DELIMITER //
create trigger `eliminarResultadoInstitucionalBefore` 
	before delete on `resultadoinstitucional`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idResultadoInstitucional,JSON_OBJECT('idResultadoInstitucional',idResultadoInstitucional ,'idAreaEstrategica',idAreaEstrategica,'idEstadoResultadoInstitucional',idEstadoResultadoInstitucional,'resultadoInstitucional',resultadoInstitucional))) as json FROM resultadoinstitucional);
    set cont = (SELECT count(*) FROM resultadoinstitucional);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total resultado institucional',cont),temp);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarResultadoInstitucionalAfter`;
DELIMITER //
create trigger `eliminarResultadoInstitucionalAfter` 
	after delete on `resultadoinstitucional`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idResultadoInstitucional,JSON_OBJECT('idResultadoInstitucional',idResultadoInstitucional ,'idAreaEstrategica',idAreaEstrategica,'idEstadoResultadoInstitucional',idEstadoResultadoInstitucional,'resultadoInstitucional',resultadoInstitucional))) as json FROM resultadoinstitucional);
    set cont2 = (SELECT count(*) FROM resultadoinstitucional);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total resultado institucional',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM bitacora);
    
    UPDATE `poa-pacc-bd`.`bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//
-- -------------------------------------------Triggers dimensionadministrativa-----------------------------------------------------------------------
drop trigger if exists `insertarDimensionAdministrativa`;
DELIMITER //
create trigger `insertarDimensionAdministrativa` 
	after insert on `dimensionadmin`
    for each row 
begin
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = @valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,@valorI,@valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarDimensionAdministrativa`;
DELIMITER //
create trigger `modificarDimensionAdministrativa` 
	after update on `dimensionadmin`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idDimension', old.idDimension ,'idEstadoDimension',old.idEstadoDimension,'dimensionAdministrativa',old.dimensionAdministrativa);
    set nuevo = JSON_OBJECT('idDimension', new.idDimension ,'idEstadoDimension',new.idEstadoDimension,'dimensionAdministrativa',new.dimensionAdministrativa);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarDimensionAdministrativaBefore`;
DELIMITER //
create trigger `eliminarDimensionAdministrativaBefore` 
	before delete on `dimensionadmin`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idDimension,JSON_OBJECT('idDimension', idDimension ,'idEstadoDimension',idEstadoDimension,'dimensionAdministrativa',dimensionAdministrativa))) as json FROM dimensionadmin);
    set cont = (SELECT count(*) FROM dimensionadmin);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total dimension administrativa',cont),temp);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarDimensionAdministrativaAfter`;
DELIMITER //
create trigger `eliminarDimensionAdministrativaAfter` 
	after delete on `dimensionadmin`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idDimension,JSON_OBJECT('idDimension', idDimension ,'idEstadoDimension',idEstadoDimension,'dimensionAdministrativa',dimensionAdministrativa))) as json FROM dimensionadmin);
    set cont2 = (SELECT count(*) FROM dimensionadmin);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total dimensiones administrativas',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM bitacora);
    
    UPDATE `poa-pacc-bd`.`bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//
-- -------------------------------------------Triggers Persona-----------------------------------------------------------------------
drop trigger if exists `insertarPersona`;
DELIMITER //
create trigger `insertarPersona` 
	after insert on `persona`
    for each row 
begin
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = @valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,@valorI,@valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarPersona`;
DELIMITER //
create trigger `modificarPersona` 
	after update on `persona`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idPersonaUsuario', old.idPersona ,'nombrePersona',old.nombrePersona,'apellidoPersona',old.apellidoPersona,'fechaNacimiento',old.fechaNacimiento,'direccion',old.direccion);
    set nuevo = JSON_OBJECT('idPersonaUsuario', new.idPersona ,'nombrePersona',new.nombrePersona,'apellidoPersona',new.apellidoPersona,'fechaNacimiento',new.fechaNacimiento,'direccion',new.direccion);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarPersonaBefore`;
DELIMITER //
create trigger `eliminarPersonaBefore` 
	before delete on `persona`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idPersona,JSON_OBJECT('idPersonaUsuario', idPersona ,'nombrePersona',nombrePersona,'apellidoPersona',apellidoPersona,'fechaNacimiento',fechaNacimiento,'direccion',direccion))) as json FROM persona);
    set cont = (SELECT count(*) FROM persona);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total personas',cont),temp);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarPersonaAfter`;
DELIMITER //
create trigger `eliminarPersonaAfter` 
	after delete on `persona`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idPersona,JSON_OBJECT('idPersonaUsuario', idPersona ,'nombrePersona',nombrePersona,'apellidoPersona',apellidoPersona,'fechaNacimiento',fechaNacimiento,'direccion',direccion))) as json FROM persona);
    set cont2 = (SELECT count(*) FROM persona);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total personas',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM bitacora);
    
    UPDATE `poa-pacc-bd`.`bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//
-- -------------------------------------------Triggers Usuario-----------------------------------------------------------------------
drop trigger if exists `insertarUsuario`;
DELIMITER //
create trigger `insertarUsuario` 
	after insert on `usuario`
    for each row 
begin
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = @valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,@tipoBitacora,@valorI,@valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarUsuario`;
DELIMITER //
create trigger `modificarUsuario` 
	before update on `usuario`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idPersonaUsuario',old.idPersonaUsuario,'nombreUsuario',old.nombreUsuario,'avatarUsuario',old.avatarUsuario,'correoInstitucional',old.correoInstitucional,'codigoEmpleado',old.codigoEmpleado,'tokenAcceso',old.tokenAcceso,'tokenExpiracion',old.tokenExpiracion);
    set nuevo = JSON_OBJECT('idPersonaUsuario',new.idPersonaUsuario,'nombreUsuario',new.nombreUsuario,'avatarUsuario',new.avatarUsuario,'correoInstitucional',new.correoInstitucional,'codigoEmpleado',new.codigoEmpleado,'tokenAcceso',new.tokenAcceso,'tokenExpiracion',new.tokenExpiracion);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,@tipoBitacora,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarUsuarioBefore`;
DELIMITER //
create trigger `eliminarUsuarioBefore` 
	before delete on `usuario`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idPersonaUsuario,JSON_OBJECT('idPersonaUsuario',idPersonaUsuario,'nombreUsuario',nombreUsuario,'avatarUsuario',avatarUsuario,'correoInstitucional',correoInstitucional,'codigoEmpleado',codigoEmpleado))) as json FROM usuario);
    set cont = (SELECT count(*) FROM usuario);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total usuarios',cont),temp);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarUsuarioAfter`;
DELIMITER //
create trigger `eliminarUsuarioAfter` 
	after delete on `usuario`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idPersonaUsuario,JSON_OBJECT('idPersonaUsuario',idPersonaUsuario,'nombreUsuario',nombreUsuario,'avatarUsuario',avatarUsuario,'correoInstitucional',correoInstitucional,'codigoEmpleado',codigoEmpleado))) as json FROM usuario);
    set cont2 = (SELECT count(*) FROM usuario);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total usuarios',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM bitacora);
    
    UPDATE `poa-pacc-bd`.`bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//
-- -------------------------------------------Triggers presupuestoDepartamento-----------------------------------------------------------------------
drop trigger if exists `insertarPresupuestoDepartamento`;
DELIMITER //
create trigger `insertarPresupuestoDepartamento` 
	after insert on `presupuestodepartamento`
    for each row 
begin
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = @valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,@valorI,@valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarPresupuestoDepartamento`;
DELIMITER //
create trigger `modificarPresupuestoDepartamento` 
	before update on `presupuestodepartamento`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idPresupuestoPorDepartamento',old.idPresupuestoPorDepartamento,'idDepartamento',old.idDepartamento,'montoPresupuesto',old.montoPresupuesto, 'idControlPresupuestoActividad',old.idControlPresupuestoActividad);
    set nuevo = JSON_OBJECT('idPresupuestoPorDepartamento',new.idPresupuestoPorDepartamento,'idDepartamento',new.idDepartamento,'montoPresupuesto',new.montoPresupuesto, 'idControlPresupuestoActividad',new.idControlPresupuestoActividad);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarPresupuestoDepartamentoBefore`;
DELIMITER //
create trigger `eliminarPresupuestoDepartamentoBefore` 
	before delete on `presupuestodepartamento`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idPresupuestoPorDepartamento,JSON_OBJECT('idPresupuestoPorDepartamento',idPresupuestoPorDepartamento,'idDepartamento',idDepartamento,'montoPresupuesto',montoPresupuesto, 'idControlPresupuestoActividad',idControlPresupuestoActividad))) as json FROM presupuestodepartamento);
    set cont = (SELECT count(*) FROM presupuestodepartamento);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total presupuestodepartamento',cont),temp);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarPresupuestoDepartamentoAfter`;
DELIMITER //
create trigger `eliminarPresupuestoDepartamentoAfter` 
	after delete on `presupuestodepartamento`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idPresupuestoPorDepartamento,JSON_OBJECT('idPresupuestoPorDepartamento',idPresupuestoPorDepartamento,'idDepartamento',idDepartamento,'montoPresupuesto',montoPresupuesto, 'idControlPresupuestoActividad',idControlPresupuestoActividad))) as json FROM presupuestodepartamento);
    set cont2 = (SELECT count(*) FROM presupuestodepartamento);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total presupuestodepartamento',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM bitacora);
    
    UPDATE `poa-pacc-bd`.`bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//

-- -------------------------------------------Triggers tipoActividad-----------------------------------------------------------------------
drop trigger if exists `insertarTipoActividad`;
DELIMITER //
create trigger `insertarTipoActividad` 
	after insert on `tipoactividad`
    for each row 
begin
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = @valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,@valorI,@valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarTipoActividad`;
DELIMITER //
create trigger `modificarTipoActividad` 
	before update on `tipoactividad`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idTipoActividad',old.idTipoActividad,'TipoActividad',old.TipoActividad);
    set nuevo = JSON_OBJECT('idTipoActividad',new.idTipoActividad,'TipoActividad',new.TipoActividad);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarTipoActividadBefore`;
DELIMITER //
create trigger `eliminarTipoActividadBefore` 
	before delete on `tipoactividad`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idTipoActividad,JSON_OBJECT('idTipoActividad',old.idTipoActividad,'TipoActividad',old.TipoActividad))) as json FROM tipoactividad);
    set cont = (SELECT count(*) FROM tipoactividad);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total tipoactividad',cont),temp);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarTipoActividadAfter`;
DELIMITER //
create trigger `eliminarTipoActividadAfter` 
	after delete on `tipoactividad`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idTipoActividad,JSON_OBJECT('idTipoActividad',old.idTipoActividad,'TipoActividad',old.TipoActividad))) as json FROM tipoactividad);
    set cont2 = (SELECT count(*) FROM tipoactividad);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total tipoactividad',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM bitacora);
    
    UPDATE `poa-pacc-bd`.`bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//