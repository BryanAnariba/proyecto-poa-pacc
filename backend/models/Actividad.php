<?php
    if (!isset($_SESSION)) {
        session_start();
    }
    require_once('../../config/config.php');
    require_once('../../database/Conexion.php');
    require_once('../../validators/validators.php');
    require_once('CostoActividadPorTrimestre.php');

    class Actividad extends CostoActividadPorTrimestre {
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

        public function generaCorrelativoActividad () {
            if (is_int($this->idDimension)) {
                $this->conexionBD = new Conexion();
                $this->consulta = $this->conexionBD->connect();
                $stmt = $this->consulta->prepare("WITH CTE_LISTADO_ACT_POR_DIM AS (SELECT (COUNT(Actividad.idActividad) + 1) AS numeroActividad, DATE_FORMAT(NOW(), '%Y') AS anioActividad, DimensionEstrategica.idDimension, DimensionEstrategica.dimensionEstrategica, DimensionEstrategica.idEstadoDimension FROM Actividad RIGHT JOIN DimensionEstrategica ON (Actividad.idDimension = DimensionEstrategica.idDimension) INNER JOIN Estadodcduoao ON (DimensionEstrategica.idEstadoDimension = Estadodcduoao.idEstado) GROUP BY DimensionEstrategica.idDimension, DimensionEstrategica.dimensionEstrategica) SELECT * FROM CTE_LISTADO_ACT_POR_DIM WHERE CTE_LISTADO_ACT_POR_DIM.idEstadoDimension = :idEstado AND (SELECT ControlPresupuestoActividad.idEstadoPresupuestoAnual FROM ControlPresupuestoActividad LEFT JOIN PresupuestoDepartamento ON (ControlPresupuestoActividad.idControlPresupuestoActividad = PresupuestoDepartamento.idControlPresupuestoActividad) RIGHT JOIN Departamento ON (PresupuestoDepartamento.idDepartamento = Departamento.idDepartamento) LEFT JOIN Usuario ON (Departamento.idDepartamento = Usuario.idDepartamento) INNER JOIN EstadoDCDUOAO ON (ControlPresupuestoActividad.idEstadoPresupuestoAnual = EstadoDCDUOAO.idEstado) WHERE Departamento.idDepartamento = :idDepartamento AND Usuario.idPersonaUsuario = :idUsuario AND DATE_FORMAT(ControlPresupuestoActividad.fechaPresupuestoAnual, '%Y') = DATE_FORMAT(NOW(), '%Y')) AND CTE_LISTADO_ACT_POR_DIM.idDimension = :idDimension;");
                $stmt->bindValue(':idEstado', ESTADO_ACTIVO);
                $stmt->bindValue(':idDepartamento', $_SESSION['idDepartamento']);
                $stmt->bindValue(':idUsuario', $_SESSION['idUsuario']);
                $stmt->bindValue(':idDimension', $this->idDimension);
                if ($stmt->execute()) {
                    $data = $stmt->fetchObject();
                    $correlativoActividad = $_SESSION['abrev'] . '_' . $data->anioActividad . '_' . $this->idDimension . '.' . $data->numeroActividad;
                    return array(
                        'status' => SUCCESS_REQUEST,
                        'data' => array('correlativoActividad' => $correlativoActividad)
                    );
                } else {
                    return array(
                        'status'=> BAD_REQUEST,
                        'data' => array('message' => 'Ha ocurrido un error')
                    );
                }
            } else {
                return array(
                    'status'=> BAD_REQUEST,
                    'data' => array('message' => 'Ha ocurrido un error al generar el correlativo, por favor recargue la pagina')
                );
            }
        }

        public function getComparativaDePresupuestos() {
            try {
                $this->conexionBD = new Conexion();
                $this->consulta = $this->conexionBD->connect();
                $stmt = $this->consulta->prepare("SELECT SUM(Actividad.CostoTotal) AS costoActividadesDepto, DATE_FORMAT(Actividad.fechaCreacionActividad, '%Y') AS anioSumaActividades, Actividad.idPersonaUsuario, Usuario.nombreUsuario, Usuario.idDepartamento, Departamento.nombreDepartamento, (SELECT PresupuestoDepartamento.montoPresupuesto FROM PresupuestoDepartamento WHERE PresupuestoDepartamento.idDepartamento = :idDepartamento AND DATE_FORMAT(PresupuestoDepartamento.fechaAprobacionPresupuesto, '%Y') = DATE_FORMAT(NOW(), '%Y')) AS PresupuestoTotalDepartamento
                FROM Actividad RIGHT JOIN Usuario ON (Actividad.idPersonaUsuario = Usuario.idPersonaUsuario) INNER JOIN Departamento ON (Usuario.idDepartamento = Departamento.idDepartamento) LEFT JOIN PresupuestoDepartamento ON (PresupuestoDepartamento.idDepartamento = Departamento.idDepartamento) WHERE Usuario.idPersonaUsuario = :idUsuario  AND Departamento.idDepartamento = :idDepto AND (DATE_FORMAT(Actividad.fechaCreacionActividad, '%Y') = DATE_FORMAT(NOW(), '%Y'));");
                $stmt->bindValue(':idDepartamento', $_SESSION['idDepartamento']);
                $stmt->bindValue(':idUsuario', $_SESSION['idUsuario']);
                $stmt->bindValue(':idDepto', $_SESSION['idDepartamento']);
                if ($stmt->execute()) {
                    $data = $stmt->fetchObject();
                    if ($data->costoActividadesDepto == null) {
                        $presupuestoDeptoConsumido = 0;
                    } else {
                        $presupuestoDeptoConsumido = $data->costoActividadesDepto;
                    }
                    return array(
                        'status' => SUCCESS_REQUEST,
                        'data' => array(
                            'presupuestoTotalDepartamento' => ($data->PresupuestoTotalDepartamento - $presupuestoDeptoConsumido),
                            'presupuestoConsumidoPorDepto' => $presupuestoDeptoConsumido
                        )
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

        public function verificaDatosPresupuestoActividad() {
            if (
                is_numeric($this->costoTotal) && 
                is_numeric($this->porcentajeTrimestre1) && 
                is_numeric($this->porcentajeTrimestre2) && 
                is_numeric($this->porcentajeTrimestre3) &&
                is_numeric($this->porcentajeTrimestre4)
                ) {
                    try {
                        $this->conexionBD = new Conexion();
                        $this->consulta = $this->conexionBD->connect();
                        $stmt = $this->consulta->prepare("SELECT SUM(Actividad.CostoTotal) AS costoActividadesDepto, DATE_FORMAT(Actividad.fechaCreacionActividad, '%Y') AS anioSumaActividades, Actividad.idPersonaUsuario, Usuario.nombreUsuario, Usuario.idDepartamento, Departamento.nombreDepartamento, (SELECT PresupuestoDepartamento.montoPresupuesto FROM PresupuestoDepartamento WHERE PresupuestoDepartamento.idDepartamento = :idDepartamento AND DATE_FORMAT(PresupuestoDepartamento.fechaAprobacionPresupuesto, '%Y') = DATE_FORMAT(NOW(), '%Y')) AS PresupuestoTotalDepartamento
                        FROM Actividad RIGHT JOIN Usuario ON (Actividad.idPersonaUsuario = Usuario.idPersonaUsuario) INNER JOIN Departamento ON (Usuario.idDepartamento = Departamento.idDepartamento) LEFT JOIN PresupuestoDepartamento ON (PresupuestoDepartamento.idDepartamento = Departamento.idDepartamento) WHERE Usuario.idPersonaUsuario = :idUsuario  AND Departamento.idDepartamento = :idDepto AND (DATE_FORMAT(Actividad.fechaCreacionActividad, '%Y') = DATE_FORMAT(NOW(), '%Y'));");
                        $stmt->bindValue(':idDepartamento', $_SESSION['idDepartamento']);
                        $stmt->bindValue(':idUsuario', $_SESSION['idUsuario']);
                        $stmt->bindValue(':idDepto', $_SESSION['idDepartamento']);
                        if ($stmt->execute()) {
                            $data = $stmt->fetchObject();
                            if ($data->costoActividadesDepto == null) {
                                $costoActividadesActual = 0;
                            } else {
                                $costoActividadesActual = $data->costoActividadesDepto;
                            }

                            if (($this->costoTotal + $costoActividadesActual) > $data->PresupuestoTotalDepartamento) {
                                return array(
                                    'status'=> BAD_REQUEST,
                                    'data' => array('message' => 'Ha ocurrido un error, el costo de la actividad supera el costo disponible del departamento, por favor cambie el monto de la actividad a un costo dentro del rango, REGRESE NUEVAMENTE AL PASO ANTERIOR Metas Trimestrales')
                                );
                            } else {
                                $pt1 = $this->porcentajeTrimestre1/100; 
                                $pt2 = $this->porcentajeTrimestre2/100; 
                                $pt3 = $this->porcentajeTrimestre3/100; 
                                $pt4 = $this->porcentajeTrimestre4/100; 
                                if (($pt1 + $pt2 + $pt3 + $pt4) == 1) {
                                    $sumatoriaValorActividad = $pt1*$this->costoTotal + $pt2*$this->costoTotal + $pt3*$this->costoTotal + $pt4*$this->costoTotal;
                                    if ($sumatoriaValorActividad == $this->costoTotal) {
                                        return array(
                                            'status' => SUCCESS_REQUEST,
                                            'data' => true
                                        );
                                    } else {
                                        return array(
                                            'status'=> BAD_REQUEST,
                                            'data' => array('message' => 'Ha ocurrido un error, la distribucion del dinero en los trimestres excede al costo de la actividad, por favor verifique nuevamente los porcentajes, REGRESE NUEVAMENTE AL PASO ANTERIOR Metas Trimestrales')
                                        );
                                    }
                                } else {
                                    return array(
                                        'status'=> BAD_REQUEST,
                                        'data' => array('message' => 'Ha ocurrido un error, la sumatoria de los porcentajes no da 1, por favor verifique nuevamente los porcentajes, REGRESE NUEVAMENTE AL PASO ANTERIOR Metas Trimestrales')
                                    );
                                }
                            }
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
            } else {
                return array(
                    'status'=> BAD_REQUEST,
                    'data' => array('message' => 'Ha ocurrido un error, los datos incluidos en el Paso de Metas Trimestrales no son correctos')
                );
            }
        }

        public function insertaActividad() {
            if (
                is_int($this->idDimension) &&
                is_int($this->idObjetivoInstitucional) &&
                is_int($this->idResultadoInstitucional) &&
                is_int($this->idAreaEstrategica) &&
                is_int($this->idTipoActividad) &&
                campoTexto($this->actividad, 1, 200) && 
                campoTexto($this->resultadosUnidad, 1, 200) && 
                campoTexto($this->indicadoresResultado, 1, 200) &&
                campoTexto($this->justificacionActividad, 1, 255) &&
                campoTexto($this->medioVerificacionActividad, 1, 255) &&
                campoTexto($this->poblacionOjetivoActividad, 1, 255) &&
                campoTexto($this->responsableActividad, 1, 255) &&
                is_numeric($this->costoTotal) &&
                is_numeric($this->porcentajeTrimestre1) &&
                is_numeric($this->porcentajeTrimestre2) &&
                is_numeric($this->porcentajeTrimestre3) &&
                is_numeric($this->porcentajeTrimestre4)
            ) {
                try {
                    $this->conexionBD = new Conexion();
                    $this->consulta = $this->conexionBD->connect();
                    $stmt = $this->consulta->prepare("INSERT INTO Actividad (idPersonaUsuario, idDimension, idObjetivoInstitucional, idResultadoInstitucional, idAreaEstrategica, idTipoActividad, resultadosUnidad, indicadoresResultado, actividad, correlativoActividad, justificacionActividad, medioVerificacionActividad, poblacionObjetivoActividad, responsableActividad, fechaCreacionActividad, CostoTotal) VALUES (:idUsuario, :idDimension, :idObjetivo, :idResultado, :idArea, :idTipoCosto, :resultado, :indicadores, :nombreActividad, :correlativo, :justificacion, :medio, :poblacion, :responsable, NOW() ,:costo)");
                    $stmt->bindValue(':idUsuario', $_SESSION['idUsuario']);
                    $stmt->bindValue(':idDimension', $this->idDimension);
                    $stmt->bindValue(':idObjetivo', $this->idObjetivoInstitucional);
                    $stmt->bindValue(':idResultado', $this->idResultadoInstitucional);
                    $stmt->bindValue(':idArea', $this->idAreaEstrategica);
                    $stmt->bindValue(':idTipoCosto', $this->idTipoActividad);
                    $stmt->bindValue(':resultado', $this->resultadosUnidad);
                    $stmt->bindValue(':indicadores', $this->indicadoresResultado);
                    $stmt->bindValue(':nombreActividad', $this->actividad);
                    $stmt->bindValue(':correlativo', $this->correlativoActividad);
                    $stmt->bindValue(':justificacion', $this->justificacionActividad);
                    $stmt->bindValue(':medio', $this->medioVerificacionActividad);
                    $stmt->bindValue(':poblacion', $this->poblacionOjetivoActividad);
                    $stmt->bindValue(':responsable', $this->responsableActividad);
                    $stmt->bindValue(':costo', $this->costoTotal);
                    if ($stmt->execute()) {
                        $insertaCostos = parent::insertaCostoActividadPorTrimestreDimension($this->consulta->lastInsertId(), $this->costoTotal);
                        if($insertaCostos==true) {
                            return array(
                                'status'=> SUCCESS_REQUEST,
                                'data' => array('message' => 'La actividad fue insertada exitosamente, por favor desglose los items de la actividad en el siguiente modal de Dimensiones Administrativas')
                            );
                        } else {
                            return array(
                                'status'=> BAD_REQUEST,
                                'data' => array('message' => 'Ha ocurrido un error, los costos no se instalaron' . $this->consulta->lastInsertId())
                            );
                        }
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
            } else {
                return array(
                    'status'=> BAD_REQUEST,
                    'data' => array('message' => 'Ha ocurrido un error, la informacion de la actividad no se pudo registrar, verifique los campos nuevamente')
                );
            }
        }

        public function getActividadesDimension () {
            if (
                is_int($this->idDimension)
            ) {
                try {
                    $this->conexionBD = new Conexion();
                    $this->consulta = $this->conexionBD->connect();
                    $stmt = $this->consulta->prepare("WITH CTE_LISTA_ACTIVIDADES_DIMENSION AS (SELECT Actividad.idActividad, Actividad.idPersonaUsuario, Usuario.nombreUsuario, Usuario.idDepartamento, Departamento.nombreDepartamento,Actividad.idDimension, DimensionEstrategica.dimensionEstrategica, Actividad.idObjetivoInstitucional, ObjetivoInstitucional.objetivoInstitucional, Actividad.idResultadoInstitucional, ResultadoInstitucional.resultadoInstitucional, Actividad.idAreaEstrategica, AreaEstrategica.areaEstrategica, Actividad.idTipoActividad, TipoActividad.tipoActividad, Actividad.resultadosUnidad, Actividad.indicadoresResultado, Actividad.actividad, Actividad.correlativoActividad, Actividad.justificacionActividad, Actividad.medioVerificacionActividad, Actividad.poblacionObjetivoActividad, Actividad.responsableActividad, Actividad.fechaCreacionActividad, Actividad.CostoTotal, CostoActividadPorTrimestre.idCostActPorTri, CostoActividadPorTrimestre.porcentajeTrimestre1, CostoActividadPorTrimestre.Trimestre1, CostoActividadPorTrimestre.abrevTrimestre1, CostoActividadPorTrimestre.porcentajeTrimestre2, CostoActividadPorTrimestre.Trimestre2, CostoActividadPorTrimestre.abrevTrimestre2, CostoActividadPorTrimestre.porcentajeTrimestre3, CostoActividadPorTrimestre.Trimestre3, CostoActividadPorTrimestre.abrevTrimestre3, CostoActividadPorTrimestre.porcentajeTrimestre4, CostoActividadPorTrimestre.Trimestre4, CostoActividadPorTrimestre.abrevTrimestre4, CostoActividadPorTrimestre.sumatoriaPorcentaje FROM Actividad INNER JOIN DimensionEstrategica ON (Actividad.idDimension = DimensionEstrategica.idDimension) INNER JOIN ObjetivoInstitucional ON (Actividad.idObjetivoInstitucional = ObjetivoInstitucional.idObjetivoInstitucional) INNER JOIN AreaEstrategica ON (Actividad.idAreaEstrategica = AreaEstrategica.idAreaEstrategica) INNER JOIN ResultadoInstitucional ON (Actividad.idResultadoInstitucional = ResultadoInstitucional.idResultadoInstitucional) INNER JOIN TipoActividad ON (Actividad.idTipoActividad = TipoActividad.idTipoActividad) INNER JOIN CostoActividadPorTrimestre ON (CostoActividadPorTrimestre.idActividad = Actividad.idActividad) INNER JOIN Usuario ON (Actividad.idPersonaUsuario = Usuario.idPersonaUsuario) INNER JOIN DEPARTAMENTO ON (Usuario.idDepartamento = Departamento.idDepartamento)) SELECT * FROM CTE_LISTA_ACTIVIDADES_DIMENSION WHERE date_format(CTE_LISTA_ACTIVIDADES_DIMENSION.fechaCreacionActividad, '%Y') = date_format(NOW(), '%Y') AND CTE_LISTA_ACTIVIDADES_DIMENSION.idDimension = :idDimension AND CTE_LISTA_ACTIVIDADES_DIMENSION.idPersonaUsuario = :idUsuario ORDER BY CTE_LISTA_ACTIVIDADES_DIMENSION.idActividad DESC;");
                    $stmt->bindValue(':idDimension', $this->idDimension);
                    $stmt->bindValue(':idUsuario', $_SESSION['idUsuario']);
                    if ($stmt->execute()) {
                        return array(
                            'status'=> SUCCESS_REQUEST,
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
            } else {
                return array(
                    'status'=> BAD_REQUEST,
                    'data' => array('message' => 'Ha ocurrido un error, la informacion de las actividades no se pudo visualizar')
                );
            }
        }
    }
?>