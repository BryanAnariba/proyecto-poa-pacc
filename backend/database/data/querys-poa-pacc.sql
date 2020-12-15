CREATE PROCEDURE SP_LISTAR_PAISES(IN id INT)
	SELECT 
		idLugar,
        nombreLugar
        FROM Lugar WHERE idTipoLugar = id;

--CALL SP_LISTAR_PAISES(1)

CREATE PROCEDURE SP_LISTAR_CIUDADES_PAIS(IN idPais INT)
	SELECT 
		A.idLugar,
        A.nombreLugar as ciudad,
        A.idLugarPadre,
        B.nombreLugar
        FROM Lugar A INNER JOIN Lugar B 
        ON(A.idLugarPadre = B.idLugar)
        WHERE A.idLugarPadre = idPais;
--CALL SP_LISTAR_MUNICIPIOS_CIUDAD(1)

CREATE PROCEDURE SP_LISTAR_MUNICIPIOS_CIUDAD(IN idDepartamento INT)
	SELECT 
		A.idLugar,
        A.nombreLugar as municipio,
        A.idLugarPadre,
        B.nombreLugar
        FROM Lugar A INNER JOIN Lugar B 
        ON(A.idLugarPadre = B.idLugar)
        WHERE A.idLugarPadre = idDepartamento;

--CALL SP_LISTAR_MUNICIPIOS_CIUDAD(9)

CREATE PROCEDURE SP_LISTAR_TIPOS_USUARIOS()
	SELECT * FROM TipoUsuario;

-- CALL SP_LISTAR_TIPOS_USUARIOS()