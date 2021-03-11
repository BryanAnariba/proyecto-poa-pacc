drop trigger if exists `insertarGestion`;
DELIMITER //
create trigger `insertarGestion` 
	after insert on `gestion`
    for each row 
begin
	insert into `poa-pacc-bd`.`tipoacciongestion` (idGestion,idAccion,idPersonaUsuario,fecha) 
	values (new.idGestion,1,@persona,now());
end 
//

drop trigger if exists `modificarGestion`;
DELIMITER //
create trigger `modificarGestion` 
	after update on `gestion`
    for each row 
begin
	IF NOT EXISTS( SELECT 1 FROM tipoacciongestion WHERE idGestion = new.idGestion and idAccion=2) THEN
		insert into `poa-pacc-bd`.`tipoacciongestion` (idGestion,idAccion,idPersonaUsuario,fecha) 
		values (new.idGestion,2,@persona,now());
	else
		update tipoacciongestion
		set fecha = now(), idPersonaUsuario=@persona
		where idGestion=new.idGestion and idAccion=2;
	end if;
end//