<?php
    require_once('../../helpers/Respuesta.php');
    require_once('../../models/Actividad.php');
    class ActividadesController {
        private $actividadesModel;
        private $data;

        public function __construct() {
            $this->actividadesModel = new Actividad();
        }

        public function listarActividadesPorDimension () {
            $this->data = $this->actividadesModel->getActividadesPorDimension();

            $_Respuesta = new Respuesta($this->data);
            $_Respuesta->respuestaPeticion();
        }

        public function peticionNoValida () {
            $this->data = array('status' => BAD_REQUEST, 'data' => array('message' => 'Tipo de peticion no valida'));

            $_Respuesta = new Respuesta($this->data);
            $_Respuesta->respuestaPeticion();
        }

        public function generarComparativoPresupuestos () {
            $this->data = $this->actividadesModel->getComparativaDePresupuestos();

            $_Respuesta = new Respuesta($this->data);
            $_Respuesta->respuestaPeticion();
        }

        public function verificaCostoRangoActividad($costoActividad, $porcentajeTrimestre1, $porcentajeTrimestre2, $porcentajeTrimestre3, $porcentajeTrimestre4) {
            $this->actividadesModel->setCostoTotal($costoActividad);
            $this->actividadesModel->setPorcentajeTrimestre1($porcentajeTrimestre1);
            $this->actividadesModel->setPorcentajeTrimestre2($porcentajeTrimestre2);
            $this->actividadesModel->setPorcentajeTrimestre3($porcentajeTrimestre3);
            $this->actividadesModel->setPorcentajeTrimestre4($porcentajeTrimestre4);

            $this->data = $this->actividadesModel->verificaDatosPresupuestoActividad();
            $_Respuesta = new Respuesta($this->data);
            $_Respuesta->respuestaPeticion();
        }

        public function generarCorrelativo ($idDimension) {
            $this->actividadesModel->setIdDimension($idDimension);
            $this->data = $this->actividadesModel->generaCorrelativoActividad();
            $_Respuesta = new Respuesta($this->data);
            $_Respuesta->respuestaPeticion();
        }

        public function insertarNuevaActividad(
            $actividad, 
            $correlativoActividad, 
            $idAreaEstrategica, 
            $idDimension, 
            $idObjetivoInstitucional, 
            $idResultadoInstitucional,
            $idTipoActividad,
            $indicadoresResultado,
            $justificacionActividad,
            $medioVerificacionActividad,
            $poblacionObjetivoActividad,
            $resultadosUnidad,
            $responsableActividad,
            $costoTotal,
            $porcentajeTrimestre1,
            $porcentajeTrimestre2,
            $porcentajeTrimestre3,
            $porcentajeTrimestre4
        ) {
            $this->actividadesModel->setActividad($actividad);
            $this->actividadesModel->setCorrelativoActividad($correlativoActividad);
            $this->actividadesModel->setIdAreaEstrategica($idAreaEstrategica);
            $this->actividadesModel->setIdDimension($idDimension);
            $this->actividadesModel->setIdObjetivoInstitucional($idObjetivoInstitucional);
            $this->actividadesModel->setIdResultadoInstitucional($idResultadoInstitucional);
            $this->actividadesModel->setIdTipoActividad($idTipoActividad);
            $this->actividadesModel->setIndicadoresResultado($indicadoresResultado);
            $this->actividadesModel->setJustificacionActividad($justificacionActividad);
            $this->actividadesModel->setMedioVerificacionActividad($medioVerificacionActividad);
            $this->actividadesModel->setPoblacionOjetivoActividad($poblacionObjetivoActividad);
            $this->actividadesModel->setResultadosUnidad($resultadosUnidad);
            $this->actividadesModel->setResponsableActividad($responsableActividad);
            $this->actividadesModel->setCostoTotal($costoTotal);
            $this->actividadesModel->setPorcentajeTrimestre1($porcentajeTrimestre1);
            $this->actividadesModel->setPorcentajeTrimestre2($porcentajeTrimestre2);
            $this->actividadesModel->setPorcentajeTrimestre3($porcentajeTrimestre3);
            $this->actividadesModel->setPorcentajeTrimestre4($porcentajeTrimestre4);

            $this->data = $this->actividadesModel->insertaActividad();
            $_Respuesta = new Respuesta($this->data);
            $_Respuesta->respuestaPeticion();
        }

        public function listarActividadesPorDimensionEstrategica ($idDimension) {
            $this->actividadesModel->setIdDimension($idDimension);
            $this->data = $this->actividadesModel->getActividadesDimension();

            $_Respuesta = new Respuesta($this->data);
            $_Respuesta->respuestaPeticion();
        }

        public function peticionNoAutorizada () {
            $this->data = array('status' => UNAUTHORIZED_REQUEST, 'data' => array(
                'message' => 'No esta autorizado para realizar esta peticion o su token de acceso ha caducado, debes cerrar sesion y loguearse nuevamente'));

            $_Respuesta = new Respuesta($this->data);
            $_Respuesta->respuestaPeticion();
        }
    }
?>