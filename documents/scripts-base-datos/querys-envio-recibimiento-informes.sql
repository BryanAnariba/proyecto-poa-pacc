-- La primera sección encerrada entre ## solo se ejecutara hasta que se hagan los 
-- cambios definitivos en el modelo y script de la base de datos
-- ###########################################################################################################
RENAME TABLE `poa-pacc-bd`.`estadoinformes` TO `poa-pacc-bd`.`estadoinforme`;

RENAME TABLE `poa-pacc-bd`.`informes` TO `poa-pacc-bd`.`informe`;

ALTER TABLE `informe` CHANGE `idInformes` `idInforme` INT(11) NOT NULL;

ALTER TABLE `informe` CHANGE `idPersonaUsuarioEnvia` `idPersonaUsuarioEnvia` INT(11) NOT NULL;

ALTER TABLE `informe` CHANGE `idInforme` `idInforme` INT(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `informe` CHANGE `idEstadoInformes` `idEstadoInforme` INT(11) NOT NULL;

ALTER TABLE `estadoinforme` CHANGE `idEstadoInformes` `idEstadoInforme` INT(11) NOT NULL;

ALTER TABLE `estadoinforme` CHANGE `idEstadoInforme` `idEstadoInforme` INT(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `informe` ADD `tituloInforme` VARCHAR(150) NOT NULL AFTER `idEstadoInforme`;

ALTER TABLE `informe` ADD `informe` VARCHAR(255) NOT NULL AFTER `tituloInforme`;

ALTER TABLE `informe` ADD `descripcionInforme` VARCHAR(255) NOT NULL AFTER `informe`;
-- ################################################################################################################



-- inserción en tabla EstadoInforme
INSERT INTO `estadoinforme` (`idEstadoInforme`, `Estado`) VALUES (NULL, 'Pendiente'), (NULL, 'Aprobado');

