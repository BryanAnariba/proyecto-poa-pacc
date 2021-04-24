-- La primera sección encerrada entre ## solo se ejecutara hasta que se hagan los 
-- cambios definitivos en el modelo y script de la base de datos
-- ###########################################################################################################
RENAME TABLE `poa-pacc-bd`.`EstadoInforme` TO `poa-pacc-bd`.`estadoinforme`;

RENAME TABLE `poa-pacc-bd`.`Informe` TO `poa-pacc-bd`.`informe`;

ALTER TABLE `Informe` CHANGE `idInformes` `idInforme` INT(11) NOT NULL;

ALTER TABLE `Informe` CHANGE `idPersonaUsuarioEnvia` `idPersonaUsuarioEnvia` INT(11) NOT NULL;

ALTER TABLE `Informe` CHANGE `idInforme` `idInforme` INT(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `Informe` CHANGE `idEstadoInformes` `idEstadoInforme` INT(11) NOT NULL;

ALTER TABLE `EstadoInforme` CHANGE `idEstadoInformes` `idEstadoInforme` INT(11) NOT NULL;

ALTER TABLE `EstadoInforme` CHANGE `idEstadoInforme` `idEstadoInforme` INT(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `Informe` ADD `tituloInforme` VARCHAR(150) NOT NULL AFTER `idEstadoInforme`;

ALTER TABLE `Informe` ADD `informe` VARCHAR(255) NOT NULL AFTER `tituloInforme`;

ALTER TABLE `Informe` ADD `descripcionInforme` VARCHAR(255) NOT NULL AFTER `informe`;
-- ################################################################################################################



-- inserción en tabla EstadoInforme
INSERT INTO `EstadoInforme` (`idEstadoInforme`, `Estado`) VALUES (NULL, 'Pendiente'), (NULL, 'Aprobado');

