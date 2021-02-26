-- MySQL Script generated by MySQL Workbench
-- Mon Feb 15 20:30:27 2021
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema poa-pacc-bd
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema poa-pacc-bd
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `poa-pacc-bd` DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish_ci ;
USE `poa-pacc-bd` ;

-- -----------------------------------------------------
-- Table `poa-pacc-bd`.`TipoLugar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `poa-pacc-bd`.`TipoLugar` (
  `idTipoLugar` INT NOT NULL AUTO_INCREMENT,
  `tipoLugar` VARCHAR(150) NOT NULL,
  PRIMARY KEY (`idTipoLugar`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `poa-pacc-bd`.`Lugar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `poa-pacc-bd`.`Lugar` (
  `idLugar` INT NOT NULL AUTO_INCREMENT,
  `idTipoLugar` INT NOT NULL,
  `idLugarPadre` INT NULL,
  `nombreLugar` VARCHAR(150) NULL,
  PRIMARY KEY (`idLugar`),
  INDEX `fk_Lugares_TipoLugares1_idx` (`idTipoLugar` ASC) VISIBLE,
  INDEX `fk_Lugares_Lugares1_idx` (`idLugarPadre` ASC) VISIBLE,
  CONSTRAINT `fk_Lugares_TipoLugares1`
    FOREIGN KEY (`idTipoLugar`)
    REFERENCES `poa-pacc-bd`.`TipoLugar` (`idTipoLugar`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Lugares_Lugares1`
    FOREIGN KEY (`idLugarPadre`)
    REFERENCES `poa-pacc-bd`.`Lugar` (`idLugar`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `poa-pacc-bd`.`Genero`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `poa-pacc-bd`.`Genero` (
  `idGenero` INT NOT NULL AUTO_INCREMENT,
  `genero` VARCHAR(45) NOT NULL,
  `abrev` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`idGenero`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `poa-pacc-bd`.`Persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `poa-pacc-bd`.`Persona` (
  `idPersona` INT NOT NULL AUTO_INCREMENT,
  `idLugar` INT NOT NULL,
  `idGenero` INT NULL,
  `direccion` VARCHAR(255) NULL,
  `nombrePersona` VARCHAR(80) NOT NULL,
  `apellidoPersona` VARCHAR(80) NOT NULL,
  `fechaNacimiento` DATE NOT NULL,
  PRIMARY KEY (`idPersona`),
  INDEX `fk_Personas_Lugares1_idx` (`idLugar` ASC) VISIBLE,
  INDEX `fk_Personas_Generos1_idx` (`idGenero` ASC) VISIBLE,
  CONSTRAINT `fk_Personas_Lugares1`
    FOREIGN KEY (`idLugar`)
    REFERENCES `poa-pacc-bd`.`Lugar` (`idLugar`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Personas_Generos1`
    FOREIGN KEY (`idGenero`)
    REFERENCES `poa-pacc-bd`.`Genero` (`idGenero`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `poa-pacc-bd`.`TipoUsuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `poa-pacc-bd`.`TipoUsuario` (
  `idTipoUsuario` INT NOT NULL AUTO_INCREMENT,
  `tipoUsuario` VARCHAR(45) NOT NULL,
  `abrev` VARCHAR(10) NULL,
  PRIMARY KEY (`idTipoUsuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `poa-pacc-bd`.`EstadoDCDUOAO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `poa-pacc-bd`.`EstadoDCDUOAO` (
  `idEstado` INT NOT NULL AUTO_INCREMENT,
  `estado` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idEstado`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `poa-pacc-bd`.`Departamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `poa-pacc-bd`.`Departamento` (
  `idDepartamento` INT NOT NULL AUTO_INCREMENT,
  `idEstadoDepartamento` INT NOT NULL,
  `nombreDepartamento` VARCHAR(80) NOT NULL,
  `correoDepartamento` VARCHAR(60) NOT NULL,
  `telefonoDepartamento` VARCHAR(60) NULL,
  `abrev` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`idDepartamento`),
  INDEX `fk_Departamento_EstadoDCD1_idx` (`idEstadoDepartamento` ASC) VISIBLE,
  CONSTRAINT `fk_Departamento_EstadoDCD1`
    FOREIGN KEY (`idEstadoDepartamento`)
    REFERENCES `poa-pacc-bd`.`EstadoDCDUOAO` (`idEstado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `poa-pacc-bd`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `poa-pacc-bd`.`Usuario` (
  `idPersonaUsuario` INT NOT NULL,
  `idTipoUsuario` INT NOT NULL,
  `idDepartamento` INT NOT NULL,
  `idEstadoUsuario` INT NOT NULL,
  `nombreUsuario` VARCHAR(80) NOT NULL,
  `correoInstitucional` VARCHAR(100) NOT NULL,
  `codigoEmpleado` VARCHAR(50) NOT NULL,
  `passwordUsuario` VARCHAR(255) NOT NULL,
  `avatarUsuario` VARCHAR(255) NULL,
  `tokenAcceso` VARCHAR(255) NULL,
  `tokenExpiracion` DATETIME NULL,
  PRIMARY KEY (`idPersonaUsuario`),
  INDEX `fk_Usuarios_Personas_idx` (`idPersonaUsuario` ASC) VISIBLE,
  INDEX `fk_Usuarios_TipoUsuarios1_idx` (`idTipoUsuario` ASC) VISIBLE,
  INDEX `fk_Usuarios_Departamentos1_idx` (`idDepartamento` ASC) VISIBLE,
  INDEX `fk_Usuario_EstadoDCDU1_idx` (`idEstadoUsuario` ASC) VISIBLE,
  UNIQUE INDEX `correoInstitucional_UNIQUE` (`correoInstitucional` ASC) VISIBLE,
  CONSTRAINT `fk_Usuarios_Personas`
    FOREIGN KEY (`idPersonaUsuario`)
    REFERENCES `poa-pacc-bd`.`Persona` (`idPersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuarios_TipoUsuarios1`
    FOREIGN KEY (`idTipoUsuario`)
    REFERENCES `poa-pacc-bd`.`TipoUsuario` (`idTipoUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuarios_Departamentos1`
    FOREIGN KEY (`idDepartamento`)
    REFERENCES `poa-pacc-bd`.`Departamento` (`idDepartamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuario_EstadoDCDU1`
    FOREIGN KEY (`idEstadoUsuario`)
    REFERENCES `poa-pacc-bd`.`EstadoDCDUOAO` (`idEstado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `poa-pacc-bd`.`DimensionEstrategica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `poa-pacc-bd`.`DimensionEstrategica` (
  `idDimension` INT NOT NULL AUTO_INCREMENT,
  `idEstadoDimension` INT NOT NULL,
  `dimensionEstrategica` VARCHAR(150) NOT NULL,
  PRIMARY KEY (`idDimension`),
  INDEX `fk_DimensionEstrategica_EstadoDCD1_idx` (`idEstadoDimension` ASC) VISIBLE,
  CONSTRAINT `fk_DimensionEstrategica_EstadoDCD1`
    FOREIGN KEY (`idEstadoDimension`)
    REFERENCES `poa-pacc-bd`.`EstadoDCDUOAO` (`idEstado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `poa-pacc-bd`.`ObjetivoInstitucional`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `poa-pacc-bd`.`ObjetivoInstitucional` (
  `idObjetivoInstitucional` INT NOT NULL AUTO_INCREMENT,
  `idDimensionEstrategica` INT NOT NULL,
  `idEstadoObjetivoInstitucional` INT NOT NULL,
  `objetivoInstitucional` TEXT NOT NULL,
  PRIMARY KEY (`idObjetivoInstitucional`),
  INDEX `fk_Objetivos_tbl_dimensiones1_idx` (`idDimensionEstrategica` ASC) VISIBLE,
  INDEX `fk_ObjetivoInstitucional_EstadoDCDUOA1_idx` (`idEstadoObjetivoInstitucional` ASC) VISIBLE,
  CONSTRAINT `fk_Objetivos_tbl_dimensiones1`
    FOREIGN KEY (`idDimensionEstrategica`)
    REFERENCES `poa-pacc-bd`.`DimensionEstrategica` (`idDimension`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ObjetivoInstitucional_EstadoDCDUOA1`
    FOREIGN KEY (`idEstadoObjetivoInstitucional`)
    REFERENCES `poa-pacc-bd`.`EstadoDCDUOAO` (`idEstado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `poa-pacc-bd`.`AreaEstrategica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `poa-pacc-bd`.`AreaEstrategica` (
  `idAreaEstrategica` INT NOT NULL AUTO_INCREMENT,
  `idEstadoAreaEstrategica` INT NOT NULL,
  `idObjetivoInstitucional` INT NOT NULL,
  `areaEstrategica` TEXT NOT NULL,
  PRIMARY KEY (`idAreaEstrategica`),
  INDEX `fk_AreasEstrategicas_Objetivos1_idx` (`idObjetivoInstitucional` ASC) VISIBLE,
  INDEX `fk_AreaEstrategica_EstadoDCDUOA1_idx` (`idEstadoAreaEstrategica` ASC) VISIBLE,
  CONSTRAINT `fk_AreasEstrategicas_Objetivos1`
    FOREIGN KEY (`idObjetivoInstitucional`)
    REFERENCES `poa-pacc-bd`.`ObjetivoInstitucional` (`idObjetivoInstitucional`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_AreaEstrategica_EstadoDCDUOA1`
    FOREIGN KEY (`idEstadoAreaEstrategica`)
    REFERENCES `poa-pacc-bd`.`EstadoDCDUOAO` (`idEstado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `poa-pacc-bd`.`TipoActividad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `poa-pacc-bd`.`TipoActividad` (
  `idTipoActividad` INT NOT NULL AUTO_INCREMENT,
  `TipoActividad` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTipoActividad`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `poa-pacc-bd`.`ResultadoInstitucional`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `poa-pacc-bd`.`ResultadoInstitucional` (
  `idResultadoInstitucional` INT NOT NULL AUTO_INCREMENT,
  `idAreaEstrategica` INT NOT NULL,
  `idEstadoResultadoInstitucional` INT NOT NULL,
  `resultadoInstitucional` TEXT NOT NULL,
  PRIMARY KEY (`idResultadoInstitucional`),
  INDEX `fk_ResultadoInstitucional_EstadoDCDUOAO1_idx` (`idEstadoResultadoInstitucional` ASC) VISIBLE,
  INDEX `fk_ResultadoInstitucional_AreaEstrategica1_idx` (`idAreaEstrategica` ASC) VISIBLE,
  CONSTRAINT `fk_ResultadoInstitucional_EstadoDCDUOAO1`
    FOREIGN KEY (`idEstadoResultadoInstitucional`)
    REFERENCES `poa-pacc-bd`.`EstadoDCDUOAO` (`idEstado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ResultadoInstitucional_AreaEstrategica1`
    FOREIGN KEY (`idAreaEstrategica`)
    REFERENCES `poa-pacc-bd`.`AreaEstrategica` (`idAreaEstrategica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `poa-pacc-bd`.`EstadoActividad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `poa-pacc-bd`.`EstadoActividad` (
  `idEstadoActividad` INT NOT NULL AUTO_INCREMENT,
  `estadoActividad` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idEstadoActividad`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `poa-pacc-bd`.`Actividad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `poa-pacc-bd`.`Actividad` (
  `idActividad` INT NOT NULL AUTO_INCREMENT,
  `idPersonaUsuario` INT NOT NULL,
  `idDimension` INT NOT NULL,
  `idObjetivoInstitucional` INT NOT NULL,
  `idResultadoInstitucional` INT NOT NULL,
  `idAreaEstrategica` INT NOT NULL,
  `idTipoActividad` INT NOT NULL,
  `idEstadoActividad` INT NOT NULL,
  `resultadosUnidad` VARCHAR(255) NOT NULL,
  `indicadoresResultado` VARCHAR(200) NOT NULL,
  `actividad` VARCHAR(255) NOT NULL,
  `correlativoActividad` VARCHAR(25) NOT NULL,
  `justificacionActividad` VARCHAR(255) NOT NULL,
  `medioVerificacionActividad` VARCHAR(255) NOT NULL,
  `poblacionObjetivoActividad` VARCHAR(255) NOT NULL,
  `responsableActividad` VARCHAR(255) NOT NULL,
  `fechaCreacionActividad` DATETIME NOT NULL,
  `CostoTotal` DECIMAL(13,2) NOT NULL,
  PRIMARY KEY (`idActividad`),
  INDEX `fk_Actividad_DimensionEstrategica1_idx` (`idDimension` ASC) VISIBLE,
  INDEX `fk_Actividad_ObjetivoInstitucional1_idx` (`idObjetivoInstitucional` ASC) VISIBLE,
  INDEX `fk_Actividad_AreaEstrategica1_idx` (`idAreaEstrategica` ASC) VISIBLE,
  INDEX `fk_Actividad_Usuario1_idx` (`idPersonaUsuario` ASC) VISIBLE,
  INDEX `fk_Actividad_TipoActividad1_idx` (`idTipoActividad` ASC) VISIBLE,
  INDEX `fk_Actividad_ResultadoInstitucional1_idx` (`idResultadoInstitucional` ASC) VISIBLE,
  INDEX `fk_Actividad_EstadoActividad1_idx` (`idEstadoActividad` ASC) VISIBLE,
  CONSTRAINT `fk_Actividad_DimensionEstrategica1`
    FOREIGN KEY (`idDimension`)
    REFERENCES `poa-pacc-bd`.`DimensionEstrategica` (`idDimension`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Actividad_ObjetivoInstitucional1`
    FOREIGN KEY (`idObjetivoInstitucional`)
    REFERENCES `poa-pacc-bd`.`ObjetivoInstitucional` (`idObjetivoInstitucional`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Actividad_AreaEstrategica1`
    FOREIGN KEY (`idAreaEstrategica`)
    REFERENCES `poa-pacc-bd`.`AreaEstrategica` (`idAreaEstrategica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Actividad_Usuario1`
    FOREIGN KEY (`idPersonaUsuario`)
    REFERENCES `poa-pacc-bd`.`Usuario` (`idPersonaUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Actividad_TipoActividad1`
    FOREIGN KEY (`idTipoActividad`)
    REFERENCES `poa-pacc-bd`.`TipoActividad` (`idTipoActividad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Actividad_ResultadoInstitucional1`
    FOREIGN KEY (`idResultadoInstitucional`)
    REFERENCES `poa-pacc-bd`.`ResultadoInstitucional` (`idResultadoInstitucional`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Actividad_EstadoActividad1`
    FOREIGN KEY (`idEstadoActividad`)
    REFERENCES `poa-pacc-bd`.`EstadoActividad` (`idEstadoActividad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `poa-pacc-bd`.`ObjetoGasto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `poa-pacc-bd`.`ObjetoGasto` (
  `idObjetoGasto` INT NOT NULL AUTO_INCREMENT,
  `idEstadoObjetoGasto` INT NOT NULL,
  `DescripcionCuenta` VARCHAR(80) NOT NULL,
  `codigoObjetoGasto` VARCHAR(60) NOT NULL,
  `abrev` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idObjetoGasto`),
  INDEX `fk_ObjetoGasto_EstadoDCDUOAO1_idx` (`idEstadoObjetoGasto` ASC) VISIBLE,
  CONSTRAINT `fk_ObjetoGasto_EstadoDCDUOAO1`
    FOREIGN KEY (`idEstadoObjetoGasto`)
    REFERENCES `poa-pacc-bd`.`EstadoDCDUOAO` (`idEstado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `poa-pacc-bd`.`TipoBitacora`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `poa-pacc-bd`.`TipoBitacora` (
  `idTipoBitacora` INT NOT NULL AUTO_INCREMENT,
  `tipoBitacora` VARCHAR(60) NOT NULL,
  `descripcion` VARCHAR(150) NULL,
  PRIMARY KEY (`idTipoBitacora`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `poa-pacc-bd`.`Bitacora`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `poa-pacc-bd`.`Bitacora` (
  `idBitacora` INT NOT NULL AUTO_INCREMENT,
  `idPersonaUsuario` INT NOT NULL,
  `idTipoBitacora` INT NOT NULL,
  `estadoInicialInformacion` JSON NULL,
  `nuevoEstadoInformacion` JSON NULL,
  `fechaHoraBitacora` DATETIME NULL,
  PRIMARY KEY (`idBitacora`),
  INDEX `fk_tbl_bitacoras_tbl_tipos_bitacoras1_idx` (`idTipoBitacora` ASC) VISIBLE,
  INDEX `fk_tbl_bitacoras_tbl_usuarios1_idx` (`idPersonaUsuario` ASC) VISIBLE,
  CONSTRAINT `fk_tbl_bitacoras_tbl_tipos_bitacoras1`
    FOREIGN KEY (`idTipoBitacora`)
    REFERENCES `poa-pacc-bd`.`TipoBitacora` (`idTipoBitacora`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_bitacoras_tbl_usuarios1`
    FOREIGN KEY (`idPersonaUsuario`)
    REFERENCES `poa-pacc-bd`.`Usuario` (`idPersonaUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `poa-pacc-bd`.`TipoSolicitudSalida`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `poa-pacc-bd`.`TipoSolicitudSalida` (
  `idTipoSolicitudSalida` INT NOT NULL AUTO_INCREMENT,
  `tipoSolicitudSalida` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`idTipoSolicitudSalida`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `poa-pacc-bd`.`SolicitudSalida`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `poa-pacc-bd`.`SolicitudSalida` (
  `idSolicitud` INT NOT NULL AUTO_INCREMENT,
  `idTipoSolicitud` INT NOT NULL,
  `idPersonaUsuario` INT NOT NULL,
  `motivoSolicitud` TEXT NOT NULL,
  `edificioAsistencia` VARCHAR(100) NOT NULL,
  `firmaDigital` VARCHAR(255) NULL,
  `documentoRespaldo` VARCHAR(255) NULL,
  `horaInicioSolicitudSalida` VARCHAR(45) NOT NULL,
  `horaFinSolicitudSalida` VARCHAR(45) NOT NULL,
  `diasSolicitados` INT NULL,
  `fechaInicioPermiso` DATE NOT NULL,
  `fechaFinPermiso` DATE NOT NULL,
  `fechaRegistroSolicitud` DATE NOT NULL,
  PRIMARY KEY (`idSolicitud`),
  INDEX `fk_Permisos_TipoPermiso1_idx` (`idTipoSolicitud` ASC) VISIBLE,
  INDEX `fk_tbl_permisos_tbl_usuarios1_idx` (`idPersonaUsuario` ASC) VISIBLE,
  CONSTRAINT `fk_Permisos_TipoPermiso1`
    FOREIGN KEY (`idTipoSolicitud`)
    REFERENCES `poa-pacc-bd`.`TipoSolicitudSalida` (`idTipoSolicitudSalida`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_permisos_tbl_usuarios1`
    FOREIGN KEY (`idPersonaUsuario`)
    REFERENCES `poa-pacc-bd`.`Usuario` (`idPersonaUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `poa-pacc-bd`.`TipoReporte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `poa-pacc-bd`.`TipoReporte` (
  `id_tipo_reporte` INT NOT NULL AUTO_INCREMENT,
  `tipo_reporte` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`id_tipo_reporte`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `poa-pacc-bd`.`EstadoReporte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `poa-pacc-bd`.`EstadoReporte` (
  `id_estado_reporte` INT NOT NULL AUTO_INCREMENT,
  `estado_reporte` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_estado_reporte`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `poa-pacc-bd`.`Reporte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `poa-pacc-bd`.`Reporte` (
  `id_reporte` INT NOT NULL AUTO_INCREMENT,
  `id_persona_usuario` INT NOT NULL,
  `id_tipo_reporte` INT NOT NULL,
  `id_estado_reporte` INT NOT NULL,
  `nombre_reporte` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(100) NOT NULL,
  `fecha_creacion` DATE NOT NULL,
  PRIMARY KEY (`id_reporte`),
  INDEX `fk_Reportes_TipoReportes1_idx` (`id_tipo_reporte` ASC) VISIBLE,
  INDEX `fk_Reportes_EstadoReportes1_idx` (`id_estado_reporte` ASC) VISIBLE,
  INDEX `fk_Reportes_Usuarios1_idx` (`id_persona_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_Reportes_TipoReportes1`
    FOREIGN KEY (`id_tipo_reporte`)
    REFERENCES `poa-pacc-bd`.`TipoReporte` (`id_tipo_reporte`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reportes_EstadoReportes1`
    FOREIGN KEY (`id_estado_reporte`)
    REFERENCES `poa-pacc-bd`.`EstadoReporte` (`id_estado_reporte`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reportes_Usuarios1`
    FOREIGN KEY (`id_persona_usuario`)
    REFERENCES `poa-pacc-bd`.`Usuario` (`idPersonaUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `poa-pacc-bd`.`TipoEstadoSolicitudSalida`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `poa-pacc-bd`.`TipoEstadoSolicitudSalida` (
  `idTipoEstadoSolicitud` INT NOT NULL AUTO_INCREMENT,
  `TipoEstadoSolicitudSalida` VARCHAR(45) NULL,
  PRIMARY KEY (`idTipoEstadoSolicitud`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `poa-pacc-bd`.`EstadoSolicitudSalida`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `poa-pacc-bd`.`EstadoSolicitudSalida` (
  `idEstadoSolicitudSalida` INT NOT NULL AUTO_INCREMENT,
  `idPersonaUsuarioVeedor` INT NULL,
  `idSolicitudSalida` INT NOT NULL,
  `idTipoEstadoSolicitud` INT NOT NULL,
  `observacionesSolicitud` VARCHAR(150) NULL,
  `fechaRevisionSolicitud` DATE NULL,
  PRIMARY KEY (`idEstadoSolicitudSalida`),
  INDEX `fk_EstadoSolicitudSalida_SolicitudSalida1_idx` (`idSolicitudSalida` ASC) VISIBLE,
  INDEX `fk_EstadoSolicitudSalida_Usuario1_idx` (`idPersonaUsuarioVeedor` ASC) VISIBLE,
  INDEX `fk_EstadoSolicitudSalida_TipoEstadoSolicitudSalida1_idx` (`idTipoEstadoSolicitud` ASC) VISIBLE,
  CONSTRAINT `fk_EstadoSolicitudSalida_SolicitudSalida1`
    FOREIGN KEY (`idSolicitudSalida`)
    REFERENCES `poa-pacc-bd`.`SolicitudSalida` (`idSolicitud`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EstadoSolicitudSalida_Usuario1`
    FOREIGN KEY (`idPersonaUsuarioVeedor`)
    REFERENCES `poa-pacc-bd`.`Usuario` (`idPersonaUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EstadoSolicitudSalida_TipoEstadoSolicitudSalida1`
    FOREIGN KEY (`idTipoEstadoSolicitud`)
    REFERENCES `poa-pacc-bd`.`TipoEstadoSolicitudSalida` (`idTipoEstadoSolicitud`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `poa-pacc-bd`.`TipoGrafico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `poa-pacc-bd`.`TipoGrafico` (
  `id_tipo_grafico` INT NOT NULL AUTO_INCREMENT,
  `tipo_grafico` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`id_tipo_grafico`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `poa-pacc-bd`.`Grafico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `poa-pacc-bd`.`Grafico` (
  `id_grafico` INT NOT NULL AUTO_INCREMENT,
  `id_persona_usuario` INT NOT NULL,
  `idTipoGraficos` INT NOT NULL,
  `nombre_grafico` VARCHAR(45) NOT NULL,
  `fecha_creacion_grafico` DATE NOT NULL,
  PRIMARY KEY (`id_grafico`),
  INDEX `fk_Graficos_TipoGraficos1_idx` (`idTipoGraficos` ASC) VISIBLE,
  INDEX `fk_Graficos_Usuarios1_idx` (`id_persona_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_Graficos_TipoGraficos1`
    FOREIGN KEY (`idTipoGraficos`)
    REFERENCES `poa-pacc-bd`.`TipoGrafico` (`id_tipo_grafico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Graficos_Usuarios1`
    FOREIGN KEY (`id_persona_usuario`)
    REFERENCES `poa-pacc-bd`.`Usuario` (`idPersonaUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `poa-pacc-bd`.`Carrera`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `poa-pacc-bd`.`Carrera` (
  `idCarrera` INT NOT NULL AUTO_INCREMENT,
  `idDepartamento` INT NOT NULL,
  `idEstadoCarrera` INT NOT NULL,
  `carrera` VARCHAR(60) NOT NULL,
  `abrev` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`idCarrera`),
  INDEX `fk_carreras_Departamentos1_idx` (`idDepartamento` ASC) VISIBLE,
  INDEX `fk_Carrera_EstadoDCD1_idx` (`idEstadoCarrera` ASC) VISIBLE,
  CONSTRAINT `fk_carreras_Departamentos1`
    FOREIGN KEY (`idDepartamento`)
    REFERENCES `poa-pacc-bd`.`Departamento` (`idDepartamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Carrera_EstadoDCD1`
    FOREIGN KEY (`idEstadoCarrera`)
    REFERENCES `poa-pacc-bd`.`EstadoDCDUOAO` (`idEstado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `poa-pacc-bd`.`ControlPresupuestoActividad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `poa-pacc-bd`.`ControlPresupuestoActividad` (
  `idControlPresupuestoActividad` INT NOT NULL AUTO_INCREMENT,
  `idEstadoPresupuestoAnual` INT NOT NULL,
  `presupuestoAnual` DECIMAL(15,2) NOT NULL,
  `fechaPresupuestoAnual` DATETIME NOT NULL,
  `estadoLlenadoActividades` TINYINT(1) NOT NULL,
  PRIMARY KEY (`idControlPresupuestoActividad`),
  INDEX `fk_ControlPresupuestoActividad_EstadoDCDUOAO1_idx` (`idEstadoPresupuestoAnual` ASC) VISIBLE,
  CONSTRAINT `fk_ControlPresupuestoActividad_EstadoDCDUOAO1`
    FOREIGN KEY (`idEstadoPresupuestoAnual`)
    REFERENCES `poa-pacc-bd`.`EstadoDCDUOAO` (`idEstado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `poa-pacc-bd`.`PresupuestoDepartamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `poa-pacc-bd`.`PresupuestoDepartamento` (
  `idPresupuestoPorDepartamento` INT NOT NULL AUTO_INCREMENT,
  `idDepartamento` INT NOT NULL,
  `idControlPresupuestoActividad` INT NOT NULL,
  `montoPresupuesto` DECIMAL(13,2) NOT NULL,
  `fechaAprobacionPresupuesto` DATETIME NOT NULL,
  INDEX `fk_tbl_presupuestos_a_deptos_tbl_departamentos1_idx` (`idDepartamento` ASC) VISIBLE,
  PRIMARY KEY (`idPresupuestoPorDepartamento`),
  INDEX `fk_PresupuestoDepartamento_ControlPresupuestoActividad1_idx` (`idControlPresupuestoActividad` ASC) VISIBLE,
  CONSTRAINT `fk_tbl_presupuestos_a_deptos_tbl_departamentos1`
    FOREIGN KEY (`idDepartamento`)
    REFERENCES `poa-pacc-bd`.`Departamento` (`idDepartamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PresupuestoDepartamento_ControlPresupuestoActividad1`
    FOREIGN KEY (`idControlPresupuestoActividad`)
    REFERENCES `poa-pacc-bd`.`ControlPresupuestoActividad` (`idControlPresupuestoActividad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `poa-pacc-bd`.`CostoActividadPorTrimestre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `poa-pacc-bd`.`CostoActividadPorTrimestre` (
  `idCostActPorTri` INT NOT NULL AUTO_INCREMENT,
  `idActividad` INT NOT NULL,
  `porcentajeTrimestre1` DECIMAL(5,2) NOT NULL,
  `Trimestre1` DECIMAL(13,2) NULL,
  `abrevTrimestre1` VARCHAR(45) NOT NULL,
  `porcentajeTrimestre2` DECIMAL(5,2) NOT NULL,
  `Trimestre2` DECIMAL(13,2) NULL,
  `abrevTrimestre2` VARCHAR(45) NOT NULL,
  `porcentajeTrimestre3` DECIMAL(5,2) NOT NULL,
  `Trimestre3` DECIMAL(13,2) NULL,
  `abrevTrimestre3` VARCHAR(45) NOT NULL,
  `porcentajeTrimestre4` DECIMAL(5,2) NOT NULL,
  `Trimestre4` DECIMAL(13,2) NULL,
  `abrevTrimestre4` VARCHAR(45) NOT NULL,
  `sumatoriaPorcentaje` DECIMAL(3,2) NULL,
  INDEX `fk_CostoActividadPorTrimestre_Actividad1_idx` (`idActividad` ASC) VISIBLE,
  PRIMARY KEY (`idCostActPorTri`),
  CONSTRAINT `fk_CostoActividadPorTrimestre_Actividad1`
    FOREIGN KEY (`idActividad`)
    REFERENCES `poa-pacc-bd`.`Actividad` (`idActividad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `poa-pacc-bd`.`TipoPresupuesto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `poa-pacc-bd`.`TipoPresupuesto` (
  `idTipoPresupuesto` INT NOT NULL AUTO_INCREMENT,
  `tipoPresupuesto` VARCHAR(80) NOT NULL,
  PRIMARY KEY (`idTipoPresupuesto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `poa-pacc-bd`.`DimensionAdmin`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `poa-pacc-bd`.`DimensionAdmin` (
  `idDimension` INT NOT NULL AUTO_INCREMENT,
  `dimensionAdministrativa` VARCHAR(255) NOT NULL,
  `idEstadoDimension` INT NOT NULL,
  PRIMARY KEY (`idDimension`),
  INDEX `fk_DimensionAdministrativa_EstadoDCDUOAO1_idx` (`idEstadoDimension` ASC) VISIBLE,
  CONSTRAINT `fk_DimensionAdministrativa_EstadoDCDUOAO1`
    FOREIGN KEY (`idEstadoDimension`)
    REFERENCES `poa-pacc-bd`.`EstadoDCDUOAO` (`idEstado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `poa-pacc-bd`.`DescripcionAdministrativa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `poa-pacc-bd`.`DescripcionAdministrativa` (
  `idDescripcionAdministrativa` INT NOT NULL AUTO_INCREMENT,
  `nombreActividad` TEXT NOT NULL,
  `idObjetoGasto` INT NOT NULL,
  `idTipoPresupuesto` INT NOT NULL,
  `idActividad` INT NOT NULL,
  `idDimensionAdministrativa` INT NOT NULL,
  `Cantidad` DECIMAL(13,2) NOT NULL,
  `Costo` DECIMAL(13,2) NOT NULL,
  `costoTotal` DECIMAL(13,2) NOT NULL,
  `mesRequerido` VARCHAR(50) NOT NULL,
  `Descripcion` JSON NULL,
  `unidadDeMedida` VARCHAR(15) NULL,
  PRIMARY KEY (`idDescripcionAdministrativa`),
  INDEX `fk_DescripcionAdministrativa_ObjetoGasto1_idx` (`idObjetoGasto` ASC) VISIBLE,
  INDEX `fk_DescripcionAdministrativa_TipoPresupuesto1_idx` (`idTipoPresupuesto` ASC) VISIBLE,
  INDEX `fk_DescripcionAdministrativa_Actividad1_idx` (`idActividad` ASC) VISIBLE,
  INDEX `fk_DescripcionAdministrativa_DimensionAdministrativa1_idx` (`idDimensionAdministrativa` ASC) VISIBLE,
  CONSTRAINT `fk_DescripcionAdministrativa_ObjetoGasto1`
    FOREIGN KEY (`idObjetoGasto`)
    REFERENCES `poa-pacc-bd`.`ObjetoGasto` (`idObjetoGasto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DescripcionAdministrativa_TipoPresupuesto1`
    FOREIGN KEY (`idTipoPresupuesto`)
    REFERENCES `poa-pacc-bd`.`TipoPresupuesto` (`idTipoPresupuesto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DescripcionAdministrativa_Actividad1`
    FOREIGN KEY (`idActividad`)
    REFERENCES `poa-pacc-bd`.`Actividad` (`idActividad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DescripcionAdministrativa_DimensionAdministrativa1`
    FOREIGN KEY (`idDimensionAdministrativa`)
    REFERENCES `poa-pacc-bd`.`DimensionAdmin` (`idDimension`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `poa-pacc-bd`.`EstadoInforme`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `poa-pacc-bd`.`EstadoInforme` (
  `idEstadoInforme` INT NOT NULL AUTO_INCREMENT,
  `Estado` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`idEstadoInforme`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `poa-pacc-bd`.`Informe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `poa-pacc-bd`.`Informe` (
  `idInforme` INT NOT NULL AUTO_INCREMENT,
  `idPersonaUsuarioEnvia` INT NOT NULL,
  `idPersonaUsuarioAprueba` INT NULL,
  `idEstadoInforme` INT NOT NULL,
  `tituloInforme` VARCHAR(255) NOT NULL,
  `informe` VARCHAR(255) NOT NULL,
  `descripcionInforme` VARCHAR(255) NOT NULL,
  `fechaRecibido` DATE NOT NULL,
  `fechaAprobado` DATE NULL,
  PRIMARY KEY (`idInforme`),
  INDEX `fk_Informes_Usuario1_idx` (`idPersonaUsuarioEnvia` ASC) VISIBLE,
  INDEX `fk_Informes_Usuario2_idx` (`idPersonaUsuarioAprueba` ASC) VISIBLE,
  INDEX `fk_Informes_EstadoInformes1_idx` (`idEstadoInforme` ASC) VISIBLE,
  CONSTRAINT `fk_Informes_Usuario1`
    FOREIGN KEY (`idPersonaUsuarioEnvia`)
    REFERENCES `poa-pacc-bd`.`Usuario` (`idPersonaUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Informes_Usuario2`
    FOREIGN KEY (`idPersonaUsuarioAprueba`)
    REFERENCES `poa-pacc-bd`.`Usuario` (`idPersonaUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Informes_EstadoInformes1`
    FOREIGN KEY (`idEstadoInforme`)
    REFERENCES `poa-pacc-bd`.`EstadoInforme` (`idEstadoInforme`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `poa-pacc-bd`.`DepartamentoPorDimension`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `poa-pacc-bd`.`DepartamentoPorDimension` (
  `idDepartamentoDimension` INT NOT NULL AUTO_INCREMENT,
  `idDimension` INT NOT NULL,
  `idDepartamento` INT NOT NULL,
  `estadoActividad` VARCHAR(45) NULL,
  `fecha` DATETIME NULL,
  PRIMARY KEY (`idDepartamentoDimension`),
  INDEX `fk_DepartamentoPorDimension_Departamento1_idx` (`idDepartamento` ASC) VISIBLE,
  CONSTRAINT `fk_DepartamentoPorDimension_DimensionEstrategica1`
    FOREIGN KEY (`idDimension`)
    REFERENCES `poa-pacc-bd`.`DimensionEstrategica` (`idDimension`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DepartamentoPorDimension_Departamento1`
    FOREIGN KEY (`idDepartamento`)
    REFERENCES `poa-pacc-bd`.`Departamento` (`idDepartamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `poa-pacc-bd`.`LlenadoActividadDimension`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `poa-pacc-bd`.`LlenadoActividadDimension` (
  `idLlenadoDimension` INT NOT NULL AUTO_INCREMENT,
  `TipoUsuario_idTipoUsuario` INT NOT NULL,
  `valorLlenadoDimensionInicial` INT NOT NULL,
  `valorLlenadoDimensionFinal` INT NOT NULL,
  PRIMARY KEY (`idLlenadoDimension`),
  INDEX `fk_LlenadoActividadDimension_TipoUsuario1_idx` (`TipoUsuario_idTipoUsuario` ASC) VISIBLE,
  CONSTRAINT `fk_LlenadoActividadDimension_TipoUsuario1`
    FOREIGN KEY (`TipoUsuario_idTipoUsuario`)
    REFERENCES `poa-pacc-bd`.`TipoUsuario` (`idTipoUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `poa-pacc-bd`.`GestionDocente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `poa-pacc-bd`.`GestionDocente` (
  `idGestionDocentes` INT NOT NULL AUTO_INCREMENT,
  `idPersonaUsuario` INT NOT NULL,
  `idPersonaUsuarioModificacion` INT NOT NULL,
  `idTrimestre` INT NOT NULL,
  `numDocenteMaestria` INT NOT NULL,
  `fechaRegistro` DATE NOT NULL,
  `fechaModificacion` DATE NULL,
  `documentoRespaldo` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`idGestionDocentes`),
  INDEX `fk_GestionDocentes_Usuario1_idx` (`idPersonaUsuario` ASC) VISIBLE,
  INDEX `fk_GestionDocentes_Trimestre1_idx` (`idTrimestre` ASC) VISIBLE,
  INDEX `fk_GestionDocente_Usuario1_idx` (`idPersonaUsuarioModificacion` ASC) VISIBLE,
  CONSTRAINT `fk_GestionDocentes_Usuario1`
    FOREIGN KEY (`idPersonaUsuario`)
    REFERENCES `poa-pacc-bd`.`Usuario` (`idPersonaUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_GestionDocentes_Trimestre1`
    FOREIGN KEY (`idTrimestre`)
    REFERENCES `poa-pacc-bd`.`Trimestre` (`idTrimestre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_GestionDocente_Usuario1`
    FOREIGN KEY (`idPersonaUsuarioModificacion`)
    REFERENCES `poa-pacc-bd`.`Usuario` (`idPersonaUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `poa-pacc-bd`.`GestionGraduado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `poa-pacc-bd`.`GestionGraduado` (
  `idGestionGraduado` INT NOT NULL AUTO_INCREMENT,
  `idPersonaUsuarioRegistro` INT NOT NULL,
  `idPersonaUsuarioModificacion` INT NOT NULL,
  `idTrimestre` INT NOT NULL,
  `numGraduado` INT NOT NULL,
  `fechaRegistro` DATE NOT NULL,
  `fechaModificacion` DATE NULL,
  `documentoRespaldo` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`idGestionGraduado`),
  INDEX `fk_GestionGraduado_Usuario1_idx` (`idPersonaUsuarioRegistro` ASC) VISIBLE,
  INDEX `fk_GestionGraduado_Trimestre1_idx` (`idTrimestre` ASC) VISIBLE,
  INDEX `fk_GestionGraduado_Usuario2_idx` (`idPersonaUsuarioModificacion` ASC) VISIBLE,
  CONSTRAINT `fk_GestionGraduado_Usuario1`
    FOREIGN KEY (`idPersonaUsuarioRegistro`)
    REFERENCES `poa-pacc-bd`.`Usuario` (`idPersonaUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_GestionGraduado_Trimestre1`
    FOREIGN KEY (`idTrimestre`)
    REFERENCES `poa-pacc-bd`.`Trimestre` (`idTrimestre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_GestionGraduado_Usuario2`
    FOREIGN KEY (`idPersonaUsuarioModificacion`)
    REFERENCES `poa-pacc-bd`.`Usuario` (`idPersonaUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `poa-pacc-bd`.`GestionMatriculado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `poa-pacc-bd`.`GestionMatriculado` (
  `idGestionMatriculado` INT NOT NULL AUTO_INCREMENT,
  `idPersonaUsuarioRegistro` INT NOT NULL,
  `idPersonaUsuarioModificacion` INT NOT NULL,
  `idTrimestre` INT NOT NULL,
  `numMatriculado` INT NOT NULL,
  `fechaRegistro` DATE NOT NULL,
  `fechaModificacion` DATE NULL,
  `documentoRespaldo` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`idGestionMatriculado`),
  INDEX `fk_GestionMatriculado_Usuario1_idx` (`idPersonaUsuarioRegistro` ASC) VISIBLE,
  INDEX `fk_GestionMatriculado_Trimestre1_idx` (`idTrimestre` ASC) VISIBLE,
  INDEX `fk_GestionMatriculado_Usuario2_idx` (`idPersonaUsuarioModificacion` ASC) VISIBLE,
  CONSTRAINT `fk_GestionMatriculado_Usuario1`
    FOREIGN KEY (`idPersonaUsuarioRegistro`)
    REFERENCES `poa-pacc-bd`.`Usuario` (`idPersonaUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_GestionMatriculado_Trimestre1`
    FOREIGN KEY (`idTrimestre`)
    REFERENCES `poa-pacc-bd`.`Trimestre` (`idTrimestre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_GestionMatriculado_Usuario2`
    FOREIGN KEY (`idPersonaUsuarioModificacion`)
    REFERENCES `poa-pacc-bd`.`Usuario` (`idPersonaUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `poa-pacc-bd`.`Trimestre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `poa-pacc-bd`.`Trimestre` (
  `idTrimestre` INT NOT NULL AUTO_INCREMENT,
  `nombreTrimeste` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTrimestre`),
  UNIQUE INDEX `nombreTrimeste_UNIQUE` (`nombreTrimeste` ASC) VISIBLE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
