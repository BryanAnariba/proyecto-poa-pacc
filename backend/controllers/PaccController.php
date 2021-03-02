<?php
    require_once('../../helpers/Respuesta.php');
    require_once('../../models/Pacc.php');
    class PaccController {
        private $paccModel;
        private $data;

        public function __construct() {
            $this->paccModel = new Pacc();
        }

        public function listarPresupuestosDepartamentos () {
            $this->data = $this->paccModel->getDatosPacc();

            $_Respuesta = new Respuesta($this->data);
            $_Respuesta->respuestaPeticion();
        }
        
        public function listarPresupuestos () {
            $this->data = $this->paccModel->generaPresupuestoAnualComparativa();

            $_Respuesta = new Respuesta($this->data);
            $_Respuesta->respuestaPeticion();
        }

        public function generaAniosPresupuestosAnuales() {
            $this->data = $this->paccModel->generaAniosPresupuestoAnual();

            $_Respuesta = new Respuesta($this->data);
            $_Respuesta->respuestaPeticion();
        }

        public function generaDataGastosPorDimension ($idPresupuestoAnual, $idDepatamento) {
            $this->paccModel->setFechaPresupuestoAnual($idPresupuestoAnual);
            $this->paccModel->setIdDepartamento($idDepatamento);
            $this->data = $this->paccModel->getDataGastosPorDimnesionLlenada();

            $_Respuesta = new Respuesta($this->data);
            $_Respuesta->respuestaPeticion();
        }

        public function peticionNoAutorizada () {
            $this->data = array('status' => UNAUTHORIZED_REQUEST, 'data' => array(
                'message' => 'No esta autorizado para realizar esta peticion o su token de acceso ha caducado, debes cerrar sesion y loguearse nuevamente'));

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