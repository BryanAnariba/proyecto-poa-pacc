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
	after insert on `Carrera`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idCarrera', new.idCarrera ,'carrera',new.carrera,'abrev',new.abrev, 'idDepartamento', new.idDepartamento, 'idEstadoCarrera',new.idEstadoCarrera);
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarCarrera`;
DELIMITER //
create trigger `modificarCarrera` 
	after update on `Carrera`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idCarrera', old.idCarrera ,'carrera',old.carrera,'abrev',old.abrev, 'idDepartamento', old.idDepartamento, 'idEstadoCarrera',old.idEstadoCarrera);
    set nuevo = JSON_OBJECT('idCarrera', new.idCarrera ,'carrera',new.carrera,'abrev',new.abrev, 'idDepartamento', new.idDepartamento, 'idEstadoCarrera',new.idEstadoCarrera);

    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//
 
drop trigger if exists `eliminarCarreraBefore`;
DELIMITER //
create trigger `eliminarCarreraBefore` 
	before delete on `Carrera`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idCarrera,JSON_OBJECT('idCarrera', idCarrera ,'carrera',carrera,'abrev',abrev, 'idDepartamento', idDepartamento, 'idEstadoCarrera',idEstadoCarrera))) as json FROM Carrera);
    set cont = (SELECT count(*) FROM Carrera);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total Carreras',cont),temp);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarCarreraAfter`;
DELIMITER //
create trigger `eliminarCarreraAfter` 
	after delete on `Carrera`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idCarrera,JSON_OBJECT('idCarrera', idCarrera ,'carrera',carrera,'abrev',abrev, 'idDepartamento', idDepartamento, 'idEstadoCarrera',idEstadoCarrera)))  FROM Carrera);
    set cont2 = (SELECT count(*) FROM Carrera);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total Carreras',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM Bitacora);
    
    UPDATE `poa-pacc-bd`.`Bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//

-- -------------------------------------------Triggers objetos del gasto-----------------------------------------------------------------------
drop trigger if exists `insertarObjetoGasto`;
DELIMITER //
create trigger `insertarObjetoGasto` 
	after insert on `ObjetoGasto`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idObjetoGasto', new.idObjetoGasto ,'DescripcionCuenta',new.DescripcionCuenta,'abrev',new.abrev, 'codigoObjetoGasto',new.codigoObjetoGasto, 'idEstadoObjetoGasto',new.idEstadoObjetoGasto);
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarObjetoGasto`;
DELIMITER //
create trigger `modificarObjetoGasto` 
	after update on `ObjetoGasto`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idObjetoGasto', old.idObjetoGasto ,'DescripcionCuenta',old.DescripcionCuenta,'abrev',old.abrev, 'codigoObjetoGasto',old.codigoObjetoGasto, 'idEstadoObjetoGasto',old.idEstadoObjetoGasto);
    set nuevo = JSON_OBJECT('idObjetoGasto', new.idObjetoGasto ,'DescripcionCuenta',new.DescripcionCuenta,'abrev',new.abrev, 'codigoObjetoGasto',new.codigoObjetoGasto, 'idEstadoObjetoGasto',new.idEstadoObjetoGasto);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 

//
drop trigger if exists `eliminarObjetoGastoBefore`;
DELIMITER //
create trigger `eliminarObjetoGastoBefore` 
	before delete on `ObjetoGasto`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idObjetoGasto,JSON_OBJECT('idObjetoGasto', idObjetoGasto ,'DescripcionCuenta',DescripcionCuenta,'abrev',abrev, 'codigoObjetoGasto',codigoObjetoGasto, 'idEstadoObjetoGasto',idEstadoObjetoGasto))) as json FROM ObjetoGasto);
    set cont = (SELECT count(*) FROM ObjetoGasto);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total Objeto de Gasto',cont),temp);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarObjetoGastoAfter`;
DELIMITER //
create trigger `eliminarObjetoGastoAfter` 
	after delete on `ObjetoGasto`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idObjetoGasto,JSON_OBJECT('idObjetoGasto', idObjetoGasto ,'DescripcionCuenta',DescripcionCuenta,'abrev',abrev, 'codigoObjetoGasto',codigoObjetoGasto, 'idEstadoObjetoGasto',idEstadoObjetoGasto))) as json FROM ObjetoGasto);
    set cont2 = (SELECT count(*) FROM ObjetoGasto);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total Objeto de Gasto',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM Bitacora);
    
    UPDATE `poa-pacc-bd`.`Bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//

-- -------------------------------------------Triggers departamento-----------------------------------------------------------------------
drop trigger if exists `insertarDepartamento`;
DELIMITER //
create trigger `insertarDepartamento` 
	after insert on `Departamento`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idDepartamento', new.idDepartamento ,'idEstadoDepartamento',new.idEstadoDepartamento,'nombreDepartamento',new.nombreDepartamento, 'telefonoDepartamento',new.telefonoDepartamento, 'abrev',new.abrev,'correoDepartamento', new.correoDepartamento);
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarDepartamento`;
DELIMITER //
create trigger `modificarDepartamento` 
	after update on `Departamento`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idDepartamento', old.idDepartamento ,'idEstadoDepartamento',old.idEstadoDepartamento,'nombreDepartamento',old.nombreDepartamento, 'telefonoDepartamento',old.telefonoDepartamento, 'abrev',old.abrev,'correoDepartamento', old.correoDepartamento);
    set nuevo = JSON_OBJECT('idDepartamento', new.idDepartamento ,'idEstadoDepartamento',new.idEstadoDepartamento,'nombreDepartamento',new.nombreDepartamento, 'telefonoDepartamento',new.telefonoDepartamento, 'abrev',new.abrev,'correoDepartamento', new.correoDepartamento);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarDepartamentoBefore`;
DELIMITER //
create trigger `eliminarDepartamentoBefore` 
	before delete on `Departamento`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idDepartamento,JSON_OBJECT('idDepartamento', idDepartamento ,'idEstadoDepartamento',idEstadoDepartamento,'nombreDepartamento',nombreDepartamento, 'telefonoDepartamento',telefonoDepartamento, 'abrev',abrev,'correoDepartamento', correoDepartamento))) as json FROM Departamento);
    set cont = (SELECT count(*) FROM Departamento);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total Objeto de Gasto',cont),temp);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarDepartamentoAfter`;
DELIMITER //
create trigger `eliminarDepartamentoAfter` 
	after delete on `Departamento`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idDepartamento,JSON_OBJECT('idDepartamento', idDepartamento ,'idEstadoDepartamento',idEstadoDepartamento,'nombreDepartamento',nombreDepartamento, 'telefonoDepartamento',telefonoDepartamento, 'abrev',abrev,'correoDepartamento', correoDepartamento))) as json FROM Departamento);
    set cont2 = (SELECT count(*) FROM Departamento);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total Objeto de Gasto',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM Bitacora);
    
    UPDATE `poa-pacc-bd`.`Bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//

-- -------------------------------------------Triggers dimensionEstrategica-----------------------------------------------------------------------
drop trigger if exists `insertarDimensionEstrategica`;
DELIMITER //
create trigger `insertarDimensionEstrategica` 
	after insert on `DimensionEstrategica`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idDimension', new.idDimension ,'idEstadoDimension',new.idEstadoDimension,'dimensionEstrategica',new.dimensionEstrategica);
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarDimensionEstrategica`;
DELIMITER //
create trigger `modificarDimensionEstrategica` 
	after update on `DimensionEstrategica`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idDimension', old.idDimension ,'idEstadoDimension',old.idEstadoDimension,'dimensionEstrategica',old.dimensionEstrategica);
    set nuevo = JSON_OBJECT('idDimension', new.idDimension ,'idEstadoDimension',new.idEstadoDimension,'dimensionEstrategica',new.dimensionEstrategica);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//
 
drop trigger if exists `eliminarDimensionEstrategicaBefore`;
DELIMITER //
create trigger `eliminarDimensionEstrategicaBefore` 
	before delete on `DimensionEstrategica`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idDimension,JSON_OBJECT('idDimension', idDimension ,'idEstadoDimension',idEstadoDimension,'dimensionEstrategica',dimensionEstrategica))) as json FROM DimensionEstrategica);
    set cont = (SELECT count(*) FROM DimensionEstrategica);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total dimension estrategica',cont),temp);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarDimensionEstrategicaAfter`;
DELIMITER //
create trigger `eliminarDimensionEstrategicaAfter` 
	after delete on `DimensionEstrategica`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idDimension,JSON_OBJECT('idDimension', idDimension ,'idEstadoDimension',idEstadoDimension,'dimensionEstrategica',dimensionEstrategica))) as json FROM DimensionEstrategica);
    set cont2 = (SELECT count(*) FROM DimensionEstrategica);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total dimension estrategica',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM Bitacora);
    
    UPDATE `poa-pacc-bd`.`Bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//
-- -------------------------------------------Triggers objetivoinstitucional-----------------------------------------------------------------------
drop trigger if exists `insertarObjetivoInstitucional`;
DELIMITER //
create trigger `insertarObjetivoInstitucional` 
	after insert on `ObjetivoInstitucional`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idObjetivoInstitucional', new.idObjetivoInstitucional ,'idDimensionEstrategica',new.idDimensionEstrategica,'idEstadoObjetivoInstitucional',new.idEstadoObjetivoInstitucional,'objetivoInstitucional',new.objetivoInstitucional);
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarObjetivoInstitucional`;
DELIMITER //
create trigger `modificarObjetivoInstitucional` 
	after update on `ObjetivoInstitucional`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idObjetivoInstitucional', old.idObjetivoInstitucional ,'idDimensionEstrategica',old.idDimensionEstrategica,'idEstadoObjetivoInstitucional',old.idEstadoObjetivoInstitucional,'objetivoInstitucional',old.objetivoInstitucional);
    set nuevo = JSON_OBJECT('idObjetivoInstitucional', new.idObjetivoInstitucional ,'idDimensionEstrategica',new.idDimensionEstrategica,'idEstadoObjetivoInstitucional',new.idEstadoObjetivoInstitucional,'objetivoInstitucional',new.objetivoInstitucional);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarObjetivoInstitucionalBefore`;
DELIMITER //
create trigger `eliminarObjetivoInstitucionalBefore` 
	before delete on `ObjetivoInstitucional`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idObjetivoInstitucional,JSON_OBJECT('idObjetivoInstitucional', idObjetivoInstitucional ,'idDimensionEstrategica',idDimensionEstrategica,'idEstadoObjetivoInstitucional',idEstadoObjetivoInstitucional,'objetivoInstitucional',objetivoInstitucional))) as json FROM ObjetivoInstitucional);
    set cont = (SELECT count(*) FROM ObjetivoInstitucional);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total objetivo institucional',cont),temp);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//

drop trigger if exists `eliminarObjetivoInstitucionalAfter`;
DELIMITER //
create trigger `eliminarObjetivoInstitucionalAfter` 
	after delete on `ObjetivoInstitucional`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idObjetivoInstitucional,JSON_OBJECT('idObjetivoInstitucional', idObjetivoInstitucional ,'idDimensionEstrategica',idDimensionEstrategica,'idEstadoObjetivoInstitucional',idEstadoObjetivoInstitucional,'objetivoInstitucional',objetivoInstitucional))) as json FROM ObjetivoInstitucional);
    set cont2 = (SELECT count(*) FROM ObjetivoInstitucional);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total objetivo institucional',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM Bitacora);
    
    UPDATE `poa-pacc-bd`.`Bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//
-- -------------------------------------------Triggers areaestrategica-----------------------------------------------------------------------
drop trigger if exists `insertarAreaEstrategica`;
DELIMITER //
create trigger `insertarAreaEstrategica` 
	after insert on `AreaEstrategica`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idAreaEstrategica',new.idAreaEstrategica ,'idEstadoAreaEstrategica',new.idEstadoAreaEstrategica,'idObjetivoInstitucional',new.idObjetivoInstitucional,'areaEstrategica',new.areaEstrategica);
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarAreaEstrategica`;
DELIMITER //
create trigger `modificarAreaEstrategica` 
	after update on `AreaEstrategica`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idAreaEstrategica',old.idAreaEstrategica ,'idEstadoAreaEstrategica',old.idEstadoAreaEstrategica,'idObjetivoInstitucional',old.idObjetivoInstitucional,'areaEstrategica',old.areaEstrategica);
    set nuevo = JSON_OBJECT('idAreaEstrategica',new.idAreaEstrategica ,'idEstadoAreaEstrategica',new.idEstadoAreaEstrategica,'idObjetivoInstitucional',new.idObjetivoInstitucional,'areaEstrategica',new.areaEstrategica);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//
 
drop trigger if exists `eliminarAreaEstrategicaBefore`;
DELIMITER //
create trigger `eliminarAreaEstrategicaBefore` 
	before delete on `AreaEstrategica`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idAreaEstrategica,JSON_OBJECT('idAreaEstrategica',idAreaEstrategica ,'idEstadoAreaEstrategica',idEstadoAreaEstrategica,'idObjetivoInstitucional',idObjetivoInstitucional,'areaEstrategica',areaEstrategica))) as json FROM AreaEstrategica);
    set cont = (SELECT count(*) FROM AreaEstrategica);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total area estrategica',cont),temp);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//

drop trigger if exists `eliminarAreaEstrategicaAfter`;
DELIMITER //
create trigger `eliminarAreaEstrategicaAfter` 
	after delete on `AreaEstrategica`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idAreaEstrategica,JSON_OBJECT('idAreaEstrategica',idAreaEstrategica ,'idEstadoAreaEstrategica',idEstadoAreaEstrategica,'idObjetivoInstitucional',idObjetivoInstitucional,'areaEstrategica',areaEstrategica))) as json FROM AreaEstrategica);
    set cont2 = (SELECT count(*) FROM AreaEstrategica);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total area estrategica',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM Bitacora);
    
    UPDATE `poa-pacc-bd`.`Bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//

-- -------------------------------------------Triggers resultadoinstitucional-----------------------------------------------------------------------
drop trigger if exists `insertarResultadoInstitucional`;
DELIMITER //
create trigger `insertarResultadoInstitucional` 
	after insert on `ResultadoInstitucional`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idResultadoInstitucional',new.idResultadoInstitucional ,'idAreaEstrategica',new.idAreaEstrategica,'idEstadoResultadoInstitucional',new.idEstadoResultadoInstitucional,'resultadoInstitucional',new.resultadoInstitucional);
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarResultadoInstitucional`;
DELIMITER //
create trigger `modificarResultadoInstitucional` 
	after update on `ResultadoInstitucional`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idResultadoInstitucional',old.idResultadoInstitucional ,'idAreaEstrategica',old.idAreaEstrategica,'idEstadoResultadoInstitucional',old.idEstadoResultadoInstitucional,'resultadoInstitucional',old.resultadoInstitucional);
    set nuevo = JSON_OBJECT('idResultadoInstitucional',new.idResultadoInstitucional ,'idAreaEstrategica',new.idAreaEstrategica,'idEstadoResultadoInstitucional',new.idEstadoResultadoInstitucional,'resultadoInstitucional',new.resultadoInstitucional);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarResultadoInstitucionalBefore`;
DELIMITER //
create trigger `eliminarResultadoInstitucionalBefore` 
	before delete on `ResultadoInstitucional`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idResultadoInstitucional,JSON_OBJECT('idResultadoInstitucional',idResultadoInstitucional ,'idAreaEstrategica',idAreaEstrategica,'idEstadoResultadoInstitucional',idEstadoResultadoInstitucional,'resultadoInstitucional',resultadoInstitucional))) as json FROM ResultadoInstitucional);
    set cont = (SELECT count(*) FROM ResultadoInstitucional);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total resultado institucional',cont),temp);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarResultadoInstitucionalAfter`;
DELIMITER //
create trigger `eliminarResultadoInstitucionalAfter` 
	after delete on `ResultadoInstitucional`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idResultadoInstitucional,JSON_OBJECT('idResultadoInstitucional',idResultadoInstitucional ,'idAreaEstrategica',idAreaEstrategica,'idEstadoResultadoInstitucional',idEstadoResultadoInstitucional,'resultadoInstitucional',resultadoInstitucional))) as json FROM ResultadoInstitucional);
    set cont2 = (SELECT count(*) FROM ResultadoInstitucional);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total resultado institucional',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM Bitacora);
    
    UPDATE `poa-pacc-bd`.`Bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//
-- -------------------------------------------Triggers dimensionadministrativa-----------------------------------------------------------------------
drop trigger if exists `insertarDimensionAdministrativa`;
DELIMITER //
create trigger `insertarDimensionAdministrativa` 
	after insert on `DimensionAdmin`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idDimension', new.idDimension ,'idEstadoDimension',new.idEstadoDimension,'dimensionAdministrativa',new.dimensionAdministrativa);
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarDimensionAdministrativa`;
DELIMITER //
create trigger `modificarDimensionAdministrativa` 
	after update on `DimensionAdmin`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idDimension', old.idDimension ,'idEstadoDimension',old.idEstadoDimension,'dimensionAdministrativa',old.dimensionAdministrativa);
    set nuevo = JSON_OBJECT('idDimension', new.idDimension ,'idEstadoDimension',new.idEstadoDimension,'dimensionAdministrativa',new.dimensionAdministrativa);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarDimensionAdministrativaBefore`;
DELIMITER //
create trigger `eliminarDimensionAdministrativaBefore` 
	before delete on `DimensionAdmin`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idDimension,JSON_OBJECT('idDimension', idDimension ,'idEstadoDimension',idEstadoDimension,'dimensionAdministrativa',dimensionAdministrativa))) as json FROM DimensionAdmin);
    set cont = (SELECT count(*) FROM DimensionAdmin);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total dimension administrativa',cont),temp);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarDimensionAdministrativaAfter`;
DELIMITER //
create trigger `eliminarDimensionAdministrativaAfter` 
	after delete on `DimensionAdmin`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idDimension,JSON_OBJECT('idDimension', idDimension ,'idEstadoDimension',idEstadoDimension,'dimensionAdministrativa',dimensionAdministrativa))) as json FROM DimensionAdmin);
    set cont2 = (SELECT count(*) FROM DimensionAdmin);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total dimensiones administrativas',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM Bitacora);
    
    UPDATE `poa-pacc-bd`.`Bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//
-- -------------------------------------------Triggers Persona-----------------------------------------------------------------------
drop trigger if exists `insertarPersona`;
DELIMITER //
create trigger `insertarPersona` 
	after insert on `Persona`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idPersonaUsuario', new.idPersona ,'nombrePersona',new.nombrePersona,'apellidoPersona',new.apellidoPersona,'fechaNacimiento',new.fechaNacimiento,'direccion',new.direccion);
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarPersona`;
DELIMITER //
create trigger `modificarPersona` 
	after update on `Persona`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idPersonaUsuario', old.idPersona ,'nombrePersona',old.nombrePersona,'apellidoPersona',old.apellidoPersona,'fechaNacimiento',old.fechaNacimiento,'direccion',old.direccion);
    set nuevo = JSON_OBJECT('idPersonaUsuario', new.idPersona ,'nombrePersona',new.nombrePersona,'apellidoPersona',new.apellidoPersona,'fechaNacimiento',new.fechaNacimiento,'direccion',new.direccion);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarPersonaBefore`;
DELIMITER //
create trigger `eliminarPersonaBefore` 
	before delete on `Persona`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idPersona,JSON_OBJECT('idPersonaUsuario', idPersona ,'nombrePersona',nombrePersona,'apellidoPersona',apellidoPersona,'fechaNacimiento',fechaNacimiento,'direccion',direccion))) as json FROM Persona);
    set cont = (SELECT count(*) FROM Persona);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total personas',cont),temp);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarPersonaAfter`;
DELIMITER //
create trigger `eliminarPersonaAfter` 
	after delete on `Persona`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idPersona,JSON_OBJECT('idPersonaUsuario', idPersona ,'nombrePersona',nombrePersona,'apellidoPersona',apellidoPersona,'fechaNacimiento',fechaNacimiento,'direccion',direccion))) as json FROM Persona);
    set cont2 = (SELECT count(*) FROM Persona);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total personas',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM Bitacora);
    
    UPDATE `poa-pacc-bd`.`Bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//
-- -------------------------------------------Triggers Usuario-----------------------------------------------------------------------
drop trigger if exists `insertarUsuario`;
DELIMITER //
create trigger `insertarUsuario` 
	after insert on `Usuario`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idPersonaUsuario',new.idPersonaUsuario,'nombreUsuario',new.nombreUsuario,'avatarUsuario',new.avatarUsuario,'correoInstitucional',new.correoInstitucional,'codigoEmpleado',new.codigoEmpleado,'tokenAcceso',new.tokenAcceso,'tokenExpiracion',new.tokenExpiracion);
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarUsuario`;
DELIMITER //
create trigger `modificarUsuario` 
	after update on `Usuario`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idPersonaUsuario',old.idPersonaUsuario,'nombreUsuario',old.nombreUsuario,'avatarUsuario',old.avatarUsuario,'correoInstitucional',old.correoInstitucional,'codigoEmpleado',old.codigoEmpleado,'tokenAcceso',old.tokenAcceso,'tokenExpiracion',old.tokenExpiracion);
    set nuevo = JSON_OBJECT('idPersonaUsuario',new.idPersonaUsuario,'nombreUsuario',new.nombreUsuario,'avatarUsuario',new.avatarUsuario,'correoInstitucional',new.correoInstitucional,'codigoEmpleado',new.codigoEmpleado,'tokenAcceso',new.tokenAcceso,'tokenExpiracion',new.tokenExpiracion);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,@tipoBitacora,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarUsuarioBefore`;
DELIMITER //
create trigger `eliminarUsuarioBefore` 
	before delete on `Usuario`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idPersonaUsuario,JSON_OBJECT('idPersonaUsuario',idPersonaUsuario,'nombreUsuario',nombreUsuario,'avatarUsuario',avatarUsuario,'correoInstitucional',correoInstitucional,'codigoEmpleado',codigoEmpleado))) as json FROM Usuario);
    set cont = (SELECT count(*) FROM Usuario);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total usuarios',cont),temp);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarUsuarioAfter`;
DELIMITER //
create trigger `eliminarUsuarioAfter` 
	after delete on `Usuario`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idPersonaUsuario,JSON_OBJECT('idPersonaUsuario',idPersonaUsuario,'nombreUsuario',nombreUsuario,'avatarUsuario',avatarUsuario,'correoInstitucional',correoInstitucional,'codigoEmpleado',codigoEmpleado))) as json FROM Usuario);
    set cont2 = (SELECT count(*) FROM Usuario);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total usuarios',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM Bitacora);
    
    UPDATE `poa-pacc-bd`.`Bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//
-- -------------------------------------------Triggers presupuestoDepartamento-----------------------------------------------------------------------
drop trigger if exists `insertarPresupuestoDepartamento`;
DELIMITER //
create trigger `insertarPresupuestoDepartamento` 
	after insert on `PresupuestoDepartamento`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idPresupuestoPorDepartamento',new.idPresupuestoPorDepartamento,'idDepartamento',new.idDepartamento,'montoPresupuesto',new.montoPresupuesto, 'idControlPresupuestoActividad',new.idControlPresupuestoActividad);
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarPresupuestoDepartamento`;
DELIMITER //
create trigger `modificarPresupuestoDepartamento` 
	after update on `PresupuestoDepartamento`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idPresupuestoPorDepartamento',old.idPresupuestoPorDepartamento,'idDepartamento',old.idDepartamento,'montoPresupuesto',old.montoPresupuesto, 'idControlPresupuestoActividad',old.idControlPresupuestoActividad);
    set nuevo = JSON_OBJECT('idPresupuestoPorDepartamento',new.idPresupuestoPorDepartamento,'idDepartamento',new.idDepartamento,'montoPresupuesto',new.montoPresupuesto, 'idControlPresupuestoActividad',new.idControlPresupuestoActividad);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarPresupuestoDepartamentoBefore`;
DELIMITER //
create trigger `eliminarPresupuestoDepartamentoBefore` 
	before delete on `PresupuestoDepartamento`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idPresupuestoPorDepartamento,JSON_OBJECT('idPresupuestoPorDepartamento',idPresupuestoPorDepartamento,'idDepartamento',idDepartamento,'montoPresupuesto',montoPresupuesto, 'idControlPresupuestoActividad',idControlPresupuestoActividad))) as json FROM PresupuestoDepartamento);
    set cont = (SELECT count(*) FROM PresupuestoDepartamento);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total presupuestodepartamento',cont),temp);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarPresupuestoDepartamentoAfter`;
DELIMITER //
create trigger `eliminarPresupuestoDepartamentoAfter` 
	after delete on `PresupuestoDepartamento`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idPresupuestoPorDepartamento,JSON_OBJECT('idPresupuestoPorDepartamento',idPresupuestoPorDepartamento,'idDepartamento',idDepartamento,'montoPresupuesto',montoPresupuesto, 'idControlPresupuestoActividad',idControlPresupuestoActividad))) as json FROM PresupuestoDepartamento);
    set cont2 = (SELECT count(*) FROM PresupuestoDepartamento);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total presupuestodepartamento',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM Bitacora);
    
    UPDATE `poa-pacc-bd`.`Bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//

-- -------------------------------------------Triggers tipoActividad-----------------------------------------------------------------------
drop trigger if exists `insertarTipoActividad`;
DELIMITER //
create trigger `insertarTipoActividad` 
	after insert on `TipoActividad`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idTipoActividad',new.idTipoActividad,'TipoActividad',new.TipoActividad);
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarTipoActividad`;
DELIMITER //
create trigger `modificarTipoActividad` 
	after update on `TipoActividad`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idTipoActividad',old.idTipoActividad,'TipoActividad',old.TipoActividad);
    set nuevo = JSON_OBJECT('idTipoActividad',new.idTipoActividad,'TipoActividad',new.TipoActividad);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarTipoActividadBefore`;
DELIMITER //
create trigger `eliminarTipoActividadBefore` 
	before delete on `TipoActividad`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idTipoActividad,JSON_OBJECT('idTipoActividad',idTipoActividad,'TipoActividad',TipoActividad))) as json FROM TipoActividad);
    set cont = (SELECT count(*) FROM TipoActividad);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total tipoactividad',cont),temp);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarTipoActividadAfter`;
DELIMITER //
create trigger `eliminarTipoActividadAfter` 
	after delete on `TipoActividad`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idTipoActividad,JSON_OBJECT('idTipoActividad',idTipoActividad,'TipoActividad',TipoActividad))) as json FROM TipoActividad);
    set cont2 = (SELECT count(*) FROM TipoActividad);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total tipoactividad',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM Bitacora);
    
    UPDATE `poa-pacc-bd`.`Bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//

-- -------------------------------------------Triggers EstadoActividad-----------------------------------------------------------------------
drop trigger if exists `insertarEstadoActividad`;
DELIMITER //
create trigger `insertarEstadoActividad` 
	after insert on `EstadoActividad`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idEstadoActividad',new.idEstadoActividad,'estadoActividad',new.estadoActividad);
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarEstadoActividad`;
DELIMITER //
create trigger `modificarEstadoActividad` 
	after update on `EstadoActividad`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idEstadoActividad',old.idEstadoActividad,'estadoActividad',old.estadoActividad);
    set nuevo = JSON_OBJECT('idEstadoActividad',new.idEstadoActividad,'estadoActividad',new.estadoActividad);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarEstadoActividadBefore`;
DELIMITER //
create trigger `eliminarEstadoActividadBefore` 
	before delete on `EstadoActividad`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idEstadoActividad,JSON_OBJECT('idEstadoActividad',idEstadoActividad,'estadoActividad',estadoActividad))) as json FROM EstadoActividad);
    set cont = (SELECT count(*) FROM EstadoActividad);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total EstadoActividad',cont),temp);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarEstadoActividadAfter`;
DELIMITER //
create trigger `eliminarEstadoActividadAfter` 
	after delete on `EstadoActividad`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idEstadoActividad,JSON_OBJECT('idEstadoActividad',idEstadoActividad,'estadoActividad',estadoActividad))) as json FROM EstadoActividad);
    set cont2 = (SELECT count(*) FROM EstadoActividad);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total EstadoActividad',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM Bitacora);
    
    UPDATE `poa-pacc-bd`.`Bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//

-- -------------------------------------------Triggers Actividad-----------------------------------------------------------------------
drop trigger if exists `insertarActividad`;
DELIMITER //
create trigger `insertarActividad` 
	after insert on `Actividad`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idActividad',new.idActividad,'idPersonaUsuario',new.idPersonaUsuario,'idDimension',new.idDimension,'idObjetivoInstitucional',new.idObjetivoInstitucional,'idResultadoInstitucional',new.idResultadoInstitucional,'idAreaEstrategica',new.idAreaEstrategica,'idTipoActividad',new.idTipoActividad,'idEstadoActividad',new.idEstadoActividad,'resultadosUnidad',new.resultadosUnidad,'indicadoresResultado',new.indicadoresResultado,'actividad',new.actividad,'correlativoActividad',new.correlativoActividad,'justificacionActividad',new.justificacionActividad,'medioVerificacionActividad',new.medioVerificacionActividad,'poblacionObjetivoActividad',new.poblacionObjetivoActividad,'responsableActividad',new.responsableActividad,'fechaCreacionActividad',new.fechaCreacionActividad,'CostoTotal',new.CostoTotal);
    
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarActividad`;
DELIMITER //
create trigger `modificarActividad` 
	after update on `Actividad`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idActividad',old.idActividad,'idPersonaUsuario',old.idPersonaUsuario,'idDimension',old.idDimension,'idObjetivoInstitucional',old.idObjetivoInstitucional,'idResultadoInstitucional',old.idResultadoInstitucional,'idAreaEstrategica',old.idAreaEstrategica,'idTipoActividad',old.idTipoActividad,'idEstadoActividad',old.idEstadoActividad,'resultadosUnidad',old.resultadosUnidad,'indicadoresResultado',old.indicadoresResultado,'actividad',old.actividad,'correlativoActividad',old.correlativoActividad,'justificacionActividad',old.justificacionActividad,'medioVerificacionActividad',old.medioVerificacionActividad,'poblacionObjetivoActividad',old.poblacionObjetivoActividad,'responsableActividad',old.responsableActividad,'fechaCreacionActividad',old.fechaCreacionActividad,'CostoTotal',old.CostoTotal);
    set nuevo = JSON_OBJECT('idActividad',new.idActividad,'idPersonaUsuario',new.idPersonaUsuario,'idDimension',new.idDimension,'idObjetivoInstitucional',new.idObjetivoInstitucional,'idResultadoInstitucional',new.idResultadoInstitucional,'idAreaEstrategica',new.idAreaEstrategica,'idTipoActividad',new.idTipoActividad,'idEstadoActividad',new.idEstadoActividad,'resultadosUnidad',new.resultadosUnidad,'indicadoresResultado',new.indicadoresResultado,'actividad',new.actividad,'correlativoActividad',new.correlativoActividad,'justificacionActividad',new.justificacionActividad,'medioVerificacionActividad',new.medioVerificacionActividad,'poblacionObjetivoActividad',new.poblacionObjetivoActividad,'responsableActividad',new.responsableActividad,'fechaCreacionActividad',new.fechaCreacionActividad,'CostoTotal',new.CostoTotal);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarActividadBefore`;
DELIMITER //
create trigger `eliminarActividadBefore` 
	before delete on `Actividad`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idTipoActividad,JSON_OBJECT('idActividad',idActividad,'idPersonaUsuario',idPersonaUsuario,'idDimension',idDimension,'idObjetivoInstitucional',idObjetivoInstitucional,'idResultadoInstitucional',idResultadoInstitucional,'idAreaEstrategica',idAreaEstrategica,'idTipoActividad',idTipoActividad,'resultadosUnidad',resultadosUnidad,'indicadoresResultado',indicadoresResultado,'actividad',actividad,'correlativoActividad',correlativoActividad,'justificacionActividad',justificacionActividad,'medioVerificacionActividad',medioVerificacionActividad,'poblacionObjetivoActividad',poblacionObjetivoActividad,'responsableActividad',responsableActividad,'fechaCreacionActividad',fechaCreacionActividad,'CostoTotal',CostoTotal))) as json FROM Actividad);
    set cont = (SELECT count(*) FROM Actividad);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total actividad',cont),temp);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarActividadAfter`;
DELIMITER //
create trigger `eliminarActividadAfter` 
	after delete on `Actividad`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idTipoActividad,JSON_OBJECT('idActividad',idActividad,'idPersonaUsuario',idPersonaUsuario,'idDimension',idDimension,'idObjetivoInstitucional',idObjetivoInstitucional,'idResultadoInstitucional',idResultadoInstitucional,'idAreaEstrategica',idAreaEstrategica,'idTipoActividad',idTipoActividad,'resultadosUnidad',resultadosUnidad,'indicadoresResultado',indicadoresResultado,'actividad',actividad,'correlativoActividad',correlativoActividad,'justificacionActividad',justificacionActividad,'medioVerificacionActividad',medioVerificacionActividad,'poblacionObjetivoActividad',poblacionObjetivoActividad,'responsableActividad',responsableActividad,'fechaCreacionActividad',fechaCreacionActividad,'CostoTotal',CostoTotal))) as json FROM Actividad);
    set cont2 = (SELECT count(*) FROM Actividad);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total actividad',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM Bitacora);
    
    UPDATE `poa-pacc-bd`.`Bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//

-- -------------------------------------------Triggers controlpresupuestoactividad-----------------------------------------------------------------------
drop trigger if exists `insertarControlPresupuestoActividad`;
DELIMITER //
create trigger `insertarControlPresupuestoActividad` 
	after insert on `ControlPresupuestoActividad`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idControlPresupuestoActividad',new.idControlPresupuestoActividad,'idEstadoPresupuestoAnual',new.idEstadoPresupuestoAnual,'presupuestoAnual',new.presupuestoAnual,'fechaPresupuestoAnual',new.fechaPresupuestoAnual);
    
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarControlPresupuestoActividad`;
DELIMITER //
create trigger `modificarControlPresupuestoActividad` 
	after update on `ControlPresupuestoActividad`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idControlPresupuestoActividad',old.idControlPresupuestoActividad,'idEstadoPresupuestoAnual',old.idEstadoPresupuestoAnual,'presupuestoAnual',old.presupuestoAnual,'fechaPresupuestoAnual',old.fechaPresupuestoAnual);
    set nuevo = JSON_OBJECT('idControlPresupuestoActividad',new.idControlPresupuestoActividad,'idEstadoPresupuestoAnual',new.idEstadoPresupuestoAnual,'presupuestoAnual',new.presupuestoAnual,'fechaPresupuestoAnual',new.fechaPresupuestoAnual);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarControlPresupuestoActividadBefore`;
DELIMITER //
create trigger `eliminarControlPresupuestoActividadBefore` 
	before delete on `ControlPresupuestoActividad`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idControlPresupuestoActividad,JSON_OBJECT('idControlPresupuestoActividad',idControlPresupuestoActividad,'idEstadoPresupuestoAnual',idEstadoPresupuestoAnual,'presupuestoAnual',presupuestoAnual,'fechaPresupuestoAnual',fechaPresupuestoAnual))) as json FROM ControlPresupuestoActividad);
    set cont = (SELECT count(*) FROM ControlPresupuestoActividad);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total controlpresupuestoactividad',cont),temp);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarControlPresupuestoActividadAfter`;
DELIMITER //
create trigger `eliminarControlPresupuestoActividadAfter` 
	after delete on `ControlPresupuestoActividad`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idControlPresupuestoActividad,JSON_OBJECT('idControlPresupuestoActividad',idControlPresupuestoActividad,'idEstadoPresupuestoAnual',idEstadoPresupuestoAnual,'presupuestoAnual',presupuestoAnual,'fechaPresupuestoAnual',fechaPresupuestoAnual))) as json FROM ControlPresupuestoActividad);
    set cont2 = (SELECT count(*) FROM ControlPresupuestoActividad);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total controlpresupuestoactividad',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM Bitacora);
    
    UPDATE `poa-pacc-bd`.`Bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//

-- -------------------------------------------Triggers costoactividadportrimestre-----------------------------------------------------------------------
drop trigger if exists `insertarCostoActividadPorTrimestre`;
DELIMITER //
create trigger `insertarCostoActividadPorTrimestre` 
	after insert on `CostoActividadPorTrimestre`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idCostActPorTri',new.idCostActPorTri,'idActividad',new.idActividad,'porcentajeTrimestre1',new.porcentajeTrimestre1,'Trimestre1',new.Trimestre1,'abrevTrimestre1',new.abrevTrimestre1,'porcentajeTrimestre2',new.porcentajeTrimestre2,'Trimestre2',new.Trimestre2,'abrevTrimestre2',new.abrevTrimestre2,'porcentajeTrimestre3',new.porcentajeTrimestre3,'Trimestre3',new.Trimestre3,'abrevTrimestre3',new.abrevTrimestre3,'porcentajeTrimestre4',new.porcentajeTrimestre4,'Trimestre4',new.Trimestre4,'abrevTrimestre4',new.abrevTrimestre4);
    
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarCostoActividadPorTrimestre`;
DELIMITER //
create trigger `modificarCostoActividadPorTrimestre` 
	after update on `CostoActividadPorTrimestre`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idCostActPorTri',old.idCostActPorTri,'idActividad',old.idActividad,'porcentajeTrimestre1',old.porcentajeTrimestre1,'Trimestre1',old.Trimestre1,'abrevTrimestre1',old.abrevTrimestre1,'porcentajeTrimestre2',old.porcentajeTrimestre2,'Trimestre2',old.Trimestre2,'abrevTrimestre2',old.abrevTrimestre2,'porcentajeTrimestre3',old.porcentajeTrimestre3,'Trimestre3',old.Trimestre3,'abrevTrimestre3',old.abrevTrimestre3,'porcentajeTrimestre4',old.porcentajeTrimestre4,'Trimestre4',old.Trimestre4,'abrevTrimestre4',old.abrevTrimestre4);
    set nuevo = JSON_OBJECT('idCostActPorTri',new.idCostActPorTri,'idActividad',new.idActividad,'porcentajeTrimestre1',new.porcentajeTrimestre1,'Trimestre1',new.Trimestre1,'abrevTrimestre1',new.abrevTrimestre1,'porcentajeTrimestre2',new.porcentajeTrimestre2,'Trimestre2',new.Trimestre2,'abrevTrimestre2',new.abrevTrimestre2,'porcentajeTrimestre3',new.porcentajeTrimestre3,'Trimestre3',new.Trimestre3,'abrevTrimestre3',new.abrevTrimestre3,'porcentajeTrimestre4',new.porcentajeTrimestre4,'Trimestre4',new.Trimestre4,'abrevTrimestre4',new.abrevTrimestre4);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarCostoActividadPorTrimestreBefore`;
DELIMITER //
create trigger `eliminarCostoActividadPorTrimestreBefore` 
	before delete on `CostoActividadPorTrimestre`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idCostActPorTri,JSON_OBJECT('idCostActPorTri',idCostActPorTri,'idActividad',idActividad,'porcentajeTrimestre1',porcentajeTrimestre1,'Trimestre1',Trimestre1,'abrevTrimestre1',abrevTrimestre1,'porcentajeTrimestre2',porcentajeTrimestre2,'Trimestre2',Trimestre2,'abrevTrimestre2',abrevTrimestre2,'porcentajeTrimestre3',porcentajeTrimestre3,'Trimestre3',Trimestre3,'abrevTrimestre3',abrevTrimestre3,'porcentajeTrimestre4',porcentajeTrimestre4,'Trimestre4',Trimestre4,'abrevTrimestre4',abrevTrimestre4))) as json FROM CostoActividadPorTrimestre);
    set cont = (SELECT count(*) FROM CostoActividadPorTrimestre);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total controlpresupuestoactividad',cont),temp);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarCostoActividadPorTrimestreAfter`;
DELIMITER //
create trigger `eliminarCostoActividadPorTrimestreAfter` 
	after delete on `CostoActividadPorTrimestre`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idCostActPorTri,JSON_OBJECT('idCostActPorTri',idCostActPorTri,'idActividad',idActividad,'porcentajeTrimestre1',porcentajeTrimestre1,'Trimestre1',Trimestre1,'abrevTrimestre1',abrevTrimestre1,'porcentajeTrimestre2',porcentajeTrimestre2,'Trimestre2',Trimestre2,'abrevTrimestre2',abrevTrimestre2,'porcentajeTrimestre3',porcentajeTrimestre3,'Trimestre3',Trimestre3,'abrevTrimestre3',abrevTrimestre3,'porcentajeTrimestre4',porcentajeTrimestre4,'Trimestre4',Trimestre4,'abrevTrimestre4',abrevTrimestre4))) as json FROM CostoActividadPorTrimestre);
    set cont2 = (SELECT count(*) FROM CostoActividadPorTrimestre);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total controlpresupuestoactividad',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM Bitacora);
    
    UPDATE `poa-pacc-bd`.`Bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//

-- -------------------------------------------Triggers departamentopordimension-----------------------------------------------------------------------
drop trigger if exists `insertarDepartamentoPorDimension`;
DELIMITER //
create trigger `insertarDepartamentoPorDimension` 
	after insert on `DepartamentoPorDimension`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idDepartamentoDimension',new.idDepartamentoDimension,'idDimension',new.idDimension,'idDepartamento',new.idDepartamento,'estadoActividad',new.estadoActividad,'fecha',new.fecha);
    
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarDepartamentoPorDimension`;
DELIMITER //
create trigger `modificarDepartamentoPorDimension` 
	after update on `DepartamentoPorDimension`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idDepartamentoDimension',old.idDepartamentoDimension,'idDimension',old.idDimension,'idDepartamento',old.idDepartamento,'estadoActividad',old.estadoActividad,'fecha',old.fecha);
    set nuevo = JSON_OBJECT('idDepartamentoDimension',new.idDepartamentoDimension,'idDimension',new.idDimension,'idDepartamento',new.idDepartamento,'estadoActividad',new.estadoActividad,'fecha',new.fecha);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarDepartamentoPorDimensionBefore`;
DELIMITER //
create trigger `eliminarDepartamentoPorDimensionBefore` 
	before delete on `DepartamentoPorDimension`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idDepartamentoDimension,JSON_OBJECT('idDepartamentoDimension',idDepartamentoDimension,'idDimension',idDimension,'idDepartamento',idDepartamento,'estadoActividad',estadoActividad,'fecha',fecha))) as json FROM DepartamentoPorDimension);
    set cont = (SELECT count(*) FROM DepartamentoPorDimension);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total departamentopordimension',cont),temp);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarDepartamentoPorDimensionAfter`;
DELIMITER //
create trigger `eliminarDepartamentoPorDimensionAfter` 
	after delete on `DepartamentoPorDimension`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idDepartamentoDimension,JSON_OBJECT('idDepartamentoDimension',idDepartamentoDimension,'idDimension',idDimension,'idDepartamento',idDepartamento,'estadoActividad',estadoActividad,'fecha',fecha))) as json FROM DepartamentoPorDimension);
    set cont2 = (SELECT count(*) FROM DepartamentoPorDimension);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total departamentopordimension',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM Bitacora);
    
    UPDATE `poa-pacc-bd`.`Bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//

-- -------------------------------------------Triggers descripcionadministrativa-----------------------------------------------------------------------
drop trigger if exists `insertarDescripcionAdministrativa`;
DELIMITER //
create trigger `insertarDescripcionAdministrativa` 
	after insert on `DescripcionAdministrativa`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idDescripcionAdministrativa',new.idDescripcionAdministrativa,'idObjetoGasto',new.idObjetoGasto,'idTipoPresupuesto',new.idTipoPresupuesto,'idActividad',new.idActividad,'idDimensionAdministrativa',new.idDimensionAdministrativa,'nombreActividad',new.nombreActividad,'Cantidad',new.Cantidad,'Costo',new.Costo,'costoTotal',new.costoTotal,'mesRequerido',new.mesRequerido,'Descripcion',new.Descripcion);
    
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarDescripcionAdministrativa`;
DELIMITER //
create trigger `modificarDescripcionAdministrativa` 
	after update on `DescripcionAdministrativa`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idDescripcionAdministrativa',old.idDescripcionAdministrativa,'idObjetoGasto',old.idObjetoGasto,'idTipoPresupuesto',old.idTipoPresupuesto,'idActividad',old.idActividad,'idDimensionAdministrativa',old.idDimensionAdministrativa,'nombreActividad',old.nombreActividad,'Cantidad',old.Cantidad,'Costo',old.Costo,'costoTotal',old.costoTotal,'mesRequerido',old.mesRequerido,'Descripcion',old.Descripcion);
    set nuevo = JSON_OBJECT('idDescripcionAdministrativa',new.idDescripcionAdministrativa,'idObjetoGasto',new.idObjetoGasto,'idTipoPresupuesto',new.idTipoPresupuesto,'idActividad',new.idActividad,'idDimensionAdministrativa',new.idDimensionAdministrativa,'nombreActividad',new.nombreActividad,'Cantidad',new.Cantidad,'Costo',new.Costo,'costoTotal',new.costoTotal,'mesRequerido',new.mesRequerido,'Descripcion',new.Descripcion);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarDescripcionAdministrativaBefore`;
DELIMITER //
create trigger `eliminarDescripcionAdministrativaBefore` 
	before delete on `DescripcionAdministrativa`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idDescripcionAdministrativa,JSON_OBJECT('idDescripcionAdministrativa',idDescripcionAdministrativa,'idObjetoGasto',idObjetoGasto,'idTipoPresupuesto',idTipoPresupuesto,'idActividad',idActividad,'idDimensionAdministrativa',idDimensionAdministrativa,'nombreActividad',nombreActividad,'Cantidad',Cantidad,'Costo',Costo,'costoTotal',costoTotal,'mesRequerido',mesRequerido,'Descripcion',Descripcion))) as json FROM DescripcionAdministrativa);
    set cont = (SELECT count(*) FROM DescripcionAdministrativa);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total descripcionadministrativa',cont),temp);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarDescripcionAdministrativaAfter`;
DELIMITER //
create trigger `eliminarDescripcionAdministrativaAfter` 
	after delete on `DescripcionAdministrativa`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idDescripcionAdministrativa,JSON_OBJECT('idDescripcionAdministrativa',idDescripcionAdministrativa,'idObjetoGasto',idObjetoGasto,'idTipoPresupuesto',idTipoPresupuesto,'idActividad',idActividad,'idDimensionAdministrativa',idDimensionAdministrativa,'nombreActividad',nombreActividad,'Cantidad',Cantidad,'Costo',Costo,'costoTotal',costoTotal,'mesRequerido',mesRequerido,'Descripcion',Descripcion))) as json FROM DescripcionAdministrativa);
    set cont2 = (SELECT count(*) FROM DescripcionAdministrativa);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total descripcionadministrativa',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM Bitacora);
    
    UPDATE `poa-pacc-bd`.`Bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//

-- -------------------------------------------Triggers estadodcduoao-----------------------------------------------------------------------
drop trigger if exists `insertarEstadoDCDUOAO`;
DELIMITER //
create trigger `insertarEstadoDCDUOAO` 
	after insert on `EstadoDCDUOAO`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idEstado',new.idEstado,'estado',new.estado);
    
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarEstadoDCDUOAO`;
DELIMITER //
create trigger `modificarEstadoDCDUOAO` 
	after update on `EstadoDCDUOAO`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idEstado',old.idEstado,'estado',old.estado);
    set nuevo = JSON_OBJECT('idEstado',new.idEstado,'estado',new.estado);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarEstadoDCDUOAOBefore`;
DELIMITER //
create trigger `eliminarEstadoDCDUOAOBefore` 
	before delete on `EstadoDCDUOAO`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idEstado,JSON_OBJECT('idEstado',idEstado,'estado',estado))) as json FROM EstadoDCDUOAO);
    set cont = (SELECT count(*) FROM EstadoDCDUOAO);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total estadodcduoao',cont),temp);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarEstadoDCDUOAOAfter`;
DELIMITER //
create trigger `eliminarEstadoDCDUOAOAfter` 
	after delete on `EstadoDCDUOAO`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idEstado,JSON_OBJECT('idEstado',idEstado,'estado',estado))) as json FROM EstadoDCDUOAO);
    set cont2 = (SELECT count(*) FROM EstadoDCDUOAO);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total estadodcduoao',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM Bitacora);
    
    UPDATE `poa-pacc-bd`.`Bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//

-- -------------------------------------------Triggers estadoinforme-----------------------------------------------------------------------
drop trigger if exists `insertarEstadoInformes`;
DELIMITER //
create trigger `insertarEstadoInformes` 
	after insert on `EstadoInforme`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idEstadoInforme',new.idEstadoInforme,'Estado',new.Estado);
    
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarEstadoInformes`;
DELIMITER //
create trigger `modificarEstadoInformes` 
	after update on `EstadoInforme`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idEstadoInforme',old.idEstadoInforme,'Estado',old.Estado);
    set nuevo = JSON_OBJECT('idEstadoInforme',new.idEstadoInforme,'Estado',new.Estado);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarEstadoInformesBefore`;
DELIMITER //
create trigger `eliminarEstadoInformesBefore` 
	before delete on `EstadoInforme`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idEstadoInforme,JSON_OBJECT('idEstadoInforme',idEstadoInforme,'Estado',Estado))) as json FROM EstadoInforme);
    set cont = (SELECT count(*) FROM EstadoInforme);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total estadoinformes',cont),temp);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarEstadoInformesAfter`;
DELIMITER //
create trigger `eliminarEstadoInformesAfter` 
	after delete on `EstadoInforme`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idEstadoInforme,JSON_OBJECT('idEstadoInforme',idEstadoInforme,'Estado',Estado))) as json FROM EstadoInforme);
    set cont2 = (SELECT count(*) FROM EstadoInforme);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total estadodcduoao',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM Bitacora);
    
    UPDATE `poa-pacc-bd`.`Bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//

-- -------------------------------------------Triggers estadoreporte-----------------------------------------------------------------------
drop trigger if exists `insertarEstadoReporte`;
DELIMITER //
create trigger `insertarEstadoReporte` 
	after insert on `EstadoReporte`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('id_estado_reporte',new.id_estado_reporte,'estado_reporte',new.estado_reporte);
    
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarEstadoReporte`;
DELIMITER //
create trigger `modificarEstadoReporte` 
	after update on `EstadoReporte`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('id_estado_reporte',old.id_estado_reporte,'estado_reporte',old.estado_reporte);
    set nuevo = JSON_OBJECT('id_estado_reporte',new.id_estado_reporte,'estado_reporte',new.estado_reporte);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarEstadoReporteBefore`;
DELIMITER //
create trigger `eliminarEstadoReporteBefore` 
	before delete on `EstadoReporte`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(id_estado_reporte,JSON_OBJECT('id_estado_reporte',id_estado_reporte,'estado_reporte',estado_reporte))) as json FROM EstadoReporte);
    set cont = (SELECT count(*) FROM EstadoReporte);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total estadoreporte',cont),temp);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarEstadoReporteAfter`;
DELIMITER //
create trigger `eliminarEstadoReporteAfter` 
	after delete on `EstadoReporte`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(id_estado_reporte,JSON_OBJECT('id_estado_reporte',id_estado_reporte,'estado_reporte',estado_reporte))) as json FROM EstadoReporte);
    set cont2 = (SELECT count(*) FROM EstadoReporte);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total estadoreporte',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM Bitacora);
    
    UPDATE `poa-pacc-bd`.`Bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//

-- -------------------------------------------Triggers tipoestadosolicitudsalida-----------------------------------------------------------------------
drop trigger if exists `insertarTipoEstadoSolicitudSalida`;
DELIMITER //
create trigger `insertarTipoEstadoSolicitudSalida` 
	after insert on `TipoEstadoSolicitudSalida`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idTipoEstadoSolicitud',new.idTipoEstadoSolicitud,'TipoEstadoSolicitudSalida',new.TipoEstadoSolicitudSalida);
    
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarTipoEstadoSolicitudSalida`;
DELIMITER //
create trigger `modificarTipoEstadoSolicitudSalida` 
	after update on `TipoEstadoSolicitudSalida`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idTipoEstadoSolicitud',old.idTipoEstadoSolicitud,'TipoEstadoSolicitudSalida',old.TipoEstadoSolicitudSalida);
    set nuevo = JSON_OBJECT('idTipoEstadoSolicitud',new.idTipoEstadoSolicitud,'TipoEstadoSolicitudSalida',new.TipoEstadoSolicitudSalida);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarTipoEstadoSolicitudSalidaBefore`;
DELIMITER //
create trigger `eliminarTipoEstadoSolicitudSalidaBefore` 
	before delete on `TipoEstadoSolicitudSalida`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idTipoEstadoSolicitud,JSON_OBJECT('idTipoEstadoSolicitud',idTipoEstadoSolicitud,'TipoEstadoSolicitudSalida',TipoEstadoSolicitudSalida))) as json FROM TipoEstadoSolicitudSalida);
    set cont = (SELECT count(*) FROM TipoEstadoSolicitudSalida);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total tipoestadosolicitudsalida',cont),temp);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarTipoEstadoSolicitudSalidaAfter`;
DELIMITER //
create trigger `eliminarTipoEstadoSolicitudSalidaAfter` 
	after delete on `TipoEstadoSolicitudSalida`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idTipoEstadoSolicitud,JSON_OBJECT('idTipoEstadoSolicitud',idTipoEstadoSolicitud,'TipoEstadoSolicitudSalida',TipoEstadoSolicitudSalida))) as json FROM TipoEstadoSolicitudSalida);
    set cont2 = (SELECT count(*) FROM TipoEstadoSolicitudSalida);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total tipoestadosolicitudsalida',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM Bitacora);
    
    UPDATE `poa-pacc-bd`.`Bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//
-- -------------------------------------------Triggers tiposolicitudsalida-----------------------------------------------------------------------
drop trigger if exists `insertarTipoSolicitudSalida`;
DELIMITER //
create trigger `insertarTipoSolicitudSalida` 
	after insert on `TipoSolicitudSalida`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idTipoSolicitudSalida',new.idTipoSolicitudSalida,'tipoSolicitudSalida',new.tipoSolicitudSalida);
    
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarTipoSolicitudSalida`;
DELIMITER //
create trigger `modificarTipoSolicitudSalida` 
	after update on `TipoSolicitudSalida`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idTipoSolicitudSalida',old.idTipoSolicitudSalida,'tipoSolicitudSalida',old.tipoSolicitudSalida);
    set nuevo = JSON_OBJECT('idTipoSolicitudSalida',new.idTipoSolicitudSalida,'tipoSolicitudSalida',new.tipoSolicitudSalida);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarTipoSolicitudSalidaBefore`;
DELIMITER //
create trigger `eliminarTipoSolicitudSalidaBefore` 
	before delete on `TipoSolicitudSalida`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idTipoSolicitudSalida,JSON_OBJECT('idTipoSolicitudSalida',idTipoSolicitudSalida,'tipoSolicitudSalida',tipoSolicitudSalida))) as json FROM TipoSolicitudSalida);
    set cont = (SELECT count(*) FROM TipoSolicitudSalida);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total tiposolicitudsalida',cont),temp);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarTipoSolicitudSalidaAfter`;
DELIMITER //
create trigger `eliminarTipoSolicitudSalidaAfter` 
	after delete on `TipoSolicitudSalida`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idTipoSolicitudSalida,JSON_OBJECT('idTipoSolicitudSalida',idTipoSolicitudSalida,'tipoSolicitudSalida',tipoSolicitudSalida))) as json FROM TipoSolicitudSalida);
    set cont2 = (SELECT count(*) FROM TipoSolicitudSalida);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total tiposolicitudsalida',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM Bitacora);
    
    UPDATE `poa-pacc-bd`.`Bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//
-- -------------------------------------------Triggers solicitudsalida-----------------------------------------------------------------------
drop trigger if exists `insertarSolicitudSalida`;
DELIMITER //
create trigger `insertarSolicitudSalida` 
	after insert on `SolicitudSalida`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idSolicitud',new.idSolicitud,'idTipoSolicitud',new.idTipoSolicitud,'idPersonaUsuario',new.idPersonaUsuario,'motivoSolicitud',new.motivoSolicitud,'edificioAsistencia',new.edificioAsistencia,'firmaDigital',new.firmaDigital,'documentoRespaldo',new.documentoRespaldo,'horaInicioSolicitudSalida',new.horaInicioSolicitudSalida,'horaFinSolicitudSalida',new.horaFinSolicitudSalida,'diasSolicitados',new.diasSolicitados,'fechaInicioPermiso',new.fechaInicioPermiso,'fechaFinPermiso',new.fechaFinPermiso,'fechaRegistroSolicitud',new.fechaRegistroSolicitud);
    
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarSolicitudSalida`;
DELIMITER //
create trigger `modificarSolicitudSalida` 
	after update on `SolicitudSalida`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idSolicitud',old.idSolicitud,'idTipoSolicitud',old.idTipoSolicitud,'idPersonaUsuario',old.idPersonaUsuario,'motivoSolicitud',old.motivoSolicitud,'edificioAsistencia',old.edificioAsistencia,'firmaDigital',old.firmaDigital,'documentoRespaldo',old.documentoRespaldo,'horaInicioSolicitudSalida',old.horaInicioSolicitudSalida,'horaFinSolicitudSalida',old.horaFinSolicitudSalida,'diasSolicitados',old.diasSolicitados,'fechaInicioPermiso',old.fechaInicioPermiso,'fechaFinPermiso',old.fechaFinPermiso,'fechaRegistroSolicitud',old.fechaRegistroSolicitud);
    set nuevo = JSON_OBJECT('idSolicitud',new.idSolicitud,'idTipoSolicitud',new.idTipoSolicitud,'idPersonaUsuario',new.idPersonaUsuario,'motivoSolicitud',new.motivoSolicitud,'edificioAsistencia',new.edificioAsistencia,'firmaDigital',new.firmaDigital,'documentoRespaldo',new.documentoRespaldo,'horaInicioSolicitudSalida',new.horaInicioSolicitudSalida,'horaFinSolicitudSalida',new.horaFinSolicitudSalida,'diasSolicitados',new.diasSolicitados,'fechaInicioPermiso',new.fechaInicioPermiso,'fechaFinPermiso',new.fechaFinPermiso,'fechaRegistroSolicitud',new.fechaRegistroSolicitud);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarSolicitudSalidaBefore`;
DELIMITER //
create trigger `eliminarSolicitudSalidaBefore` 
	before delete on `SolicitudSalida`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idSolicitud,JSON_OBJECT('idSolicitud',idSolicitud,'idTipoSolicitud',idTipoSolicitud,'idPersonaUsuario',idPersonaUsuario,'motivoSolicitud',motivoSolicitud,'edificioAsistencia',edificioAsistencia,'firmaDigital',firmaDigital,'documentoRespaldo',documentoRespaldo,'horaInicioSolicitudSalida',horaInicioSolicitudSalida,'horaFinSolicitudSalida',horaFinSolicitudSalida,'diasSolicitados',diasSolicitados,'fechaInicioPermiso',fechaInicioPermiso,'fechaFinPermiso',fechaFinPermiso,'fechaRegistroSolicitud',fechaRegistroSolicitud))) as json FROM SolicitudSalida);
    set cont = (SELECT count(*) FROM SolicitudSalida);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total solicitudsalida',cont),temp);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarSolicitudSalidaAfter`;
DELIMITER //
create trigger `eliminarSolicitudSalidaAfter` 
	after delete on `SolicitudSalida`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idSolicitud,JSON_OBJECT('idSolicitud',idSolicitud,'idTipoSolicitud',idTipoSolicitud,'idPersonaUsuario',idPersonaUsuario,'motivoSolicitud',motivoSolicitud,'edificioAsistencia',edificioAsistencia,'firmaDigital',firmaDigital,'documentoRespaldo',documentoRespaldo,'horaInicioSolicitudSalida',horaInicioSolicitudSalida,'horaFinSolicitudSalida',horaFinSolicitudSalida,'diasSolicitados',diasSolicitados,'fechaInicioPermiso',fechaInicioPermiso,'fechaFinPermiso',fechaFinPermiso,'fechaRegistroSolicitud',fechaRegistroSolicitud))) as json FROM SolicitudSalida);
    set cont2 = (SELECT count(*) FROM SolicitudSalida);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total solicitudsalida',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM Bitacora);
    
    UPDATE `poa-pacc-bd`.`Bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//
-- -------------------------------------------Triggers estadosolicitudsalida-----------------------------------------------------------------------
drop trigger if exists `insertarEstadoSolicitudSalida`;
DELIMITER //
create trigger `insertarEstadoSolicitudSalida` 
	after insert on `EstadoSolicitudSalida`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idEstadoSolicitudSalida',new.idEstadoSolicitudSalida,'idPersonaUsuarioVeedor',new.idPersonaUsuarioVeedor,'idSolicitudSalida',new.idSolicitudSalida,'idTipoEstadoSolicitud',new.idTipoEstadoSolicitud,'observacionesSolicitud',new.observacionesSolicitud,'fechaRevisionSolicitud',new.fechaRevisionSolicitud);
    
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarEstadoSolicitudSalida`;
DELIMITER //
create trigger `modificarEstadoSolicitudSalida` 
	after update on `EstadoSolicitudSalida`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idEstadoSolicitudSalida',old.idEstadoSolicitudSalida,'idPersonaUsuarioVeedor',old.idPersonaUsuarioVeedor,'idSolicitudSalida',old.idSolicitudSalida,'idTipoEstadoSolicitud',old.idTipoEstadoSolicitud,'observacionesSolicitud',old.observacionesSolicitud,'fechaRevisionSolicitud',old.fechaRevisionSolicitud);
    set nuevo = JSON_OBJECT('idEstadoSolicitudSalida',new.idEstadoSolicitudSalida,'idPersonaUsuarioVeedor',new.idPersonaUsuarioVeedor,'idSolicitudSalida',new.idSolicitudSalida,'idTipoEstadoSolicitud',new.idTipoEstadoSolicitud,'observacionesSolicitud',new.observacionesSolicitud,'fechaRevisionSolicitud',new.fechaRevisionSolicitud);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarEstadoSolicitudSalidaBefore`;
DELIMITER //
create trigger `eliminarEstadoSolicitudSalidaBefore` 
	before delete on `EstadoSolicitudSalida`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idEstadoSolicitudSalida,JSON_OBJECT('idEstadoSolicitudSalida',idEstadoSolicitudSalida,'idPersonaUsuarioVeedor',idPersonaUsuarioVeedor,'idSolicitudSalida',idSolicitudSalida,'idTipoEstadoSolicitud',idTipoEstadoSolicitud,'observacionesSolicitud',observacionesSolicitud,'fechaRevisionSolicitud',fechaRevisionSolicitud))) as json FROM EstadoSolicitudSalida);
    set cont = (SELECT count(*) FROM EstadoSolicitudSalida);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total estadosolicitudsalida',cont),temp);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarEstadoSolicitudSalidaAfter`;
DELIMITER //
create trigger `eliminarEstadoSolicitudSalidaAfter` 
	after delete on `EstadoSolicitudSalida`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idEstadoSolicitudSalida,JSON_OBJECT('idEstadoSolicitudSalida',idEstadoSolicitudSalida,'idPersonaUsuarioVeedor',idPersonaUsuarioVeedor,'idSolicitudSalida',idSolicitudSalida,'idTipoEstadoSolicitud',idTipoEstadoSolicitud,'observacionesSolicitud',observacionesSolicitud,'fechaRevisionSolicitud',fechaRevisionSolicitud))) as json FROM EstadoSolicitudSalida);
    set cont2 = (SELECT count(*) FROM EstadoSolicitudSalida);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total estadosolicitudsalida',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM Bitacora);
    
    UPDATE `poa-pacc-bd`.`Bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//
-- -------------------------------------------Triggers genero-----------------------------------------------------------------------
drop trigger if exists `insertarGenero`;
DELIMITER //
create trigger `insertarGenero` 
	after insert on `Genero`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idGenero',new.idGenero,'genero',new.genero,'abrev',new.abrev);
    
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarGenero`;
DELIMITER //
create trigger `modificarGenero` 
	after update on `Genero`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idGenero',old.idGenero,'genero',old.genero,'abrev',old.abrev);
    set nuevo = JSON_OBJECT('idGenero',new.idGenero,'genero',new.genero,'abrev',new.abrev);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarGeneroBefore`;
DELIMITER //
create trigger `eliminarGeneroBefore` 
	before delete on `Genero`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idGenero,JSON_OBJECT('idGenero',idGenero,'genero',genero,'abrev',abrev))) as json FROM Genero);
    set cont = (SELECT count(*) FROM Genero);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total genero',cont),temp);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarGeneroAfter`;
DELIMITER //
create trigger `eliminarGeneroAfter` 
	after delete on `Genero`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idGenero,JSON_OBJECT('idGenero',idGenero,'genero',genero,'abrev',abrev))) as json FROM Genero);
    set cont2 = (SELECT count(*) FROM Genero);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total genero',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM Bitacora);
    
    UPDATE `poa-pacc-bd`.`Bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//
-- -------------------------------------------Triggers tipografico-----------------------------------------------------------------------
drop trigger if exists `insertarTipoGrafico`;
DELIMITER //
create trigger `insertarTipoGrafico` 
	after insert on `TipoGrafico`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('id_tipo_grafico',new.id_tipo_grafico,'tipo_grafico',new.tipo_grafico);
    
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarTipoGrafico`;
DELIMITER //
create trigger `modificarTipoGrafico` 
	after update on `TipoGrafico`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('id_tipo_grafico',old.id_tipo_grafico,'tipo_grafico',old.tipo_grafico);
    set nuevo = JSON_OBJECT('id_tipo_grafico',new.id_tipo_grafico,'tipo_grafico',new.tipo_grafico);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarTipoGraficoBefore`;
DELIMITER //
create trigger `eliminarTipoGraficoBefore` 
	before delete on `TipoGrafico`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(id_tipo_grafico,JSON_OBJECT('id_tipo_grafico',id_tipo_grafico,'tipo_grafico',tipo_grafico))) as json FROM TipoGrafico);
    set cont = (SELECT count(*) FROM TipoGrafico);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total tipografico',cont),temp);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarTipoGraficoAfter`;
DELIMITER //
create trigger `eliminarTipoGraficoAfter` 
	after delete on `TipoGrafico`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(id_tipo_grafico,JSON_OBJECT('id_tipo_grafico',id_tipo_grafico,'tipo_grafico',tipo_grafico))) as json FROM TipoGrafico);
    set cont2 = (SELECT count(*) FROM TipoGrafico);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total tipografico',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM Bitacora);
    
    UPDATE `poa-pacc-bd`.`Bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//
-- -------------------------------------------Triggers grafico-----------------------------------------------------------------------
drop trigger if exists `insertarGrafico`;
DELIMITER //
create trigger `insertarGrafico` 
	after insert on `Grafico`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('id_grafico',new.id_grafico,'id_persona_usuario',new.id_persona_usuario,'idTipoGraficos',new.idTipoGraficos,'nombre_grafico',new.nombre_grafico,'fecha_creacion_grafico',new.fecha_creacion_grafico);
    
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarGrafico`;
DELIMITER //
create trigger `modificarGrafico` 
	after update on `Grafico`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('id_grafico',old.id_grafico,'id_persona_usuario',old.id_persona_usuario,'idTipoGraficos',old.idTipoGraficos,'nombre_grafico',old.nombre_grafico,'fecha_creacion_grafico',old.fecha_creacion_grafico);
    set nuevo = JSON_OBJECT('id_grafico',new.id_grafico,'id_persona_usuario',new.id_persona_usuario,'idTipoGraficos',new.idTipoGraficos,'nombre_grafico',new.nombre_grafico,'fecha_creacion_grafico',new.fecha_creacion_grafico);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarGraficoBefore`;
DELIMITER //
create trigger `eliminarGraficoBefore` 
	before delete on `Grafico`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(id_grafico,JSON_OBJECT('id_grafico',id_grafico,'id_persona_usuario',id_persona_usuario,'idTipoGraficos',idTipoGraficos,'nombre_grafico',nombre_grafico,'fecha_creacion_grafico',fecha_creacion_grafico))) as json FROM Grafico);
    set cont = (SELECT count(*) FROM Grafico);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total grafico',cont),temp);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarGraficoAfter`;
DELIMITER //
create trigger `eliminarGraficoAfter` 
	after delete on `Grafico`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(id_grafico,JSON_OBJECT('id_grafico',id_grafico,'id_persona_usuario',id_persona_usuario,'idTipoGraficos',idTipoGraficos,'nombre_grafico',nombre_grafico,'fecha_creacion_grafico',fecha_creacion_grafico))) as json FROM Grafico);
    set cont2 = (SELECT count(*) FROM Grafico);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total grafico',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM Bitacora);
    
    UPDATE `poa-pacc-bd`.`Bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//
-- -------------------------------------------Triggers informes-----------------------------------------------------------------------
drop trigger if exists `insertarInforme`;
DELIMITER //
create trigger `insertarInforme` 
	after insert on `Informe`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idInforme',new.idInforme,'idPersonaUsuarioEnvia',new.idPersonaUsuarioEnvia,'idPersonaUsuarioAprueba',new.idPersonaUsuarioAprueba,'idEstadoInforme',new.idEstadoInforme,'fechaRecibido',new.fechaRecibido,'fechaAprobado',new.fechaAprobado);
    
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarInforme`;
DELIMITER //
create trigger `modificarInforme` 
	after update on `Informe`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idInforme',old.idInforme,'idPersonaUsuarioEnvia',old.idPersonaUsuarioEnvia,'idPersonaUsuarioAprueba',old.idPersonaUsuarioAprueba,'idEstadoInforme',old.idEstadoInforme,'fechaRecibido',old.fechaRecibido,'fechaAprobado',old.fechaAprobado);
    set nuevo = JSON_OBJECT('idInforme',new.idInforme,'idPersonaUsuarioEnvia',new.idPersonaUsuarioEnvia,'idPersonaUsuarioAprueba',new.idPersonaUsuarioAprueba,'idEstadoInforme',new.idEstadoInforme,'fechaRecibido',new.fechaRecibido,'fechaAprobado',new.fechaAprobado);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarInformeBefore`;
DELIMITER //
create trigger `eliminarInformeBefore` 
	before delete on `Informe`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idInforme,JSON_OBJECT('idInforme',idInforme,'idPersonaUsuarioEnvia',idPersonaUsuarioEnvia,'idPersonaUsuarioAprueba',idPersonaUsuarioAprueba,'idEstadoInforme',idEstadoInforme,'fechaRecibido',fechaRecibido,'fechaAprobado',fechaAprobado))) as json FROM Informe);
    set cont = (SELECT count(*) FROM Informe);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total informe',cont),temp);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarInformeAfter`;
DELIMITER //
create trigger `eliminarInformeAfter` 
	after delete on `Informe`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idInforme,JSON_OBJECT('idInforme',idInforme,'idPersonaUsuarioEnvia',idPersonaUsuarioEnvia,'idPersonaUsuarioAprueba',idPersonaUsuarioAprueba,'idEstadoInforme',idEstadoInforme,'fechaRecibido',fechaRecibido,'fechaAprobado',fechaAprobado))) as json FROM Informe);
    set cont2 = (SELECT count(*) FROM Informe);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total informe',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM Bitacora);
    
    UPDATE `poa-pacc-bd`.`Bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//

-- -------------------------------------------Triggers llenadoactividaddimension-----------------------------------------------------------------------
drop trigger if exists `insertarLlenadoActividadDimension`;
DELIMITER //
create trigger `insertarLlenadoActividadDimension` 
	after insert on `LlenadoActividadDimension`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idLlenadoDimension',new.idLlenadoDimension,'TipoUsuario_idTipoUsuario',new.TipoUsuario_idTipoUsuario,'valorLlenadoDimensionInicial',new.valorLlenadoDimensionInicial,'valorLlenadoDimensionFinal',new.valorLlenadoDimensionFinal);
    
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarLlenadoActividadDimension`;
DELIMITER //
create trigger `modificarLlenadoActividadDimension` 
	after update on `LlenadoActividadDimension`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idLlenadoDimension',old.idLlenadoDimension,'TipoUsuario_idTipoUsuario',old.TipoUsuario_idTipoUsuario,'valorLlenadoDimensionInicial',old.valorLlenadoDimensionInicial,'valorLlenadoDimensionFinal',old.valorLlenadoDimensionFinal);
    set nuevo = JSON_OBJECT('idLlenadoDimension',new.idLlenadoDimension,'TipoUsuario_idTipoUsuario',new.TipoUsuario_idTipoUsuario,'valorLlenadoDimensionInicial',new.valorLlenadoDimensionInicial,'valorLlenadoDimensionFinal',new.valorLlenadoDimensionFinal);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarLlenadoActividadDimensionBefore`;
DELIMITER //
create trigger `eliminarLlenadoActividadDimensionBefore` 
	before delete on `LlenadoActividadDimension`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idLlenadoDimension,JSON_OBJECT('idLlenadoDimension',idLlenadoDimension,'TipoUsuario_idTipoUsuario',TipoUsuario_idTipoUsuario,'valorLlenadoDimensionInicial',valorLlenadoDimensionInicial,'valorLlenadoDimensionFinal',valorLlenadoDimensionFinal))) as json FROM LlenadoActividadDimension);
    set cont = (SELECT count(*) FROM LlenadoActividadDimension);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total llenadoactividaddimension',cont),temp);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarLlenadoActividadDimensionAfter`;
DELIMITER //
create trigger `eliminarLlenadoActividadDimensionAfter` 
	after delete on `LlenadoActividadDimension`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idLlenadoDimension,JSON_OBJECT('idLlenadoDimension',idLlenadoDimension,'TipoUsuario_idTipoUsuario',TipoUsuario_idTipoUsuario,'valorLlenadoDimensionInicial',valorLlenadoDimensionInicial,'valorLlenadoDimensionFinal',valorLlenadoDimensionFinal))) as json FROM LlenadoActividadDimension);
    set cont2 = (SELECT count(*) FROM LlenadoActividadDimension);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total llenadoactividaddimension',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM Bitacora);
    
    UPDATE `poa-pacc-bd`.`Bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//
-- -------------------------------------------Triggers lugar-----------------------------------------------------------------------
drop trigger if exists `insertarLugar`;
DELIMITER //
create trigger `insertarLugar` 
	after insert on `Lugar`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idLugar',new.idLugar,'idTipoLugar',new.idTipoLugar,'idLugarPadre',new.idLugarPadre,'nombreLugar',new.nombreLugar);
    
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarLugar`;
DELIMITER //
create trigger `modificarLugar` 
	after update on `Lugar`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idLugar',old.idLugar,'idTipoLugar',old.idTipoLugar,'idLugarPadre',old.idLugarPadre,'nombreLugar',old.nombreLugar);
    set nuevo = JSON_OBJECT('idLugar',new.idLugar,'idTipoLugar',new.idTipoLugar,'idLugarPadre',new.idLugarPadre,'nombreLugar',new.nombreLugar);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarLugarBefore`;
DELIMITER //
create trigger `eliminarLugarBefore` 
	before delete on `Lugar`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idLugar,JSON_OBJECT('idLugar',idLugar,'idTipoLugar',idTipoLugar,'idLugarPadre',idLugarPadre,'nombreLugar',nombreLugar))) as json FROM Lugar);
    set cont = (SELECT count(*) FROM Lugar);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total lugar',cont),temp);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarLugarAfter`;
DELIMITER //
create trigger `eliminarLugarAfter` 
	after delete on `Lugar`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idLugar,JSON_OBJECT('idLugar',idLugar,'idTipoLugar',idTipoLugar,'idLugarPadre',idLugarPadre,'nombreLugar',nombreLugar))) as json FROM Lugar);
    set cont2 = (SELECT count(*) FROM Lugar);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total lugar',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM Bitacora);
    
    UPDATE `poa-pacc-bd`.`Bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//
-- -------------------------------------------Triggers tiporeporte-----------------------------------------------------------------------
drop trigger if exists `insertarTipoReporte`;
DELIMITER //
create trigger `insertarTipoReporte` 
	after insert on `TipoReporte`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('id_tipo_reporte',new.id_tipo_reporte,'tipo_reporte',new.tipo_reporte);
    
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarTipoReporte`;
DELIMITER //
create trigger `modificarTipoReporte` 
	after update on `TipoReporte`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('id_tipo_reporte',old.id_tipo_reporte,'tipo_reporte',old.tipo_reporte);
    set nuevo = JSON_OBJECT('id_tipo_reporte',new.id_tipo_reporte,'tipo_reporte',new.tipo_reporte);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarTipoReporteBefore`;
DELIMITER //
create trigger `eliminarTipoReporteBefore` 
	before delete on `TipoReporte`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(id_tipo_reporte,JSON_OBJECT('id_tipo_reporte',id_tipo_reporte,'tipo_reporte',tipo_reporte))) as json FROM TipoReporte);
    set cont = (SELECT count(*) FROM TipoReporte);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total tiporeporte',cont),temp);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarTipoReporteAfter`;
DELIMITER //
create trigger `eliminarTipoReporteAfter` 
	after delete on `TipoReporte`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(id_tipo_reporte,JSON_OBJECT('id_tipo_reporte',id_tipo_reporte,'tipo_reporte',tipo_reporte))) as json FROM TipoReporte);
    set cont2 = (SELECT count(*) FROM TipoReporte);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total tiporeporte',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM Bitacora);
    
    UPDATE `poa-pacc-bd`.`Bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//
-- -------------------------------------------Triggers reporte-----------------------------------------------------------------------
drop trigger if exists `insertarReporte`;
DELIMITER //
create trigger `insertarReporte` 
	after insert on `Reporte`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('id_reporte',new.id_reporte,'id_persona_usuario',new.id_persona_usuario,'id_tipo_reporte',new.id_tipo_reporte,'id_estado_reporte',new.id_estado_reporte,'nombre_reporte',new.nombre_reporte,'descripcion',new.descripcion,'fecha_creacion',new.fecha_creacion);
    
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarReporte`;
DELIMITER //
create trigger `modificarReporte` 
	after update on `Reporte`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('id_reporte',old.id_reporte,'id_persona_usuario',old.id_persona_usuario,'id_tipo_reporte',old.id_tipo_reporte,'id_estado_reporte',old.id_estado_reporte,'nombre_reporte',old.nombre_reporte,'descripcion',old.descripcion,'fecha_creacion',old.fecha_creacion);
    set nuevo = JSON_OBJECT('id_reporte',new.id_reporte,'id_persona_usuario',new.id_persona_usuario,'id_tipo_reporte',new.id_tipo_reporte,'id_estado_reporte',new.id_estado_reporte,'nombre_reporte',new.nombre_reporte,'descripcion',new.descripcion,'fecha_creacion',new.fecha_creacion);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarReporteBefore`;
DELIMITER //
create trigger `eliminarReporteBefore` 
	before delete on `Reporte`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(id_reporte,JSON_OBJECT('id_reporte',id_reporte,'id_persona_usuario',id_persona_usuario,'id_tipo_reporte',id_tipo_reporte,'id_estado_reporte',id_estado_reporte,'nombre_reporte',nombre_reporte,'descripcion',descripcion,'fecha_creacion',fecha_creacion))) as json FROM Reporte);
    set cont = (SELECT count(*) FROM Reporte);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total reporte',cont),temp);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarReporteAfter`;
DELIMITER //
create trigger `eliminarReporteAfter` 
	after delete on `Reporte`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(id_reporte,JSON_OBJECT('id_reporte',id_reporte,'id_persona_usuario',id_persona_usuario,'id_tipo_reporte',id_tipo_reporte,'id_estado_reporte',id_estado_reporte,'nombre_reporte',nombre_reporte,'descripcion',descripcion,'fecha_creacion',fecha_creacion))) as json FROM Reporte);
    set cont2 = (SELECT count(*) FROM Reporte);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total reporte',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM Bitacora);
    
    UPDATE `poa-pacc-bd`.`Bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//

-- -------------------------------------------Triggers tipolugar-----------------------------------------------------------------------
drop trigger if exists `insertarTipoLugar`;
DELIMITER //
create trigger `insertarTipoLugar` 
	after insert on `TipoLugar`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idTipoLugar',new.idTipoLugar,'tipoLugar',new.tipoLugar);
    
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarTipoLugar`;
DELIMITER //
create trigger `modificarTipoLugar` 
	after update on `TipoLugar`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idTipoLugar',old.idTipoLugar,'tipoLugar',old.tipoLugar);
    set nuevo = JSON_OBJECT('idTipoLugar',new.idTipoLugar,'tipoLugar',new.tipoLugar);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarTipoLugarBefore`;
DELIMITER //
create trigger `eliminarTipoLugarBefore` 
	before delete on `TipoLugar`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idTipoLugar,JSON_OBJECT('idTipoLugar',idTipoLugar,'tipoLugar',tipoLugar))) as json FROM TipoLugar);
    set cont = (SELECT count(*) FROM TipoLugar);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total tipolugar',cont),temp);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarTipoLugarAfter`;
DELIMITER //
create trigger `eliminarTipoLugarAfter` 
	after delete on `TipoLugar`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idTipoLugar,JSON_OBJECT('idTipoLugar',idTipoLugar,'tipoLugar',tipoLugar))) as json FROM TipoLugar);
    set cont2 = (SELECT count(*) FROM TipoLugar);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total tipolugar',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM Bitacora);
    
    UPDATE `poa-pacc-bd`.`Bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//
-- -------------------------------------------Triggers tipopresupuesto-----------------------------------------------------------------------
drop trigger if exists `insertarTipoPresupuesto`;
DELIMITER //
create trigger `insertarTipoPresupuesto` 
	after insert on `TipoPresupuesto`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idTipoPresupuesto',new.idTipoPresupuesto,'tipoPresupuesto',new.tipoPresupuesto);
    
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarTipoPresupuesto`;
DELIMITER //
create trigger `modificarTipoPresupuesto` 
	after update on `TipoPresupuesto`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idTipoPresupuesto',old.idTipoPresupuesto,'tipoPresupuesto',old.tipoPresupuesto);
    set nuevo = JSON_OBJECT('idTipoPresupuesto',new.idTipoPresupuesto,'tipoPresupuesto',new.tipoPresupuesto);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarTipoPresupuestoBefore`;
DELIMITER //
create trigger `eliminarTipoPresupuestoBefore` 
	before delete on `TipoPresupuesto`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idTipoPresupuesto,JSON_OBJECT('idTipoPresupuesto',idTipoPresupuesto,'tipoPresupuesto',tipoPresupuesto))) as json FROM TipoPresupuesto);
    set cont = (SELECT count(*) FROM TipoPresupuesto);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total tipopresupuesto',cont),temp);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarTipoPresupuestoAfter`;
DELIMITER //
create trigger `eliminarTipoPresupuestoAfter` 
	after delete on `TipoPresupuesto`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idTipoPresupuesto,JSON_OBJECT('idTipoPresupuesto',idTipoPresupuesto,'tipoPresupuesto',tipoPresupuesto))) as json FROM TipoPresupuesto);
    set cont2 = (SELECT count(*) FROM TipoPresupuesto);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total tipopresupuesto',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM Bitacora);
    
    UPDATE `poa-pacc-bd`.`Bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//
-- -------------------------------------------Triggers tipousuario-----------------------------------------------------------------------
drop trigger if exists `insertarTipoUsuario`;
DELIMITER //
create trigger `insertarTipoUsuario` 
	after insert on `TipoUsuario`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idTipoUsuario',new.idTipoUsuario,'tipoUsuario',new.tipoUsuario,'abrev',new.abrev);
    
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarTipoUsuario`;
DELIMITER //
create trigger `modificarTipoUsuario` 
	after update on `TipoUsuario`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idTipoUsuario',old.idTipoUsuario,'tipoUsuario',old.tipoUsuario,'abrev',old.abrev);
    set nuevo = JSON_OBJECT('idTipoUsuario',new.idTipoUsuario,'tipoUsuario',new.tipoUsuario,'abrev',new.abrev);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarTipoUsuarioBefore`;
DELIMITER //
create trigger `eliminarTipoUsuarioBefore` 
	before delete on `TipoUsuario`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idTipoUsuario,JSON_OBJECT('idTipoUsuario',idTipoUsuario,'tipoUsuario',tipoUsuario,'abrev',abrev))) as json FROM TipoUsuario);
    set cont = (SELECT count(*) FROM TipoUsuario);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total tipousuario',cont),temp);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarTipoUsuarioAfter`;
DELIMITER //
create trigger `eliminarTipoUsuarioAfter` 
	after delete on `TipoUsuario`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idTipoUsuario,JSON_OBJECT('idTipoUsuario',idTipoUsuario,'tipoUsuario',tipoUsuario,'abrev',abrev))) as json FROM TipoUsuario);
    set cont2 = (SELECT count(*) FROM TipoUsuario);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total tipousuario',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM Bitacora);
    
    UPDATE `poa-pacc-bd`.`Bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//
-- -------------------------------------------Triggers tipobitacora-----------------------------------------------------------------------
drop trigger if exists `insertarTipoBitacora`;
DELIMITER //
create trigger `insertarTipoBitacora` 
	after insert on `TipoBitacora`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idTipoBitacora',new.idTipoBitacora,'tipoBitacora',new.tipoBitacora,'descripcion',new.descripcion);
    
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarTipoBitacora`;
DELIMITER //
create trigger `modificarTipoBitacora` 
	after update on `TipoBitacora`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idTipoBitacora',old.idTipoBitacora,'tipoBitacora',old.tipoBitacora,'descripcion',old.descripcion);
    set nuevo = JSON_OBJECT('idTipoBitacora',new.idTipoBitacora,'tipoBitacora',new.tipoBitacora,'descripcion',new.descripcion);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarTipoBitacoraBefore`;
DELIMITER //
create trigger `eliminarTipoBitacoraBefore` 
	before delete on `TipoBitacora`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idTipoBitacora,JSON_OBJECT('idTipoBitacora',idTipoBitacora,'tipoBitacora',tipoBitacora,'descripcion',descripcion))) as json FROM TipoBitacora);
    set cont = (SELECT count(*) FROM TipoBitacora);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total tipobitacora',cont),temp);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarTipoBitacoraAfter`;
DELIMITER //
create trigger `eliminarTipoBitacoraAfter` 
	after delete on `TipoBitacora`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idTipoBitacora,JSON_OBJECT('idTipoBitacora',idTipoBitacora,'tipoBitacora',tipoBitacora,'descripcion',descripcion))) as json FROM TipoBitacora);
    set cont2 = (SELECT count(*) FROM TipoBitacora);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total tipobitacora',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM Bitacora);
    
    UPDATE `poa-pacc-bd`.`Bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//

-- -------------------------------------------Triggers gestion-----------------------------------------------------------------------
drop trigger if exists `insertarGestionB`;
DELIMITER //
create trigger `insertarGestionB` 
	after insert on `Gestion`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idGestion',new.idGestion,'idTipoGestion',new.idTipoGestion,'idTrimestre',new.idTrimestre,'cantidad',new.cantidad,'documentoRespaldo',new.documentoRespaldo);
    
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarGestionB`;
DELIMITER //
create trigger `modificarGestionB` 
	after update on `Gestion`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idGestion',old.idGestion,'idTipoGestion',old.idTipoGestion,'idTrimestre',old.idTrimestre,'cantidad',old.cantidad,'documentoRespaldo',old.documentoRespaldo);
    set nuevo = JSON_OBJECT('idGestion',new.idGestion,'idTipoGestion',new.idTipoGestion,'idTrimestre',new.idTrimestre,'cantidad',new.cantidad,'documentoRespaldo',new.documentoRespaldo);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarGestionBeforeB`;
DELIMITER //
create trigger `eliminarGestionBeforeB` 
	before delete on `Gestion`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idGestion,JSON_OBJECT('idGestion',idGestion,'idTipoGestion',idTipoGestion,'idTrimestre',idTrimestre,'cantidad',cantidad,'documentoRespaldo',documentoRespaldo))) as json FROM Gestion);
    set cont = (SELECT count(*) FROM Gestion);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total gestion',cont),temp);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarGestionAfterB`;
DELIMITER //
create trigger `eliminarGestionAfterB` 
	after delete on `Gestion`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idGestion,JSON_OBJECT('idGestion',idGestion,'idTipoGestion',idTipoGestion,'idTrimestre',idTrimestre,'cantidad',cantidad,'documentoRespaldo',documentoRespaldo))) as json FROM Gestion);
    set cont2 = (SELECT count(*) FROM Gestion);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total gestion',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM Bitacora);
    
    UPDATE `poa-pacc-bd`.`Bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//

-- -------------------------------------------Triggers tipoaccion-----------------------------------------------------------------------
drop trigger if exists `insertarTipoAccionB`;
DELIMITER //
create trigger `insertarTipoAccionB` 
	after insert on `TipoAccion`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idAccion',new.idAccion,'TipoAccion',new.TipoAccion);
    
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarTipoAccionB`;
DELIMITER //
create trigger `modificarTipoAccionB` 
	after update on `TipoAccion`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idAccion',old.idAccion,'TipoAccion',old.TipoAccion);
    set nuevo = JSON_OBJECT('idAccion',new.idAccion,'TipoAccion',new.TipoAccion);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarTipoAccionBeforeB`;
DELIMITER //
create trigger `eliminarTipoAccionBeforeB` 
	before delete on `TipoAccion`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idAccion,JSON_OBJECT('idAccion',idAccion,'TipoAccion',TipoAccion))) as json FROM TipoAccion);
    set cont = (SELECT count(*) FROM TipoAccion);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total tipoaccion',cont),temp);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarTipoAccionAfterB`;
DELIMITER //
create trigger `eliminarTipoAccionAfterB` 
	after delete on `TipoAccion`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idAccion,JSON_OBJECT('idAccion',idAccion,'TipoAccion',TipoAccion))) as json FROM TipoAccion);
    set cont2 = (SELECT count(*) FROM TipoAccion);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total tipoaccion',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM Bitacora);
    
    UPDATE `poa-pacc-bd`.`Bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//

-- -------------------------------------------Triggers tipoacciongestion-----------------------------------------------------------------------
drop trigger if exists `insertarTipoAccionGestionnB`;
DELIMITER //
create trigger `insertarTipoAccionGestionnB` 
	after insert on `TipoAccionGestion`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idGestion',new.idGestion,'idAccion',new.idAccion,'idPersonaUsuario',new.idPersonaUsuario,'fecha',new.fecha);
    
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarTipoAccionGestionB`;
DELIMITER //
create trigger `modificarTipoAccionGestionB` 
	after update on `TipoAccionGestion`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idGestion',old.idGestion,'idAccion',old.idAccion,'idPersonaUsuario',old.idPersonaUsuario,'fecha',old.fecha);
    set nuevo = JSON_OBJECT('idGestion',new.idGestion,'idAccion',new.idAccion,'idPersonaUsuario',new.idPersonaUsuario,'fecha',new.fecha);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarTipoAccionGestionBeforeB`;
DELIMITER //
create trigger `eliminarTipoAccionGestionBeforeB` 
	before delete on `TipoAccionGestion`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idGestion,JSON_OBJECT('idGestion',idGestion,'idAccion',idAccion,'idPersonaUsuario',idPersonaUsuario,'fecha',fecha))) as json FROM TipoAccionGestion);
    set cont = (SELECT count(*) FROM TipoAccionGestion);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total tipoacciongestion',cont),temp);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarTipoAccionGestionAfterB`;
DELIMITER //
create trigger `eliminarTipoAccionGestionAfterB` 
	after delete on `TipoAccionGestion`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idGestion,JSON_OBJECT('idGestion',idGestion,'idAccion',idAccion,'idPersonaUsuario',idPersonaUsuario,'fecha',fecha))) as json FROM TipoAccionGestion);
    set cont2 = (SELECT count(*) FROM TipoAccionGestion);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total tipoacciongestion',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM Bitacora);
    
    UPDATE `poa-pacc-bd`.`Bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//

-- -------------------------------------------Triggers tipogestion-----------------------------------------------------------------------
drop trigger if exists `insertarTipoGestionB`;
DELIMITER //
create trigger `insertarTipoGestionB` 
	after insert on `TipoGestion`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idTipoGestion',new.idTipoGestion,'nombre',new.nombre);
    
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarTipoGestionB`;
DELIMITER //
create trigger `modificarTipoGestionB` 
	after update on `TipoGestion`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idTipoGestion',old.idTipoGestion,'nombre',old.nombre);
    set nuevo = JSON_OBJECT('idTipoGestion',new.idTipoGestion,'nombre',new.nombre);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarTipoGestionBeforeB`;
DELIMITER //
create trigger `eliminarTipoGestionBeforeB` 
	before delete on `TipoGestion`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idTipoGestion,JSON_OBJECT('idTipoGestion',idTipoGestion,'nombre',nombre))) as json FROM TipoGestion);
    set cont = (SELECT count(*) FROM TipoGestion);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total tipogestion',cont),temp);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarTipoGestionAfterB`;
DELIMITER //
create trigger `eliminarTipoGestionAfterB` 
	after delete on `TipoGestion`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idTipoGestion,JSON_OBJECT('idTipoGestion',idTipoGestion,'nombre',nombre))) as json FROM TipoGestion);
    set cont2 = (SELECT count(*) FROM TipoGestion);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total tipogestion',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM Bitacora);
    
    UPDATE `poa-pacc-bd`.`Bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//

-- -------------------------------------------Triggers trimestre-----------------------------------------------------------------------
drop trigger if exists `insertarTrimestre`;
DELIMITER //
create trigger `insertarTrimestre` 
	after insert on `Trimestre`
    for each row 
begin
    declare valorI json;
    declare valorf json;
    set valorI = '{}';
    set valorf = JSON_OBJECT('idTrimestre',new.idTrimestre,'nombreTrimeste',new.nombreTrimeste);
    
	IF NOT EXISTS( SELECT 1 FROM bitacora WHERE nuevoEstadoInformacion = valorf and fechaHoraBitacora=now()) THEN
        insert into `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
		values (@persona,1,valorI,valorf,now());
    END IF;
end 
//

drop trigger if exists `modificarTrimestre`;
DELIMITER //
create trigger `modificarTrimestre` 
	after update on `Trimestre`
    for each row 
begin
    declare viejo json;
    declare nuevo json;
    set viejo = JSON_OBJECT('idTrimestre',old.idTrimestre,'nombreTrimeste',old.nombreTrimeste);
    set nuevo = JSON_OBJECT('idTrimestre',new.idTrimestre,'nombreTrimeste',new.nombreTrimeste);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,2,viejo,nuevo,now());
end 
//

drop trigger if exists `eliminarTrimestreBefore`;
DELIMITER //
create trigger `eliminarTrimestreBefore` 
	before delete on `Trimestre`
    for each row 
begin
	declare temp json;
    declare temp2 json;
    declare cont int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idTrimestre,JSON_OBJECT('idTrimestre',idTrimestre,'nombreTrimeste',nombreTrimeste))) as json FROM Trimestre);
    set cont = (SELECT count(*) FROM Trimestre);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total trimestre',cont),temp);
    insert into
    `poa-pacc-bd`.`Bitacora` (idPersonaUsuario,idTipoBitacora,estadoInicialInformacion,nuevoEstadoInformacion,fechaHoraBitacora) 
    values (@persona,3,temp2,'{}',now());
end 
//
 
drop trigger if exists `eliminarTrimestreAfter`;
DELIMITER //
create trigger `eliminarTrimestreAfter` 
	after delete on `Trimestre`
    for each row 
begin
	declare temp json;
    declare cont int;
    declare temp2 json;
    declare cont2 int;
    
    set temp = (SELECT (JSON_OBJECTAGG(idTrimestre,JSON_OBJECT('idTrimestre',idTrimestre,'nombreTrimeste',nombreTrimeste))) as json FROM Trimestre);
    set cont2 = (SELECT count(*) FROM Trimestre);
    set temp2 = JSON_OBJECT(JSON_OBJECT('Total trimestre',cont2),temp);
    set cont = (SELECT MAX(idBitacora) AS id FROM Bitacora);
    
    UPDATE `poa-pacc-bd`.`Bitacora` 
	SET nuevoEstadoInformacion = temp2 
	WHERE idBitacora = cont;
end 
//