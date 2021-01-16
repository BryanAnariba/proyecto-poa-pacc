<?php
    if (!isset($_SESSION)) {
        session_start();
    }
    require_once('../../config/config.php');
    require_once('../../database/Conexion.php');
    require_once('../../validators/validators.php');

    class Actividad {
        private $idActividad;
        private $idPersonaUsuario;
        private $idDimension;
        private $idObjetivoInstitucional;
        private $idResultadoInstitucional;
        private $idAreaEstrategica;
        private $idTipoActividad;
        private $resultadosUnidad;
        private $indicadoresResultado;
        private $actividad;
        private $correlativoActividad;
        private $justificacionActividad;
        private $medioVerificacionActividad;
        private $poblacionOjetivoActividad;
        private $responsableActividad;
        private $fechaCreacionActividad;
        private $costoTotal;

        private $conexionBD;
        private $consulta;
        private $tablaBaseDatos;

        public function __construct() {
            $this->tablaBaseDatos = TBL_ACTIVIDADES;
        }

        public function getIdActividad() {
            return $this->idActividad;
        }

        public function setIdActividad($idActividad) {
            $this->idActividad = $idActividad;
            return $this;
        }
 
        public function getIdPersonaUsuario() {
            return $this->idPersonaUsuario;
        }

        public function setIdPersonaUsuario($idPersonaUsuario) {
            $this->idPersonaUsuario = $idPersonaUsuario;
            return $this;
        }

        public function getIdDimension() {
            return $this->idDimension;
        }

        public function setIdDimension($idDimension) {
            $this->idDimension = $idDimension;
            return $this;
        }

        public function getIdObjetivoInstitucional() {
            return $this->idObjetivoInstitucional;
        }

        public function setIdObjetivoInstitucional($idObjetivoInstitucional) {
            $this->idObjetivoInstitucional = $idObjetivoInstitucional;
            return $this;
        }

        public function getIdResultadoInstitucional() {
            return $this->idResultadoInstitucional;
        }

        public function setIdResultadoInstitucional($idResultadoInstitucional) {
            $this->idResultadoInstitucional = $idResultadoInstitucional;
            return $this;
        }

        public function getIdAreaEstrategica() {
            return $this->idAreaEstrategica;
        }

        public function setIdAreaEstrategica($idAreaEstrategica) {
            $this->idAreaEstrategica = $idAreaEstrategica;
            return $this;
        }

        public function getIdTipoActividad() {
            return $this->idTipoActividad;
        }

        public function setIdTipoActividad($idTipoActividad) {
            $this->idTipoActividad = $idTipoActividad;
            return $this;
        }

        public function getResultadosUnidad() {
            return $this->resultadosUnidad;
        }

        public function setResultadosUnidad($resultadosUnidad) {
            $this->resultadosUnidad = $resultadosUnidad;
            return $this;
        }

        public function getIndicadoresResultado() {
            return $this->indicadoresResultado;
        }

        public function setIndicadoresResultado($indicadoresResultado) {
            $this->indicadoresResultado = $indicadoresResultado;
            return $this;
        }

        public function getActividad() {
            return $this->actividad;
        }

        public function setActividad($actividad) {
            $this->actividad = $actividad;
            return $this;
        }

        public function getCorrelativoActividad() {
            return $this->correlativoActividad;
        }

        public function setCorrelativoActividad($correlativoActividad) {
            $this->correlativoActividad = $correlativoActividad;
            return $this;
        }

        public function getJustificacionActividad() {
            return $this->justificacionActividad;
        }

        public function setJustificacionActividad($justificacionActividad) {
            $this->justificacionActividad = $justificacionActividad;
            return $this;
        }

        public function getMedioVerificacionActividad() {
            return $this->medioVerificacionActividad;
        }

        public function setMedioVerificacionActividad($medioVerificacionActividad) {
            $this->medioVerificacionActividad = $medioVerificacionActividad;
            return $this;
        }

        public function getPoblacionOjetivoActividad() {
            return $this->poblacionOjetivoActividad;
        }

        public function setPoblacionOjetivoActividad($poblacionOjetivoActividad) {
            $this->poblacionOjetivoActividad = $poblacionOjetivoActividad;
            return $this;
        }

        public function getResponsableActividad() {
            return $this->responsableActividad;
        }

        public function setResponsableActividad($responsableActividad) {
            $this->responsableActividad = $responsableActividad;
            return $this;
        }
 
        public function getFechaCreacionActividad() {
            return $this->fechaCreacionActividad;
        }

        public function setFechaCreacionActividad($fechaCreacionActividad) {
            $this->fechaCreacionActividad = $fechaCreacionActividad;
            return $this;
        }

        public function getCostoTotal() {
            return $this->costoTotal;
        }

        public function setCostoTotal($costoTotal) {
            $this->costoTotal = $costoTotal;
            return $this;
        }

        public function getActividadesPorDimension () {
            try {
                $this->conexionBD = new Conexion();
                $this->consulta = $this->conexionBD->connect();
                $stmt = $this->consulta->prepare("WITH CTE_LISTADO_ACT_POR_DIM AS (SELECT COUNT(Actividad.idActividad) AS cantidadActividadesPorDimension, DimensionEstrategica.idDimension, DimensionEstrategica.dimensionEstrategica,
                DimensionEstrategica.idEstadoDimension, Estadodcduoao.estado FROM " . $this->tablaBaseDatos .  " RIGHT JOIN DimensionEstrategica ON (Actividad.idDimension = DimensionEstrategica.idDimension) INNER JOIN Estadodcduoao ON (DimensionEstrategica.idEstadoDimension = Estadodcduoao.idEstado) GROUP BY DimensionEstrategica.idDimension, DimensionEstrategica.dimensionEstrategica) SELECT * FROM CTE_LISTADO_ACT_POR_DIM WHERE CTE_LISTADO_ACT_POR_DIM.idEstadoDimension = :idEstado AND (SELECT ControlPresupuestoActividad.idEstadoPresupuestoAnual FROM ControlPresupuestoActividad LEFT JOIN PresupuestoDepartamento ON (ControlPresupuestoActividad.idControlPresupuestoActividad = PresupuestoDepartamento.idControlPresupuestoActividad) RIGHT JOIN Departamento ON (PresupuestoDepartamento.idDepartamento = Departamento.idDepartamento) LEFT JOIN Usuario ON (Departamento.idDepartamento = Usuario.idDepartamento) INNER JOIN EstadoDCDUOAO ON (ControlPresupuestoActividad.idEstadoPresupuestoAnual = EstadoDCDUOAO.idEstado) WHERE Departamento.idDepartamento = :idDepartamento AND Usuario.idPersonaUsuario = :idUsuario AND DATE_FORMAT(ControlPresupuestoActividad.fechaPresupuestoAnual, '%Y') = DATE_FORMAT(NOW(), '%Y')) AND CTE_LISTADO_ACT_POR_DIM.idDimension BETWEEN (SELECT LlenadoActividadDimension.valorLlenadoDimensionInicial FROM LlenadoActividadDimension INNER JOIN TipoUsuario ON(LlenadoActividadDimension.TipoUsuario_idTipoUsuario = TipoUsuario.idTipoUsuario) WHERE LlenadoActividadDimension.TipoUsuario_idTipoUsuario = :tipoUsuario) AND (SELECT LlenadoActividadDimension.valorLlenadoDimensionFinal FROM LlenadoActividadDimension INNER JOIN TipoUsuario ON (LlenadoActividadDimension.TipoUsuario_idTipoUsuario = TipoUsuario.idTipoUsuario) WHERE LlenadoActividadDimension.TipoUsuario_idTipoUsuario = :tipoUsuario2);");
                $stmt->bindValue(':idEstado', ESTADO_ACTIVO);
                $stmt->bindValue(':idDepartamento', $_SESSION['idDepartamento']);
                $stmt->bindValue(':idUsuario', $_SESSION['idUsuario']);
                $stmt->bindValue(':tipoUsuario', $_SESSION['idTipoUsuario']);
                $stmt->bindValue(':tipoUsuario2', $_SESSION['idTipoUsuario']);
                if ($stmt->execute()) {
                    return array(
                        'status' => SUCCESS_REQUEST,
                        'data' => $stmt->fetchAll(PDO::FETCH_OBJ)
                    );
                } else {
                    return array(
                        'status'=> BAD_REQUEST,
                        'data' => array('message' => 'Ha ocurrido un error')
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
?>