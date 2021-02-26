<?php
    require_once('../../config/config.php');
    require_once('../../database/Conexion.php');
    require_once('../../validators/validators.php');
    require_once('../../models/DescripcionAdministrativa.php');

    
    require('../../vendor/autoload.php');
    use PhpOffice\PhpSpreadsheet\Spreadsheet;
    use PhpOffice\PhpSpreadsheet\Writer\Xlsx;
    use PhpOffice\PhpSpreadsheet\IOFactory;


    

    class Pacc {
        private $fechaPresupuestoAnual;
        private $idDepartamento;

        
        public function getFechaPresupuestoAnual() {
            return $this->fechaPresupuestoAnual;
        }

        public function setFechaPresupuestoAnual($fechaPresupuestoAnual) {
            $this->fechaPresupuestoAnual = $fechaPresupuestoAnual;
            return $this;
        }

        public function getIdDepartamento() {
            return $this->idDepartamento;
        }

        public function setIdDepartamento($idDepartamento) {
            $this->idDepartamento = $idDepartamento;
            return $this;
        }

        private $conexionBD;
        private $consulta;


        public function generaAnioPaccSeleccionado () {
            $this->conexionBD = new Conexion();
            $this->consulta = $this->conexionBD->connect();
            $stmt = $this->consulta->prepare("WITH CTE_GENERA_ANIO_PACC AS (SELECT YEAR(ControlPresupuestoActividad.fechaPresupuestoAnual) AS anioPacc FROM ControlPresupuestoActividad  WHERE ControlPresupuestoActividad.idControlPresupuestoActividad = :idPresupuesto) SELECT * FROM CTE_GENERA_ANIO_PACC;");
            $stmt->bindValue(':idPresupuesto', $this->fechaPresupuestoAnual);
            if ($stmt->execute()) {
                return $stmt->fetchObject();
            } else {
                return false;
            }
        }
        public function getDatosPacc () {
            try {
                $this->conexionBD = new Conexion();
                $this->consulta = $this->conexionBD->connect();
                $stmt = $this->consulta->prepare("WITH CTE_GENERA_PRESUPUESTOS_POR_DEPTO AS (SELECT PresupuestoDepartamento.montoPresupuesto, Departamento.nombreDepartamento FROM PresupuestoDepartamento INNER JOIN ControlPresupuestoActividad ON (PresupuestoDepartamento.idControlPresupuestoActividad = ControlPresupuestoActividad.idControlPresupuestoActividad) INNER JOIN Departamento ON (PresupuestoDepartamento.idDepartamento = Departamento.idDepartamento) WHERE ControlPresupuestoActividad.estadoLlenadoActividades = :estado AND Departamento.idEstadoDepartamento = :estadoDepartamento) SELECT * FROM CTE_GENERA_PRESUPUESTOS_POR_DEPTO;");
                $stmt->bindValue(':estado', ESTADO_ACTIVO);
                $stmt->bindValue(':estadoDepartamento', ESTADO_ACTIVO);
                if ($stmt->execute()) {
                    return array(
                        'status' => SUCCESS_REQUEST,
                        'data' => $stmt->fetchAll(PDO::FETCH_OBJ)
                    );
                } else {
                    return array(
                        'status'=> BAD_REQUEST,
                        'data' => array('message' => 'Ha ocurrido un error, los presupuestos no se listaron correctamente')
                    );
                }
            } catch (PDOException $ex) {
                return false;
            } finally {
                $this->conexionBD = null;
            }
        }

        public function generaPresupuestoAnualComparativa () {
            try {
                $this->conexionBD = new Conexion();
                $this->consulta = $this->conexionBD->connect();
                $stmt = $this->consulta->prepare("WITH CTE_GENERA_PRESUPUESTOS_COMPARATIVA AS (SELECT SUM(PresupuestoDepartamento.montoPresupuesto) AS montoUtilizado, ControlPresupuestoActividad.presupuestoAnual, YEAR(ControlPresupuestoActividad.fechaPresupuestoAnual) AS fechaPresupuesto FROM PresupuestoDepartamento INNER JOIN ControlPresupuestoActividad ON (PresupuestoDepartamento.idControlPresupuestoActividad = ControlPresupuestoActividad.idControlPresupuestoActividad) WHERE ControlPresupuestoActividad.estadoLlenadoActividades = :estado) SELECT * FROM CTE_GENERA_PRESUPUESTOS_COMPARATIVA;");
                $stmt->bindValue(':estado', ESTADO_ACTIVO);
                if ($stmt->execute()) {
                    return array(
                        'status' => SUCCESS_REQUEST,
                        'data' => $stmt->fetchObject()
                    );
                } else {
                    return array(
                        'status'=> BAD_REQUEST,
                        'data' => array('message' => 'Ha ocurrido un error, los presupuestos no se listaron correctamente')
                    );
                }
            } catch (PDOException $ex) {
                return false;
            } finally {
                $this->conexionBD = null;
            }
        }
        
        public function generaAniosPresupuestoAnual () {
            try {
                $this->conexionBD = new Conexion();
                $this->consulta = $this->conexionBD->connect();
                $stmt = $this->consulta->prepare("WITH CTE_LISTA_ANIOS_PRESUPUESTOS AS (SELECT ControlPresupuestoActividad.idControlPresupuestoActividad, YEAR(ControlPresupuestoActividad.fechaPresupuestoAnual) AS anio FROM ControlPresupuestoActividad) SELECT * FROM CTE_LISTA_ANIOS_PRESUPUESTOS; ");
                if ($stmt->execute()) {
                    return array(
                        'status' => SUCCESS_REQUEST,
                        'data' => $stmt->fetchAll(PDO::FETCH_OBJ)
                    );
                } else {
                    return array(
                        'status'=> BAD_REQUEST,
                        'data' => array('message' => 'Ha ocurrido un error, los presupuestos no se listaron correctamente')
                    );
                }
            } catch (PDOException $ex) {
                return false;
            } finally {
                $this->conexionBD = null;
            }
        }

        public function generaPaccFacultadIngenieria () {
            $this->conexionBD = new Conexion();
            $this->consulta = $this->conexionBD->connect();
            $stmt = $this->consulta->prepare("WITH CTE_QUERY_PACC_INGENIERIA AS (SELECT Actividad.CorrelativoActividad, ObjetoGasto.codigoObjetoGasto, DescripcionAdministrativa.nombreActividad, DescripcionAdministrativa.unidadDeMedida,DescripcionAdministrativa.cantidad, DescripcionAdministrativa.costo, DescripcionAdministrativa.costoTotal, Departamento.nombreDepartamento FROM DescripcionAdministrativa INNER JOIN  Actividad ON (DescripcionAdministrativa.idActividad = Actividad.idActividad) INNER JOIN ObjetoGasto ON (DescripcionAdministrativa.idObjetoGasto = ObjetoGasto.idObjetoGasto) INNER JOIN Usuario ON (Actividad.idPersonaUsuario = Usuario.idPersonaUsuario) INNER JOIN Departamento ON (Usuario.idDepartamento = Departamento.idDepartamento) WHERE DATE_FORMAT(Actividad.fechaCreacionActividad,'%Y') = (SELECT YEAR(ControlPresupuestoActividad.fechaPresupuestoAnual) FROM ControlPresupuestoActividad WHERE ControlPresupuestoActividad.idControlPresupuestoActividad = :idPresupuesto)) SELECT * FROM CTE_QUERY_PACC_INGENIERIA ORDER BY CTE_QUERY_PACC_INGENIERIA.nombreDepartamento ASC;");
            $stmt->bindValue(':idPresupuesto', $this->fechaPresupuestoAnual);
            if ($stmt->execute()) {
                return $stmt->fetchAll(PDO::FETCH_ASSOC);
            } else {
                return false;
            }
        }

        public function generaCostoObjetosGastoPaccGeneral () {
            $this->conexionBD = new Conexion();
            $this->consulta = $this->conexionBD->connect();
            $stmt = $this->consulta->prepare("WITH CTE_GENERA_COSTO_TOTAL_POR_OG AS (SELECT ObjetoGasto.codigoObjetoGasto, SUM(DescripcionAdministrativa.costoTotal) AS sumCostoActPorCodObjGasto FROM DescripcionAdministrativa INNER JOIN Actividad ON (DescripcionAdministrativa.idActividad = Actividad.idActividad) INNER JOIN ObjetoGasto ON (DescripcionAdministrativa.idObjetoGasto = ObjetoGasto.idObjetoGasto)WHERE DATE_FORMAT(Actividad.fechaCreacionActividad, '%Y') = (SELECT YEAR(ControlPresupuestoActividad.fechaPresupuestoAnual) FROM ControlPresupuestoActividad WHERE ControlPresupuestoActividad.idControlPresupuestoActividad = :idPresupuesto) GROUP BY ObjetoGasto.idObjetoGasto) SELECT * FROM CTE_GENERA_COSTO_TOTAL_POR_OG ORDER BY CTE_GENERA_COSTO_TOTAL_POR_OG.codigoObjetoGasto ASC;");
            $stmt->bindValue(':idPresupuesto', $this->fechaPresupuestoAnual);
            if ($stmt->execute()) {
                return $stmt->fetchAll(PDO::FETCH_ASSOC);
            } else {
                return array(
                    'status'=> BAD_REQUEST,
                    'data' => array('message' => 'Ha ocurrido un error, los presupuestos no se listaroncorrectamente')
                );
            }
        }

        public function generaDescripcionObjetosGastoPaccGeneral () {
            $this->conexionBD = new Conexion();
            $this->consulta = $this->conexionBD->connect();
            $stmt = $this->consulta->prepare("WITH CTE_GENERA_COSTO_TOTAL_POR_OG AS (SELECT ObjetoGasto.codigoObjetoGasto, ObjetoGasto.descripcionCuenta, SUM(DescripcionAdministrativa.costoTotal) AS sumCostoActPorCodObjGasto FROM DescripcionAdministrativa INNER JOIN Actividad ON (DescripcionAdministrativa.idActividad = Actividad.idActividad) INNER JOIN ObjetoGasto ON (DescripcionAdministrativa.idObjetoGasto = ObjetoGasto.idObjetoGasto) WHERE DATE_FORMAT(Actividad.fechaCreacionActividad, '%Y') = (SELECT YEAR(ControlPresupuestoActividad.fechaPresupuestoAnual) FROM ControlPresupuestoActividad WHERE ControlPresupuestoActividad.idControlPresupuestoActividad = :idPresupuesto) GROUP BY ObjetoGasto.idObjetoGasto) SELECT * FROM CTE_GENERA_COSTO_TOTAL_POR_OG ORDER BY CTE_GENERA_COSTO_TOTAL_POR_OG.codigoObjetoGasto;");
            $stmt->bindValue(':idPresupuesto', $this->fechaPresupuestoAnual);
            if ($stmt->execute()) {
                return $stmt->fetchAll(PDO::FETCH_ASSOC);
            } else {
                return false;
            }
        }

        public function generaCostoTotalDescripciones () {
            $this->conexionBD = new Conexion();
            $this->consulta = $this->conexionBD->connect();
            $stmt = $this->consulta->prepare("WITH CTE_QUERY_PACC_INGENIERIA AS (SELECT SUM(descripcionadministrativa.costoTotal) AS total FROM DescripcionAdministrativa INNER JOIN  Actividad ON (DescripcionAdministrativa.idActividad = Actividad.idActividad) INNER JOIN ObjetoGasto ON (DescripcionAdministrativa.idObjetoGasto = ObjetoGasto.idObjetoGasto) INNER JOIN Usuario ON (Actividad.idPersonaUsuario = Usuario.idPersonaUsuario) INNER JOIN Departamento ON (Usuario.idDepartamento = Departamento.idDepartamento) WHERE DATE_FORMAT(Actividad.fechaCreacionActividad,'%Y') = (SELECT YEAR(ControlPresupuestoActividad.fechaPresupuestoAnual) FROM ControlPresupuestoActividad WHERE ControlPresupuestoActividad.idControlPresupuestoActividad = :idPresupuesto)) SELECT * FROM CTE_QUERY_PACC_INGENIERIA;");
            $stmt->bindValue(':idPresupuesto', $this->fechaPresupuestoAnual);
            if ($stmt->execute()) {
                return $stmt->fetchObject();
            } else {
                return array(
                    'status'=> BAD_REQUEST,
                    'data' => array('message' => 'Ha ocurrido un error, los presupuestos no se listaroncorrectamente')
                );
            }
        }

        // public function generaReportePacc () {
        //     if (is_int($this->fechaPresupuestoAnual)) {
        //         $anioPacc = $this->generaAnioPaccSeleccionado();
        //         $paccFacultad = $this->generaPaccFacultadIngenieria();
        //         $costoObjetosGasto = $this->generaCostoObjetosGastoPaccGeneral();
        //         $descripcionesObjetoGasto = $this->generaDescripcionObjetosGastoPaccGeneral();
        //         $generaCostoTotal = $this->generaCostoTotalDescripciones();
                
        //         // Generando excel
        //         // Hoja Uno
        //         $nombreDelDocumento = "Reporte-General-Pacc.xlsx";
        //         $spreadsheet = new Spreadsheet();
        //         $sheet = $spreadsheet->getActiveSheet();
        //         $sheet->setCellValue('A2', 'FACULTAD DE INGENIERIA');
        //         $sheet->setCellValue('A3', 'PLAN ANUAL DE COMPRAS Y CONTRATACIONES (PACC)');
        //         $sheet->setCellValue('A4', $anioPacc->anioPacc);
        //         $sheet->setCellValue('A10', 'N°');
        //         $sheet->setCellValue('B10', 'Objeto del Gasto');
        //         $sheet->setCellValue('C10', 'Descripción');
        //         $sheet->setCellValue('D10', 'Correlativo POA');
        //         $sheet->setCellValue('E10', 'Unidad de Medida');
        //         $sheet->setCellValue('F10', 'Cantidad');
        //         $sheet->setCellValue('G10', 'Valor Unitario Aproximado');
        //         $sheet->setCellValue('H10', 'Valor Total');
        //         $sheet->setCellValue('I10', 'Nombre Departamento');
        //         $rowCount = 11;
        //         $count = 1;
        //         foreach ($paccFacultad as $item) {
        //             $sheet->setCellValue('A' . $rowCount, $count);
        //             $sheet->setCellValue('B' . $rowCount, $item['codigoObjetoGasto']);
        //             $sheet->setCellValue('C' . $rowCount, $item['descripcionCuenta']);
        //             $sheet->setCellValue('D' . $rowCount, $item['CorrelativoActividad']);
        //             $sheet->setCellValue('E' . $rowCount, $item['unidadDeMedida']);
        //             $sheet->setCellValue('F' . $rowCount, $item['cantidad']);
        //             $sheet->setCellValue('G' . $rowCount, $item['costo']);
        //             $sheet->setCellValue('H' . $rowCount, $item['costoTotal']);
        //             $sheet->setCellValue('I' . $rowCount, $item['nombreDepartamento']);
        //             $rowCount++;
        //             $count++;
        //         }
        //         try {
        //             ob_start();
        //             $writer = IOFactory::createWriter($spreadsheet, 'Xlsx');
        //             $writer->save('php://output');
        //             //readfile($writer);
        //             $xlsData = ob_get_contents();
        //             ob_end_clean();
        //             return array(
        //                 'status'=> SUCCESS_REQUEST,
        //                 'data' => array('message' => 'Archivo Pacc Facultad Generado Con Exito')
        //             );
        //         } catch(Exception $e){
        //             return array(
        //                 'status'=> BAD_REQUEST,
        //                 'data' => $e->getMessage()
        //             );
        //         }
        //     } else {
        //         return array(
        //             'status'=> BAD_REQUEST,
        //             'data' => array('message' => 'Ha ocurrido un error, la fecha no es correcta, no se puede generar el reporte pacc')
        //         );
        //     }
        // }

        public function generaReportePaccPorDepartamento () {

        }
    }