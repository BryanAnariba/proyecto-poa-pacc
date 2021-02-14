CREATE PROCEDURE SP_LISTAR_PAISES(IN id INT)
	SELECT 
		idLugar,
        nombreLugar
        FROM Lugar WHERE idTipoLugar = id;

-- CALL SP_LISTAR_PAISES(1)

CREATE PROCEDURE SP_LISTAR_CIUDADES_PAIS(IN idPais INT)
	SELECT 
		A.idLugar,
        A.nombreLugar as ciudad,
        A.idLugarPadre,
        B.nombreLugar
        FROM Lugar A INNER JOIN Lugar B 
        ON(A.idLugarPadre = B.idLugar)
        WHERE A.idLugarPadre = idPais;

-- CALL SP_LISTAR_MUNICIPIOS_CIUDAD(1)

CREATE PROCEDURE SP_LISTAR_MUNICIPIOS_CIUDAD(IN idDepartamento INT)
	SELECT 
		A.idLugar,
        A.nombreLugar as municipio,
        A.idLugarPadre,
        B.nombreLugar
        FROM Lugar A INNER JOIN Lugar B 
        ON(A.idLugarPadre = B.idLugar)
        WHERE A.idLugarPadre = idDepartamento;

-- CALL SP_LISTAR_MUNICIPIOS_CIUDAD(9)

CREATE PROCEDURE SP_LISTAR_TIPOS_USUARIOS()
	SELECT * FROM TipoUsuario;

-- CALL SP_LISTAR_TIPOS_USUARIOS()

CREATE PROCEDURE SP_LISTAR_DEPARTAMENTOS(IN idEstado INT)
	SELECT * FROM Departamento WHERE idEstadoDepartamento = idEstado;

-- CALL SP_LISTAR_DEPARTAMENTOS(1)


CREATE PROCEDURE SP_REGISTRA_DIM_ESTRATEGICA(IN estadoDimension INT, dimension VARCHAR(150))
	INSERT INTO DimensionEstrategica (idEstadoDimension, dimensionEstrategica) VALUES (
		estadoDimension, dimension
    );

-- CALL SP_REGISTRA_DIM_ESTRATEGICA(p1,p2)

CREATE PROCEDURE SP_GET_DIMENSION_ESTRATEGICA(IN idDimensionEstrategica INT)
	SELECT idEstadoDimension, idDimension, dimensionEstrategica FROM DimensionEstrategica  WHERE idDimension = idDimensionEstrategica;
    
-- CALL SP_GET_DIMENSION_ESTRATEGICA(1)


CREATE PROCEDURE SP_CAMBIA_ESTADO_DIMENSION(IN idDimensionEstrategica INT, IN estadoDimension INT)
	UPDATE DimensionEstrategica SET idEstadoDimension = estadoDimension
    WHERE idDimension = idDimensionEstrategica;

-- CALL SP_CAMBIA_ESTADO_DIMENSION(1,2)

CREATE PROCEDURE SP_MODIFICA_DIMENSION(IN idDimensionEstrategica INT, IN dimension VARCHAR(150))
	UPDATE DimensionEstrategica SET dimensionEstrategica = dimension 
    WHERE idDimension = idDimensionEstrategica;

-- CALL SP_MODIFICA_DIMENSION(24, 'Test Dimension 24 Modificada')

CREATE PROCEDURE SP_LISTA_OBJ_POR_DIM(IN idDimension INT)
	SELECT 
		ObjetivoInstitucional.idObjetivoInstitucional,
        ObjetivoInstitucional.idDimensionEstrategica,
        ObjetivoInstitucional.idEstadoObjetivoInstitucional,
        estadodcduoao.estado,
        ObjetivoInstitucional.ObjetivoInstitucional
    FROM ObjetivoInstitucional INNER JOIN estadodcduoao 
    ON (ObjetivoInstitucional.idEstadoObjetivoInstitucional = estadodcduoao.idEstado)
    WHERE idDimensionEstrategica = idDimension
    ORDER BY ObjetivoInstitucional.idObjetivoInstitucional ASC;

-- CALL SP_LISTA_OBJ_POR_DIM(1)


CREATE PROCEDURE SP_REGISTRA_OBJETIVO(IN dimensionEstrategica INT, IN estadoObjetivoInstitucional INT , objetivo TEXT)
	INSERT INTO ObjetivoInstitucional(idDimensionEstrategica, idEstadoObjetivoInstitucional, objetivoInstitucional) 
    VALUES (dimensionEstrategica, estadoObjetivoInstitucional, objetivo);

-- CALL SP_REGISTRA_OBJETIVO(P1,P2,P3)


CREATE PROCEDURE SP_CAMBIA_ESTADO_OBJETIVO(IN idObjetivo INT,IN idEstado INT)
	UPDATE ObjetivoInstitucional SET idEstadoObjetivoInstitucional = idEstado
    WHERE idObjetivoInstitucional = idObjetivo;

-- CALL SP_CAMBIA_ESTADO_OBJETIVO(3, 2)

CREATE PROCEDURE SP_MODIFICA_OBJETIVO(IN idObjetivo INT, IN objetivo TEXT)
	UPDATE ObjetivoInstitucional SET ObjetivoInstitucional = objetivo
    WHERE idObjetivoInstitucional = idObjetivo;

-- CALL SP_MODIFICA_OBJETIVO(P1,P2)

CREATE PROCEDURE SP_REGISTRA_AREA_ESTRATEGICA(IN idObjetivo INT,IN idEstado INT, IN area TEXT)
	INSERT INTO AreaEstrategica (idObjetivoInstitucional, idEstadoAreaEstrategica, areaEstrategica)
    VALUES (idObjetivo, idEstado, area);

-- CALL SP_REGISTRA_AREA_ESTRATEGICA(P1,P2,P3)

CREATE PROCEDURE SP_LISTA_AREAS_POR_OBJ (IN idObjetivo INT)
	SELECT  
		AreaEstrategica.idAreaEstrategica, 
        AreaEstrategica.areaEstrategica, 
        AreaEstrategica.idEstadoAreaEstrategica, 
        AreaEstrategica.idObjetivoInstitucional, 
        EstadoDCDUOAO.estado 
        FROM AreaEstrategica LEFT JOIN EstadoDCDUOAO 
        ON (AreaEstrategica.idEstadoAreaEstrategica = EstadoDCDUOAO.idEstado) 
        WHERE idObjetivoInstitucional = idObjetivo 
        ORDER BY AreaEstrategica.idAreaEstrategica ASC;

-- CALL SP_LISTA_AREAS_POR_OBJ(2)

CREATE PROCEDURE SP_CAMBIA_ESTADO_AREA(IN idArea INT,IN idEstadoArea INT)
	UPDATE AreaEstrategica SET idEstadoAreaEstrategica = idEstadoArea
    WHERE idAreaEstrategica = idArea;

-- CALL SP_CAMBIA_ESTADO_AREA(P1,P2)

CREATE PROCEDURE SP_MODIFICA_AREA(IN idArea INT, IN area TEXT)
	UPDATE AreaEstrategica SET areaEstrategica = area
    WHERE idAreaEstrategica = idArea;

-- CALL SP_MODIFICA_AREA(P1,P2)

CREATE PROCEDURE SP_VERIFICA_EMAIL_USUARIO(IN emailUsuario VARCHAR(100))
	SELECT idPersonaUsuario, correoInstitucional FROM Usuario WHERE correoInstitucional = emailUsuario;

-- SP_VERIFICA_EMAIL_USUARIO('bsancheza@unah.hn');

CREATE PROCEDURE SP_INSERTA_PERSONA(IN nombre VARCHAR(80), IN apellido VARCHAR(80), IN lugar INT, IN direccionLugar VARCHAR(255),IN fechaDeNacimiento DATE)
    INSERT INTO Persona (nombrePersona, apellidoPersona, idLugar, idGenero , direccion,  fechaNacimiento) VALUES 
    (nombre, apellido, lugar, NULL, direccionLugar, fechaDeNacimiento);
    SELECT LAST_INSERT_ID() AS 'idPersonaInsertada';

-- CALL SP_INSERTA_PERSONA(p1,p2,p3,p4,p5)


CREATE PROCEDURE SP_INSERTA_USUARIO(
	IN idUsuario INT, 
    IN idTUsuario INT, 
    IN idDepto INT, 
    IN idEstado INT, 
    IN usuario VARCHAR(80), 
    IN correo VARCHAR(100),
    IN codigo VARCHAR(50),
    IN password VARCHAR(255))
    INSERT INTO Usuario (
		idPersonaUsuario, 
        idTipoUsuario, 
        idDepartamento, 
        idEstadoUsuario, 
        nombreUsuario, 
        correoInstitucional,
        codigoEmpleado,
        passwordUsuario,
        avatarUsuario)
	VALUES 
		(idUsuario, idTUsuario, idDepto, idEstado, usuario, correo, codigo, password, NULL);

-- CALL SP_INSERTA_USUARIO(P1,P2,P3,P4,P5,P6,P7,P8)


CREATE PROCEDURE SP_LISTAR_USUARIOS()
	SELECT 	Persona.idPersona, 
		Persona.nombrePersona,
        Persona.apellidoPersona, 
        Persona.fechaNacimiento,
        Persona.direccion,
        Persona.idLugar AS idLugarMunicipio,
        Lugar.nombreLugar AS municipio,
        LugarCiudad.idLugar AS idLugarCiudad,
        LugarCiudad.nombreLugar AS ciudad,
        LugarPais.idLugar AS idLugarPais,
        LugarPais.nombreLugar AS pais,
        Usuario.nombreUsuario,
        Usuario.correoInstitucional,
        Usuario.idTipoUsuario,
        TipoUsuario.tipoUsuario,
        Usuario.idEstadoUsuario,
        EstadoDCDUOAO.estado,
        Usuario.idDepartamento,
        Departamento.nombreDepartamento,
        Departamento.telefonoDepartamento,
        Departamento.abrev,
        Usuario.codigoEmpleado,
        Usuario.avatarUsuario
		FROM Persona 
		INNER JOIN Lugar ON (Persona.idLugar = Lugar.idLugar)
        INNER JOIN Lugar LugarCiudad ON (Lugar.idLugarPadre = LugarCiudad.idLugar)
        INNER JOIN Lugar LugarPais ON (LugarCiudad.idLugarPadre = LugarPais.idLugar)
        INNER JOIN Usuario ON (Persona.idPersona = Usuario.idPersonaUsuario)
        INNER JOIN TipoUsuario ON (Usuario.idTipoUsuario = TipoUsuario.idTipoUsuario)
        INNER JOIN EstadoDCDUOAO ON (Usuario.idEstadoUsuario = EstadoDCDUOAO.idEstado)
        INNER JOIN Departamento ON (Usuario.idDepartamento = Departamento.idDepartamento)
        ORDER BY Usuario.idPersonaUsuario ASC;
-- CALL SP_LISTAR_USUARIOS()

DELIMITER ;;
CREATE PROCEDURE SP_Registrar_Carrera(
   IN _idCarrera INT,
   IN _carrera varchar(60),
   IN _abrev varchar(10),
   IN _idDepartamento INT,
   IN _idEstadoDCD INT,
   IN _peticion varchar(60),
   OUT _respuesta INT
)
BEGIN
   declare temp int;
   
   if _peticion = 'insert' then
		set temp = (SELECT COUNT(*) FROM carrera WHERE carrera = _carrera or abrev=_abrev);
        
        if temp = 1 then
			set _respuesta = 0;
		elseif temp = 0 then
			set _respuesta = 1;
			insert into carrera (carrera,abrev,idDepartamento,idEstadoCarrera) values (_carrera,_Abrev,_idDepartamento,_idEstadoDCD);
		end if;
   elseif _peticion = 'actualizarCarrera' then
		set temp = (SELECT COUNT(*) FROM carrera WHERE idCarrera=_idCarrera);
        
        if temp = 0 then
			set _respuesta = 0;
		elseif temp = 1 then
			set temp = (SELECT COUNT(*) FROM carrera WHERE idCarrera<>_idCarrera and (carrera = _carrera or abrev=_abrev));
            
            if temp >= 1 then
				set _respuesta = 0;
			elseif temp = 0 then 
                set _respuesta = 1;
                UPDATE carrera SET idDepartamento=_idDepartamento,idEstadoCarrera=_idEstadoDCD,carrera=_carrera,abrev=_abrev where idCarrera=_idCarrera;
			end if;
        end if;
   end if;
   
END ;;
DELIMITER ;

-- CALL SP_Registrar_Carrera()

DELIMITER ;;
CREATE PROCEDURE SP_Registrar_Objeto(
   IN _idObjeto INT,
   IN _objeto varchar(80),
   IN _abrev varchar(25),
   IN _codigoObjeto varchar(8),
   IN _idEstadoDCD INT,
   IN _peticion varchar(60),
   OUT _respuesta INT
)
BEGIN
   declare temp int;
   
   if LENGTH(_objeto) >0 && LENGTH(_objeto)<=80 && LENGTH(_abrev) >0 && LENGTH(_abrev)<=25 && LENGTH(_codigoObjeto) >0 && LENGTH(_codigoObjeto)<=8 then
   if _peticion = 'insert' then
		set temp = (SELECT COUNT(*) FROM objetogasto WHERE (codigoObjetoGasto = _codigoObjeto or abrev=_abrev or DescripcionCuenta=_objeto));
        
        if temp >= 1 then
			set _respuesta = 0;
		elseif temp = 0 then
			set _respuesta = 1;
			insert into objetogasto (DescripcionCuenta,abrev,codigoObjetoGasto,idEstadoObjetoGasto) values (_objeto,_Abrev,_codigoObjeto,_idEstadoDCD);
		end if;
   elseif _peticion = 'actualizarCarrera' then
		set temp = (SELECT COUNT(*) FROM objetogasto WHERE idObjetoGasto=_idObjeto);
        
        if temp = 0 then
			set _respuesta = 0;
		elseif temp = 1 then
			set temp = (SELECT COUNT(*) FROM objetogasto WHERE idObjetoGasto<>_idObjeto and (codigoObjetoGasto = _codigoObjeto or abrev=_abrev or DescripcionCuenta=_objeto));
            
            if temp >= 1 then
				set _respuesta = 0;
			elseif temp = 0 then 
                set _respuesta = 1;
                UPDATE objetogasto SET DescripcionCuenta=_objeto,idEstadoObjetoGasto=_idEstadoDCD,codigoObjetoGasto=_codigoObjeto,abrev=_abrev where idObjetoGasto=_idObjeto;
			end if;
        end if;
   end if;
   else
       set _respuesta = 0;
   end if;
END ;;
DELIMITER ;

-- CALL SP_Registrar_Objeto()
-- CALL Registrar_Carrera()


CREATE PROCEDURE SP_CAMBIA_ESTADO_USUARIO(IN idUsuario INT, IN identificadorEstadoUsuario INT)
	UPDATE Usuario SET idEstadoUsuario = identificadorEstadoUsuario 
    WHERE idPersonaUsuario = idUsuario;

-- CALL SP_CAMBIA_ESTADO_USUARIO(8,2)

CREATE PROCEDURE SP_MODIFICA_DIRECCION_PERSONA(IN idUsuario INT, IN lugar INT, direccionLugar VARCHAR(255))
	UPDATE Persona SET direccion = direccionLugar, idLugar = lugar
    WHERE idPersona = idUsuario;

-- CALL SP_MODIFICA_DIRECCION_PERSONA(P1,P2,P3)

CREATE PROCEDURE SP_MODIF_DATOS_GEN_PERSONA( 
	IN nombre VARCHAR(80), 
    IN apellido VARCHAR(80),
    IN fecha DATE,
    IN idUsuario INT)
    UPDATE Persona SET 
		nombrePersona = nombre,
        apellidoPersona = apellido,
        fechaNacimiento = fecha
        WHERE idPersona = idUsuario;

-- CALL SP_MODIF_DATOS_GEN_persona(p1,p2,p3,p4)

CREATE PROCEDURE SP_MODIF_DATOS_GEN_USUARIO(IN idUsuario INT,IN departamento INT,IN tipoUsuario INT,IN codigo VARCHAR(50))
	UPDATE Usuario SET 
    codigoEmpleado = codigo,
    idTipoUsuario = tipoUsuario,
    idDepartamento = departamento
    WHERE idPersonaUsuario = idUsuario;
-- CALL SP_MODIF_DATOS_GEN_USUARIO(p1,p2,p3,p4)


CREATE PROCEDURE SP_VERIF_CREDENCIALES_USUARIO (IN correo VARCHAR(100))
	SELECT 
		Usuario.idPersonaUsuario,
		Persona.nombrePersona,
		Persona.apellidoPersona,
		Persona.direccion,
        Usuario.nombreUsuario,
		Usuario.idDepartamento,
		Departamento.nombreDepartamento,
        Departamento.abrev,
        Departamento.telefonoDepartamento,
		Usuario.idEstadoUsuario,
		estadoDCDUOAO.estado,
		Usuario.codigoEmpleado,
		Usuario.idTipoUsuario,
		TipoUsuario.tipoUsuario,
        TipoUsuario.abrev as abrevTipoUsuario,
		Usuario.correoInstitucional,
		Usuario.passwordUsuario,
		Usuario.avatarUsuario
		FROM Persona INNER JOIN Usuario ON (Persona.idPersona = Usuario.idPersonaUsuario)
		INNER JOIN Departamento ON (Usuario.idDepartamento = Departamento.idDepartamento)
		INNER JOIN estadoDCDUOAO ON (Usuario.idEstadoUsuario = estadoDCDUOAO.idEstado)
		INNER JOIN TipoUsuario ON (Usuario.idTipoUsuario = TipoUsuario.idTipoUsuario)
		WHERE Usuario.correoInstitucional = correo;

-- CALL SP_VERIF_CREDENCIALES_USUARIO('bsancheza@unah.hn')


CREATE PROCEDURE SP_GENERAR_TOKEN_ACCESO(IN idUsuario INT, IN token VARCHAR(255), IN fechaExpiracion DATETIME)
	UPDATE Usuario SET 
		tokenAcceso = token,
        tokenExpiracion = fechaExpiracion
	WHERE idPersonaUsuario = idUsuario;

-- CALL SP_GENERAR_TOKEN_ACCESO(P1,P2,P3)


CREATE PROCEDURE SP_REMOVER_TOKEN(IN idUsuario INT, IN token VARCHAR(255))
	UPDATE Usuario SET 
		tokenAcceso = NULL,
        tokenExpiracion = NULL
	WHERE idPersonaUsuario = idUsuario AND tokenAcceso = token;

-- CALL SP_GENERAR_TOKEN_ACCESO(P1,P2)

CREATE PROCEDURE SP_VERIFICA_TOKEN(IN idUsuario INT, IN token VARCHAR(255))
	SELECT * FROM Usuario WHERE tokenAcceso = token AND idPersonaUsuario = idUsuario;

-- PROCEDIMIENTOS PARA CONTROL DE DEPARTAMENTOS
-- Procedimiento para registrar nuevo departamento 
-- CALL SP_REGISTRAR_DEPARTAMENTO
CREATE PROCEDURE SP_REGISTRAR_DEPARTAMENTO(
    IN idDepartamento INT,
    IN idEstadoDepartamento INT,
    IN nombreDepartamento varchar(80),
    IN telefonoDepartamento varchar(60),
    IN abreviaturaDepartamento varchar(2), 
    IN correoDepartamento varchar(60)
    )
    INSERT INTO departamento (
        idDepartamento,
		idEstadoDepartamento, 
        nombreDepartamento, 
        telefonoDepartamento, 
        abrev, 
        correoDepartamento)
	VALUES 
		(idDepartamento,
		idEstadoDepartamento, 
        nombreDepartamento, 
        telefonoDepartamento, 
        abreviaturaDepartamento, 
        correoDepartamento);


-- Procedimiento para modificar departamento
-- CALL SP_MODIFICAR_DEPARTAMENTO
CREATE PROCEDURE SP_MODIFICAR_DEPARTAMENTO(
    IN idDepartamentoM INT,
    IN idEstadoDepartamentoM INT,
    IN nombreDepartamentoM varchar(80),
    IN telefonoDepartamentoM varchar(60),
    IN abrevM varchar(2), 
    IN correoDepartamentoM varchar(60)
    )
	UPDATE departamento
    SET idEstadoDepartamento = idEstadoDepartamentoM,
        nombreDepartamento = nombreDepartamentoM,
        telefonoDepartamento = telefonoDepartamentoM,
        abrev = abrevM,
        correoDepartamento = correoDepartamentoM
    WHERE idDepartamento = idDepartamentoM;

-- Procedimientos almacenados para dimensiones administrativas

-- CALL SP_REGISTRA_DIM_ADMINISTRATIVA
CREATE PROCEDURE SP_REGISTRA_DIM_ADMINISTRATIVA(
    IN estadoDimension INT, 
    IN dimension VARCHAR(150)
)
INSERT INTO DimensionAdmin(
    idEstadoDimension, 
    dimensionAdministrativa
) 
VALUES (estadoDimension, 
    dimension
);

-- CALL SP_GET_DIMENSION_ADMINISTRATIVA
CREATE PROCEDURE SP_GET_DIMENSION_ADMINISTRATIVA(
    IN idDimensionAdministrativa INT
)
SELECT idEstadoDimension, 
    idDimension, 
    dimensionAdministrativa 
FROM DimensionAdmin 
WHERE idDimension = idDimensionAdministrativa;
    


-- CALL SP_CAMBIA_ESTADO_DIMENSION_ADMIN
CREATE PROCEDURE SP_CAMBIA_ESTADO_DIMENSION_ADMIN(
    IN idDimensionAdministrativa INT, 
    IN estadoDimension INT
)
UPDATE DimensionAdmin
SET idEstadoDimension = estadoDimension
WHERE idDimension = idDimensionAdministrativa;


-- CALL SP_MODIFICA_DIMENSION_ADMIN
CREATE PROCEDURE SP_MODIFICA_DIMENSION_ADMIN(
    IN idDimensionAdministrativa INT, 
    IN dimension VARCHAR(150)
)
UPDATE DimensionAdmin 
SET dimensionAdministrativa = dimension 
WHERE idDimension = idDimensionAdministrativa;


CREATE PROCEDURE SP_INSERTA_ACTIVIDAD(
	IN idUsuario INT, 
    IN idDimensionEstrategica INT,
    IN idObjetivo INT,
    IN idResultado INT,
    IN idArea INT,
    IN idTipoCostoActividad INT,
    IN resultados VARCHAR(200),
    IN indicadores VARCHAR(200),
    IN nombreActividad VARCHAR(200),
    IN correlativo VARCHAR(25),
    IN justificacion VARCHAR(255),
    IN medio VARCHAR(255),
    IN poblacion VARCHAR(255),
    IN responsable VARCHAR(255),
    IN costo DECIMAL(13,2)
)
	INSERT INTO Actividad (
		idPersonaUsuario, 
        idDimension, 
        idObjetivoInstitucional, 
        idResultadoInstitucional, 
        idAreaEstrategica, 
        idTipoActividad, 
        resultadosUnidad, 
        indicadoresResultado, 
        actividad, 
        correlativoActividad, 
        justificacionActividad, 
        medioVerificacionActividad, 
        poblacionObjetivoActividad, 
        responsableActividad, 
        fechaCreacionActividad, 
        CostoTotal
	) VALUES (
		idUsuario,
        idDimensionEstrategica,
        idObjetivo,
        idResultado,
        idArea,
        idTipoCostoActividad,
        resultados,
        indicadores,
        nombreActividad,
        correlativo,
        justificacion,
        medio,
        poblacion,
        responsable,
        NOW(),
        costo
    );
    SELECT last_insert_id() as ultimoIdInsertado;

CREATE PROCEDURE SP_INSERTA_COSTO_ACT_TRIMESTRE(
	IN idAct INT, 
	IN pTrimestre1 DECIMAL(5,2), 
    IN T1 DECIMAL(13,2), 
    IN pTrimestre2 DECIMAL(5,2), 
    IN T2 DECIMAL(13,2), 
    IN pTrimestre3 DECIMAL(5,2), 
    IN T3 DECIMAL(13,2), 
    IN pTrimestre4 DECIMAL(5,2), 
    IN T4 DECIMAL(13,2),
    IN sumatoria DECIMAL(3,2)
)
	INSERT INTO CostoActividadPorTrimestre (
		idActividad, 
        porcentajeTrimestre1, 
        Trimestre1, 
        abrevTrimestre1, 
        porcentajeTrimestre2, 
        Trimestre2, 
        abrevTrimestre2, 
        porcentajeTrimestre3, 
        Trimestre3, 
        abrevTrimestre3, 
        porcentajeTrimestre4, 
        Trimestre4, 
        abrevTrimestre4,
        sumatoriaPorcentaje
	) VALUES (
		idAct,
        pTrimestre1,
        T1,
        'I',
        pTrimestre2,
        T2,
        'II',
        pTrimestre3,
        T3,
        'III',
        pTrimestre4,
        T4,
        'IV',
        sumatoria
    );


-- --->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ESTAS CONSULTAS SON QUERYS PARA LAS ACTIVIDADES NO TOCAR 
-- --->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ESTAS CONSULTAS QUEDAN COMO RESPANDO DEL LAS CTE EN LOS METODOS DE LA CLASES ACTIVIDADES Y PRESUPUESTO

-- Consulta para cargar actividades por dimension al anio
WITH CTE_LISTADO_ACT_POR_DIM AS (
	SELECT 
    COUNT(Actividad.idActividad) AS cantidadActividadesPorDimension,
    DimensionEstrategica.idDimension,
    DimensionEstrategica.dimensionEstrategica,
    DimensionEstrategica.idEstadoDimension,
    Estadodcduoao.estado
    FROM 
    Actividad 
    RIGHT JOIN DimensionEstrategica ON (Actividad.idDimension = DimensionEstrategica.idDimension)
    INNER JOIN Estadodcduoao ON (DimensionEstrategica.idEstadoDimension = Estadodcduoao.idEstado)
    GROUP BY DimensionEstrategica.idDimension, DimensionEstrategica.dimensionEstrategica
)
SELECT * FROM CTE_LISTADO_ACT_POR_DIM 
WHERE CTE_LISTADO_ACT_POR_DIM.idEstadoDimension = 1 AND 
(
    SELECT 
    ControlPresupuestoActividad.idEstadoPresupuestoAnual
    FROM ControlPresupuestoActividad 
    LEFT JOIN PresupuestoDepartamento ON (ControlPresupuestoActividad.idControlPresupuestoActividad = PresupuestoDepartamento.idControlPresupuestoActividad)
    RIGHT JOIN Departamento ON (PresupuestoDepartamento.idDepartamento = Departamento.idDepartamento)
    LEFT JOIN Usuario ON (Departamento.idDepartamento = Usuario.idDepartamento)
    INNER JOIN EstadoDCDUOAO ON (ControlPresupuestoActividad.idEstadoPresupuestoAnual = EstadoDCDUOAO.idEstado)
    WHERE Departamento.idDepartamento = 1 AND Usuario.idPersonaUsuario = 2 AND DATE_FORMAT(ControlPresupuestoActividad.fechaPresupuestoAnual, '%Y') = DATE_FORMAT(NOW(), '%Y')
) AND 
CTE_LISTADO_ACT_POR_DIM.idDimension BETWEEN (
    SELECT 
	LlenadoActividadDimension.valorLlenadoDimensionInicial
    FROM LlenadoActividadDimension INNER JOIN TipoUsuario ON (LlenadoActividadDimension.TipoUsuario_idTipoUsuario = TipoUsuario.idTipoUsuario)
    WHERE LlenadoActividadDimension.TipoUsuario_idTipoUsuario = 3
) AND (
    SELECT 
	LlenadoActividadDimension.valorLlenadoDimensionFinal
    FROM LlenadoActividadDimension INNER JOIN TipoUsuario ON (LlenadoActividadDimension.TipoUsuario_idTipoUsuario = TipoUsuario.idTipoUsuario)
    WHERE LlenadoActividadDimension.TipoUsuario_idTipoUsuario = 3
);

-- consulta para generar el correlativo
WITH CTE_GENERA_CORRELATIVO AS (
	SELECT 
		(COUNT(Actividad.idPersonaUsuario) + 1) AS numeroActividad,
        Actividad.fechaCreacionActividad,
		date_format(Actividad.fechaCreacionActividad,'%Y') as anioActividad,
		Actividad.idDimension,
		Actividad.idPersonaUsuario,
		Usuario.idDepartamento,
		Departamento.abrev
		FROM DimensionEstrategica 
		INNER JOIN Actividad ON (DimensionEstrategica.idDimension = Actividad.idDimension)
		INNER JOIN Usuario ON (Actividad.idPersonaUsuario = Usuario.idPersonaUsuario)
		INNER JOIN Departamento ON (Usuario.idDepartamento = Departamento.idDepartamento)
		GROUP BY Usuario.idDepartamento, DimensionEstrategica.idDimension
) SELECT * FROM CTE_GENERA_CORRELATIVO 
WHERE CTE_GENERA_CORRELATIVO.idDimension = 1 AND CTE_GENERA_CORRELATIVO.idPersonaUsuario = 4 AND date_format(CTE_GENERA_CORRELATIVO.fechaCreacionActividad,'%Y') = date_format(NOW(), '%Y')
AND CTE_GENERA_CORRELATIVO.idDepartamento = 4;


-- Query para generar el vs de presupuestos -> PresupuestoDeptoTotal vs PresupuestoConsumidoPorActividades
SELECT 
	SUM(Actividad.CostoTotal) AS costoActividadesDepto,
    DATE_FORMAT(Actividad.fechaCreacionActividad, '%Y') AS anioSumaActividades,
    Actividad.idPersonaUsuario,
    Usuario.nombreUsuario,
    Usuario.idDepartamento,
    Departamento.nombreDepartamento,
    (
		SELECT PresupuestoDepartamento.montoPresupuesto FROM PresupuestoDepartamento WHERE PresupuestoDepartamento.idDepartamento = 1 AND
        DATE_FORMAT(PresupuestoDepartamento.fechaAprobacionPresupuesto, '%Y') = DATE_FORMAT(NOW(), '%Y')
    ) AS PresupuestoTotalDepartamento
    FROM Actividad 
	RIGHT JOIN Usuario ON (Actividad.idPersonaUsuario = Usuario.idPersonaUsuario)
    INNER JOIN Departamento ON (Usuario.idDepartamento = Departamento.idDepartamento) 
    LEFT JOIN PresupuestoDepartamento ON (PresupuestoDepartamento.idDepartamento = Departamento.idDepartamento)
    WHERE Usuario.idPersonaUsuario = 2  AND Departamento.idDepartamento = 1 AND (DATE_FORMAT(Actividad.fechaCreacionActividad, '%Y') = DATE_FORMAT(NOW(), '%Y'));
    
    
-- Query para cargar info en la parte de actividades especiales
SELECT 
	Actividad.idActividad, 
    Actividad.actividad, 
    Actividad.idDimension,
    DimensionEstrategica.dimensionEstrategica,
    Actividad.correlativoActividad, 
    Actividad.fechaCreacionActividad, 
    Actividad.CostoTotal
    FROM Actividad INNER JOIN DimensionEstrategica ON (Actividad.idDimension = DimensionEstrategica.idDimension)
    WHERE date_format(Actividad.fechaCreacionActividad, '%Y') = date_format(NOW(), '%Y') AND DimensionEstrategica.idDimension = 1;

-- Query para cargar actividades de una dimension correspondiente
WITH CTE_LISTA_ACTIVIDADES_DIMENSION AS (
	SELECT 
		Actividad.idActividad, 
		Actividad.idPersonaUsuario,
		Usuario.nombreUsuario,
		Usuario.idDepartamento,
		Departamento.nombreDepartamento,
		Actividad.idDimension, 
		DimensionEstrategica.dimensionEstrategica,
		Actividad.idObjetivoInstitucional, 
		ObjetivoInstitucional.objetivoInstitucional,
		Actividad.idResultadoInstitucional, 
		ResultadoInstitucional.resultadoInstitucional,
		Actividad.idAreaEstrategica, 
		AreaEstrategica.areaEstrategica,
		Actividad.idTipoActividad, 
		TipoActividad.tipoActividad,
		Actividad.resultadosUnidad, 
		Actividad.indicadoresResultado, 
		Actividad.actividad, 
		Actividad.correlativoActividad, 
		Actividad.justificacionActividad, 
		Actividad.medioVerificacionActividad, 
		Actividad.poblacionObjetivoActividad, 
		Actividad.responsableActividad, 
		Actividad.fechaCreacionActividad, 
		Actividad.CostoTotal,
		CostoActividadPorTrimestre.idCostActPorTri, 
		CostoActividadPorTrimestre.porcentajeTrimestre1, 
		CostoActividadPorTrimestre.Trimestre1, 
		CostoActividadPorTrimestre.abrevTrimestre1, 
		CostoActividadPorTrimestre.porcentajeTrimestre2, 
		CostoActividadPorTrimestre.Trimestre2, 
		CostoActividadPorTrimestre.abrevTrimestre2, 
		CostoActividadPorTrimestre.porcentajeTrimestre3, 
		CostoActividadPorTrimestre.Trimestre3, 
		CostoActividadPorTrimestre.abrevTrimestre3, 
		CostoActividadPorTrimestre.porcentajeTrimestre4, 
		CostoActividadPorTrimestre.Trimestre4, 
		CostoActividadPorTrimestre.abrevTrimestre4, 
		CostoActividadPorTrimestre.sumatoriaPorcentaje
		FROM Actividad 
		INNER JOIN DimensionEstrategica ON (Actividad.idDimension = DimensionEstrategica.idDimension)
		INNER JOIN ObjetivoInstitucional ON (Actividad.idObjetivoInstitucional = ObjetivoInstitucional.idObjetivoInstitucional)
		INNER JOIN AreaEstrategica ON (Actividad.idAreaEstrategica = AreaEstrategica.idAreaEstrategica) 
		INNER JOIN ResultadoInstitucional ON (Actividad.idResultadoInstitucional = ResultadoInstitucional.idResultadoInstitucional) 
		INNER JOIN TipoActividad ON (Actividad.idTipoActividad = TipoActividad.idTipoActividad) 
		INNER JOIN CostoActividadPorTrimestre ON (CostoActividadPorTrimestre.idActividad = Actividad.idActividad)
		INNER JOIN Usuario ON (Actividad.idPersonaUsuario = Usuario.idPersonaUsuario) 
		INNER JOIN DEPARTAMENTO ON (Usuario.idDepartamento = Departamento.idDepartamento)
) SELECT * FROM CTE_LISTA_ACTIVIDADES_DIMENSION WHERE date_format(CTE_LISTA_ACTIVIDADES_DIMENSION.fechaCreacionActividad, '%Y') = date_format(NOW(), '%Y') 
AND CTE_LISTA_ACTIVIDADES_DIMENSION.idDimension = 1 and CTE_LISTA_ACTIVIDADES_DIMENSION.idPersonaUsuario = 1

-- query para calcular que la insercion de la actividad y su desglose valla bien en cuanto al costo de la actividad
SELECT 
	SUM(DescripcionAdministrativa.costoTotal) AS costoDescripcionAdmin,
    Actividad.idActividad,
    (
		SELECT Actividad.costoTotal FROM ACTIVIDAD WHERE idActividad = 15
    ) AS costoActividad
    FROM DescripcionAdministrativa RIGHT JOIN Actividad ON (DescripcionAdministrativa.idActividad = Actividad.idActividad) 
    WHERE Actividad.idActividad = 15

-- Consulta para verificar el estado del presupuesto
WITH CTE_VER_ESTADO_ANUAL_PRESUPUESTO AS (
	SELECT ControlPresupuestoActividad.fechaPresupuestoAnual,
	DATE_FORMAT(ControlPresupuestoActividad.fechaPresupuestoAnual, '%Y') AS anioPresupuesto,
    ControlPresupuestoActividad.idEstadoPresupuestoAnual,
    EstadoDCDUOAO.estado
    FROM ControlPresupuestoActividad INNER JOIN EstadoDCDUOAO 
    ON (ControlPresupuestoActividad.idEstadoPresupuestoAnual = EstadoDCDUOAO.idEstado)
) SELECT * FROM  CTE_VER_ESTADO_ANUAL_PRESUPUESTO 
WHERE DATE_FORMAT(CTE_VER_ESTADO_ANUAL_PRESUPUESTO.fechaPresupuestoAnual,'%Y') = DATE_FORMAT(NOW(), '%Y');


-- ALTER TABLE CostoActividadPorTrimestre ADD COLUMN sumatoriaPorcentaje DECIMAL(3,2);
-- ALTER TABLE DescripcionAdministrativa DROP COLUMN nombreACtividad;




SELECT 
	DimensionEstrategica.idDimension,
    DimensionEstrategica.dimensionEstrategica,
    DimensionEstrategica.idEstadoDimension,
    Actividad.fechaCreacionActividad,
    DATE_FORMAT(Actividad.fechaCreacionActividad, '%Y') AS anioActividades,
    COUNT(Actividad.idActividad) AS cantidadActividadesPorDimension,
    Usuario.idDepartamento
    FROM DimensionEstrategica 
    RIGHT JOIN Actividad ON (DimensionEstrategica.idDimension = Actividad.idDimension) 
    LEFT JOIN Usuario ON (Actividad.idPersonaUsuario = Usuario.idPersonaUsuario)
    WHERE DimensionEstrategica.idEstadoDimension = 1 
    AND DATE_FORMAT(Actividad.fechaCreacionActividad, '%Y') = DATE_FORMAT(NOW(),'%Y') 
    AND Usuario.idDepartamento = 1 AND DimensionEstrategica.idDimension BETWEEN (
    SELECT
	LlenadoActividadDimension.valorLlenadoDimensionInicial
    FROM LlenadoActividadDimension INNER JOIN TipoUsuario ON (LlenadoActividadDimension.TipoUsuario_idTipoUsuario = TipoUsuario.idTipoUsuario)
    WHERE LlenadoActividadDimension.TipoUsuario_idTipoUsuario = 2
) AND (
    SELECT 
	LlenadoActividadDimension.valorLlenadoDimensionFinal
    FROM LlenadoActividadDimension INNER JOIN TipoUsuario ON (LlenadoActividadDimension.TipoUsuario_idTipoUsuario = TipoUsuario.idTipoUsuario)
    WHERE LlenadoActividadDimension.TipoUsuario_idTipoUsuario = 2
)
GROUP BY DimensionEstrategica.idDimension


-- CONSULTAS PARA GENERAR EL EXCEL HABIENDO LLENADO LAS DIMENSIONES CORRESPONDIENTES
SELECT 
	DimensionEstrategica.idDimension,
    DimensionEstrategica.dimensionEstrategica,
    DimensionEstrategica.idEstadoDimension,
    DATE_FORMAT(Actividad.fechaCreacionActividad, '%Y') AS anioActividades,
    COUNT(Actividad.idActividad) AS cantidadActividadesPorDimension,
    Usuario.idDepartamento
    FROM DimensionEstrategica 
    RIGHT JOIN Actividad 
    ON (DimensionEstrategica.idDimension = Actividad.idDimension) 
    LEFT JOIN Usuario 
    ON (Actividad.idPersonaUsuario = Usuario.idPersonaUsuario)
    WHERE DimensionEstrategica.idEstadoDimension = 1 
    AND DATE_FORMAT(Actividad.fechaCreacionActividad, '%Y') = 
    (
		SELECT DATE_FORMAT(ControlPresupuestoActividad.fechaPresupuestoAnual, '%Y') 
        FROM ControlPresupuestoActividad 
        WHERE ControlPresupuestoActividad.estadoLlenadoActividades = 1
    ) 
    AND Usuario.idDepartamento = 1 
    AND DimensionEstrategica.idDimension BETWEEN 
        (
            SELECT
            LlenadoActividadDimension.valorLlenadoDimensionInicial
            FROM LlenadoActividadDimension INNER JOIN TipoUsuario ON (LlenadoActividadDimension.TipoUsuario_idTipoUsuario = TipoUsuario.idTipoUsuario)
            WHERE LlenadoActividadDimension.TipoUsuario_idTipoUsuario = 3
        ) 
        AND 
        (
        SELECT 
        LlenadoActividadDimension.valorLlenadoDimensionFinal
        FROM LlenadoActividadDimension INNER JOIN TipoUsuario ON (LlenadoActividadDimension.TipoUsuario_idTipoUsuario = TipoUsuario.idTipoUsuario)
        WHERE LlenadoActividadDimension.TipoUsuario_idTipoUsuario = 3
    )
GROUP BY 
DimensionEstrategica.idDimension, 
DimensionEstrategica.dimensionEstrategica, 
Usuario.idDepartamento,
DimensionEstrategica.idEstadoDimension;


SELECT COUNT(*) cantidadDimensionesUsuario FROM dimensionestrategica WHERE idDimension BETWEEN 
    (
    SELECT
        LlenadoActividadDimension.valorLlenadoDimensionInicial
        FROM LlenadoActividadDimension INNER JOIN TipoUsuario ON (LlenadoActividadDimension.TipoUsuario_idTipoUsuario = TipoUsuario.idTipoUsuario)
        WHERE LlenadoActividadDimension.TipoUsuario_idTipoUsuario = 2
    ) 
    AND 
    (
        SELECT 
        LlenadoActividadDimension.valorLlenadoDimensionFinal
        FROM LlenadoActividadDimension INNER JOIN TipoUsuario ON (LlenadoActividadDimension.TipoUsuario_idTipoUsuario = TipoUsuario.idTipoUsuario)
        WHERE LlenadoActividadDimension.TipoUsuario_idTipoUsuario = 2
    );



-- Modificar en esto
ALTER TABLE `poa-pacc-bd`.controlpresupuestoactividad ADD COLUMN estadoLlenadoActividades BOOLEAN;
ALTER TABLE DescripcionAdministrativa MODIFY COLUMN Cantidad DECIMAL(13,2); 



UPDATE ControlPresupuestoActividad SET estadoLlenadoActividades = FALSE WHERE idControlPresupuestoActividad = 1;
UPDATE ControlPresupuestoActividad SET estadoLlenadoActividades = TRUE WHERE idControlPresupuestoActividad = 2;

WITH 
CTE_VERIF_EXIS_PRES_ANUAL AS (
	SELECT * FROM controlPresupuestoActividad
    WHERE estadoLlenadoActividades = TRUE
) 
SELECT * FROM CTE_VERIF_EXIS_PRES_ANUAL;


WITH CTE_QUERY_PACC_INGENIERIA AS (
	SELECT 
		Actividad.CorrelativoActividad,
        ObjetoGasto.codigoObjetoGasto,
        ObjetoGasto.descripcionCuenta,
        DescripcionAdministrativa.cantidad,
        DescripcionAdministrativa.costo,
        DescripcionAdministrativa.costoTotal
    FROM DescripcionAdministrativa 
    INNER JOIN  Actividad
	ON (DescripcionAdministrativa.idActividad = Actividad.idActividad)
    INNER JOIN ObjetoGasto 
    ON (DescripcionAdministrativa.idObjetoGasto = ObjetoGasto.idObjetoGasto)
    WHERE DATE_FORMAT(Actividad.fechaCreacionActividad,'%Y') = (
		SELECT DATE_FORMAT(ControlPresupuestoActividad.fechaPresupuestoAnual, '%Y') 
		FROM ControlPresupuestoActividad 
		WHERE ControlPresupuestoActividad.estadoLlenadoActividades = 1
	)
)
SELECT * FROM CTE_QUERY_PACC_INGENIERIA 