<?php
    require_once('../../config/config.php');    
    require_once('../../validators/validators.php');
    require_once('../../database/Conexion.php');
    class PresupuestoDepartamento {
        private $idPresupuestoPorDepartamento; 
        private $idDepartamento; 
        private $idControlPresupuestoActividad; 
        private $montoPresupuesto; 
        private $fechaAprobacionPresupuesto;

        private $conexionBD;
        private $consulta;
        private $tablaBaseDatos;

        public function getIdPresupuestoPorDepartamento(){
            return $this->idPresupuestoPorDepartamento;
        }
 
        public function setIdPresupuestoPorDepartamento($idPresupuestoPorDepartamento){
            $this->idPresupuestoPorDepartamento = $idPresupuestoPorDepartamento;
            return $this;
        }

        public function getIdDepartamento(){
            return $this->idDepartamento;
        }

        public function setIdDepartamento($idDepartamento){
            $this->idDepartamento = $idDepartamento;
            return $this;
        }

        public function getIdControlPresupuestoActividad(){
            return $this->idControlPresupuestoActividad;
        }

        public function setIdControlPresupuestoActividad($idControlPresupuestoActividad){
            $this->idControlPresupuestoActividad = $idControlPresupuestoActividad;
            return $this;
        }

        public function getMontoPresupuesto(){
            return $this->montoPresupuesto;
        }

        public function setMontoPresupuesto($montoPresupuesto){
            $this->montoPresupuesto = $montoPresupuesto;
            return $this;
        }

        public function getFechaAprobacionPresupuesto(){
            return $this->fechaAprobacionPresupuesto;
        }

        public function setFechaAprobacionPresupuesto($fechaAprobacionPresupuesto){
            $this->fechaAprobacionPresupuesto = $fechaAprobacionPresupuesto;
            return $this;
        }

        public function __construct() {
            $this->tablaBaseDatos = TBL_PRESUPUESTO_DEPTO;
        }

        public function getPresupuestoDeptos() {
            try {
                $this->conexionBD = new Conexion();
                $this->consulta = $this->conexionBD->connect();
                $stmt = $this->consulta->prepare("WITH CTE_VER_PRESUPUESTOS_DEPTO AS (SELECT controlPresupuestoActividad.idControlPresupuestoActividad, controlPresupuestoActividad.presupuestoAnual, date_format(controlPresupuestoActividad.fechaPresupuestoAnual, '%Y') AS fechaPresupuesto, presupuestoDepartamento.idPresupuestoPorDepartamento, presupuestoDepartamento.montoPresupuesto, presupuestoDepartamento.fechaAprobacionPresupuesto, presupuestoDepartamento.idDepartamento, departamento.nombreDepartamento, departamento.abrev, departamento.idEstadoDepartamento as estadoDepartamento, estadodcduoao.estado FROM controlPresupuestoActividad LEFT JOIN presupuestoDepartamento ON (controlPresupuestoActividad.idControlPresupuestoActividad = presupuestoDepartamento.idControlPresupuestoActividad) RIGHT JOIN departamento ON (presupuestoDepartamento.idDepartamento = departamento.idDepartamento) INNER JOIN estadodcduoao ON (departamento.idEstadoDepartamento = estadodcduoao.idEstado) ORDER BY controlPresupuestoActividad.idControlPresupuestoActividad DESC) SELECT * FROM CTE_VER_PRESUPUESTOS_DEPTO WHERE CTE_VER_PRESUPUESTOS_DEPTO.estadoDepartamento = " . ESTADO_ACTIVO . " AND CTE_VER_PRESUPUESTOS_DEPTO.fechaPresupuesto = date_format(NOW(), '%Y');");
                if ($stmt->execute()) {
                    return array(
                        'status'=> SUCCESS_REQUEST,
                        'data' => $stmt->fetchAll(PDO::FETCH_OBJ)
                    );
                } else {
                    return array(
                        'status'=> BAD_REQUEST,
                        'data' => array('message' => 'ha ocurrido un error al ver la distribucion del presupuesto anual en los departamentos, vuelva a ingresar la informacion')
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

        public function getInformacionPresupuestoAnual () {
            try {
                $this->conexionBD = new Conexion();
                $this->consulta = $this->conexionBD->connect();
                $stmt = $this->consulta->prepare("WITH CTE_VER_PRESUPUESTO AS (SELECT ControlPresupuestoActividad.presupuestoAnual, SUM(PresupuestoDepartamento.montoPresupuesto) AS montoTotalPorDepartamentos, ControlPresupuestoActividad.idControlPresupuestoActividad FROM ControlPresupuestoActividad LEFT JOIN PresupuestoDepartamento ON (PresupuestoDepartamento.idControlPresupuestoActividad = ControlPresupuestoActividad.idControlPresupuestoActividad) LEFT JOIN Departamento ON (PresupuestoDepartamento.idDepartamento = Departamento.idDepartamento) WHERE date_format(ControlPresupuestoActividad.fechaPresupuestoAnual, '%Y') = date_format(NOW(), '%Y') GROUP BY ControlPresupuestoActividad.presupuestoAnual) SELECT * FROM CTE_VER_PRESUPUESTO;");
                if ($stmt->execute()) {
                    return array(
                        'status'=> SUCCESS_REQUEST,
                        'data' => $stmt->fetchObject()
                    );
                } else {
                    return array(
                        'status'=> BAD_REQUEST,
                        'data' => array('message' => 'ha ocurrido un error al ver la informacion del presupuesto anual')
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

        public function verificarPresupuestoActualDepto () {
            try {
                $this->conexionBD = new Conexion();
                $this->consulta = $this->conexionBD->connect();
                $stmt = $this->consulta->prepare("WITH CTE_VER_PRESUPUESTO_DEPTO AS (SELECT * FROM presupuestodepartamento) SELECT * FROM CTE_VER_PRESUPUESTO_DEPTO WHERE CTE_VER_PRESUPUESTO_DEPTO.idDepartamento = :departamento AND CTE_VER_PRESUPUESTO_DEPTO.idControlPresupuestoActividad = :idPresupuestoAnual");
                $stmt->bindValue(':departamento', $this->idControlPresupuestoActividad);
                if ($stmt->execute()) {
                    $data = $stmt->fetchObject();
                    return $data->montoPresupuesto;
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
        
        public function verificaMontoPresupuestoDeptoGuardar () {
            try {
                $this->conexionBD = new Conexion();
                $this->consulta = $this->conexionBD->connect();
                $stmt = $this->consulta->prepare("WITH CTE_VER_PRESUPUESTO AS (SELECT ControlPresupuestoActividad.presupuestoAnual, SUM(PresupuestoDepartamento.montoPresupuesto) AS montoTotalPorDepartamentos, ControlPresupuestoActividad.idControlPresupuestoActividad FROM ControlPresupuestoActividad LEFT JOIN PresupuestoDepartamento ON (PresupuestoDepartamento.idControlPresupuestoActividad = ControlPresupuestoActividad.idControlPresupuestoActividad) LEFT JOIN Departamento ON (PresupuestoDepartamento.idDepartamento = Departamento.idDepartamento) GROUP BY ControlPresupuestoActividad.presupuestoAnual) SELECT * FROM CTE_VER_PRESUPUESTO WHERE CTE_VER_PRESUPUESTO.idControlPresupuestoActividad = :idPresupuestoAnual;");
                $stmt->bindValue(':idPresupuestoAnual', $this->idControlPresupuestoActividad);
                if ($stmt->execute() && ($stmt->rowCount() != 0)) {
                    $data = $stmt->fetchObject();
                    $banderaPresupuestaria = null;
                    if ($data->montoTotalPorDepartamentos == null) {
                        $banderaPresupuestaria = 0;
                    } else {
                        $banderaPresupuestaria = $data->montoTotalPorDepartamentos;
                    } 
                    $banderaNuevoMonto = $banderaPresupuestaria + $this->montoPresupuesto;
                        if ($banderaNuevoMonto > $data->presupuestoAnual) {
                            return false;
                        } else {
                            return true;
                        }
                    
                } else {
                    return false;
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


        public function verificaMontoPresupuestoDeptoModificar () {
            try {
                $this->conexionBD = new Conexion();
                $this->consulta = $this->conexionBD->connect();
                $stmt = $this->consulta->prepare("WITH CTE_VER_PRESUPUESTO AS (SELECT ControlPresupuestoActividad.presupuestoAnual, SUM(PresupuestoDepartamento.montoPresupuesto) AS montoTotalPorDepartamentos, ControlPresupuestoActividad.idControlPresupuestoActividad FROM ControlPresupuestoActividad LEFT JOIN PresupuestoDepartamento ON (PresupuestoDepartamento.idControlPresupuestoActividad = ControlPresupuestoActividad.idControlPresupuestoActividad) LEFT JOIN Departamento ON (PresupuestoDepartamento.idDepartamento = Departamento.idDepartamento) GROUP BY ControlPresupuestoActividad.presupuestoAnual) SELECT * FROM CTE_VER_PRESUPUESTO WHERE CTE_VER_PRESUPUESTO.idControlPresupuestoActividad = :idPresupuestoAnual;");
                $stmt->bindValue(':idPresupuestoAnual', $this->idControlPresupuestoActividad);
                if ($stmt->execute() && ($stmt->rowCount() != 0)) {
                    $data = $stmt->fetchObject();
                    return $data;
                } else {
                    return false;
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

        public function compruebaInformacionPresupuesto() {
            try {
                $this->conexionBD = new Conexion();
                $this->consulta = $this->conexionBD->connect();
                $stmt = $this->consulta->prepare("WITH CTE_VERIF_EXIS_PRESU_DEPTO AS (SELECT * FROM presupuestodepartamento) SELECT * FROM CTE_VERIF_EXIS_PRESU_DEPTO WHERE CTE_VERIF_EXIS_PRESU_DEPTO.idDepartamento = :departamento AND CTE_VERIF_EXIS_PRESU_DEPTO.idControlPresupuestoActividad = :idPresupuestoAnual;");
                $stmt->bindValue(':departamento', $this->idDepartamento);
                $stmt->bindValue(':idPresupuestoAnual', $this->idControlPresupuestoActividad);
                if ($stmt->execute() && ($stmt->rowCount() == 0)) {
                    return true;
                } else {
                    return false;
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

        public function verifExistenciaPresupuestoDepartamento() {
            try {
                $this->conexionBD = new Conexion();
                $this->consulta = $this->conexionBD->connect();
                $stmt = $this->consulta->prepare("WITH CTE_VERIF_EXIS_PRESU_DEPTO AS (SELECT * FROM presupuestodepartamento) SELECT * FROM CTE_VERIF_EXIS_PRESU_DEPTO WHERE CTE_VERIF_EXIS_PRESU_DEPTO.idDepartamento = :departamento AND CTE_VERIF_EXIS_PRESU_DEPTO.idControlPresupuestoActividad = :idPresupuestoAnual;");
                $stmt->bindValue(':departamento', $this->idDepartamento);
                $stmt->bindValue(':idPresupuestoAnual', $this->idControlPresupuestoActividad);
                if ($stmt->execute()) {
                    $data = $stmt->fetchObject();
                    return $data->montoPresupuesto;
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
        
        public function registrarPresupuestoDepartamento () {
            if (is_int($this->idDepartamento) && is_int($this->idControlPresupuestoActividad) &&  validaCampoMonetario($this->montoPresupuesto)) {
                if ($this->compruebaInformacionPresupuesto() == false) {
                    return array(
                        'status'=> BAD_REQUEST,
                        'data' => array('message' => 'ha ocurido un error, el departamento ya tiene un presupuesto asignado')
                    );
                } else {
                    if ($this->verificaMontoPresupuestoDeptoGuardar()) {
                        try {
                            $this->conexionBD = new Conexion();
                            $this->consulta = $this->conexionBD->connect();
                            $stmt = $this->consulta->prepare('INSERT INTO ' . TBL_PRESUPUESTO_DEPTO . '(idDepartamento, idControlPresupuestoActividad, montoPresupuesto, fechaAprobacionPresupuesto) VALUES (:departamento, :idPresupuestoAnual, :montoPresupuesto,  NOW())');
                            $stmt->bindValue(':departamento', $this->idDepartamento);
                            $stmt->bindValue(':montoPresupuesto', $this->montoPresupuesto);
                            $stmt->bindValue(':idPresupuestoAnual', $this->idControlPresupuestoActividad);
                            if ($stmt->execute()) {
                                return array(
                                    'status'=> SUCCESS_REQUEST,
                                    'data' => array('message' => 'El presupuesto fue asignado al departamento exitosamente')
                                );
                            } else {
                                return array(
                                    'status'=> BAD_REQUEST,
                                    'data' => array('message' => 'ha ocurrido un error al registrar el presupuesto anual')
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
                    } else {
                        return array(
                            'status'=> BAD_REQUEST,
                            'data' => array('message' => 'Ha ocurrido un error, el presupuesto digitado al departamento excede al presupuesto actual disponible, debe registrar un monto dentro del rango')
                        );
                    }
                }
            } else {
                return array(
                    'status'=> BAD_REQUEST,
                    'data' => array('message' => 'ha ocurido un error, la informacion es incorrecta')
                );
            }
        }

        public function modificarPresupuesto () {
            if (is_int($this->idDepartamento) && is_int($this->idControlPresupuestoActividad) &&  validaCampoMonetario($this->montoPresupuesto)) {
                $presupuestoActualDepto = $this->verifExistenciaPresupuestoDepartamento();
                $dataInformacionPresupuestoPorDepto = $this->verificaMontoPresupuestoDeptoModificar();
                $presupuestoAnual = $dataInformacionPresupuestoPorDepto->presupuestoAnual;
                $sumaPresupuestoDeptos = $dataInformacionPresupuestoPorDepto->montoTotalPorDepartamentos;

                $verificandoPresupuestoActual = (($sumaPresupuestoDeptos - $presupuestoActualDepto) + $this->montoPresupuesto);
                if ($verificandoPresupuestoActual > $presupuestoAnual) {
                    return array(
                        'status'=> BAD_REQUEST,
                        'data' => array('message' => 'Ha ocurrido un error, el presupuesto digitado al departamento excede al presupuesto actual disponible, debe registrar un monto dentro del rango')
                    );
                } else {
                    if ($this->verificaMontoPresupuestoDeptoModificar()) {
                        $this->conexionBD = new Conexion();
                        $this->consulta = $this->conexionBD->connect();
                        $stmt = $this->consulta->prepare('UPDATE ' . TBL_PRESUPUESTO_DEPTO . ' SET montoPresupuesto = :montoPresupuesto WHERE idControlPresupuestoActividad = :idPresupuestoAnual AND idDepartamento = :departamento');
                                $stmt->bindValue(':montoPresupuesto', $this->montoPresupuesto);
                                $stmt->bindValue(':idPresupuestoAnual', $this->idControlPresupuestoActividad);
                                $stmt->bindValue(':departamento', $this->idDepartamento);
                                if ($stmt->execute()) {
                                    return array(
                                        'status'=> SUCCESS_REQUEST,
                                        'data' => array('message' => 'El presupuesto fue actualizado al departamento exitosamente')
                                    );
                                } else {
                                    return array(
                                        'status'=> BAD_REQUEST,
                                        'data' => array('message' => 'ha ocurrido un error al registrar el presupuesto anual')
                                    );
                                }
                    } else {
                        return array(
                            'status'=> BAD_REQUEST,
                            'data' => array('message' => 'Ha ocurrido un error, el presupuesto digitado al departamento excede al presupuesto actual disponible, debe registrar un monto dentro del rango')
                        );
                    }
                }
            } else {
                return array(
                    'status'=> BAD_REQUEST,
                    'data' => array('message' => 'ha ocurido un error, la informacion es incorrecta')
                );
            }
        }
    }
?>