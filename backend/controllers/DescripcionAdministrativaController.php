<?php
    require_once('../../helpers/Respuesta.php');
    require_once('../../models/DescripcionAdministrativa.php');
    class DescripcionAdministrativaController {
        private $descripcionAdministrativaModel;
        private $data;

        public function __construct () {
            $this->descripcionAdministrativaModel = new DescripcionAdministrativa();
        }

        public function listarDescripcionesAdministrativas ($idActividad, $idDimensionAdmin) {
            $this->descripcionAdministrativaModel->setIdDimensionAdministrativa($idDimensionAdmin);
            $this->descripcionAdministrativaModel->setIdActividad($idActividad);

            $this->data = $this->descripcionAdministrativaModel->getDescripcionAdministrativaPorActividad();
            $_Respuesta = new Respuesta($this->data);
            $_Respuesta->respuestaPeticion();
        }

        public function insertaNuevaDescripcionAdministrativa ($idObjetoGasto, $idTipoPresupuesto, $idActividad, $idDimension, $cantidad, $costo, $costoTotal, $mesRequerido, $descripcion) {
            $this->descripcionAdministrativaModel->setIdObjetoGasto($idObjetoGasto);
            $this->descripcionAdministrativaModel->setIdTipoPresupuesto($idTipoPresupuesto);
            $this->descripcionAdministrativaModel->setIdActividad($idActividad);
            $this->descripcionAdministrativaModel->setIdDimensionAdministrativa($idDimension);
            $this->descripcionAdministrativaModel->setCantidad($cantidad);
            $this->descripcionAdministrativaModel->setCosto($costo);
            $this->descripcionAdministrativaModel->setCostoTotal($costoTotal);
            $this->descripcionAdministrativaModel->setMesRequerido($mesRequerido);
            $this->descripcionAdministrativaModel->setDescripcion($descripcion);

            $this->data = $this->descripcionAdministrativaModel->insertaDescripcionAdministrativa();
            $_Respuesta = new Respuesta($this->data);
            $_Respuesta->respuestaPeticion();
        }

        public function modificaDescripcionAdministrativa ($idDescripcionAdministrativa, $idObjetoGasto, $idTipoPresupuesto, $idActividad, $idDimension, $cantidad, $costo, $costoTotal, $mesRequerido, $descripcion) {
            $this->descripcionAdministrativaModel->setIdDescripcionAdministrativa($idDescripcionAdministrativa);
            $this->descripcionAdministrativaModel->setIdObjetoGasto($idObjetoGasto);
            $this->descripcionAdministrativaModel->setIdTipoPresupuesto($idTipoPresupuesto);
            $this->descripcionAdministrativaModel->setIdActividad($idActividad);
            $this->descripcionAdministrativaModel->setIdDimensionAdministrativa($idDimension);
            $this->descripcionAdministrativaModel->setCantidad($cantidad);
            $this->descripcionAdministrativaModel->setCosto($costo);
            $this->descripcionAdministrativaModel->setCostoTotal($costoTotal);
            $this->descripcionAdministrativaModel->setMesRequerido($mesRequerido);
            $this->descripcionAdministrativaModel->setDescripcion($descripcion);

            $this->data = $this->descripcionAdministrativaModel->modifDescripcionAdministrativa();
            $_Respuesta = new Respuesta($this->data);
            $_Respuesta->respuestaPeticion();
        }

        public function modificaDescripcion () {

        }

        public function peticionNoValida () {
            $this->data = array('status' => BAD_REQUEST, 'data' => array('message' => 'Tipo de peticion no valida'));

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