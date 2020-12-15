<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/proyecto-poa-pacc/backend/helpers/Respuesta.php');
    require_once($_SERVER['DOCUMENT_ROOT'] . '/proyecto-poa-pacc/backend/models/Lugar.php');
    class LugaresController {
        private $LugarModel;
        private $data;
        public function __construct() {
            $this->LugarModel = new Lugar();
        }

        public function listarPaises ($idPais) {
            $this->LugarModel->setIdTipoLugar($idPais);
            $this->data = $this->LugarModel->getPaises();

            $_Respuesta = new Respuesta($this->data);
            $_Respuesta->respuestaPeticion();
        }

        public function listarCiudades ($idPais) {
            $this->LugarModel->setIdLugarPadre($idPais);
            $this->data = $this->LugarModel->getCiudades();

            $_Respuesta = new Respuesta($this->data);
            $_Respuesta->respuestaPeticion();
        }

        public function listarMunicipios($idCiudad) {
            $this->LugarModel->setIdLugarPadre($idCiudad);
            $this->data = $this->LugarModel->getMunicipios();

            $_Respuesta = new Respuesta($this->data);
            $_Respuesta->respuestaPeticion();
        }

        public function peticionNoValida () {
            $this->data = array('status' => BAD_REQUEST, 'data' => array('message' => 'Tipo de peticion no valida'));

            $_Respuesta = new Respuesta($this->data);
            $_Respuesta->respuestaPeticion();
        }
    }