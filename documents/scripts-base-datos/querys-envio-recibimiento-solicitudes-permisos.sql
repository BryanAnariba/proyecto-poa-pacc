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
