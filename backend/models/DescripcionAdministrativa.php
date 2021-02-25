<?php
    require_once('../../config/config.php');
    require_once('../../database/Conexion.php');
    require_once('../../validators/validators.php');
    class DescripcionAdministrativa {
        private $idDescripcionAdministrativa;
        private $idObjetoGasto;
        private $idTipoPresupuesto;
        private $idActividad;
        private $idDimensionAdministrativa;
        private $nombreActividad;
        private $cantidad;
        private $costo;
        private $costoTotal;
        private $mesRequerido;
        private $descripcion;
        private $unidadDeMedida;

        private $conexionBD;
        private $consulta;
        private $tablaBaseDatos;


        public function getIdDescripcionAdministrativa() {
            return $this->idDescripcionAdministrativa;
        }

        public function setIdDescripcionAdministrativa($idDescripcionAdministrativa) {
            $this->idDescripcionAdministrativa = $idDescripcionAdministrativa;
            return $this;
        }

        public function getIdObjetoGasto() {
            return $this->idObjetoGasto;
        }

        public function setIdObjetoGasto($idObjetoGasto) {
            $this->idObjetoGasto = $idObjetoGasto;
            return $this;
        }

        public function getIdTipoPresupuesto() {
            return $this->idTipoPresupuesto;
        }

        public function setIdTipoPresupuesto($idTipoPresupuesto) {
            $this->idTipoPresupuesto = $idTipoPresupuesto;
            return $this;
        }

        public function getIdActividad() {
            return $this->idActividad;
        }

        public function setIdActividad($idActividad) {
            $this->idActividad = $idActividad;
            return $this;
        }

        public function getIdDimensionAdministrativa() {
            return $this->idDimensionAdministrativa;
        }

        public function setIdDimensionAdministrativa($idDimensionAdministrativa) {
            $this->idDimensionAdministrativa = $idDimensionAdministrativa;
            return $this;
        }

        public function getCantidad() {
            return $this->cantidad;
        }

        public function setCantidad($cantidad) {
            $this->cantidad = $cantidad;
            return $this;
        }

        public function getCosto() {
            return $this->costo;
        }

        public function setCosto($costo) {
            $this->costo = $costo;
            return $this;
        }

        public function getCostoTotal() {
            return $this->costoTotal;
        }

        public function setCostoTotal($costoTotal) {
            $this->costoTotal = $costoTotal;
            return $this;
        }

        public function getMesRequerido() {
            return $this->mesRequerido;
        }

        public function setMesRequerido($mesRequerido) {
            $this->mesRequerido = $mesRequerido;
            return $this;
        }

        public function getDescripcion() {
            return $this->descripcion;
        }

        public function setDescripcion($descripcion) {
            $this->descripcion = $descripcion;
            return $this;
        }
        public function getNombreActividad(){
            return $this->nombreActividad;
        }

        public function setNombreActividad($nombreActividad){
            $this->nombreActividad = $nombreActividad;
            return $this;
        }

        public function getUnidadDeMedida() {
            return $this->unidadDeMedida;
        }


        public function setUnidadDeMedida($unidadDeMedida) {
            $this->unidadDeMedida = $unidadDeMedida;
            return $this;
        }

        public function __construct () {
            $this->tablaBaseDatos = TBL_DESCRIPCION_ADMINISTRATIVA;
        }

        public function compruebaCostoActividad () {
            try {
                $this->conexionBD = new Conexion();
                $this->consulta = $this->conexionBD->connect();
                $stmt = $this->consulta->prepare('SELECT  SUM(DescripcionAdministrativa.costoTotal) AS costoDescripcionAdmin,
                Actividad.idActividad, (SELECT Actividad.costoTotal FROM ACTIVIDAD WHERE idActividad = :idActividad) AS costoActividad FROM DescripcionAdministrativa RIGHT JOIN Actividad ON (DescripcionAdministrativa.idActividad = Actividad.idActividad) WHERE Actividad.idActividad = :idActividad1');
                $stmt->bindValue(':idActividad', $this->idActividad);
                $stmt->bindValue(':idActividad1', $this->idActividad);
                if ($stmt->execute()) {
                    $data = $stmt->fetchObject();
                    if ($data->costoDescripcionAdmin == null) {
                        $costoAcumuladoPorActividades = 0;
                    } else {
                        $costoAcumuladoPorActividades = $data->costoDescripcionAdmin;
                    }
                    $costoPorCantidad = $this->cantidad * $this->costo;
                    $costoNuevoDescripcion = $costoPorCantidad + $costoAcumuladoPorActividades;
                    if ($costoNuevoDescripcion > $data->costoActividad) {
                        return false;
                    } else {
                        return true;
                    }
                    
                } else {
                    return false;
                }
            } catch (PDOException $ex) {
                return false;
            } finally {
                $this->conexionBD = null;
            } 
        }

        public function compruebaCostoActividadModificar () {
            try {
                $this->conexionBD = new Conexion();
                $this->consulta = $this->conexionBD->connect();
                $stmt = $this->consulta->prepare('SELECT SUM(DescripcionAdministrativa.costoTotal) AS costoDescripcionAdmin,
                Actividad.idActividad, (SELECT Actividad.costoTotal FROM ACTIVIDAD WHERE idActividad = :idActividad) AS costoActividad , (SELECT CostoTotal FROM DescripcionAdministrativa WHERE idDescripcionAdministrativa = :idDescripcion) AS costoItem FROM DescripcionAdministrativa RIGHT JOIN Actividad ON (DescripcionAdministrativa.idActividad = Actividad.idActividad) WHERE Actividad.idActividad = :idActividad1;');
                $stmt->bindValue(':idActividad', $this->idActividad);
                $stmt->bindValue(':idDescripcion', $this->idDescripcionAdministrativa);
                $stmt->bindValue(':idActividad1', $this->idActividad);
                if ($stmt->execute()) {
                    $data = $stmt->fetchObject();
                    if ($data->costoDescripcionAdmin == null) {
                        $costoAcumuladoPorActividades = 0;
                    } else {
                        $costoAcumuladoPorActividades = $data->costoDescripcionAdmin;
                    }
                    $costoPorCantidad = $this->cantidad * $this->costo;
                    $costoNuevoDescripcion = (($costoAcumuladoPorActividades - $data->costoItem) + $costoPorCantidad);
                    if ($costoNuevoDescripcion > $data->costoActividad) {
                        return false;
                    } else {
                        return true;
                    }
                    
                } else {
                    return false;
                }
            } catch (PDOException $ex) {
                return false;
            } finally {
                $this->conexionBD = null;
            } 
        }

        public function insertaDescripcionAdministrativa () {
            if (
                is_int($this->idObjetoGasto) && 
                is_int($this->idTipoPresupuesto) && 
                is_int($this->idActividad) && 
                is_int($this->idDimensionAdministrativa) &&
                is_numeric($this->cantidad) &&
                is_numeric($this->costo) &&
                is_numeric($this->costoTotal)) {
                    $calculoCorrecto = $this->compruebaCostoActividad();
                    if ($calculoCorrecto == true) {
                        try {
                            $this->conexionBD = new Conexion();
                            $this->consulta = $this->conexionBD->connect();
                            $stmt = $this->consulta->prepare('INSERT INTO DescripcionAdministrativa (idObjetoGasto, idTipoPresupuesto, idActividad, idDimensionAdministrativa, nombreActividad, Cantidad, Costo, costoTotal, mesRequerido, Descripcion, unidadDeMedida) VALUES (:idObjeto, :idTipoPresupuesto, :idActividad, :idDimension, :nombreAct, :cantidad, :costo, :costoTotal, :mesRequerido, :descripcion, :unidadMedida)');
                            $stmt->bindValue(':idObjeto', $this->idObjetoGasto);
                            $stmt->bindValue(':idTipoPresupuesto', $this->idTipoPresupuesto);
                            $stmt->bindValue(':idActividad', $this->idActividad);
                            $stmt->bindValue(':idDimension', $this->idDimensionAdministrativa);
                            $stmt->bindValue(':cantidad', $this->cantidad);
                            $stmt->bindValue(':nombreAct', $this->nombreActividad);
                            $stmt->bindValue(':costo', $this->costo);
                            $stmt->bindValue(':costoTotal', $this->costo * $this->cantidad);
                            $stmt->bindValue(':mesRequerido', $this->mesRequerido);
                            $stmt->bindValue(':descripcion', json_encode($this->descripcion));
                            $stmt->bindValue(':unidadMedida', $this->unidadDeMedida);

                            if ($stmt->execute()) {
                                return array(
                                    'status'=> SUCCESS_REQUEST,
                                    'data' => array('message' => 'El item fue agregado a la actividad exitosamente')
                                );
                            } else {
                                return array(
                                    'status'=> BAD_REQUEST,
                                    'data' => array('message' => 'ha ocurrido un error al listar los tipos de costos de la actividad')
                                );
                            }
                        } catch (PDOException $ex) {
                            return array(
                                'status'=> INTERNAL_SERVER_ERROR,
                                'data' => array('message' => $ex->getMessage() . $this->Descripcion)
                            );
                        } finally {
                            $this->conexionBD = null;
                        } 
                    } else {
                        return array(
                            'status'=> BAD_REQUEST,
                            'data' => array('message' => 'ha ocurrido un error al insertar la descripcion de la actividad, el costo * cantidad excede el costo de la actividad, por favor verifique los datos')
                        );
                    }
                } else {
                    return array(
                        'status'=> BAD_REQUEST,
                        'data' => array('message' => 'ha ocurrido un error al insertar la descripcion de la actividad, los campos no son correctos')
                    );
                }
        }

        public function getDescripcionAdministrativaPorActividad () {
            if (is_int($this->idActividad) && is_int($this->idDimensionAdministrativa)) {
                try {
                    $this->conexionBD = new Conexion();
                    $this->consulta = $this->conexionBD->connect();
                    $stmt = $this->consulta->prepare('WITH CTE_LISTA_DESGLOSE_ACTIVIDAD AS (SELECT DescripcionAdministrativa.idDescripcionAdministrativa, DescripcionAdministrativa.nombreActividad, DescripcionAdministrativa.idObjetoGasto, ObjetoGasto.descripcionCuenta, ObjetoGasto.abrev ,DescripcionAdministrativa.idTipoPresupuesto, TipoPresupuesto.tipoPresupuesto, Actividad.idActividad, Actividad.Actividad, DescripcionAdministrativa.idDimensionAdministrativa, DimensionAdmin.dimensionAdministrativa, DescripcionAdministrativa.Cantidad, DescripcionAdministrativa.Costo, DescripcionAdministrativa.costoTotal, DescripcionAdministrativa.mesRequerido, DescripcionAdministrativa.Descripcion, DescripcionAdministrativa.unidadDeMedida, Actividad.idDimension, DimensionEstrategica.dimensionEstrategica FROM DescripcionAdministrativa INNER JOIN  ObjetoGasto ON (DescripcionAdministrativa.idObjetoGasto = ObjetoGasto.idObjetoGasto) INNER JOIN Actividad ON (DescripcionAdministrativa.idActividad = Actividad.idActividad) INNER JOIN TipoPresupuesto ON (DescripcionAdministrativa.idTipoPresupuesto = TipoPresupuesto.idTipoPresupuesto) INNER JOIN DimensionAdmin ON (DescripcionAdministrativa.idDimensionAdministrativa = DimensionAdmin.idDimension) INNER JOIN DimensionEstrategica ON (Actividad.idDimension = DimensionEstrategica.idDimension)) SELECT * FROM CTE_LISTA_DESGLOSE_ACTIVIDAD WHERE CTE_LISTA_DESGLOSE_ACTIVIDAD.idActividad = :idActividad  AND CTE_LISTA_DESGLOSE_ACTIVIDAD.idDimensionAdministrativa = :idDimenAdmin ORDER BY CTE_LISTA_DESGLOSE_ACTIVIDAD.idDescripcionAdministrativa DESC');
                    $stmt->bindValue(':idActividad', $this->idActividad);
                    $stmt->bindValue(':idDimenAdmin', $this->idDimensionAdministrativa);
                    if ($stmt->execute()) {
                        return array(
                            'status'=> SUCCESS_REQUEST,
                            'data' => $stmt->fetchAll(PDO::FETCH_OBJ)
                        );
                    } else {
                        return array(
                            'status'=> BAD_REQUEST,
                            'data' => array('message' => 'ha ocurrido un error al listar los tipos de costos de la actividad')
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
                    'data' => array('message' => 'ha ocurrido un error al listar la descripcion de la actividad, el id no es correcto')
                );
            }
        }

        public function modifDescripcionAdministrativa () {
            if (
                is_int($this->idDescripcionAdministrativa) &&
                is_int($this->idObjetoGasto) && 
                is_int($this->idTipoPresupuesto) && 
                is_int($this->idActividad) && 
                is_int($this->idDimensionAdministrativa) &&
                is_numeric($this->cantidad) &&
                is_numeric($this->costo) &&
                is_numeric($this->costoTotal)) {
                    $calculoCorrecto = $this->compruebaCostoActividadModificar();
                    if ($calculoCorrecto == true) {
                        try {
                            $this->conexionBD = new Conexion();
                            $this->consulta = $this->conexionBD->connect();
                            $stmt = $this->consulta->prepare('UPDATE DescripcionAdministrativa SET idObjetoGasto = :idObjeto, idTipoPresupuesto = :idTipoPresupuesto, idActividad = :idActividad, idDimensionAdministrativa = :idDimension, nombreActividad = :nombreAct, Cantidad = :cantidad, Costo = :costo, costoTotal = :costoTotal, mesRequerido = :mesRequerido, Descripcion = :descripcion, unidadDeMedida = :unidadMedida WHERE idDescripcionAdministrativa = :idDescripcion ');
                            $stmt->bindValue(':idDescripcion', $this->idDescripcionAdministrativa);
                            $stmt->bindValue(':idObjeto', $this->idObjetoGasto);
                            $stmt->bindValue(':idTipoPresupuesto', $this->idTipoPresupuesto);
                            $stmt->bindValue(':idActividad', $this->idActividad);
                            $stmt->bindValue(':idDimension', $this->idDimensionAdministrativa);
                            $stmt->bindValue(':nombreAct', $this->nombreActividad);
                            $stmt->bindValue(':cantidad', $this->cantidad);
                            $stmt->bindValue(':costo', $this->costo);
                            $stmt->bindValue(':costoTotal', $this->costo * $this->cantidad);
                            $stmt->bindValue(':mesRequerido', $this->mesRequerido);
                            $stmt->bindValue(':descripcion', json_encode($this->descripcion));
                            $stmt->bindValue(':unidadMedida', $this->unidadDeMedida);
                            if ($stmt->execute()) {
                                return array(
                                    'status'=> SUCCESS_REQUEST,
                                    'data' => array('message' => 'El item fue agregado a la actividad exitosamente')
                                );
                            } else {
                                return array(
                                    'status'=> BAD_REQUEST,
                                    'data' => array('message' => 'ha ocurrido un error al listar los tipos de costos de la actividad')
                                );
                            }
                        } catch (PDOException $ex) {
                            return array(
                                'status'=> INTERNAL_SERVER_ERROR,
                                'data' => array('message' => $ex->getMessage() . $this->Descripcion)
                            );
                        } finally {
                            $this->conexionBD = null;
                        } 
                    } else {
                        return array(
                            'status'=> BAD_REQUEST,
                            'data' => array('message' => 'ha ocurrido un error al insertar la descripcion de la actividad, el costo * cantidad excede el costo de la actividad, por favor verifique los datos')
                        );
                    }
                } else {
                    return array(
                        'status'=> BAD_REQUEST,
                        'data' => array('message' => 'ha ocurrido un error al insertar la descripcion de la actividad, los campos no son correctos')
                    );
                }
        }


        public function generaDescripcionAdmin () {
            if (is_int($this->idDescripcionAdministrativa)) {
                $this->conexionBD = new Conexion();
                $this->consulta = $this->conexionBD->connect();
                $stmt = $this->consulta->prepare("WITH CTE_GENERA_DESCRIPCION_ADMIN AS (SELECT DescripcionAdministrativa.Cantidad, DescripcionAdministrativa.Costo, DescripcionAdministrativa.idActividad, DescripcionAdministrativa.descripcion,DescripcionAdministrativa.idDescripcionAdministrativa, DescripcionAdministrativa.idDimensionAdministrativa,DescripcionAdministrativa.mesRequerido, DescripcionAdministrativa.idObjetoGasto, ObjetoGasto.abrev, ObjetoGasto.descripcionCuenta, DescripcionAdministrativa.idTipoPresupuesto, TipoPresupuesto.tipoPresupuesto, DescripcionAdministrativa.nombreActividad, DescripcionAdministrativa.unidadDeMedida FROM DescripcionAdministrativa INNER JOIN ObjetoGasto ON (DescripcionAdministrativa.idObjetoGasto = ObjetoGasto.idObjetoGasto) INNER JOIN TipoPresupuesto ON (DescripcionAdministrativa.idTipoPresupuesto = TipoPresupuesto.idTipoPresupuesto)) SELECT * FROM CTE_GENERA_DESCRIPCION_ADMIN WHERE CTE_GENERA_DESCRIPCION_ADMIN.idDescripcionAdministrativa = :idDescripcion;");
                $stmt->bindValue(':idDescripcion', $this->idDescripcionAdministrativa);
                if ($stmt->execute()) {
                    return array(
                        'status'=> SUCCESS_REQUEST,
                        'data' => $stmt->fetchObject()
                    );
                } else {
                    return array(
                        'status'=> BAD_REQUEST,
                        'data' => array('message' => 'ha ocurrido un error al listar la descripcion administrativa')
                    );
                }
            } else {
                return array(
                    'status'=> BAD_REQUEST,
                    'data' => array('message' => 'ha ocurrido un error al listar la descripcion administrativa')
                );
            }
        }
    }
?>