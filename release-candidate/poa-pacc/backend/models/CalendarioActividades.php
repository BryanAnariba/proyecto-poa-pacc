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
                $stmt = $this->consulta->prepare("select descripcionadministrativa.idDimensionAdministrativa,descripcionadministrativa.idDescripcionAdministrativa,descripcionadministrativa.nombreActividad,
                                                    descripcionadministrativa.Descripcion,descripcionadministrativa.Cantidad,descripcionadministrativa.Costo,descripcionadministrativa.CostoTotal,
                                                    tipopresupuesto.tipoPresupuesto,objetogasto.abrev as ObjetoGasto,objetogasto.DescripcionCuenta,dimensionestrategica.dimensionEstrategica,
                                                    descripcionadministrativa.mesRequerido,actividad.responsableActividad,actividad.justificacionActividad,actividad.medioVerificacionActividad,
                                                    departamento.nombreDepartamento
                                                    from descripcionadministrativa
                                                    inner join tipopresupuesto
                                                    on tipoPresupuesto.idTipoPresupuesto=descripcionadministrativa.idTipoPresupuesto
                                                    inner join objetogasto
                                                    on objetogasto.idObjetoGasto=descripcionadministrativa.idObjetoGasto
                                                    inner join actividad
                                                    on actividad.idActividad=descripcionadministrativa.idActividad
                                                    inner join dimensionestrategica
                                                    on dimensionEstrategica.idDimension=actividad.idDimension
                                                    inner join usuario
                                                    on usuario.idPersonaUsuario=actividad.idPersonaUsuario
                                                    inner join departamento
                                                    on departamento.idDepartamento=usuario.idDepartamento
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
                                                        departamento.idDepartamento,actividad.responsableActividad,actividad.justificacionActividad,actividad.medioVerificacionActividad,
                                                        departamento.nombreDepartamento
                                                from descripcionadministrativa
                                                inner join tipopresupuesto
                                                on tipoPresupuesto.idTipoPresupuesto=descripcionadministrativa.idTipoPresupuesto
                                                inner join objetogasto
                                                on objetogasto.idObjetoGasto=descripcionadministrativa.idObjetoGasto
                                                inner join actividad
                                                on actividad.idActividad=descripcionadministrativa.idActividad
                                                inner join dimensionestrategica
                                                on dimensionEstrategica.idDimension=actividad.idDimension
                                                inner join usuario
                                                on usuario.idPersonaUsuario=actividad.idPersonaUsuario
                                                inner join departamento
                                                on departamento.idDepartamento=usuario.idDepartamento
                                                where departamento.idDepartamento=(select idDepartamento from usuario u where u.idPersonaUsuario = actividad.idPersonaUsuario);"
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
                $stmt = $this->consulta->prepare('select a.idActividad,a.actividad,a.correlativoActividad,de.nombreDepartamento
                                                            ,(SELECT count(*) FROM descripcionadministrativa da where da.idActividad=a.idActividad) as NumeroDeActividadesDefinidas
                                                            ,a.idDimension,ta.TipoActividad
                                                    FROM actividad a
                                                    inner join resultadoinstitucional ri on a.idResultadoInstitucional=ri.idResultadoInstitucional
                                                    inner join tipoactividad ta on ta.idTipoActividad=a.idTipoActividad
                                                    inner join areaestrategica ae on ae.idAreaEstrategica=a.idAreaEstrategica
                                                    inner join objetivoinstitucional oi on a.idObjetivoInstitucional=oi.idObjetivoInstitucional
                                                    inner join usuario u on u.idPersonaUsuario=a.idPersonaUsuario
                                                    inner join departamento de on de.idDepartamento=u.idDepartamento
                                                    where YEAR(a.fechaCreacionActividad)=:Anio and a.idDimension=:idDimension
                                                    and de.idDepartamento = (select idDepartamento from usuario u where u.idPersonaUsuario = a.idPersonaUsuario);'
                                                );
                $stmt->bindValue(':idDimension', $this->idDimension);
                $stmt->bindValue(':Anio', $this->Anio);
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
                $stmt = $this->consulta->prepare('select
                                                        actividad.idActividad,actividad.actividad,actividad.correlativoActividad,departamento.nombreDepartamento,areaestrategica.areaEstrategica
                                                        ,objetivoinstitucional.objetivoInstitucional,dimensionestrategica.dimensionEstrategica
                                                        ,(SELECT count(*) FROM descripcionadministrativa da where da.idActividad=actividad.idActividad) as NumeroDeActividadesDefinidas,tipoactividad.TipoActividad
                                                    FROM actividad
                                                    inner join resultadoinstitucional on actividad.idResultadoInstitucional=resultadoinstitucional.idResultadoInstitucional
                                                    inner join tipoactividad on tipoactividad.idTipoActividad=actividad.idTipoActividad
                                                    inner join dimensionestrategica on dimensionestrategica.idDimension=actividad.idDimension
                                                    inner join areaestrategica on areaestrategica.idAreaEstrategica=actividad.idAreaEstrategica
                                                    inner join objetivoinstitucional on actividad.idObjetivoInstitucional=objetivoinstitucional.idObjetivoInstitucional
                                                    inner join usuario on usuario.idPersonaUsuario=actividad.idPersonaUsuario
                                                    inner join departamento on departamento.idDepartamento=usuario.idDepartamento
                                                    where actividad.idActividad=:idActividad;'
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
                $stmt = $this->consulta->prepare('select actividad.actividad,resultadoinstitucional.resultadoInstitucional,actividad.resultadosUnidad,actividad.indicadoresResultado,
                                                        actividad.justificacionActividad,actividad.medioVerificacionActividad,actividad.poblacionObjetivoActividad
                                                        ,dimensionestrategica.dimensionEstrategica,actividad.responsableActividad,actividad.CostoTotal,costoactividadportrimestre.Trimestre1
                                                        ,costoactividadportrimestre.Trimestre2,costoactividadportrimestre.Trimestre3,costoactividadportrimestre.Trimestre4
                                                FROM actividad
                                                inner join resultadoinstitucional on actividad.idResultadoInstitucional=resultadoinstitucional.idResultadoInstitucional
                                                inner join dimensionestrategica on dimensionestrategica.idDimension=actividad.idDimension
                                                inner join areaestrategica on areaestrategica.idAreaEstrategica=actividad.idAreaEstrategica
                                                inner join objetivoinstitucional on actividad.idObjetivoInstitucional=objetivoinstitucional.idObjetivoInstitucional
                                                inner join usuario on usuario.idPersonaUsuario=actividad.idPersonaUsuario
                                                inner join departamento on departamento.idDepartamento=usuario.idDepartamento
                                                inner join costoactividadportrimestre on costoactividadportrimestre.idActividad=actividad.idActividad
                                                where actividad.idActividad=:idActividad;'
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
                $stmt = $this->consulta->prepare('select actividad.idActividad,actividad.actividad,actividad.correlativoActividad,departamento.nombreDepartamento
                                                        ,(SELECT count(*) FROM descripcionadministrativa where descripcionadministrativa.idActividad=actividad.idActividad) as NumeroDeActividadesDefinidas
                                                        ,dimensionestrategica.dimensionEstrategica,tipoactividad.TipoActividad
                                                FROM actividad
                                                inner join resultadoinstitucional on actividad.idResultadoInstitucional=resultadoinstitucional.idResultadoInstitucional
                                                inner join tipoactividad on tipoactividad.idTipoActividad=actividad.idTipoActividad
                                                inner join dimensionestrategica on dimensionestrategica.idDimension=actividad.idDimension
                                                inner join areaestrategica on areaestrategica.idAreaEstrategica=actividad.idAreaEstrategica
                                                inner join objetivoinstitucional on actividad.idObjetivoInstitucional=objetivoinstitucional.idObjetivoInstitucional
                                                inner join usuario on usuario.idPersonaUsuario=actividad.idPersonaUsuario 
                                                inner join departamento on departamento.idDepartamento=usuario.idDepartamento
                                                where YEAR(actividad.fechaCreacionActividad)=:Anio and actividad.idDimension=:idDimension and departamento.idDepartamento=:Depa
                                                and departamento.idDepartamento = (select idDepartamento from usuario u where u.idPersonaUsuario = actividad.idPersonaUsuario);'
                                                );
                $stmt->bindValue(':Depa', $this->Depa);
                $stmt->bindValue(':Anio', $this->Anio);
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
}