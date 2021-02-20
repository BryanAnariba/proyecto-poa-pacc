-- <--Obtener carreras-->
SELECT ca.idCarrera, ca.carrera, ca.abrev, dep.nombreDepartamento, es.estado
    from carrera as ca
    inner join departamento as dep
        on dep.idDepartamento=ca.idDepartamento
    inner join estadodcduoao as es
        on es.idEstado=ca.idEstadoCarrera

-- <--Obtener Departamentos-->
SELECT * FROM departamento

-- <--Obtener Estados-->
SELECT * FROM estadodcduoao

-- <--Obtener Carreras por departamento-->
SELECT * from carrera where idDepartamento=$idDepartamento

-- <--Obtener Carreras por Id-->
SELECT * from carrera where idCarrera=$this->idCarrera

-- <--Llamar procedimiento almacenado SP_Registrar_Carrera-->
CALL SP_Registrar_Carrera (0, '$this->Carrera', '$this->Abreviatura', $this->idDepartamento, $this->idEstado, 'insert', @resp)

-- <--Obtener todos los objetos de gasto-->
SELECT * from 
    objetogasto as og
    inner join estadodcduoao as es
    on og.idEstadoObjetoGasto=es.idEstado
    order by og.codigoObjetoGasto asc

-- <--Llamar procedimiento almacenado SP_Registrar_Objeto-->
CALL SP_Registrar_Objeto (0, '$this->ObjetoDeGasto', '$this->Abreviatura', '$this->CodigoObjeto', $this->idEstado, 'insert', @resp)