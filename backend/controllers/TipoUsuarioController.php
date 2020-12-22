<?php
    require_once('../../helpers/Respuesta.php');
    require_once('../../models/TipoUsuario.php');
    class TipoUsuarioController {
        private $tipoUsuarioModel;
        private $data;
        public function __construct() {
            $this->tipoUsuarioModel = new TipoUsuario();
        }

        public function listarTiposUsuarios () {
            $this->data = $this->tipoUsuarioModel->getTiposUsuarios();

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