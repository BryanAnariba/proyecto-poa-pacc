<?php
    require_once('../../validators/validators.php');
    require_once('../../config/config.php');

    class ResultadoInstitucional {
        private $idResultadoInstitucional;
        private $idObjetivoInstitucional;
        private $resultadoInstitucional;
        private $idEstadoResultadoInstitucional;

        private $conexionBD;
        private $consulta;
        private $tablaBaseDatos;

        public function getIdResultadoInstitucional(){
            return $this->idResultadoInstitucional;
        }

        public function setIdResultadoInstitucional($idResultadoInstitucional){
            $this->idResultadoInstitucional = $idResultadoInstitucional;
            return $this;
        }
        
        public function getIdObjetivoInstitucional(){
            return $this->idObjetivoInstitucional;
        }

        public function setIdObjetivoInstitucional($idObjetivoInstitucional){
            $this->idObjetivoInstitucional = $idObjetivoInstitucional;
            return $this;
        }

        public function getResultadoInstitucional() {
            return $this->resultadoInstitucional;
        }

        public function setResultadoInstitucional($resultadoInstitucional){
            $this->resultadoInstitucional = $resultadoInstitucional;
            return $this;
        }

        public function getIdEstadoResultadoInstitucional(){
            return $this->idEstadoResultadoInstitucional;
        }

        public function setIdEstadoResultadoInstitucional($idEstadoResultadoInstitucional){
            $this->idEstadoResultadoInstitucional = $idEstadoResultadoInstitucional;
            return $this;
        }

        public function __construct() {
            $this->tablaBaseDatos = TBL_RESULTADOS_INSTITUCIONALES;
        }

        public function getEstadoResultadoDimension () {

        }

        public function getResultadosInstitucionales () {
            $this->conexionBD = new Conexion();
            $this->consulta = $this->conexionBD->connect();

            try {
                $stmt = $this->consulta->prepare('WITH CTE_LISTAR_RESULTADOS_INSTITUCIONALES AS (SELECT ResultadoInstitucional.idResultadoInstitucional, ResultadoInstitucional.idObjetivoInstitucional, EstadoDCDUOAO.estado, ResultadoInstitucional.idEstadoResultadoInstitucional, ResultadoInstitucional.resultadoInstitucional FROM ResultadoInstitucional INNER JOIN EstadoDCDUOAO ON (ResultadoInstitucional.idEstadoResultadoInstitucional = EstadoDCDUOAO.idEstado)) SELECT * FROM CTE_LISTAR_RESULTADOS_INSTITUCIONALES WHERE CTE_LISTAR_RESULTADOS_INSTITUCIONALES.idObjetivoInstitucional = :idObjetivoInstitucional ORDER BY CTE_LISTAR_RESULTADOS_INSTITUCIONALES.idResultadoInstitucional ASC;');
                $stmt->bindValue(':idObjetivoInstitucional', $this->idObjetivoInstitucional);
                if ($stmt->execute()) {
                    return array(
                        'status' => SUCCESS_REQUEST,
                        'data' => $stmt->fetchAll(PDO::FETCH_OBJ)
                    );
                } else {
                    return array(
                        'status'=> BAD_REQUEST,
                        'data' => array('message' => 'Ha ocurrido un error al listar los resultados institucionales, por favor recargue la pagina nuevamente')
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

        public function getResultadosInstitucionalesActivos () {

        }

        public function registroResultadoInstitucional () {
            if (is_int($this->idEstadoResultadoInstitucional) && is_int($this->idObjetivoInstitucional) && campoTexto($this->resultadoInstitucional, 1, 500)) {
                try {
                    $this->conexionBD = new Conexion();
                    $this->consulta = $this->conexionBD->connect();
                    $stmt = $this->consulta->prepare('INSERT INTO ' . $this->tablaBaseDatos . '(idObjetivoInstitucional, idEstadoResultadoInstitucional, resultadoInstitucional) VALUES (:idObjetivoInstitucional, :idEstadoResultadoInstitucional, :resultadoInstitucional)');
                    $stmt->bindValue(':idObjetivoInstitucional', $this->idObjetivoInstitucional);
                    $stmt->bindValue(':idEstadoResultadoInstitucional', $this->idEstadoResultadoInstitucional);
                    $stmt->bindValue(':resultadoInstitucional', $this->resultadoInstitucional);
                    if ($stmt->execute()) {
                        return array(
                            'status' => SUCCESS_REQUEST,
                            'data' => array('message' => 'El resultado institucional fue insertado con exito')
                        );
                    } else {
                        return array(
                            'status'=> BAD_REQUEST,
                            'data' => array('message' => 'Ha ocurrido un error, al registrar el nuevo resultado institucional')
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
                    'data' => array('message' => 'Ha ocurrido un error, los datos ha insertar son erroneos')
                );
            }
        }
        
        public function modificarEstadoResultadoInstitucional () {
            if (is_int($this->idEstadoResultadoInstitucional) && is_int($this->idResultadoInstitucional)) {
                $this->conexionBD = new Conexion();
                $this->consulta = $this->conexionBD->connect();
    
                try {
                    $stmt = $this->consulta->prepare('UPDATE ' . $this->tablaBaseDatos . ' SET idEstadoResultadoInstitucional = :idEstado WHERE idResultadoInstitucional = :idResultado');
                    $stmt->bindValue(':idEstado', $this->idEstadoResultadoInstitucional);
                    $stmt->bindValue(':idResultado', $this->idResultadoInstitucional);
                    if ($stmt->execute()) {
                        return array(
                            'status'=> SUCCESS_REQUEST,
                            'data' => array('message' => 'El resultado institucional se cambio de estado exitosamente')
                        );
                    } else {
                        return array(
                            'status'=> BAD_REQUEST,
                            'data' => array('message' => 'Ha ocurrido un error al modificar el estado de los resultados institucionales, por favor recargue la pagina nuevamente')
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
                    'data' => array('message' => 'Ha ocurrido un error, los datos ha modificar son erroneos')
                );
            }
        }

        public function modificarResultadoInstitucional () {
            if (is_int($this->idResultadoInstitucional) && campoTexto($this->resultadoInstitucional, 1, 500)) {
                $this->conexionBD = new Conexion();
                $this->consulta = $this->conexionBD->connect();
    
                try {
                    $stmt = $this->consulta->prepare('UPDATE ' . $this->tablaBaseDatos . ' SET resultadoInstitucional = :resultado WHERE idResultadoInstitucional = :idResultado');
                    $stmt->bindValue(':idResultado', $this->idResultadoInstitucional);
                    $stmt->bindValue(':resultado', $this->resultadoInstitucional);
                    if ($stmt->execute()) {
                        return array(
                            'status'=> SUCCESS_REQUEST,
                            'data' => array('message' => 'El resultado institucional ha sido modificado exitosamente'));
                    } else {
                        return array(
                            'status'=> BAD_REQUEST,
                            'data' => array('message' => 'Ha ocurrido un error al modificar el resultado institucional, por favor recargue la pagina nuevamente')
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
                    'data' => array('message' => 'Ha ocurrido un error, los datos ha modificar son erroneos')
                );
            }
        }
    }
?>