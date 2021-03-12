-- Procedimiento almacenado para modificar Registros de docentes y estudiantes, desde la vista de usuario Estratega

CREATE PROCEDURE SP_MODIFICAR_REGISTROS_POBLACION(
    IN Trimestre INT,
   	IN cantidadPoblacion INT,
   	IN _idGestion INT
    )
	UPDATE gestion
	SET
	idTrimestre = Trimestre,
	cantidad = cantidadPoblacion
	WHERE idGestion = _idGestion;