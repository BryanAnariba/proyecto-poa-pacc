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