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
	SELECT idEstadoDimension, idDimension, dimensionEstrategica FROM DimensionEstrategica  WHERE idDimension = idDimensionEstrategica
    
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


CREATE PROCEDURE SP_REGISTRA_OBJETIVO(IN dimensionEstrategica INT, IN estadoObjetivoInstitucional INT , objetivo VARCHAR(150))
	INSERT INTO ObjetivoInstitucional(idDimensionEstrategica, idEstadoObjetivoInstitucional, objetivoInstitucional) 
    VALUES (dimensionEstrategica, estadoObjetivoInstitucional, objetivo);

-- CALL SP_REGISTRA_OBJETIVO(P1,P2,P3)


CREATE PROCEDURE SP_CAMBIA_ESTADO_OBJETIVO(IN idObjetivo INT,IN idEstado INT)
	UPDATE ObjetivoInstitucional SET idEstadoObjetivoInstitucional = idEstado
    WHERE idObjetivoInstitucional = idObjetivo;

-- CALL SP_CAMBIA_ESTADO_OBJETIVO(3, 2)

CREATE PROCEDURE SP_MODIFICA_OBJETIVO(IN idObjetivo INT, IN objetivo VARCHAR(180))
	UPDATE ObjetivoInstitucional SET ObjetivoInstitucional = objetivo
    WHERE idObjetivoInstitucional = idObjetivo

-- CALL SP_MODIFICA_OBJETIVO(P1,P2)

CREATE PROCEDURE SP_REGISTRA_AREA_ESTRATEGICA(IN idObjetivo INT,IN idEstado INT, IN area VARCHAR(200))
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
        ORDER BY AreaEstrategica.idAreaEstrategica ASC

-- CALL SP_LISTA_AREAS_POR_OBJ(2)

CREATE PROCEDURE SP_CAMBIA_ESTADO_AREA(IN idArea INT,IN idEstadoArea INT)
	UPDATE AreaEstrategica SET idEstadoAreaEstrategica = idEstadoArea
    WHERE idAreaEstrategica = idArea;

-- CALL SP_CAMBIA_ESTADO_AREA(P1,P2)

CREATE PROCEDURE SP_MODIFICA_AREA(IN idArea INT, IN area VARCHAR(200))
	UPDATE AreaEstrategica SET areaEstrategica = area
    WHERE idAreaEstrategica = idArea

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
		(idUsuario, idTUsuario, idDepto, idEstado, usuario, correo, codigo, password, NULL)

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

CREATE PROCEDURE SP_CAMBIA_ESTADO_USUARIO(IN idUsuario INT, IN identificadorEstadoUsuario INT)
	UPDATE Usuario SET idEstadoUsuario = identificadorEstadoUsuario 
    WHERE idPersonaUsuario = idUsuario;

-- CALL SP_CAMBIA_ESTADO_USUARIO(8,2)



-- CALL SP_MODIF_DATOS_GEN_USUARIO(p1,p2,p3,p4)

CREATE PROCEDURE SP_MODIF_DATOS_GEN_PERSONA( 
	IN nombre VARCHAR(80), 
    IN apellido VARCHAR(80),
    IN fecha DATE,
    IN idUsuario INT)
    UPDATE Persona SET 
		nombrePersona = nombre,
        apellidoPersona = apellido,
        fechaNacimiento = fecha
        WHERE idPersona = idUsuario

-- CALL SP_MODIF_DATOS_GEN_persona(p1,p2,p3,p4)

CREATE PROCEDURE SP_MODIFICA_DIRECCION_PERSONA(IN idUsuario INT, IN lugar INT, direccionLugar VARCHAR(255))
	UPDATE Persona SET direccion = direccionLugar, 
    WHERE idPersona = idUsuario;

-- CALL SP_MODIFICA_DIRECCION_PERSONA(P1,P2,P3)