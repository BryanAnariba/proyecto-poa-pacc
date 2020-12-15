<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/proyecto-poa-pacc/backend/models/Persona.php');
    require_once($_SERVER['DOCUMENT_ROOT'] . '/proyecto-poa-pacc/backend/config/config.php');
    class Usuario extends Persona {

        // Propiedades clase
        private $idTipoUsuario;
        private $idDepartamento;
        private $idEstadoDCDU;
        private $nombreUsuario;
        private $correoInstitucional;
        private $codigoEmpleado;
        private $passwordEmpleado;
        private $avatarUsuario;


        private $tablaBaseDatos;

        // constructor
        public function __construct() {
            $this->tablaBaseDatos = TBL_USUARIO;
        }

        // Metodos setters y getters
        public function getIdTipoUsuario() {
            return $this->idTipoUsuario;
        }

        public function setIdTipoUsuario($idTipoUsuario) {
            $this->idTipoUsuario = $idTipoUsuario;
            return $this;
        }

        public function getIdDepartamento() {
            return $this->idDepartamento;
        }

        public function setIdDepartamento($idDepartamento) {
            $this->idDepartamento = $idDepartamento;
            return $this;
        }

        public function getIdEstadoDCDU() {
            return $this->idEstadoDCDU;
        }

        public function setIdEstadoDCDU($idEstadoDCDU) {
            $this->idEstadoDCDU = $idEstadoDCDU;
            return $this;
        }

        public function getNombreUsuario() {
            return $this->nombreUsuario;
        }

        public function setNombreUsuario($nombreUsuario) {
            $this->nombreUsuario = $nombreUsuario;
            return $this;
        }

        public function getCorreoInstitucional() {
            return $this->correoInstitucional;
        }

        public function setCorreoInstitucional($correoInstitucional) {
            $this->correoInstitucional = $correoInstitucional;
            return $this;
        }

        public function getCodigoEmpleado() {
            return $this->codigoEmpleado;
        }

        public function setCodigoEmpleado($codigoEmpleado) {
            $this->codigoEmpleado = $codigoEmpleado;
            return $this;
        }

        public function getPasswordEmpleado() {
            return $this->passwordEmpleado;
        }

        public function setPasswordEmpleado($passwordEmpleado) {
            $this->passwordEmpleado = $passwordEmpleado;
            return $this;
        }

        public function getAvatarUsuario() {
                return $this->avatarUsuario;
        }

        public function setAvatarUsuario($avatarUsuario) {
            $this->avatarUsuario = $avatarUsuario;
            return $this;
        }

        //                                                 Metodos clase Usuario

        public function registrarUsuario () {

        }

        public function actualizarDatosUsuario () {

        }

        public function getInformacionUsuarios () {

        }

        public function getInformacionUsuario () {

        }

        public function actualizarEstadoUsuario () {

        }
    }