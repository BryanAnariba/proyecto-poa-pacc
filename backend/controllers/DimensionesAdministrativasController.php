<?php
    require_once('../../helpers/Respuesta.php');
    require_once('../../models/DimensionAdministrativa.php');
    class DimensionesAdministrativasController {
        private $dimensionAdministrativaModel;
        private $data;

        public function __construct() {
            $this->dimensionAdministrativaModel = new Dimension();
        }

        public function listarDimensiones () {
            $this->data = $this->dimensionAdministrativaModel->getDimensiones();

            $_Respuesta = new Respuesta($this->data);
            $_Respuesta->respuestaPeticion();
        }

        public function listarDimensionesActivas () {

        }

        public function insertaDimension ($dimensionAdministrativa) {
            $this->dimensionAdministrativaModel->setDimensionAdministrativa($dimensionAdministrativa);
            $this->dimensionAdministrativaModel->setIdEstadoDimension(ESTADO_ACTIVO);
            $this->data = $this->dimensionAdministrativaModel->insertaDimension();

            $_Respuesta = new Respuesta($this->data);
            $_Respuesta->respuestaPeticion();
        }

        public function modificaEstadoDimension ($idDimensionAdministrativa) {
            $this->dimensionAdministrativaModel->setIdDimension($idDimensionAdministrativa);
            $this->data = $this->dimensionAdministrativaModel->modificaEstadoDimension();

            $_Respuesta = new Respuesta($this->data);
            $_Respuesta->respuestaPeticion();
        }

        public function modificarDimension ($idDimensionAdministrativa, $dimensionAdministrativa) {
            $this->dimensionAdministrativaModel->setIdDimension($idDimensionAdministrativa);
            $this->dimensionAdministrativaModel->setDimensionAdministrativa($dimensionAdministrativa);
            $this->data = $this->dimensionAdministrativaModel->modificarDimension();

            $_Respuesta = new Respuesta($this->data);
            $_Respuesta->respuestaPeticion();
        }

        public function peticionNoValida () {
            $this->data = array('status' => BAD_REQUEST, 'data' => array('message' => 'Tipo de peticion no valida'));

            $_Respuesta = new Respuesta($this->data);
            $_Respuesta->respuestaPeticion();
        }
    }
?>