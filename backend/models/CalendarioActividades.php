<?php
    if (!isset($_SESSION)) {
        session_start();
    }
    require_once('../../validators/validators.php');
    
    class Calendario { 
        protected $idActividad;
        protected $actividadAdmin;
        protected $idDimension;
        protected $Mes;
        protected $Anio;
        protected $Depa;

        protected function _construct($idActividad = null,$Mes = null,$idDimension = null,$Depa = null,$Anio = null, $actividadAdmin = null){
            $this->idActividad = $idActividad;
            $this->Mes = $Mes;
            $this->Depa = $Depa;
            $this->idDimension = $idDimension;
            $this->Anio = $Anio;
            $this->$actividadAdmin = $actividadAdmin;
        }

        public function getActividadAdmin(){
            return $this->actividadAdmin;
        }

        public function setActividadAdmin($actividadAdmin){
            $this->actividadAdmin = $actividadAdmin;
            return $this;
        }

        public function getAnio(){
            return $this->Anio;
        }

        public function setAnio($Anio){
            $this->Anio = $Anio;
            return $this;
        }

        public function getIdDimension(){
            return $this->idDimension;
        }

        public function setIdDimension($idDimension){
            $this->idDimension = $idDimension;
            return $this;
        }

        public function getIdActividad(){
            return $this->idActividad;
        }

        public function setIdActividad($idActividad){
            $this->idActividad = $idActividad;
            return $this;
        }
        
        public function getMes(){
            return $this->Mes;
        }

        public function setMes($Mes){
            $this->Mes = $Mes;
            return $this;
        }

        public function getDepa(){
            return $this->Depa;
        }

        public function setDepa($Depa){
            $this->Depa = $Depa;
            return $this;
        }

        public function getDimensionEstrategicas () {
            try {
                $this->conexionBD = new Conexion();
                $this->consulta = $this->conexionBD->connect();
                $stmt = $this->consulta->prepare('SELECT * FROM dimensionestrategica WHERE idEstadoDimension=1');
                if ($stmt->execute()) {
                    return array(
                        'status' => SUCCESS_REQUEST,
                        'data' => $stmt->fetchAll(PDO::FETCH_OBJ)
                    );
                } else {
                    return array(
                        'status'=> BAD_REQUEST,
                        'data' => array('message' => 'Ha ocurrido un error al listar las actividades')
                    );
                }
            } catch (PDOException $ex) {
                return array(
                    'status'=> INTERNAL_SERVER_ERROR,
                    'data' => array('message' => $ex->getMessage())
                );
            } finally {
                $this->conexionBD = null;
            }
        }

        public function getActividadDescripcionAdmin () {
            try {
                $this->conexionBD = new Conexion();
                $this->consulta = $this->conexionBD->connect();
                $stmt = $this->consulta->prepare("select descripcionadministrativa.idDimensionAdministrativa,descripcionadministrativa.idDescripcionAdministrativa,descripcionadministrativa.nombreActividad,descripcionadministrativa.Descripcion,descripcionadministrativa.Cantidad,descripcionadministrativa.Costo,descripcionadministrativa.CostoTotal,
                                                        tipopresupuesto.tipoPresupuesto,objetogasto.abrev as ObjetoGasto,objetogasto.DescripcionCuenta,dimensionestrategica.dimensionEstrategica,descripcionadministrativa.mesRequerido
                                                from descripcionadministrativa
                                                inner join tipopresupuesto
                                                on tipoPresupuesto.idTipoPresupuesto=descripcionadministrativa.idTipoPresupuesto
                                                inner join objetogasto
                                                on objetogasto.idObjetoGasto=descripcionadministrativa.idObjetoGasto
                                                inner join actividad
                                                on actividad.idActividad=descripcionadministrativa.idActividad
                                                inner join dimensionestrategica
                                                on dimensionEstrategica.idDimension=actividad.idDimension
                                                where descripcionadministrativa.idDescripcionAdministrativa=$this->actividadAdmin"
                                                );
                if ($stmt->execute()) {
                    return array(
                        'status' => SUCCESS_REQUEST,
                        'data' => $stmt->fetchAll(PDO::FETCH_OBJ)
                    );
                } else {
                    return array(
                        'status'=> BAD_REQUEST,
                        'data' => array('message' => 'Ha ocurrido un error al listar las actividades')
                    );
                }
            } catch (PDOException $ex) {
                return array(
                    'status'=> INTERNAL_SERVER_ERROR,
                    'data' => array('message' => $ex->getMessage())
                );
            } finally {
                $this->conexionBD = null;
            }
        }

        public function getActividadDescripcionAdminTodas () {
            try {
                $this->conexionBD = new Conexion();
                $this->consulta = $this->conexionBD->connect();
                $stmt = $this->consulta->prepare("select year(actividad.fechaCreacionActividad) as anio,descripcionadministrativa.idDimensionAdministrativa,descripcionadministrativa.idDescripcionAdministrativa,
                                                    descripcionadministrativa.nombreActividad,descripcionadministrativa.Descripcion,descripcionadministrativa.Cantidad,descripcionadministrativa.Costo,descripcionadministrativa.CostoTotal,
                                                    tipopresupuesto.tipoPresupuesto,objetogasto.abrev as ObjetoGasto,objetogasto.DescripcionCuenta,dimensionestrategica.dimensionEstrategica,descripcionadministrativa.mesRequerido,
                                                    departamento.idDepartamento
                                            from descripcionadministrativa
                                            inner join tipopresupuesto
                                            on tipoPresupuesto.idTipoPresupuesto=descripcionadministrativa.idTipoPresupuesto
                                            inner join objetogasto
                                            on objetogasto.idObjetoGasto=descripcionadministrativa.idObjetoGasto
                                            inner join actividad
                                            on actividad.idActividad=descripcionadministrativa.idActividad
                                            inner join dimensionestrategica
                                            on dimensionEstrategica.idDimension=actividad.idDimension
                                            inner join departamentopordimension
                                            on departamentopordimension.idDimension=dimensionestrategica.idDimension
                                            inner join departamento
                                            on departamento.idDepartamento=departamentopordimension.idDepartamento
                                            where departamento.idDepartamento=(select idDepartamento from usuario u where u.idPersonaUsuario = actividad.idPersonaUsuario)
                                            and YEAR(actividad.fechaCreacionActividad) = YEAR(departamentopordimension.fecha);"
                                                );
                if ($stmt->execute()) {
                    return array(
                        'status' => SUCCESS_REQUEST,
                        'data' => $stmt->fetchAll(PDO::FETCH_OBJ)
                    );
                } else {
                    return array(
                        'status'=> BAD_REQUEST,
                        'data' => array('message' => 'Ha ocurrido un error al listar las actividades')
                    );
                }
            } catch (PDOException $ex) {
                return array(
                    'status'=> INTERNAL_SERVER_ERROR,
                    'data' => array('message' => $ex->getMessage())
                );
            } finally {
                $this->conexionBD = null;
            }
        }

        public function getAnioPresupuesto () {
            try {
                $this->conexionBD = new Conexion();
                $this->consulta = $this->conexionBD->connect();
                $stmt = $this->consulta->prepare('SELECT year(fechaPresupuestoAnual) FROM controlpresupuestoactividad
                                                order by year(fechaPresupuestoAnual) desc;'
                                                );
                if ($stmt->execute()) {
                    return array(
                        'status' => SUCCESS_REQUEST,
                        'data' => $stmt->fetchAll(PDO::FETCH_OBJ)
                    );
                } else {
                    return array(
                        'status'=> BAD_REQUEST,
                        'data' => array('message' => 'Ha ocurrido un error al listar las actividades')
                    );
                }
            } catch (PDOException $ex) {
                return array(
                    'status'=> INTERNAL_SERVER_ERROR,
                    'data' => array('message' => $ex->getMessage())
                );
            } finally {
                $this->conexionBD = null;
            }
        }

        public function getActividades () {
            try {
                $this->conexionBD = new Conexion();
                $this->consulta = $this->conexionBD->connect();
                $stmt = $this->consulta->prepare('WITH CTE_Actividad_Resultado AS 
                                                (
                                                    SELECT a.idActividad,a.actividad,a.correlativoActividad,a.fechaCreacionActividad,ta.TipoActividad,a.idPersonaUsuario
                                                    FROM actividad a
                                                    inner join resultadoinstitucional ri on a.idResultadoInstitucional=ri.idResultadoInstitucional
                                                    inner join tipoactividad ta on ta.idTipoActividad=a.idTipoActividad
                                                ), CTE_Actividad_AREAESTRATEGICA AS
                                                (
                                                    SELECT a.idActividad
                                                    FROM actividad a
                                                    inner join areaestrategica ae on ae.idAreaEstrategica=a.idAreaEstrategica
                                                ), CTE_Actividad_ObjetivoInstitucional AS
                                                (
                                                    SELECT a.idActividad
                                                    FROM actividad a
                                                    inner join objetivoinstitucional oi on a.idObjetivoInstitucional=oi.idObjetivoInstitucional
                                                ), CTE_Actividad_DimensionEstrategica AS
                                                (
                                                    SELECT a.idActividad,d.idDepartamento,d.nombreDepartamento,dpd.fecha,dpd.estadoActividad,de.dimensionEstrategica,de.idDimension
                                                    FROM actividad a
                                                    inner join dimensionestrategica de on de.idDimension= a.idDimension
                                                    inner join departamentopordimension dpd on dpd.idDimension=de.idDimension
                                                    inner join departamento d on d.idDepartamento=dpd.idDepartamento
                                                )
                                                select 
                                                    r.idActividad,r.actividad,r.correlativoActividad,de.nombreDepartamento
                                                    ,(SELECT count(*) FROM descripcionadministrativa da where da.idActividad=r.idActividad) as NumeroDeActividadesDefinidas
                                                    ,de.dimensionEstrategica,r.TipoActividad
                                                from CTE_Actividad_Resultado r
                                                inner join CTE_Actividad_AREAESTRATEGICA a
                                                on a.idActividad=r.idActividad
                                                inner join CTE_Actividad_ObjetivoInstitucional o
                                                on r.idActividad=o.idActividad
                                                inner join CTE_Actividad_DimensionEstrategica de
                                                on r.idActividad=de.idActividad
                                                where YEAR(r.fechaCreacionActividad) = YEAR(de.fecha) and YEAR(de.fecha)=:Anio
                                                and YEAR(r.fechaCreacionActividad)=:Anio2 and de.estadoActividad="Activo"
                                                and de.idDimension=:idDimension 
                                                and de.idDepartamento = (select idDepartamento from usuario u where u.idPersonaUsuario = r.idPersonaUsuario);'
                                                );
                $stmt->bindValue(':idDimension', $this->idDimension);
                $stmt->bindValue(':Anio', $this->Anio);
                $stmt->bindValue(':Anio2', $this->Anio);
                if ($stmt->execute()) {
                    return array(
                        'status' => SUCCESS_REQUEST,
                        'data' => $stmt->fetchAll(PDO::FETCH_OBJ)
                    );
                } else {
                    return array(
                        'status'=> BAD_REQUEST,
                        'data' => array('message' => 'Ha ocurrido un error al listar las actividades')
                    );
                }
            } catch (PDOException $ex) {
                return array(
                    'status'=> INTERNAL_SERVER_ERROR,
                    'data' => array('message' => $ex->getMessage())
                );
            } finally {
                $this->conexionBD = null;
            }
        }

        public function getActividadPorId () {
            try {
                $this->conexionBD = new Conexion();
                $this->consulta = $this->conexionBD->connect();
                $stmt = $this->consulta->prepare('WITH CTE_Actividad_Resultado AS 
                                                (
                                                    SELECT a.idActividad,a.actividad,a.correlativoActividad,ta.TipoActividad
                                                    FROM actividad a
                                                    inner join resultadoinstitucional ri on a.idResultadoInstitucional=ri.idResultadoInstitucional
                                                    inner join tipoactividad ta on ta.idTipoActividad=a.idTipoActividad
                                                ), CTE_Actividad_AREAESTRATEGICA AS
                                                (
                                                    SELECT a.idActividad,ae.areaEstrategica
                                                    FROM actividad a
                                                    inner join areaestrategica ae on ae.idAreaEstrategica=a.idAreaEstrategica
                                                ), CTE_Actividad_ObjetivoInstitucional AS
                                                (
                                                    SELECT a.idActividad,oi.objetivoInstitucional
                                                    FROM actividad a
                                                    inner join objetivoinstitucional oi on a.idObjetivoInstitucional=oi.idObjetivoInstitucional
                                                ), CTE_Actividad_DimensionEstrategica AS
                                                (
                                                    SELECT a.idActividad,de.dimensionEstrategica,d.nombreDepartamento
                                                    FROM actividad a
                                                    inner join dimensionestrategica de on de.idDimension= a.idDimension
                                                    inner join departamentopordimension dpd on dpd.idDimension=de.idDimension
                                                    inner join departamento d on d.idDepartamento=dpd.idDepartamento
                                                ), CTE_Conteo_Actividades AS
                                                (
                                                    SELECT * FROM descripcionadministrativa
                                                )
                                                select distinct
                                                    r.idActividad,r.actividad,r.correlativoActividad,de.nombreDepartamento,a.areaEstrategica,o.objetivoInstitucional,de.dimensionEstrategica
                                                    ,(SELECT count(*) FROM descripcionadministrativa da where da.idActividad=r.idActividad) as NumeroDeActividadesDefinidas
                                                    ,de.dimensionEstrategica,r.TipoActividad
                                                from CTE_Actividad_Resultado r
                                                inner join CTE_Actividad_AREAESTRATEGICA a
                                                on a.idActividad=r.idActividad
                                                inner join CTE_Actividad_ObjetivoInstitucional o
                                                on r.idActividad=o.idActividad
                                                inner join CTE_Actividad_DimensionEstrategica de
                                                on r.idActividad=de.idActividad
                                                where a.idActividad=:idActividad;'
                                                );
                $stmt->bindValue(':idActividad', $this->idActividad);
                if ($stmt->execute()) {
                    return array(
                        'status' => SUCCESS_REQUEST,
                        'data' => $stmt->fetchAll(PDO::FETCH_OBJ)
                    );
                } else {
                    return array(
                        'status'=> BAD_REQUEST,
                        'data' => array('message' => 'Ha ocurrido un error al obtener informacion de la actividad')
                    );
                }
            } catch (PDOException $ex) {
                return array(
                    'status'=> INTERNAL_SERVER_ERROR,
                    'data' => array('message' => $ex->getMessage())
                );
            } finally {
                $this->conexionBD = null;
            }
        }

        public function getInfoActPorId () {
            try {
                $this->conexionBD = new Conexion();
                $this->consulta = $this->conexionBD->connect();
                $stmt = $this->consulta->prepare('WITH CTE_Actividad_Resultado AS 
                                                (
                                                    SELECT a.idActividad,a.CostoTotal,a.fechaCreacionActividad,ri.resultadoInstitucional,a.resultadosUnidad,a.indicadoresResultado
                                                    ,a.justificacionActividad,a.medioVerificacionActividad,a.poblacionObjetivoActividad,a.responsableActividad
                                                    FROM actividad a
                                                    inner join resultadoinstitucional ri on a.idResultadoInstitucional=ri.idResultadoInstitucional
                                                ), CTE_Actividad_AREAESTRATEGICA AS
                                                (
                                                    SELECT a.idActividad
                                                    FROM actividad a
                                                    inner join areaestrategica ae on ae.idAreaEstrategica=a.idAreaEstrategica
                                                ), CTE_Actividad_ObjetivoInstitucional AS
                                                (
                                                    SELECT a.idActividad
                                                    FROM actividad a
                                                    inner join objetivoinstitucional oi on a.idObjetivoInstitucional=oi.idObjetivoInstitucional
                                                ), CTE_Actividad_DimensionEstrategica AS
                                                (
                                                    SELECT a.idActividad,dpd.fecha,dpd.estadoActividad,de.dimensionEstrategica
                                                    FROM actividad a
                                                    inner join dimensionestrategica de on de.idDimension= a.idDimension
                                                    inner join departamentopordimension dpd on dpd.idDimension=de.idDimension
                                                    inner join departamento d on d.idDepartamento=dpd.idDepartamento
                                                ), CTE_Conteo_Actividades AS
                                                (
                                                    SELECT * FROM descripcionadministrativa
                                                )
                                                select 
                                                    r.resultadoInstitucional,r.resultadosUnidad,r.indicadoresResultado,
                                                    r.justificacionActividad,r.medioVerificacionActividad,r.poblacionObjetivoActividad
                                                    ,de.dimensionEstrategica,r.responsableActividad,r.CostoTotal,capt.Trimestre1,capt.Trimestre2,capt.Trimestre3,capt.Trimestre4
                                                from CTE_Actividad_Resultado r
                                                inner join CTE_Actividad_AREAESTRATEGICA a
                                                on a.idActividad=r.idActividad
                                                inner join CTE_Actividad_ObjetivoInstitucional o
                                                on r.idActividad=o.idActividad
                                                inner join CTE_Actividad_DimensionEstrategica de
                                                on r.idActividad=de.idActividad
                                                inner join costoactividadportrimestre capt
                                                on capt.idActividad=r.idActividad
                                                where YEAR(r.fechaCreacionActividad) = YEAR(de.fecha) and de.estadoActividad="Activo"
                                                and r.idActividad=:idActividad;'
                                                );
                $stmt->bindValue(':idActividad', $this->idActividad);
                if ($stmt->execute()) {
                    return array(
                        'status' => SUCCESS_REQUEST,
                        'data' => $stmt->fetchAll(PDO::FETCH_OBJ)
                    );
                } else {
                    return array(
                        'status'=> BAD_REQUEST,
                        'data' => array('message' => 'Ha ocurrido un error al obtener los resultados de la unidad de la actividad')
                    );
                }
            } catch (PDOException $ex) {
                return array(
                    'status'=> INTERNAL_SERVER_ERROR,
                    'data' => array('message' => $ex->getMessage())
                );
            } finally {
                $this->conexionBD = null;
            }
        }
        public function obtenerActividadesPlanif () {
            try {
                $this->conexionBD = new Conexion();
                $this->consulta = $this->conexionBD->connect();
                $stmt = $this->consulta->prepare('SELECT * FROM descripcionadministrativa where idActividad=:idActividad');
                $stmt->bindValue(':idActividad', $this->idActividad);
                if ($stmt->execute()) {
                    return array(
                        'status' => SUCCESS_REQUEST,
                        'data' => $stmt->fetchAll(PDO::FETCH_OBJ)
                    );
                } else {
                    return array(
                        'status'=> BAD_REQUEST,
                        'data' => array('message' => 'Ha ocurrido un error al obtener informacion de la actividad')
                    );
                }
            } catch (PDOException $ex) {
                return array(
                    'status'=> INTERNAL_SERVER_ERROR,
                    'data' => array('message' => $ex->getMessage())
                );
            } finally {
                $this->conexionBD = null;
            }
        }
        public function obtenerActividadesPlanifPorId () {
            try {
                $this->conexionBD = new Conexion();
                $this->consulta = $this->conexionBD->connect();
                $stmt = $this->consulta->prepare('SELECT * FROM descripcionadministrativa 
                                                inner join tipopresupuesto 
                                                on tipoPresupuesto.idTipoPresupuesto=descripcionadministrativa.idTipoPresupuesto 
                                                inner join objetogasto 
                                                on objetogasto.idObjetoGasto=descripcionadministrativa.idObjetoGasto 
                                                inner join actividad
                                                on actividad.idActividad=descripcionadministrativa.idActividad
                                                inner join dimensionestrategica
                                                on dimensionEstrategica.idDimension=actividad.idDimension
                                                where idDescripcionAdministrativa=:idActividad');
                $stmt->bindValue(':idActividad', $this->idActividad);
                if ($stmt->execute()) {
                    return array(
                        'status' => SUCCESS_REQUEST,
                        'data' => $stmt->fetchAll(PDO::FETCH_OBJ)
                    );
                } else {
                    return array(
                        'status'=> BAD_REQUEST,
                        'data' => array('message' => 'Ha ocurrido un error al obtener informacion de la actividad')
                    );
                }
            } catch (PDOException $ex) {
                return array(
                    'status'=> INTERNAL_SERVER_ERROR,
                    'data' => array('message' => $ex->getMessage())
                );
            } finally {
                $this->conexionBD = null;
            }
        }

        public function getActividadesPorDepa () {
            try {
                $this->conexionBD = new Conexion();
                $this->consulta = $this->conexionBD->connect();
                $stmt = $this->consulta->prepare('WITH CTE_Actividad_Resultado AS 
                                                (
                                                    SELECT a.idActividad,a.actividad,a.correlativoActividad,a.fechaCreacionActividad,ta.TipoActividad,a.idPersonaUsuario
                                                    FROM actividad a
                                                    inner join resultadoinstitucional ri on a.idResultadoInstitucional=ri.idResultadoInstitucional
                                                    inner join tipoactividad ta on ta.idTipoActividad=a.idTipoActividad
                                                ), CTE_Actividad_AREAESTRATEGICA AS
                                                (
                                                    SELECT a.idActividad
                                                    FROM actividad a
                                                    inner join areaestrategica ae on ae.idAreaEstrategica=a.idAreaEstrategica
                                                ), CTE_Actividad_ObjetivoInstitucional AS
                                                (
                                                    SELECT a.idActividad
                                                    FROM actividad a
                                                    inner join objetivoinstitucional oi on a.idObjetivoInstitucional=oi.idObjetivoInstitucional
                                                ), CTE_Actividad_DimensionEstrategica AS
                                                (
                                                    SELECT a.idActividad,d.idDepartamento,d.nombreDepartamento,dpd.fecha,dpd.estadoActividad,de.dimensionEstrategica,de.idDimension
                                                    FROM actividad a
                                                    inner join dimensionestrategica de on de.idDimension= a.idDimension
                                                    inner join departamentopordimension dpd on dpd.idDimension=de.idDimension
                                                    inner join departamento d on d.idDepartamento=dpd.idDepartamento
                                                )
                                                select 
                                                    r.idActividad,r.actividad,r.correlativoActividad,de.nombreDepartamento
                                                    ,(SELECT count(*) FROM descripcionadministrativa da where da.idActividad=r.idActividad) as NumeroDeActividadesDefinidas
                                                    ,de.dimensionEstrategica,r.TipoActividad
                                                from CTE_Actividad_Resultado r
                                                inner join CTE_Actividad_AREAESTRATEGICA a
                                                on a.idActividad=r.idActividad
                                                inner join CTE_Actividad_ObjetivoInstitucional o
                                                on r.idActividad=o.idActividad
                                                inner join CTE_Actividad_DimensionEstrategica de
                                                on r.idActividad=de.idActividad
                                                where YEAR(r.fechaCreacionActividad) = YEAR(de.fecha) and YEAR(de.fecha)=:Anio
                                                and YEAR(r.fechaCreacionActividad)=:Anio2 and de.estadoActividad="Activo"
                                                and de.idDimension=:idDimension and de.idDepartamento=:Depa
                                                and de.idDepartamento = (select idDepartamento from usuario u where u.idPersonaUsuario = r.idPersonaUsuario);'
                                                );
                $stmt->bindValue(':Depa', $this->Depa);
                $stmt->bindValue(':Anio', $this->Anio);
                $stmt->bindValue(':Anio2', $this->Anio);
                $stmt->bindValue(':idDimension', $this->idDimension);
                if ($stmt->execute()) {
                    return array(
                        'status' => SUCCESS_REQUEST,
                        'data' => $stmt->fetchAll(PDO::FETCH_OBJ)
                    );
                } else {
                    return array(
                        'status'=> BAD_REQUEST,
                        'data' => array('message' => 'Ha ocurrido un error al listar las actividades')
                    );
                }
            } catch (PDOException $ex) {
                return array(
                    'status'=> INTERNAL_SERVER_ERROR,
                    'data' => array('message' => $ex->getMessage())
                );
            } finally {
                $this->conexionBD = null;
            }
        }
        
    public function getActividadesPorMesDepa () {
            try {
                $this->conexionBD = new Conexion();
                $this->consulta = $this->conexionBD->connect();
                $stmt = $this->consulta->prepare('WITH CTE_Actividad_Resultado AS 
                                                (
                                                    SELECT a.idActividad,a.actividad,a.correlativoActividad,a.fechaCreacionActividad,ta.TipoActividad
                                                    FROM actividad a
                                                    inner join resultadoinstitucional ri on a.idResultadoInstitucional=ri.idResultadoInstitucional
                                                    inner join tipoactividad ta on ta.idTipoActividad=a.idTipoActividad
                                                ), CTE_Actividad_AREAESTRATEGICA AS
                                                (
                                                    SELECT a.idActividad
                                                    FROM actividad a
                                                    inner join areaestrategica ae on ae.idAreaEstrategica=a.idAreaEstrategica
                                                ), CTE_Actividad_ObjetivoInstitucional AS
                                                (
                                                    SELECT a.idActividad
                                                    FROM actividad a
                                                    inner join objetivoinstitucional oi on a.idObjetivoInstitucional=oi.idObjetivoInstitucional
                                                ), CTE_Actividad_DimensionEstrategica AS
                                                (
                                                    SELECT a.idActividad,d.nombreDepartamento,dpd.fecha,dpd.estadoActividad,d.idDepartamento,de.dimensionEstrategica
                                                    FROM actividad a
                                                    inner join dimensionestrategica de on de.idDimension= a.idDimension
                                                    inner join departamentopordimension dpd on dpd.idDimension=de.idDimension
                                                    inner join departamento d on d.idDepartamento=dpd.idDepartamento
                                                ), CTE_Conteo_Actividades AS
                                                (
                                                    SELECT * FROM descripcionadministrativa
                                                )
                                                select 
                                                    r.idActividad,r.actividad,r.correlativoActividad,de.nombreDepartamento
                                                    ,(SELECT count(*) FROM descripcionadministrativa da where da.idActividad=r.idActividad) as NumeroDeActividadesDefinidas
                                                    ,de.dimensionEstrategica,r.TipoActividad
                                                from CTE_Actividad_Resultado r
                                                inner join CTE_Actividad_AREAESTRATEGICA a
                                                on a.idActividad=r.idActividad
                                                inner join CTE_Actividad_ObjetivoInstitucional o
                                                on r.idActividad=o.idActividad
                                                inner join CTE_Actividad_DimensionEstrategica de
                                                on r.idActividad=de.idActividad
                                                where YEAR(r.fechaCreacionActividad) = YEAR(de.fecha) and de.estadoActividad="Activo"
                                                and EXISTS (SELECT 1 FROM descripcionadministrativa da WHERE r.idActividad=da.idActividad and da.mesRequerido=:Mes and de.idDepartamento=:Depa);'
                                                );
                $stmt->bindValue(':Mes', $this->Mes);
                $stmt->bindValue(':Depa', $this->Depa);
                if ($stmt->execute()) {
                    return array(
                        'status' => SUCCESS_REQUEST,
                        'data' => $stmt->fetchAll(PDO::FETCH_OBJ)
                    );
                } else {
                    return array(
                        'status'=> BAD_REQUEST,
                        'data' => array('message' => 'Ha ocurrido un error al listar las actividades')
                    );
                }
            } catch (PDOException $ex) {
                return array(
                    'status'=> INTERNAL_SERVER_ERROR,
                    'data' => array('message' => $ex->getMessage())
                );
            } finally {
                $this->conexionBD = null;
            }
        }
}