<?php
    class UsuariosController {
        // https://anexsoft.com/tipos-de-autenticacion-token-session-base-de-datos-con-php
        public function registrarUsuario () {

        }

        public function obtenerUsuarios () {

        }

        public function obtenerUsuarioPorId () {

        }

        public function peticionNoValida () {
            $this->data = array('status' => BAD_REQUEST, 'data' => array('message' => 'Tipo de peticion no valida'));

            $_Respuesta = new Respuesta($this->data);
            $_Respuesta->respuestaPeticion();
        }
    }