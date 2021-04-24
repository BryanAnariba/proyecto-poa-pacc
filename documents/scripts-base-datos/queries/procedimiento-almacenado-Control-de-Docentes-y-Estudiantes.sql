DELIMITER ;;
CREATE PROCEDURE `SP_INGRESAR_POBLACION`(
   IN _Trimestre INT,
   IN _numeroPoblacion INT,
   IN _respaldo varchar(1000),
   IN _poblacion varchar(45),
   IN _idUsuario INT,
   OUT _respuesta varchar(80),
   OUT _respuesta2 boolean
)
BEGIN
	   if _poblacion = 'NumEstudiantesMatriculados' then
			set @persona = _idUsuario;
            IF NOT EXISTS( SELECT 1 FROM Gestion inner join TipoAccionGestion on Gestion.idGestion=TipoAccionGestion.idGestion 
							WHERE Gestion.idTrimestre = _Trimestre and Gestion.idTipoGestion=1 and year(TipoAccionGestion.fecha)=year(now())) 
			THEN
				INSERT INTO `poa-pacc-bd`.`Gestion`
				(`idTipoGestion`,`idTrimestre`,`cantidad`,`documentoRespaldo`)
				VALUES(1,_Trimestre,_numeroPoblacion,_respaldo);
                set _respuesta2 = true;
			else 
				set _respuesta2 = false;
			end if;
            set @persona = null;
            set _respuesta = 'Numero de Estudiantes Matriculados';
	   elseif _poblacion = 'NumEgresados' then
			set @persona = _idUsuario;
            IF NOT EXISTS( SELECT 1 FROM Gestion inner join TipoAccionGestion on Gestion.idGestion=TipoAccionGestion.idGestion 
							WHERE Gestion.idTrimestre = _Trimestre and Gestion.idTipoGestion=2 and year(TipoAccionGestion.fecha)=year(now())) 
			THEN
				INSERT INTO `poa-pacc-bd`.`Gestion`
				(`idTipoGestion`,`idTrimestre`,`cantidad`,`documentoRespaldo`)
				VALUES(2,_Trimestre,_numeroPoblacion,_respaldo);
                set _respuesta2 = true;
			else 
				set _respuesta2 = false;
			end if;
            set @persona = null;
            set _respuesta = 'Numero de Egresados';
	   elseif _poblacion = 'NumDocentes' then
			set @persona = _idUsuario;
            IF NOT EXISTS( SELECT 1 FROM Gestion inner join TipoAccionGestion on Gestion.idGestion=TipoAccionGestion.idGestion 
							WHERE Gestion.idTrimestre = _Trimestre and Gestion.idTipoGestion=3 and year(TipoAccionGestion.fecha)=year(now())) 
			THEN
				INSERT INTO `poa-pacc-bd`.`Gestion`
				(`idTipoGestion`,`idTrimestre`,`cantidad`,`documentoRespaldo`)
				VALUES(3,_Trimestre,_numeroPoblacion,_respaldo);
                set _respuesta2 = true;
			else 
				set _respuesta2 = false;
			end if;
            set @persona = null;
            set _respuesta = 'Numero de Docentes con Maestria';
	   end if;
END;;

DELIMITER ;;
CREATE PROCEDURE `SP_MODIFICAR_POBLACION`(
   IN _Trimestre INT,
   IN _numeroPoblacion INT,
   IN _idGestion INT,
   IN _idTipoGestion INT,
   IN _fechaRegistro date,
   OUT _respuesta boolean
)
BEGIN
	IF NOT EXISTS( SELECT 1 FROM Gestion inner join TipoAccionGestion on Gestion.idGestion=TipoAccionGestion.idGestion 
					WHERE Gestion.idTrimestre = _Trimestre and Gestion.idTipoGestion=_idTipoGestion and year(TipoAccionGestion.fecha)=year(_fechaRegistro)
                    and Gestion.idGestion<>_idGestion) 
	THEN
		UPDATE Gestion
		SET
		idTrimestre = _Trimestre,
		cantidad = _numeroPoblacion
		WHERE idGestion = _idGestion;
		set _respuesta = true;
	else 
		set _respuesta = false;
	end if;
end;;