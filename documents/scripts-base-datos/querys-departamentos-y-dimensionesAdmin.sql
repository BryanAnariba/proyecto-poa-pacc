
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




-- ----------------------------------------------------------------------------------------------------------------------

-- --------------------------------esto tambien debe revisarse 
-- agregando una tabla para las dimensiones administrativas, 
CREATE TABLE IF NOT EXISTS `poa-pacc-bd`.`DimensionAdmin` (
  `idDimension` INT NOT NULL AUTO_INCREMENT,
  `idEstadoDimension` INT NOT NULL,
  `dimensionAdministrativa` VARCHAR(150) NOT NULL,
  PRIMARY KEY (`idDimension`),
  INDEX `fk_DimensionAdministrativa_EstadoDCD1_idx` (`idEstadoDimension`),
  CONSTRAINT `fk_DimensionAdministrativa_EstadoDCD1`
    FOREIGN KEY (`idEstadoDimension`)
    REFERENCES `poa-pacc-bd`.`EstadoDCDUOAO` (`idEstado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO `dimensionadmin` (`idDimension`, `idEstadoDimension`, `dimensionAdministrativa`) 
VALUES (NULL, '1', 'TALLERES SEMINARIOS');
-- ------------------------------------------------------------------

