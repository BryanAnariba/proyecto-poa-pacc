-- IMPORTANTE: esta primera parte que esta encerrada entre "#" de este script solo se ejecutara si aun no se han hecho los cambios
-- en el modelo de la base de datos, una vez que se hagan dichos cambios esta parte ya no sera necesaria

-- ######################################################################################
--Modificaciones en la tabla solicitudSalida
ALTER TABLE `solicitudsalida` CHANGE `motivoSolicitud` `motivoSolicitud` 
TEXT CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL;

ALTER TABLE `solicitudsalida` 
CHANGE `descripcionSolicitud` `motivoSolicitud` VARCHAR(255) 
CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL;

ALTER TABLE `solicitudsalida` 
CHANGE `excusa` `edificioAsistencia` VARCHAR(100) 
CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL;

ALTER TABLE `solicitudsalida` 
CHANGE `diasSolicitados` `diasSolicitados` INT(11) NULL;

ALTER TABLE `estadosolicitudsalida` 
CHANGE `idPersonaUsuarioVeedor` `idPersonaUsuarioVeedor` INT(11) NULL;

ALTER TABLE `solicitudsalida` ADD `fechaRegistroSolicitud` DATE NOT NULL AFTER `fechaFinPermiso`;

--Modificaciones en la tabla estadosolicitudsalida
ALTER TABLE `estadosolicitudsalida` ADD `fechaRevisionSolicitud` DATE NULL AFTER `observacionesSolicitud`;

-- ########################################################################################


-- ESTA PARTE SI SE INSERTARA EN LA BD
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




-- Recibimiento de Persmisos
-- Procedimiento para hacer una observacion al revisar una solicitud de permisos 

CREATE PROCEDURE SP_HACER_OBSERVACION(
        IN idSolicitud INT, 
        IN observaciones VARCHAR(255)
        )
UPDATE estadosolicitudsalida 
SET observacionesSolicitud = observaciones
WHERE idSolicitudSalida = idSolicitud;

-- Procedimiento para actualizar la solicitud de permiso
CREATE PROCEDURE SP_ACTUALIZAR_SOLICITUD_PERMISO(
        IN idSolicitud INT, 
        IN idEstado INT,
        IN idUsuario INT,
        IN fechaRevision DATE
        )
UPDATE estadosolicitudsalida 
SET idTipoEstadoSolicitud = idEstado,
        idPersonaUsuarioVeedor = idUsuario,
        fechaRevisionSolicitud = fechaRevision
WHERE idSolicitudSalida = idSolicitud;
