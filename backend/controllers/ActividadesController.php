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

        public function peticionNoAutorizada () {
            $this->data = array('status' => UNAUTHORIZED_REQUEST, 'data' => array(
                'message' => 'No esta autorizado para realizar esta peticion o su token de acceso ha caducado, debes cerrar sesion y loguearse nuevamente'));

            $_Respuesta = new Respuesta($this->data);
            $_Respuesta->respuestaPeticion();
        }
    }
?>