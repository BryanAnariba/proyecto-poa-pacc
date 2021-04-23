drop trigger if exists `insertarGestion`;
DELIMITER //
create trigger `insertarGestion` 
	after insert on `Gestion`
    for each row 
begin
	insert into `poa-pacc-bd`.`TipoAccionGestion` (idGestion,idAccion,idPersonaUsuario,fecha) 
	values (new.idGestion,1,@persona,now());
end 
//

drop trigger if exists `modificarGestion`;
DELIMITER //
create trigger `modificarGestion` 
	after update on `Gestion`
    for each row 
begin
	IF NOT EXISTS( SELECT 1 FROM TipoAccionGestion WHERE idGestion = new.idGestion and idAccion=2) THEN
		insert into `poa-pacc-bd`.`TipoAccionGestion` (idGestion,idAccion,idPersonaUsuario,fecha) 
		values (new.idGestion,2,@persona,now());
	else
		update TipoAccionGestion
		set fecha = now(), idPersonaUsuario=@persona
		where idGestion=new.idGestion and idAccion=2;
	end if;
end//