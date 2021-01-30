<?php
    require_once('../../config/config.php');    
    require_once('../../validators/validators.php');
    require_once('../../database/Conexion.php');
    class ControlPresupuestoActividad {
        private $idControlPresupuestoActividad;
        private $presupuestoAnual;
        private $fechaPresupuestoAnual;
        private $estadoPresupuestoAnual;

        private $conexionBD;
        private $consulta;
        private $tablaBaseDatos;

        public function __construct() {
            $this->tablaBaseDatos = TBL_PRESUPUESTO_ANUAL;
        }
        public function getIdControlPresupuestoActividad(){
            return $this->idControlPresupuestoActividad;
        }

        public function setIdControlPresupuestoActividad($idControlPresupuestoActividad){
            $this->idControlPresupuestoActividad = $idControlPresupuestoActividad;
            return $this;
        }

        public function getPresupuestoAnual(){
            return $this->presupuestoAnual;
        }

        public function setPresupuestoAnual($presupuestoAnual){
            $this->presupuestoAnual = $presupuestoAnual;
            return $this;
        }

        public function getFechaPresupuestoAnual(){
            return $this->fechaPresupuestoAnual;
        }

        public function setFechaPresupuestoAnual($fechaPresupuestoAnual){
            $this->fechaPresupuestoAnual = $fechaPresupuestoAnual;
            return $this;
        }

        public function getEstadoPresupuestoAnual(){
            return $this->estadoPresupuestoAnual;
        }

        public function setEstadoPresupuestoAnual($estadoPresupuestoAnual){
            $this->estadoPresupuestoAnual = $estadoPresupuestoAnual;
            return $this;
        }

        public function verificaExistenciaPresupuestoAnual () {
            try {
                $this->conexionBD = new Conexion();
                $this->consulta = $this->conexionBD->connect();
                $stmt = $this->consulta->prepare("WITH CTE_VERIF_EXIS_PRES_ANUAL AS ( select * from controlPresupuestoActividad WHERE date_format(fechaPresupuestoAnual, '%Y') = date_format(NOW(), '%Y')) SELECT * FROM CTE_VERIF_EXIS_PRES_ANUAL");
                if ($stmt->execute()) {
                    if ($stmt->rowCount() == 0) {
                        return true;
                    } else {
                        return false;
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
        public function registrarPresupuesto () {
            if (validaCampoMonetario($this->presupuestoAnual) && is_int($this->estadoPresupuestoAnual)) {
                $noExistePresupuestoParaAnio = $this->verificaExistenciaPresupuestoAnual();
                if ($noExistePresupuestoParaAnio) {
                    try {
                        $this->conexionBD = new Conexion();
                        $this->consulta = $this->conexionBD->connect();

                        $this->consulta->prepare("
                            set @persona = {$_SESSION['idUsuario']};
                        ")->execute();

                        $stmt = $this->consulta->prepare('INSERT INTO ' . $this->tablaBaseDatos . '(presupuestoAnual, fechaPresupuestoAnual, idEstadoPresupuestoAnual) VALUES (:presupuesto, NOW(), :estadoPresupuestoAnual)');
                        $stmt->bindValue(':presupuesto', $this->presupuestoAnual);
                        $stmt->bindValue(':estadoPresupuestoAnual', $this->estadoPresupuestoAnual);
                        if ($stmt->execute()) {
                            return array(
                                'status'=> SUCCESS_REQUEST,
                                'data' => array('message' => 'El presupuesto para este año ingresado exitosamente')
                            );
                        } else {
                            return array(
                                'status'=> BAD_REQUEST,
                                'data' => array('message' => 'ha ocurrido un error al ingresar el presupuesto, vuelva a ingresar la informacion')
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
                        'data' => array('message' => 'El presupuesto para este año ya fue asignado, no puede agregar otro presupuesto, solo puede modificarlo')
                    );
                }
            } else {
                return array(
                    'status'=> BAD_REQUEST,
                    'data' => array('message' => 'El campo presupuesto anual no es valido, debe ser un campo numerico')
                );
            }
        }

        public function getPresupuestosAnuales () {
            try {
                $this->conexionBD = new Conexion();
                $this->consulta = $this->conexionBD->connect();
                $stmt = $this->consulta->prepare("WITH CTE_VER_PRESUPUESTOS_DEPTO AS (SELECT controlPresupuestoActividad.idControlPresupuestoActividad, controlPresupuestoActividad.presupuestoAnual, date_format(controlPresupuestoActividad.fechaPresupuestoAnual, '%Y') AS fechaPresupuesto FROM " . $this->tablaBaseDatos . ") SELECT * FROM CTE_VER_PRESUPUESTOS_DEPTO ORDER BY CTE_VER_PRESUPUESTOS_DEPTO.idControlPresupuestoActividad DESC;");
                $stmt->bindValue(':estado', ESTADO_ACTIVO);
                if ($stmt->execute()) {
                    return array(
                        'status'=> SUCCESS_REQUEST,
                        'data' => $stmt->fetchAll(PDO::FETCH_OBJ)
                    );
                } else {
                    return array(
                        'status'=> BAD_REQUEST,
                        'data' => array('message' => 'ha ocurrido un error al ver los presupuestos, vuelva a ingresar la informacion')
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

        public function verificarPresupuestoModificar () {
            if (is_int($this->idControlPresupuestoActividad)) {
                try {
                    $this->conexionBD = new Conexion();
                    $this->consulta = $this->conexionBD->connect();
                    $stmt = $this->consulta->prepare("WITH CTE_VERIF_PRESUPUESTO AS (SELECT * FROM  controlPresupuestoActividad) SELECT * FROM CTE_VERIF_PRESUPUESTO  WHERE DATE_FORMAT(CTE_VERIF_PRESUPUESTO.fechaPresupuestoAnual, '%Y') = DATE_FORMAT(NOW(), '%Y') AND CTE_VERIF_PRESUPUESTO.idControlPresupuestoActividad = :idPresupuestoAnual");
                    $stmt->bindValue(':idPresupuestoAnual', $this->idControlPresupuestoActividad);
                    if ($stmt->execute()) {
                        if ($stmt->rowCount() == 0) {
                            return array(
                                'status'=> BAD_REQUEST,
                                'data' => array('message' => 'Este presupuesto no pertenece a este año, no es posible modificarlo')
                            );
                        } else {
                            return array(
                                'status'=> SUCCESS_REQUEST,
                                'data' => $stmt->fetchObject()
                            );
                        }
                    } else {
                        return array(
                            'status'=> BAD_REQUEST,
                            'data' => array('message' => 'ha ocurrido un error al ingresar el presupuesto modificado, vuelva a ingresar la informacion')
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
                    'data' => array('message' => 'ha ocurrido un error al ingresar el presupuesto modificado, vuelva a ingresar la informacion')
                );
            }
        }

        public function verificaCantidadPresupuestoModificar () {
            try {
                $this->conexionBD = new Conexion();
                $this->consulta = $this->conexionBD->connect();
                $stmt = $this->consulta->prepare("WITH CTE_VER_PRESUPUESTO AS (SELECT ControlPresupuestoActividad.presupuestoAnual, SUM(PresupuestoDepartamento.montoPresupuesto) AS montoTotalPorDepartamentos, ControlPresupuestoActividad.idControlPresupuestoActividad FROM ControlPresupuestoActividad LEFT JOIN PresupuestoDepartamento ON (PresupuestoDepartamento.idControlPresupuestoActividad = ControlPresupuestoActividad.idControlPresupuestoActividad) LEFT JOIN Departamento ON (PresupuestoDepartamento.idDepartamento = Departamento.idDepartamento) GROUP BY ControlPresupuestoActividad.presupuestoAnual) SELECT * FROM CTE_VER_PRESUPUESTO WHERE CTE_VER_PRESUPUESTO.idControlPresupuestoActividad = :idPresupuestoAnual;");
                $stmt->bindValue(':idPresupuestoAnual', $this->idControlPresupuestoActividad);
                if ($stmt->execute()) {
                    $data = $stmt->fetchObject();
                    if ($data->montoTotalPorDepartamentos == null) {
                        $monto = 0;
                    } else {
                        $monto = $data->montoTotalPorDepartamentos;
                    }
                    if ($monto > $this->presupuestoAnual) {
                        return true;
                    } else {
                        return false;
                    }
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

        public function modificaPresupuesto() {
            if (is_int($this->idControlPresupuestoActividad) && validaCampoMonetario($this->presupuestoAnual) && is_int($this->estadoPresupuestoAnual)) {
                if ($this->verificaCantidadPresupuestoModificar() == true) {
                    return array(
                        'status'=> BAD_REQUEST,
                        'data' => array('message' => 'ha ocurrido un error, el presupuesto a modificar es menor al presupuesto utilizado por los departamento, reajuste el presupuesto de los departamentos o aumente el presupuesto anual')
                    );
                } else {
                    try {
                        $this->conexionBD = new Conexion();
                        $this->consulta = $this->conexionBD->connect();

                        $this->consulta->prepare("
                            set @persona = {$_SESSION['idUsuario']};
                        ")->execute();

                        $stmt = $this->consulta->prepare('UPDATE ' . $this->tablaBaseDatos . ' SET presupuestoAnual = :presupuesto, idEstadoPresupuestoAnual = :estado WHERE idControlPresupuestoActividad = :idPresupuestoAnual');
                        $stmt->bindValue(':idPresupuestoAnual', $this->idControlPresupuestoActividad);
                        $stmt->bindValue(':estado', $this->estadoPresupuestoAnual);
                        $stmt->bindValue(':presupuesto', $this->presupuestoAnual);
                        
                        if ($stmt->execute()) {
                            return array(
                                'status'=> SUCCESS_REQUEST,
                                'data' => array('message' => 'El presupuesto fue modificado con exito')
                            );
                        } else {
                            return array(
                                'status'=> BAD_REQUEST,
                                'data' => array('message' => 'ha ocurrido un error al actualizar el presupuesto, vuelva a ingresar la informacion')
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
            } else {
                return array(
                    'status'=> BAD_REQUEST,
                    'data' => array('message' => 'ha ocurrido un error al actualizar el presupuesto, vuelva a ingresar la informacion')
                );
            }
        }
    }
?>