<?php
    require_once('../../helpers/Respuesta.php');
    require_once('../../models/DimensionEstrategica.php');
    class DimensionesEstrategicasController {
        private $dimensionEstrategicaModel;
        private $data;

        public function __construct() {
            $this->dimensionEstrategicaModel = new Dimension();
        }

        public function listarDimensiones () {
            $this->data = $this->dimensionEstrategicaModel->getDimensiones();

            $_Respuesta = new Respuesta($this->data);
            $_Respuesta->respuestaPeticion();
        }

        public function listarDimensionesActivas () {

        }

        public function insertaDimension ($dimensionEstrategica) {
            $this->dimensionEstrategicaModel->setDimensionEstrategica($dimensionEstrategica);
            $this->dimensionEstrategicaModel->setIdEstadoDimension(ESTADO_ACTIVO);
            $this->data = $this->dimensionEstrategicaModel->insertaDimension();

            $_Respuesta = new Respuesta($this->data);
            $_Respuesta->respuestaPeticion();
        }

        public function modificaEstadoDimension ($idDimensionEstrategica) {
            $this->dimensionEstrategicaModel->setIdDimension($idDimensionEstrategica);
            $this->data = $this->dimensionEstrategicaModel->modificaEstadoDimension();

            $_Respuesta = new Respuesta($this->data);
            $_Respuesta->respuestaPeticion();
        }

        public function modificarDimension ($idDimensionEstrategica, $dimensionEstrategica) {
            $this->dimensionEstrategicaModel->setIdDimension($idDimensionEstrategica);
            $this->dimensionEstrategicaModel->setDimensionEstrategica($dimensionEstrategica);
            $this->data = $this->dimensionEstrategicaModel->modificarDimension();

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