-- -----------------------------------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------Nota-----------------------------------------------------------------------
-- -----------------------------------------------------------------------------------------------------------------------------------
-- Necesario para agregar,modificar o eliminar de una tabla(Considerar esto al momento de eliminar directamente desde la bd):       --
--                                                                                                                                  --
--     *  Set @persona = <<id del usuario que esta realizando la accion>>                                                           --
--        <<dentro del aplicacion seria "@persona={$_SESSION['idusuario']}"                                                           --
--        (Antes de hacer el insert,update o delete de alguna tabla)>>                                                              -- 
--                                                                                                                                  --   
-- Definir para las modificaciones en la tabla usuario la variable @tipoBitacora igual a:                                           --
--       * '2', siendo este por cambio datos existentes en la bd.                                                                   --
--       * '3', siendo este por eliminacion de datos existentes en la bd.                                                           --
--       * '4', siendo este por cambio en la session.                                                                               --
--       * '5', siendo este por cambio en las credenciales de acceso al sistema.                                                    --                                                                                                                    --
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
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idCarrera', new.idCarrera ,'carrera',new.carrera,'abrev',new.abrev, 'idDepartamento', new.idDepartamento, 'idEstadoCarrera',new.idEstadoCarrera);
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
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
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idObjetoGasto', new.idObjetoGasto ,'DescripcionCuenta',new.DescripcionCuenta,'abrev',new.abrev, 'codigoObjetoGasto',new.codigoObjetoGasto, 'idEstadoObjetoGasto',new.idEstadoObjetoGasto);
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
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
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idDepartamento', new.idDepartamento ,'idEstadoDepartamento',new.idEstadoDepartamento,'nombreDepartamento',new.nombreDepartamento, 'telefonoDepartamento',new.telefonoDepartamento, 'abrev',new.abrev,'correoDepartamento', new.correoDepartamento);
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
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
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idDimension', new.idDimension ,'idEstadoDimension',new.idEstadoDimension,'dimensionEstrategica',new.dimensionEstrategica);
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
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
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idObjetivoInstitucional', new.idObjetivoInstitucional ,'idDimensionEstrategica',new.idDimensionEstrategica,'idEstadoObjetivoInstitucional',new.idEstadoObjetivoInstitucional,'objetivoInstitucional',new.objetivoInstitucional);
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
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
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idAreaEstrategica',new.idAreaEstrategica ,'idEstadoAreaEstrategica',new.idEstadoAreaEstrategica,'idObjetivoInstitucional',new.idObjetivoInstitucional,'areaEstrategica',new.areaEstrategica);
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
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
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idResultadoInstitucional',new.idResultadoInstitucional ,'idAreaEstrategica',new.idAreaEstrategica,'idEstadoResultadoInstitucional',new.idEstadoResultadoInstitucional,'resultadoInstitucional',new.resultadoInstitucional);
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
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
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idDimension', new.idDimension ,'idEstadoDimension',new.idEstadoDimension,'dimensionAdministrativa',new.dimensionAdministrativa);
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
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
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idPersonaUsuario', new.idPersona ,'nombrePersona',new.nombrePersona,'apellidoPersona',new.apellidoPersona,'fechaNacimiento',new.fechaNacimiento,'direccion',new.direccion);
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
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
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idPersonaUsuario',new.idPersonaUsuario,'nombreUsuario',new.nombreUsuario,'avatarUsuario',new.avatarUsuario,'correoInstitucional',new.correoInstitucional,'codigoEmpleado',new.codigoEmpleado,'tokenAcceso',new.tokenAcceso,'tokenExpiracion',new.tokenExpiracion);
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarUsuario`;
DELIMITER //
create trigger `modificarUsuario` 
	after update on `usuario`
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
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idPresupuestoPorDepartamento',new.idPresupuestoPorDepartamento,'idDepartamento',new.idDepartamento,'montoPresupuesto',new.montoPresupuesto, 'idControlPresupuestoActividad',new.idControlPresupuestoActividad);
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarPresupuestoDepartamento`;
DELIMITER //
create trigger `modificarPresupuestoDepartamento` 
	after update on `presupuestodepartamento`
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
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idTipoActividad',new.idTipoActividad,'TipoActividad',new.TipoActividad);
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarTipoActividad`;
DELIMITER //
create trigger `modificarTipoActividad` 
	after update on `tipoactividad`
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
    
    set temp = (SELECT (JSON_OBJECTAGG(idTipoActividad,JSON_OBJECT('idTipoActividad',idTipoActividad,'TipoActividad',TipoActividad))) as json FROM tipoactividad);
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
    
    set temp = (SELECT (JSON_OBJECTAGG(idTipoActividad,JSON_OBJECT('idTipoActividad',idTipoActividad,'TipoActividad',TipoActividad))) as json FROM tipoactividad);
    set cont2 = (SELECT count(*) FROM tipoactividad);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total tipoactividad',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM bitacora);
    
    UPDATE `poa-pacc-bd`.`bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//

-- -------------------------------------------Triggers Actividad-----------------------------------------------------------------------
drop trigger if exists `insertarActividad`;
DELIMITER //
create trigger `insertarActividad` 
	after insert on `actividad`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idActividad',new.idActividad,'idPersonaUsuario',new.idPersonaUsuario,'idDimension',new.idDimension,'idObjetivoInstitucional',new.idObjetivoInstitucional,'idResultadoInstitucional',new.idResultadoInstitucional,'idAreaEstrategica',new.idAreaEstrategica,'idTipoActividad',new.idTipoActividad,'resultadosUnidad',new.resultadosUnidad,'indicadoresResultado',new.indicadoresResultado,'actividad',new.actividad,'correlativoActividad',new.correlativoActividad,'justificacionActividad',new.justificacionActividad,'medioVerificacionActividad',new.medioVerificacionActividad,'poblacionObjetivoActividad',new.poblacionObjetivoActividad,'responsableActividad',new.responsableActividad,'fechaCreacionActividad',new.fechaCreacionActividad,'CostoTotal',new.CostoTotal);
    
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarActividad`;
DELIMITER //
create trigger `modificarActividad` 
	after update on `actividad`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idActividad',old.idActividad,'idPersonaUsuario',old.idPersonaUsuario,'idDimension',old.idDimension,'idObjetivoInstitucional',old.idObjetivoInstitucional,'idResultadoInstitucional',old.idResultadoInstitucional,'idAreaEstrategica',old.idAreaEstrategica,'idTipoActividad',old.idTipoActividad,'resultadosUnidad',old.resultadosUnidad,'indicadoresResultado',old.indicadoresResultado,'actividad',old.actividad,'correlativoActividad',old.correlativoActividad,'justificacionActividad',old.justificacionActividad,'medioVerificacionActividad',old.medioVerificacionActividad,'poblacionObjetivoActividad',old.poblacionObjetivoActividad,'responsableActividad',old.responsableActividad,'fechaCreacionActividad',old.fechaCreacionActividad,'CostoTotal',old.CostoTotal);
    set nuevo = JSON_OBJECT('idActividad',new.idActividad,'idPersonaUsuario',new.idPersonaUsuario,'idDimension',new.idDimension,'idObjetivoInstitucional',new.idObjetivoInstitucional,'idResultadoInstitucional',new.idResultadoInstitucional,'idAreaEstrategica',new.idAreaEstrategica,'idTipoActividad',new.idTipoActividad,'resultadosUnidad',new.resultadosUnidad,'indicadoresResultado',new.indicadoresResultado,'actividad',new.actividad,'correlativoActividad',new.correlativoActividad,'justificacionActividad',new.justificacionActividad,'medioVerificacionActividad',new.medioVerificacionActividad,'poblacionObjetivoActividad',new.poblacionObjetivoActividad,'responsableActividad',new.responsableActividad,'fechaCreacionActividad',new.fechaCreacionActividad,'CostoTotal',new.CostoTotal);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarActividadBefore`;
DELIMITER //
create trigger `eliminarActividadBefore` 
	before delete on `actividad`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idTipoActividad,JSON_OBJECT('idActividad',idActividad,'idPersonaUsuario',idPersonaUsuario,'idDimension',idDimension,'idObjetivoInstitucional',idObjetivoInstitucional,'idResultadoInstitucional',idResultadoInstitucional,'idAreaEstrategica',idAreaEstrategica,'idTipoActividad',idTipoActividad,'resultadosUnidad',resultadosUnidad,'indicadoresResultado',indicadoresResultado,'actividad',actividad,'correlativoActividad',correlativoActividad,'justificacionActividad',justificacionActividad,'medioVerificacionActividad',medioVerificacionActividad,'poblacionObjetivoActividad',poblacionObjetivoActividad,'responsableActividad',responsableActividad,'fechaCreacionActividad',fechaCreacionActividad,'CostoTotal',CostoTotal))) as json FROM actividad);
    set cont = (SELECT count(*) FROM actividad);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total actividad',cont),temp);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarActividadAfter`;
DELIMITER //
create trigger `eliminarActividadAfter` 
	after delete on `actividad`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idTipoActividad,JSON_OBJECT('idActividad',idActividad,'idPersonaUsuario',idPersonaUsuario,'idDimension',idDimension,'idObjetivoInstitucional',idObjetivoInstitucional,'idResultadoInstitucional',idResultadoInstitucional,'idAreaEstrategica',idAreaEstrategica,'idTipoActividad',idTipoActividad,'resultadosUnidad',resultadosUnidad,'indicadoresResultado',indicadoresResultado,'actividad',actividad,'correlativoActividad',correlativoActividad,'justificacionActividad',justificacionActividad,'medioVerificacionActividad',medioVerificacionActividad,'poblacionObjetivoActividad',poblacionObjetivoActividad,'responsableActividad',responsableActividad,'fechaCreacionActividad',fechaCreacionActividad,'CostoTotal',CostoTotal))) as json FROM actividad);
    set cont2 = (SELECT count(*) FROM actividad);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total actividad',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM bitacora);
    
    UPDATE `poa-pacc-bd`.`bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//

-- -------------------------------------------Triggers controlpresupuestoactividad-----------------------------------------------------------------------
drop trigger if exists `insertarControlPresupuestoActividad`;
DELIMITER //
create trigger `insertarControlPresupuestoActividad` 
	after insert on `controlpresupuestoactividad`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idControlPresupuestoActividad',new.idControlPresupuestoActividad,'idEstadoPresupuestoAnual',new.idEstadoPresupuestoAnual,'presupuestoAnual',new.presupuestoAnual,'fechaPresupuestoAnual',new.fechaPresupuestoAnual);
    
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarControlPresupuestoActividad`;
DELIMITER //
create trigger `modificarControlPresupuestoActividad` 
	after update on `controlpresupuestoactividad`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idControlPresupuestoActividad',old.idControlPresupuestoActividad,'idEstadoPresupuestoAnual',old.idEstadoPresupuestoAnual,'presupuestoAnual',old.presupuestoAnual,'fechaPresupuestoAnual',old.fechaPresupuestoAnual);
    set nuevo = JSON_OBJECT('idControlPresupuestoActividad',new.idControlPresupuestoActividad,'idEstadoPresupuestoAnual',new.idEstadoPresupuestoAnual,'presupuestoAnual',new.presupuestoAnual,'fechaPresupuestoAnual',new.fechaPresupuestoAnual);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarControlPresupuestoActividadBefore`;
DELIMITER //
create trigger `eliminarControlPresupuestoActividadBefore` 
	before delete on `controlpresupuestoactividad`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idControlPresupuestoActividad,JSON_OBJECT('idControlPresupuestoActividad',idControlPresupuestoActividad,'idEstadoPresupuestoAnual',idEstadoPresupuestoAnual,'presupuestoAnual',presupuestoAnual,'fechaPresupuestoAnual',fechaPresupuestoAnual))) as json FROM controlpresupuestoactividad);
    set cont = (SELECT count(*) FROM controlpresupuestoactividad);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total controlpresupuestoactividad',cont),temp);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarControlPresupuestoActividadAfter`;
DELIMITER //
create trigger `eliminarControlPresupuestoActividadAfter` 
	after delete on `controlpresupuestoactividad`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idControlPresupuestoActividad,JSON_OBJECT('idControlPresupuestoActividad',idControlPresupuestoActividad,'idEstadoPresupuestoAnual',idEstadoPresupuestoAnual,'presupuestoAnual',presupuestoAnual,'fechaPresupuestoAnual',fechaPresupuestoAnual))) as json FROM controlpresupuestoactividad);
    set cont2 = (SELECT count(*) FROM controlpresupuestoactividad);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total controlpresupuestoactividad',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM bitacora);
    
    UPDATE `poa-pacc-bd`.`bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//

-- -------------------------------------------Triggers costoactividadportrimestre-----------------------------------------------------------------------
drop trigger if exists `insertarCostoActividadPorTrimestre`;
DELIMITER //
create trigger `insertarCostoActividadPorTrimestre` 
	after insert on `costoactividadportrimestre`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idCostActPorTri',new.idCostActPorTri,'idActividad',new.idActividad,'porcentajeTrimestre1',new.porcentajeTrimestre1,'Trimestre1',new.Trimestre1,'abrevTrimestre1',new.abrevTrimestre1,'porcentajeTrimestre2',new.porcentajeTrimestre2,'Trimestre2',new.Trimestre2,'abrevTrimestre2',new.abrevTrimestre2,'porcentajeTrimestre3',new.porcentajeTrimestre3,'Trimestre3',new.Trimestre3,'abrevTrimestre3',new.abrevTrimestre3,'porcentajeTrimestre4',new.porcentajeTrimestre4,'Trimestre4',new.Trimestre4,'abrevTrimestre4',new.abrevTrimestre4);
    
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarCostoActividadPorTrimestre`;
DELIMITER //
create trigger `modificarCostoActividadPorTrimestre` 
	after update on `costoactividadportrimestre`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idCostActPorTri',old.idCostActPorTri,'idActividad',old.idActividad,'porcentajeTrimestre1',old.porcentajeTrimestre1,'Trimestre1',old.Trimestre1,'abrevTrimestre1',old.abrevTrimestre1,'porcentajeTrimestre2',old.porcentajeTrimestre2,'Trimestre2',old.Trimestre2,'abrevTrimestre2',old.abrevTrimestre2,'porcentajeTrimestre3',old.porcentajeTrimestre3,'Trimestre3',old.Trimestre3,'abrevTrimestre3',old.abrevTrimestre3,'porcentajeTrimestre4',old.porcentajeTrimestre4,'Trimestre4',old.Trimestre4,'abrevTrimestre4',old.abrevTrimestre4);
    set nuevo = JSON_OBJECT('idCostActPorTri',new.idCostActPorTri,'idActividad',new.idActividad,'porcentajeTrimestre1',new.porcentajeTrimestre1,'Trimestre1',new.Trimestre1,'abrevTrimestre1',new.abrevTrimestre1,'porcentajeTrimestre2',new.porcentajeTrimestre2,'Trimestre2',new.Trimestre2,'abrevTrimestre2',new.abrevTrimestre2,'porcentajeTrimestre3',new.porcentajeTrimestre3,'Trimestre3',new.Trimestre3,'abrevTrimestre3',new.abrevTrimestre3,'porcentajeTrimestre4',new.porcentajeTrimestre4,'Trimestre4',new.Trimestre4,'abrevTrimestre4',new.abrevTrimestre4);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarCostoActividadPorTrimestreBefore`;
DELIMITER //
create trigger `eliminarCostoActividadPorTrimestreBefore` 
	before delete on `costoactividadportrimestre`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idCostActPorTri,JSON_OBJECT('idCostActPorTri',idCostActPorTri,'idActividad',idActividad,'porcentajeTrimestre1',porcentajeTrimestre1,'Trimestre1',Trimestre1,'abrevTrimestre1',abrevTrimestre1,'porcentajeTrimestre2',porcentajeTrimestre2,'Trimestre2',Trimestre2,'abrevTrimestre2',abrevTrimestre2,'porcentajeTrimestre3',porcentajeTrimestre3,'Trimestre3',Trimestre3,'abrevTrimestre3',abrevTrimestre3,'porcentajeTrimestre4',porcentajeTrimestre4,'Trimestre4',Trimestre4,'abrevTrimestre4',abrevTrimestre4))) as json FROM costoactividadportrimestre);
    set cont = (SELECT count(*) FROM costoactividadportrimestre);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total controlpresupuestoactividad',cont),temp);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarCostoActividadPorTrimestreAfter`;
DELIMITER //
create trigger `eliminarCostoActividadPorTrimestreAfter` 
	after delete on `costoactividadportrimestre`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idCostActPorTri,JSON_OBJECT('idCostActPorTri',idCostActPorTri,'idActividad',idActividad,'porcentajeTrimestre1',porcentajeTrimestre1,'Trimestre1',Trimestre1,'abrevTrimestre1',abrevTrimestre1,'porcentajeTrimestre2',porcentajeTrimestre2,'Trimestre2',Trimestre2,'abrevTrimestre2',abrevTrimestre2,'porcentajeTrimestre3',porcentajeTrimestre3,'Trimestre3',Trimestre3,'abrevTrimestre3',abrevTrimestre3,'porcentajeTrimestre4',porcentajeTrimestre4,'Trimestre4',Trimestre4,'abrevTrimestre4',abrevTrimestre4))) as json FROM costoactividadportrimestre);
    set cont2 = (SELECT count(*) FROM costoactividadportrimestre);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total controlpresupuestoactividad',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM bitacora);
    
    UPDATE `poa-pacc-bd`.`bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//

-- -------------------------------------------Triggers departamentopordimension-----------------------------------------------------------------------
drop trigger if exists `insertarDepartamentoPorDimension`;
DELIMITER //
create trigger `insertarDepartamentoPorDimension` 
	after insert on `departamentopordimension`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idDepartamentoDimension',new.idDepartamentoDimension,'idDimension',new.idDimension,'idDepartamento',new.idDepartamento,'estadoActividad',new.estadoActividad,'fecha',new.fecha);
    
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarDepartamentoPorDimension`;
DELIMITER //
create trigger `modificarDepartamentoPorDimension` 
	after update on `departamentopordimension`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idDepartamentoDimension',old.idDepartamentoDimension,'idDimension',old.idDimension,'idDepartamento',old.idDepartamento,'estadoActividad',old.estadoActividad,'fecha',old.fecha);
    set nuevo = JSON_OBJECT('idDepartamentoDimension',new.idDepartamentoDimension,'idDimension',new.idDimension,'idDepartamento',new.idDepartamento,'estadoActividad',new.estadoActividad,'fecha',new.fecha);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarDepartamentoPorDimensionBefore`;
DELIMITER //
create trigger `eliminarDepartamentoPorDimensionBefore` 
	before delete on `departamentopordimension`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idDepartamentoDimension,JSON_OBJECT('idDepartamentoDimension',idDepartamentoDimension,'idDimension',idDimension,'idDepartamento',idDepartamento,'estadoActividad',estadoActividad,'fecha',fecha))) as json FROM departamentopordimension);
    set cont = (SELECT count(*) FROM costoactividadportrimestre);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total departamentopordimension',cont),temp);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarDepartamentoPorDimensionAfter`;
DELIMITER //
create trigger `eliminarDepartamentoPorDimensionAfter` 
	after delete on `departamentopordimension`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idDepartamentoDimension,JSON_OBJECT('idDepartamentoDimension',idDepartamentoDimension,'idDimension',idDimension,'idDepartamento',idDepartamento,'estadoActividad',estadoActividad,'fecha',fecha))) as json FROM departamentopordimension);
    set cont2 = (SELECT count(*) FROM departamentopordimension);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total departamentopordimension',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM bitacora);
    
    UPDATE `poa-pacc-bd`.`bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//

-- -------------------------------------------Triggers descripcionadministrativa-----------------------------------------------------------------------
drop trigger if exists `insertarDescripcionAdministrativa`;
DELIMITER //
create trigger `insertarDescripcionAdministrativa` 
	after insert on `descripcionadministrativa`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idDescripcionAdministrativa',new.idDescripcionAdministrativa,'idObjetoGasto',new.idObjetoGasto,'idTipoPresupuesto',new.idTipoPresupuesto,'idActividad',new.idActividad,'idDimensionAdministrativa',new.idDimensionAdministrativa,'nombreActividad',new.nombreActividad,'Cantidad',new.Cantidad,'Costo',new.Costo,'costoTotal',new.costoTotal,'mesRequerido',new.mesRequerido,'Descripcion',new.Descripcion);
    
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarDescripcionAdministrativa`;
DELIMITER //
create trigger `modificarDescripcionAdministrativa` 
	after update on `descripcionadministrativa`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idDescripcionAdministrativa',old.idDescripcionAdministrativa,'idObjetoGasto',old.idObjetoGasto,'idTipoPresupuesto',old.idTipoPresupuesto,'idActividad',old.idActividad,'idDimensionAdministrativa',old.idDimensionAdministrativa,'nombreActividad',old.nombreActividad,'Cantidad',old.Cantidad,'Costo',old.Costo,'costoTotal',old.costoTotal,'mesRequerido',old.mesRequerido,'Descripcion',old.Descripcion);
    set nuevo = JSON_OBJECT('idDescripcionAdministrativa',new.idDescripcionAdministrativa,'idObjetoGasto',new.idObjetoGasto,'idTipoPresupuesto',new.idTipoPresupuesto,'idActividad',new.idActividad,'idDimensionAdministrativa',new.idDimensionAdministrativa,'nombreActividad',new.nombreActividad,'Cantidad',new.Cantidad,'Costo',new.Costo,'costoTotal',new.costoTotal,'mesRequerido',new.mesRequerido,'Descripcion',new.Descripcion);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarDescripcionAdministrativaBefore`;
DELIMITER //
create trigger `eliminarDescripcionAdministrativaBefore` 
	before delete on `descripcionadministrativa`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idDescripcionAdministrativa,JSON_OBJECT('idDescripcionAdministrativa',idDescripcionAdministrativa,'idObjetoGasto',idObjetoGasto,'idTipoPresupuesto',idTipoPresupuesto,'idActividad',idActividad,'idDimensionAdministrativa',idDimensionAdministrativa,'nombreActividad',nombreActividad,'Cantidad',Cantidad,'Costo',Costo,'costoTotal',costoTotal,'mesRequerido',mesRequerido,'Descripcion',Descripcion))) as json FROM descripcionadministrativa);
    set cont = (SELECT count(*) FROM descripcionadministrativa);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total descripcionadministrativa',cont),temp);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarDescripcionAdministrativaAfter`;
DELIMITER //
create trigger `eliminarDescripcionAdministrativaAfter` 
	after delete on `descripcionadministrativa`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idDescripcionAdministrativa,JSON_OBJECT('idDescripcionAdministrativa',idDescripcionAdministrativa,'idObjetoGasto',idObjetoGasto,'idTipoPresupuesto',idTipoPresupuesto,'idActividad',idActividad,'idDimensionAdministrativa',idDimensionAdministrativa,'nombreActividad',nombreActividad,'Cantidad',Cantidad,'Costo',Costo,'costoTotal',costoTotal,'mesRequerido',mesRequerido,'Descripcion',Descripcion))) as json FROM descripcionadministrativa);
    set cont2 = (SELECT count(*) FROM descripcionadministrativa);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total descripcionadministrativa',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM bitacora);
    
    UPDATE `poa-pacc-bd`.`bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//

-- -------------------------------------------Triggers estadodcduoao-----------------------------------------------------------------------
drop trigger if exists `insertarEstadoDCDUOAO`;
DELIMITER //
create trigger `insertarEstadoDCDUOAO` 
	after insert on `estadodcduoao`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idEstado',new.idEstado,'estado',new.estado);
    
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarEstadoDCDUOAO`;
DELIMITER //
create trigger `modificarEstadoDCDUOAO` 
	after update on `estadodcduoao`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idEstado',old.idEstado,'estado',old.estado);
    set nuevo = JSON_OBJECT('idEstado',new.idEstado,'estado',new.estado);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarEstadoDCDUOAOBefore`;
DELIMITER //
create trigger `eliminarEstadoDCDUOAOBefore` 
	before delete on `estadodcduoao`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idEstado,JSON_OBJECT('idEstado',idEstado,'estado',estado))) as json FROM estadodcduoao);
    set cont = (SELECT count(*) FROM estadodcduoao);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total estadodcduoao',cont),temp);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarEstadoDCDUOAOAfter`;
DELIMITER //
create trigger `eliminarEstadoDCDUOAOAfter` 
	after delete on `estadodcduoao`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idEstado,JSON_OBJECT('idEstado',idEstado,'estado',estado))) as json FROM estadodcduoao);
    set cont2 = (SELECT count(*) FROM estadodcduoao);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total estadodcduoao',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM bitacora);
    
    UPDATE `poa-pacc-bd`.`bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//

-- -------------------------------------------Triggers estadoinformes-----------------------------------------------------------------------
drop trigger if exists `insertarEstadoInformes`;
DELIMITER //
create trigger `insertarEstadoInformes` 
	after insert on `estadoinformes`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idEstadoInformes',new.idEstadoInformes,'Estado',new.Estado);
    
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarEstadoInformes`;
DELIMITER //
create trigger `modificarEstadoInformes` 
	after update on `estadoinformes`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idEstadoInformes',old.idEstadoInformes,'Estado',old.Estado);
    set nuevo = JSON_OBJECT('idEstadoInformes',new.idEstadoInformes,'Estado',new.Estado);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarEstadoInformesBefore`;
DELIMITER //
create trigger `eliminarEstadoInformesBefore` 
	before delete on `estadoinformes`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idEstadoInformes,JSON_OBJECT('idEstadoInformes',idEstadoInformes,'Estado',Estado))) as json FROM estadoinformes);
    set cont = (SELECT count(*) FROM estadoinformes);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total estadoinformes',cont),temp);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarEstadoInformesAfter`;
DELIMITER //
create trigger `eliminarEstadoInformesAfter` 
	after delete on `estadoinformes`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idEstadoInformes,JSON_OBJECT('idEstadoInformes',idEstadoInformes,'Estado',Estado))) as json FROM estadoinformes);
    set cont2 = (SELECT count(*) FROM estadoinformes);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total estadodcduoao',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM bitacora);
    
    UPDATE `poa-pacc-bd`.`bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//

-- -------------------------------------------Triggers estadoreporte-----------------------------------------------------------------------
drop trigger if exists `insertarEstadoReporte`;
DELIMITER //
create trigger `insertarEstadoReporte` 
	after insert on `estadoreporte`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('id_estado_reporte',new.id_estado_reporte,'estado_reporte',new.estado_reporte);
    
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarEstadoReporte`;
DELIMITER //
create trigger `modificarEstadoReporte` 
	after update on `estadoreporte`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('id_estado_reporte',old.id_estado_reporte,'estado_reporte',old.estado_reporte);
    set nuevo = JSON_OBJECT('id_estado_reporte',new.id_estado_reporte,'estado_reporte',new.estado_reporte);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarEstadoReporteBefore`;
DELIMITER //
create trigger `eliminarEstadoReporteBefore` 
	before delete on `estadoreporte`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(id_estado_reporte,JSON_OBJECT('id_estado_reporte',id_estado_reporte,'estado_reporte',estado_reporte))) as json FROM estadoreporte);
    set cont = (SELECT count(*) FROM estadoreporte);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total estadoreporte',cont),temp);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarEstadoReporteAfter`;
DELIMITER //
create trigger `eliminarEstadoReporteAfter` 
	after delete on `estadoreporte`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(id_estado_reporte,JSON_OBJECT('id_estado_reporte',id_estado_reporte,'estado_reporte',estado_reporte))) as json FROM estadoreporte);
    set cont2 = (SELECT count(*) FROM estadoreporte);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total estadoreporte',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM bitacora);
    
    UPDATE `poa-pacc-bd`.`bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//

-- -------------------------------------------Triggers tipoestadosolicitudsalida-----------------------------------------------------------------------
drop trigger if exists `insertarTipoEstadoSolicitudSalida`;
DELIMITER //
create trigger `insertarTipoEstadoSolicitudSalida` 
	after insert on `tipoestadosolicitudsalida`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idTipoEstadoSolicitud',new.idTipoEstadoSolicitud,'TipoEstadoSolicitudSalida',new.TipoEstadoSolicitudSalida);
    
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarTipoEstadoSolicitudSalida`;
DELIMITER //
create trigger `modificarTipoEstadoSolicitudSalida` 
	after update on `tipoestadosolicitudsalida`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idTipoEstadoSolicitud',old.idTipoEstadoSolicitud,'TipoEstadoSolicitudSalida',old.TipoEstadoSolicitudSalida);
    set nuevo = JSON_OBJECT('idTipoEstadoSolicitud',new.idTipoEstadoSolicitud,'TipoEstadoSolicitudSalida',new.TipoEstadoSolicitudSalida);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarTipoEstadoSolicitudSalidaBefore`;
DELIMITER //
create trigger `eliminarTipoEstadoSolicitudSalidaBefore` 
	before delete on `tipoestadosolicitudsalida`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idTipoEstadoSolicitud,JSON_OBJECT('idTipoEstadoSolicitud',idTipoEstadoSolicitud,'TipoEstadoSolicitudSalida',TipoEstadoSolicitudSalida))) as json FROM tipoestadosolicitudsalida);
    set cont = (SELECT count(*) FROM tipoestadosolicitudsalida);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total tipoestadosolicitudsalida',cont),temp);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarTipoEstadoSolicitudSalidaAfter`;
DELIMITER //
create trigger `eliminarTipoEstadoSolicitudSalidaAfter` 
	after delete on `tipoestadosolicitudsalida`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idTipoEstadoSolicitud,JSON_OBJECT('idTipoEstadoSolicitud',idTipoEstadoSolicitud,'TipoEstadoSolicitudSalida',TipoEstadoSolicitudSalida))) as json FROM tipoestadosolicitudsalida);
    set cont2 = (SELECT count(*) FROM tipoestadosolicitudsalida);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total tipoestadosolicitudsalida',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM bitacora);
    
    UPDATE `poa-pacc-bd`.`bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//
-- -------------------------------------------Triggers tiposolicitudsalida-----------------------------------------------------------------------
drop trigger if exists `insertarTipoSolicitudSalida`;
DELIMITER //
create trigger `insertarTipoSolicitudSalida` 
	after insert on `tiposolicitudsalida`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idTipoSolicitudSalida',new.idTipoSolicitudSalida,'tipoSolicitudSalida',new.tipoSolicitudSalida);
    
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarTipoSolicitudSalida`;
DELIMITER //
create trigger `modificarTipoSolicitudSalida` 
	after update on `tiposolicitudsalida`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idTipoSolicitudSalida',old.idTipoSolicitudSalida,'tipoSolicitudSalida',old.tipoSolicitudSalida);
    set nuevo = JSON_OBJECT('idTipoSolicitudSalida',new.idTipoSolicitudSalida,'tipoSolicitudSalida',new.tipoSolicitudSalida);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarTipoSolicitudSalidaBefore`;
DELIMITER //
create trigger `eliminarTipoSolicitudSalidaBefore` 
	before delete on `tiposolicitudsalida`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idTipoSolicitudSalida,JSON_OBJECT('idTipoSolicitudSalida',idTipoSolicitudSalida,'tipoSolicitudSalida',tipoSolicitudSalida))) as json FROM tiposolicitudsalida);
    set cont = (SELECT count(*) FROM tiposolicitudsalida);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total tiposolicitudsalida',cont),temp);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarTipoSolicitudSalidaAfter`;
DELIMITER //
create trigger `eliminarTipoSolicitudSalidaAfter` 
	after delete on `tiposolicitudsalida`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idTipoSolicitudSalida,JSON_OBJECT('idTipoSolicitudSalida',idTipoSolicitudSalida,'tipoSolicitudSalida',tipoSolicitudSalida))) as json FROM tiposolicitudsalida);
    set cont2 = (SELECT count(*) FROM tiposolicitudsalida);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total tiposolicitudsalida',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM bitacora);
    
    UPDATE `poa-pacc-bd`.`bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//
-- -------------------------------------------Triggers solicitudsalida-----------------------------------------------------------------------
drop trigger if exists `insertarSolicitudSalida`;
DELIMITER //
create trigger `insertarSolicitudSalida` 
	after insert on `solicitudsalida`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idSolicitud',new.idSolicitud,'idTipoSolicitud',new.idTipoSolicitud,'idPersonaUsuario',new.idPersonaUsuario,'descripcionSolicitud',new.descripcionSolicitud,'excusa',new.excusa,'firmaDigital',new.firmaDigital,'documentoRespaldo',new.documentoRespaldo,'horaInicioSolicitudSalida',new.horaInicioSolicitudSalida,'horaFinSolicitudSalida',new.horaFinSolicitudSalida,'diasSolicitados',new.diasSolicitados,'fechaInicioPermiso',new.fechaInicioPermiso,'fechaFinPermiso',new.fechaFinPermiso);
    
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarSolicitudSalida`;
DELIMITER //
create trigger `modificarSolicitudSalida` 
	after update on `solicitudsalida`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idSolicitud',old.idSolicitud,'idTipoSolicitud',old.idTipoSolicitud,'idPersonaUsuario',old.idPersonaUsuario,'descripcionSolicitud',old.descripcionSolicitud,'excusa',old.excusa,'firmaDigital',old.firmaDigital,'documentoRespaldo',old.documentoRespaldo,'horaInicioSolicitudSalida',old.horaInicioSolicitudSalida,'horaFinSolicitudSalida',old.horaFinSolicitudSalida,'diasSolicitados',old.diasSolicitados,'fechaInicioPermiso',old.fechaInicioPermiso,'fechaFinPermiso',old.fechaFinPermiso);
    set nuevo = JSON_OBJECT('idSolicitud',new.idSolicitud,'idTipoSolicitud',new.idTipoSolicitud,'idPersonaUsuario',new.idPersonaUsuario,'descripcionSolicitud',new.descripcionSolicitud,'excusa',new.excusa,'firmaDigital',new.firmaDigital,'documentoRespaldo',new.documentoRespaldo,'horaInicioSolicitudSalida',new.horaInicioSolicitudSalida,'horaFinSolicitudSalida',new.horaFinSolicitudSalida,'diasSolicitados',new.diasSolicitados,'fechaInicioPermiso',new.fechaInicioPermiso,'fechaFinPermiso',new.fechaFinPermiso);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarSolicitudSalidaBefore`;
DELIMITER //
create trigger `eliminarSolicitudSalidaBefore` 
	before delete on `solicitudsalida`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idSolicitud,JSON_OBJECT('idSolicitud',idSolicitud,'idTipoSolicitud',idTipoSolicitud,'idPersonaUsuario',idPersonaUsuario,'descripcionSolicitud',descripcionSolicitud,'excusa',excusa,'firmaDigital',firmaDigital,'documentoRespaldo',documentoRespaldo,'horaInicioSolicitudSalida',horaInicioSolicitudSalida,'horaFinSolicitudSalida',horaFinSolicitudSalida,'diasSolicitados',diasSolicitados,'fechaInicioPermiso',fechaInicioPermiso,'fechaFinPermiso',fechaFinPermiso))) as json FROM solicitudsalida);
    set cont = (SELECT count(*) FROM solicitudsalida);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total solicitudsalida',cont),temp);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarSolicitudSalidaAfter`;
DELIMITER //
create trigger `eliminarSolicitudSalidaAfter` 
	after delete on `solicitudsalida`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idSolicitud,JSON_OBJECT('idSolicitud',idSolicitud,'idTipoSolicitud',idTipoSolicitud,'idPersonaUsuario',idPersonaUsuario,'descripcionSolicitud',descripcionSolicitud,'excusa',excusa,'firmaDigital',firmaDigital,'documentoRespaldo',documentoRespaldo,'horaInicioSolicitudSalida',horaInicioSolicitudSalida,'horaFinSolicitudSalida',horaFinSolicitudSalida,'diasSolicitados',diasSolicitados,'fechaInicioPermiso',fechaInicioPermiso,'fechaFinPermiso',fechaFinPermiso))) as json FROM solicitudsalida);
    set cont2 = (SELECT count(*) FROM solicitudsalida);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total solicitudsalida',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM bitacora);
    
    UPDATE `poa-pacc-bd`.`bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//
-- -------------------------------------------Triggers estadosolicitudsalida-----------------------------------------------------------------------
drop trigger if exists `insertarEstadoSolicitudSalida`;
DELIMITER //
create trigger `insertarEstadoSolicitudSalida` 
	after insert on `estadosolicitudsalida`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idEstadoSolicitudSalida',new.idEstadoSolicitudSalida,'idPersonaUsuarioVeedor',new.idPersonaUsuarioVeedor,'idSolicitudSalida',new.idSolicitudSalida,'idTipoEstadoSolicitud',new.idTipoEstadoSolicitud,'observacionesSolicitud',new.observacionesSolicitud);
    
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarEstadoSolicitudSalida`;
DELIMITER //
create trigger `modificarEstadoSolicitudSalida` 
	after update on `estadosolicitudsalida`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idEstadoSolicitudSalida',old.idEstadoSolicitudSalida,'idPersonaUsuarioVeedor',old.idPersonaUsuarioVeedor,'idSolicitudSalida',old.idSolicitudSalida,'idTipoEstadoSolicitud',old.idTipoEstadoSolicitud,'observacionesSolicitud',old.observacionesSolicitud);
    set nuevo = JSON_OBJECT('idEstadoSolicitudSalida',new.idEstadoSolicitudSalida,'idPersonaUsuarioVeedor',new.idPersonaUsuarioVeedor,'idSolicitudSalida',new.idSolicitudSalida,'idTipoEstadoSolicitud',new.idTipoEstadoSolicitud,'observacionesSolicitud',new.observacionesSolicitud);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarEstadoSolicitudSalidaBefore`;
DELIMITER //
create trigger `eliminarEstadoSolicitudSalidaBefore` 
	before delete on `estadosolicitudsalida`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idEstadoSolicitudSalida,JSON_OBJECT('idEstadoSolicitudSalida',idEstadoSolicitudSalida,'idPersonaUsuarioVeedor',idPersonaUsuarioVeedor,'idSolicitudSalida',idSolicitudSalida,'idTipoEstadoSolicitud',idTipoEstadoSolicitud,'observacionesSolicitud',observacionesSolicitud))) as json FROM estadosolicitudsalida);
    set cont = (SELECT count(*) FROM estadosolicitudsalida);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total estadosolicitudsalida',cont),temp);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarEstadoSolicitudSalidaAfter`;
DELIMITER //
create trigger `eliminarEstadoSolicitudSalidaAfter` 
	after delete on `estadosolicitudsalida`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idEstadoSolicitudSalida,JSON_OBJECT('idEstadoSolicitudSalida',idEstadoSolicitudSalida,'idPersonaUsuarioVeedor',idPersonaUsuarioVeedor,'idSolicitudSalida',idSolicitudSalida,'idTipoEstadoSolicitud',idTipoEstadoSolicitud,'observacionesSolicitud',observacionesSolicitud))) as json FROM estadosolicitudsalida);
    set cont2 = (SELECT count(*) FROM estadosolicitudsalida);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total estadosolicitudsalida',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM bitacora);
    
    UPDATE `poa-pacc-bd`.`bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//
-- -------------------------------------------Triggers genero-----------------------------------------------------------------------
drop trigger if exists `insertarGenero`;
DELIMITER //
create trigger `insertarGenero` 
	after insert on `genero`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idGenero',new.idGenero,'genero',new.genero,'abrev',new.abrev);
    
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarGenero`;
DELIMITER //
create trigger `modificarGenero` 
	after update on `genero`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idGenero',old.idGenero,'genero',old.genero,'abrev',old.abrev);
    set nuevo = JSON_OBJECT('idGenero',new.idGenero,'genero',new.genero,'abrev',new.abrev);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarGeneroBefore`;
DELIMITER //
create trigger `eliminarGeneroBefore` 
	before delete on `genero`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idGenero,JSON_OBJECT('idGenero',idGenero,'genero',genero,'abrev',abrev))) as json FROM genero);
    set cont = (SELECT count(*) FROM genero);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total genero',cont),temp);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarGeneroAfter`;
DELIMITER //
create trigger `eliminarGeneroAfter` 
	after delete on `genero`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idGenero,JSON_OBJECT('idGenero',idGenero,'genero',genero,'abrev',abrev))) as json FROM genero);
    set cont2 = (SELECT count(*) FROM genero);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total genero',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM bitacora);
    
    UPDATE `poa-pacc-bd`.`bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//
-- -------------------------------------------Triggers tipografico-----------------------------------------------------------------------
drop trigger if exists `insertarTipoGrafico`;
DELIMITER //
create trigger `insertarTipoGrafico` 
	after insert on `tipografico`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('id_tipo_grafico',new.id_tipo_grafico,'tipo_grafico',new.tipo_grafico);
    
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarTipoGrafico`;
DELIMITER //
create trigger `modificarTipoGrafico` 
	after update on `tipografico`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('id_tipo_grafico',old.id_tipo_grafico,'tipo_grafico',old.tipo_grafico);
    set nuevo = JSON_OBJECT('id_tipo_grafico',new.id_tipo_grafico,'tipo_grafico',new.tipo_grafico);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarTipoGraficoBefore`;
DELIMITER //
create trigger `eliminarTipoGraficoBefore` 
	before delete on `tipografico`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(id_tipo_grafico,JSON_OBJECT('id_tipo_grafico',id_tipo_grafico,'tipo_grafico',tipo_grafico))) as json FROM tipografico);
    set cont = (SELECT count(*) FROM tipografico);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total tipografico',cont),temp);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarTipoGraficoAfter`;
DELIMITER //
create trigger `eliminarTipoGraficoAfter` 
	after delete on `tipografico`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(id_tipo_grafico,JSON_OBJECT('id_tipo_grafico',id_tipo_grafico,'tipo_grafico',tipo_grafico))) as json FROM tipografico);
    set cont2 = (SELECT count(*) FROM tipografico);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total tipografico',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM bitacora);
    
    UPDATE `poa-pacc-bd`.`bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//
-- -------------------------------------------Triggers grafico-----------------------------------------------------------------------
drop trigger if exists `insertarGrafico`;
DELIMITER //
create trigger `insertarGrafico` 
	after insert on `grafico`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('id_grafico',new.id_grafico,'id_persona_usuario',new.id_persona_usuario,'idTipoGraficos',new.idTipoGraficos,'nombre_grafico',new.nombre_grafico,'fecha_creacion_grafico',new.fecha_creacion_grafico);
    
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarGrafico`;
DELIMITER //
create trigger `modificarGrafico` 
	after update on `grafico`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('id_grafico',old.id_grafico,'id_persona_usuario',old.id_persona_usuario,'idTipoGraficos',old.idTipoGraficos,'nombre_grafico',old.nombre_grafico,'fecha_creacion_grafico',old.fecha_creacion_grafico);
    set nuevo = JSON_OBJECT('id_grafico',new.id_grafico,'id_persona_usuario',new.id_persona_usuario,'idTipoGraficos',new.idTipoGraficos,'nombre_grafico',new.nombre_grafico,'fecha_creacion_grafico',new.fecha_creacion_grafico);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarGraficoBefore`;
DELIMITER //
create trigger `eliminarGraficoBefore` 
	before delete on `grafico`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(id_grafico,JSON_OBJECT('id_grafico',id_grafico,'id_persona_usuario',id_persona_usuario,'idTipoGraficos',idTipoGraficos,'nombre_grafico',nombre_grafico,'fecha_creacion_grafico',fecha_creacion_grafico))) as json FROM grafico);
    set cont = (SELECT count(*) FROM grafico);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total grafico',cont),temp);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarGraficoAfter`;
DELIMITER //
create trigger `eliminarGraficoAfter` 
	after delete on `grafico`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(id_grafico,JSON_OBJECT('id_grafico',id_grafico,'id_persona_usuario',id_persona_usuario,'idTipoGraficos',idTipoGraficos,'nombre_grafico',nombre_grafico,'fecha_creacion_grafico',fecha_creacion_grafico))) as json FROM grafico);
    set cont2 = (SELECT count(*) FROM grafico);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total grafico',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM bitacora);
    
    UPDATE `poa-pacc-bd`.`bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//
-- -------------------------------------------Triggers informes-----------------------------------------------------------------------
drop trigger if exists `insertarInformes`;
DELIMITER //
create trigger `insertarInformes` 
	after insert on `informes`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idInformes',new.idInformes,'idPersonaUsuarioEnvia',new.idPersonaUsuarioEnvia,'idPersonaUsuarioAprueba',new.idPersonaUsuarioAprueba,'idEstadoInformes',new.idEstadoInformes,'fechaRecibido',new.fechaRecibido,'fechaAprobado',new.fechaAprobado);
    
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarInformes`;
DELIMITER //
create trigger `modificarInformes` 
	after update on `informes`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idInformes',old.idInformes,'idPersonaUsuarioEnvia',old.idPersonaUsuarioEnvia,'idPersonaUsuarioAprueba',old.idPersonaUsuarioAprueba,'idEstadoInformes',old.idEstadoInformes,'fechaRecibido',old.fechaRecibido,'fechaAprobado',old.fechaAprobado);
    set nuevo = JSON_OBJECT('idInformes',new.idInformes,'idPersonaUsuarioEnvia',new.idPersonaUsuarioEnvia,'idPersonaUsuarioAprueba',new.idPersonaUsuarioAprueba,'idEstadoInformes',new.idEstadoInformes,'fechaRecibido',new.fechaRecibido,'fechaAprobado',new.fechaAprobado);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarInformesBefore`;
DELIMITER //
create trigger `eliminarInformesBefore` 
	before delete on `informes`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idInformes,JSON_OBJECT('idInformes',idInformes,'idPersonaUsuarioEnvia',idPersonaUsuarioEnvia,'idPersonaUsuarioAprueba',idPersonaUsuarioAprueba,'idEstadoInformes',idEstadoInformes,'fechaRecibido',fechaRecibido,'fechaAprobado',fechaAprobado))) as json FROM informes);
    set cont = (SELECT count(*) FROM informes);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total informes',cont),temp);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarInformesAfter`;
DELIMITER //
create trigger `eliminarInformesAfter` 
	after delete on `informes`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idInformes,JSON_OBJECT('idInformes',idInformes,'idPersonaUsuarioEnvia',idPersonaUsuarioEnvia,'idPersonaUsuarioAprueba',idPersonaUsuarioAprueba,'idEstadoInformes',idEstadoInformes,'fechaRecibido',fechaRecibido,'fechaAprobado',fechaAprobado))) as json FROM informes);
    set cont2 = (SELECT count(*) FROM informes);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total informes',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM bitacora);
    
    UPDATE `poa-pacc-bd`.`bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//

-- -------------------------------------------Triggers llenadoactividaddimension-----------------------------------------------------------------------
drop trigger if exists `insertarLlenadoActividadDimension`;
DELIMITER //
create trigger `insertarLlenadoActividadDimension` 
	after insert on `llenadoactividaddimension`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idLlenadoDimension',new.idLlenadoDimension,'TipoUsuario_idTipoUsuario',new.TipoUsuario_idTipoUsuario,'valorLlenadoDimensionInicial',new.valorLlenadoDimensionInicial,'valorLlenadoDimensionFinal',new.valorLlenadoDimensionFinal);
    
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarLlenadoActividadDimension`;
DELIMITER //
create trigger `modificarLlenadoActividadDimension` 
	after update on `llenadoactividaddimension`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idLlenadoDimension',old.idLlenadoDimension,'TipoUsuario_idTipoUsuario',old.TipoUsuario_idTipoUsuario,'valorLlenadoDimensionInicial',old.valorLlenadoDimensionInicial,'valorLlenadoDimensionFinal',old.valorLlenadoDimensionFinal);
    set nuevo = JSON_OBJECT('idLlenadoDimension',new.idLlenadoDimension,'TipoUsuario_idTipoUsuario',new.TipoUsuario_idTipoUsuario,'valorLlenadoDimensionInicial',new.valorLlenadoDimensionInicial,'valorLlenadoDimensionFinal',new.valorLlenadoDimensionFinal);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarLlenadoActividadDimensionBefore`;
DELIMITER //
create trigger `eliminarLlenadoActividadDimensionBefore` 
	before delete on `llenadoactividaddimension`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idLlenadoDimension,JSON_OBJECT('idLlenadoDimension',idLlenadoDimension,'TipoUsuario_idTipoUsuario',TipoUsuario_idTipoUsuario,'valorLlenadoDimensionInicial',valorLlenadoDimensionInicial,'valorLlenadoDimensionFinal',valorLlenadoDimensionFinal))) as json FROM llenadoactividaddimension);
    set cont = (SELECT count(*) FROM llenadoactividaddimension);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total llenadoactividaddimension',cont),temp);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarLlenadoActividadDimensionAfter`;
DELIMITER //
create trigger `eliminarLlenadoActividadDimensionAfter` 
	after delete on `llenadoactividaddimension`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idLlenadoDimension,JSON_OBJECT('idLlenadoDimension',idLlenadoDimension,'TipoUsuario_idTipoUsuario',TipoUsuario_idTipoUsuario,'valorLlenadoDimensionInicial',valorLlenadoDimensionInicial,'valorLlenadoDimensionFinal',valorLlenadoDimensionFinal))) as json FROM llenadoactividaddimension);
    set cont2 = (SELECT count(*) FROM llenadoactividaddimension);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total llenadoactividaddimension',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM bitacora);
    
    UPDATE `poa-pacc-bd`.`bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//
-- -------------------------------------------Triggers lugar-----------------------------------------------------------------------
drop trigger if exists `insertarLugar`;
DELIMITER //
create trigger `insertarLugar` 
	after insert on `lugar`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idLugar',new.idLugar,'idTipoLugar',new.idTipoLugar,'idLugarPadre',new.idLugarPadre,'nombreLugar',new.nombreLugar);
    
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarLugar`;
DELIMITER //
create trigger `modificarLugar` 
	after update on `lugar`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idLugar',old.idLugar,'idTipoLugar',old.idTipoLugar,'idLugarPadre',old.idLugarPadre,'nombreLugar',old.nombreLugar);
    set nuevo = JSON_OBJECT('idLugar',new.idLugar,'idTipoLugar',new.idTipoLugar,'idLugarPadre',new.idLugarPadre,'nombreLugar',new.nombreLugar);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarLugarBefore`;
DELIMITER //
create trigger `eliminarLugarBefore` 
	before delete on `lugar`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idLugar,JSON_OBJECT('idLugar',idLugar,'idTipoLugar',idTipoLugar,'idLugarPadre',idLugarPadre,'nombreLugar',nombreLugar))) as json FROM lugar);
    set cont = (SELECT count(*) FROM lugar);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total lugar',cont),temp);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarLugarAfter`;
DELIMITER //
create trigger `eliminarLugarAfter` 
	after delete on `lugar`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idLugar,JSON_OBJECT('idLugar',idLugar,'idTipoLugar',idTipoLugar,'idLugarPadre',idLugarPadre,'nombreLugar',nombreLugar))) as json FROM lugar);
    set cont2 = (SELECT count(*) FROM lugar);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total lugar',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM bitacora);
    
    UPDATE `poa-pacc-bd`.`bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//
-- -------------------------------------------Triggers tiporeporte-----------------------------------------------------------------------
drop trigger if exists `insertarTipoReporte`;
DELIMITER //
create trigger `insertarTipoReporte` 
	after insert on `tiporeporte`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('id_tipo_reporte',new.id_tipo_reporte,'tipo_reporte',new.tipo_reporte);
    
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarTipoReporte`;
DELIMITER //
create trigger `modificarTipoReporte` 
	after update on `tiporeporte`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('id_tipo_reporte',old.id_tipo_reporte,'tipo_reporte',old.tipo_reporte);
    set nuevo = JSON_OBJECT('id_tipo_reporte',new.id_tipo_reporte,'tipo_reporte',new.tipo_reporte);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarTipoReporteBefore`;
DELIMITER //
create trigger `eliminarTipoReporteBefore` 
	before delete on `tiporeporte`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(id_tipo_reporte,JSON_OBJECT('id_tipo_reporte',id_tipo_reporte,'tipo_reporte',tipo_reporte))) as json FROM tiporeporte);
    set cont = (SELECT count(*) FROM tiporeporte);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total tiporeporte',cont),temp);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarTipoReporteAfter`;
DELIMITER //
create trigger `eliminarTipoReporteAfter` 
	after delete on `tiporeporte`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(id_tipo_reporte,JSON_OBJECT('id_tipo_reporte',id_tipo_reporte,'tipo_reporte',tipo_reporte))) as json FROM tiporeporte);
    set cont2 = (SELECT count(*) FROM tiporeporte);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total tiporeporte',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM bitacora);
    
    UPDATE `poa-pacc-bd`.`bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//
-- -------------------------------------------Triggers reporte-----------------------------------------------------------------------
drop trigger if exists `insertarReporte`;
DELIMITER //
create trigger `insertarReporte` 
	after insert on `reporte`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('id_reporte',new.id_reporte,'id_persona_usuario',new.id_persona_usuario,'id_tipo_reporte',new.id_tipo_reporte,'id_estado_reporte',new.id_estado_reporte,'nombre_reporte',new.nombre_reporte,'descripcion',new.descripcion,'fecha_creacion',new.fecha_creacion);
    
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarReporte`;
DELIMITER //
create trigger `modificarReporte` 
	after update on `reporte`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('id_reporte',old.id_reporte,'id_persona_usuario',old.id_persona_usuario,'id_tipo_reporte',old.id_tipo_reporte,'id_estado_reporte',old.id_estado_reporte,'nombre_reporte',old.nombre_reporte,'descripcion',old.descripcion,'fecha_creacion',old.fecha_creacion);
    set nuevo = JSON_OBJECT('id_reporte',new.id_reporte,'id_persona_usuario',new.id_persona_usuario,'id_tipo_reporte',new.id_tipo_reporte,'id_estado_reporte',new.id_estado_reporte,'nombre_reporte',new.nombre_reporte,'descripcion',new.descripcion,'fecha_creacion',new.fecha_creacion);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarReporteBefore`;
DELIMITER //
create trigger `eliminarReporteBefore` 
	before delete on `reporte`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(id_reporte,JSON_OBJECT('id_reporte',id_reporte,'id_persona_usuario',id_persona_usuario,'id_tipo_reporte',id_tipo_reporte,'id_estado_reporte',id_estado_reporte,'nombre_reporte',nombre_reporte,'descripcion',descripcion,'fecha_creacion',fecha_creacion))) as json FROM reporte);
    set cont = (SELECT count(*) FROM reporte);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total reporte',cont),temp);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarReporteAfter`;
DELIMITER //
create trigger `eliminarReporteAfter` 
	after delete on `reporte`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(id_reporte,JSON_OBJECT('id_reporte',id_reporte,'id_persona_usuario',id_persona_usuario,'id_tipo_reporte',id_tipo_reporte,'id_estado_reporte',id_estado_reporte,'nombre_reporte',nombre_reporte,'descripcion',descripcion,'fecha_creacion',fecha_creacion))) as json FROM reporte);
    set cont2 = (SELECT count(*) FROM reporte);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total reporte',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM bitacora);
    
    UPDATE `poa-pacc-bd`.`bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//

-- -------------------------------------------Triggers tipolugar-----------------------------------------------------------------------
drop trigger if exists `insertarTipoLugar`;
DELIMITER //
create trigger `insertarTipoLugar` 
	after insert on `tipolugar`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idTipoLugar',new.idTipoLugar,'tipoLugar',new.tipoLugar);
    
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarTipoLugar`;
DELIMITER //
create trigger `modificarTipoLugar` 
	after update on `tipolugar`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idTipoLugar',old.idTipoLugar,'tipoLugar',old.tipoLugar);
    set nuevo = JSON_OBJECT('idTipoLugar',new.idTipoLugar,'tipoLugar',new.tipoLugar);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarTipoLugarBefore`;
DELIMITER //
create trigger `eliminarTipoLugarBefore` 
	before delete on `tipolugar`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idTipoLugar,JSON_OBJECT('idTipoLugar',idTipoLugar,'tipoLugar',tipoLugar))) as json FROM tipolugar);
    set cont = (SELECT count(*) FROM tipolugar);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total tipolugar',cont),temp);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarTipoLugarAfter`;
DELIMITER //
create trigger `eliminarTipoLugarAfter` 
	after delete on `tipolugar`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idTipoLugar,JSON_OBJECT('idTipoLugar',idTipoLugar,'tipoLugar',tipoLugar))) as json FROM tipolugar);
    set cont2 = (SELECT count(*) FROM tipolugar);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total tipolugar',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM bitacora);
    
    UPDATE `poa-pacc-bd`.`bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//
-- -------------------------------------------Triggers tipopresupuesto-----------------------------------------------------------------------
drop trigger if exists `insertarTipoPresupuesto`;
DELIMITER //
create trigger `insertarTipoPresupuesto` 
	after insert on `tipopresupuesto`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idTipoPresupuesto',new.idTipoPresupuesto,'tipoPresupuesto',new.tipoPresupuesto);
    
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarTipoPresupuesto`;
DELIMITER //
create trigger `modificarTipoPresupuesto` 
	after update on `tipopresupuesto`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idTipoPresupuesto',old.idTipoPresupuesto,'tipoPresupuesto',old.tipoPresupuesto);
    set nuevo = JSON_OBJECT('idTipoPresupuesto',new.idTipoPresupuesto,'tipoPresupuesto',new.tipoPresupuesto);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarTipoPresupuestoBefore`;
DELIMITER //
create trigger `eliminarTipoPresupuestoBefore` 
	before delete on `tipopresupuesto`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idTipoPresupuesto,JSON_OBJECT('idTipoPresupuesto',idTipoPresupuesto,'tipoPresupuesto',tipoPresupuesto))) as json FROM tipopresupuesto);
    set cont = (SELECT count(*) FROM tipopresupuesto);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total tipopresupuesto',cont),temp);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarTipoPresupuestoAfter`;
DELIMITER //
create trigger `eliminarTipoPresupuestoAfter` 
	after delete on `tipopresupuesto`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idTipoPresupuesto,JSON_OBJECT('idTipoPresupuesto',idTipoPresupuesto,'tipoPresupuesto',tipoPresupuesto))) as json FROM tipopresupuesto);
    set cont2 = (SELECT count(*) FROM tipopresupuesto);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total tipopresupuesto',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM bitacora);
    
    UPDATE `poa-pacc-bd`.`bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//
-- -------------------------------------------Triggers tipousuario-----------------------------------------------------------------------
drop trigger if exists `insertarTipoUsuario`;
DELIMITER //
create trigger `insertarTipoUsuario` 
	after insert on `tipousuario`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idTipoUsuario',new.idTipoUsuario,'tipoUsuario',new.tipoUsuario,'abrev',new.abrev);
    
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarTipoUsuario`;
DELIMITER //
create trigger `modificarTipoUsuario` 
	after update on `tipousuario`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idTipoUsuario',old.idTipoUsuario,'tipoUsuario',old.tipoUsuario,'abrev',old.abrev);
    set nuevo = JSON_OBJECT('idTipoUsuario',new.idTipoUsuario,'tipoUsuario',new.tipoUsuario,'abrev',new.abrev);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarTipoUsuarioBefore`;
DELIMITER //
create trigger `eliminarTipoUsuarioBefore` 
	before delete on `tipousuario`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idTipoUsuario,JSON_OBJECT('idTipoUsuario',idTipoUsuario,'tipoUsuario',tipoUsuario,'abrev',abrev))) as json FROM tipousuario);
    set cont = (SELECT count(*) FROM tipousuario);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total tipousuario',cont),temp);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarTipoUsuarioAfter`;
DELIMITER //
create trigger `eliminarTipoUsuarioAfter` 
	after delete on `tipousuario`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idTipoUsuario,JSON_OBJECT('idTipoUsuario',idTipoUsuario,'tipoUsuario',tipoUsuario,'abrev',abrev))) as json FROM tipousuario);
    set cont2 = (SELECT count(*) FROM tipousuario);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total tipousuario',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM bitacora);
    
    UPDATE `poa-pacc-bd`.`bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//
-- -------------------------------------------Triggers tipobitacora-----------------------------------------------------------------------
drop trigger if exists `insertarTipoBitacora`;
DELIMITER //
create trigger `insertarTipoBitacora` 
	after insert on `tipobitacora`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idTipoBitacora',new.idTipoBitacora,'tipoBitacora',new.tipoBitacora,'descripcion',new.descripcion);
    
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarTipoBitacora`;
DELIMITER //
create trigger `modificarTipoBitacora` 
	after update on `tipobitacora`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idTipoBitacora',old.idTipoBitacora,'tipoBitacora',old.tipoBitacora,'descripcion',old.descripcion);
    set nuevo = JSON_OBJECT('idTipoBitacora',new.idTipoBitacora,'tipoBitacora',new.tipoBitacora,'descripcion',new.descripcion);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarTipoBitacoraBefore`;
DELIMITER //
create trigger `eliminarTipoBitacoraBefore` 
	before delete on `tipobitacora`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idTipoBitacora,JSON_OBJECT('idTipoBitacora',idTipoBitacora,'tipoBitacora',tipoBitacora,'descripcion',descripcion))) as json FROM tipobitacora);
    set cont = (SELECT count(*) FROM tipobitacora);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total tipobitacora',cont),temp);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarTipoBitacoraAfter`;
DELIMITER //
create trigger `eliminarTipoBitacoraAfter` 
	after delete on `tipobitacora`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idTipoBitacora,JSON_OBJECT('idTipoBitacora',idTipoBitacora,'tipoBitacora',tipoBitacora,'descripcion',descripcion))) as json FROM tipobitacora);
    set cont2 = (SELECT count(*) FROM tipobitacora);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total tipobitacora',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM bitacora);
    
    UPDATE `poa-pacc-bd`.`bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//
-- -------------------------------------------Triggers bitacora-----------------------------------------------------------------------
drop trigger if exists `modificarBitacora`;
DELIMITER //
create trigger `modificarBitacora` 
	after update on `bitacora`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idBitacora',old.idBitacora,'idPersonaUsuario',old.idPersonaUsuario,'idTipoBitacora',old.idTipoBitacora,'estadoInicialInformacion',old.estadoInicialInformacion,'nuevoEstadoInformacion',old.nuevoEstadoInformacion,'fechaHoraBitacora',old.fechaHoraBitacora);
    set nuevo = JSON_OBJECT('idBitacora',new.idBitacora,'idPersonaUsuario',new.idPersonaUsuario,'idTipoBitacora',new.idTipoBitacora,'estadoInicialInformacion',new.estadoInicialInformacion,'nuevoEstadoInformacion',new.nuevoEstadoInformacion,'fechaHoraBitacora',new.fechaHoraBitacora);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarBitacoraBefore`;
DELIMITER //
create trigger `eliminarBitacoraBefore` 
	before delete on `bitacora`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idBitacora,JSON_OBJECT('idBitacora',idBitacora,'idPersonaUsuario',idPersonaUsuario,'idTipoBitacora',idTipoBitacora,'estadoInicialInformacion',estadoInicialInformacion,'nuevoEstadoInformacion',nuevoEstadoInformacion,'fechaHoraBitacora',fechaHoraBitacora))) as json FROM bitacora);
    set cont = (SELECT count(*) FROM bitacora);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total bitacora',cont),temp);
    insert into
    `poa-pacc-bd`.`bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarBitacoraAfter`;
DELIMITER //
create trigger `eliminarBitacoraAfter` 
	after delete on `bitacora`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idBitacora,JSON_OBJECT('idBitacora',idBitacora,'idPersonaUsuario',idPersonaUsuario,'idTipoBitacora',idTipoBitacora,'estadoInicialInformacion',estadoInicialInformacion,'nuevoEstadoInformacion',nuevoEstadoInformacion,'fechaHoraBitacora',fechaHoraBitacora))) as json FROM bitacora);
    set cont2 = (SELECT count(*) FROM bitacora);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total bitacora',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM bitacora);
    
    UPDATE `poa-pacc-bd`.`bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//