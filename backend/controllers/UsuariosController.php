<?php
    require_once('../../helpers/Respuesta.php');
    require_once('../../models/Usuario.php');
    class UsuariosController {

        // https://anexsoft.com/tipos-de-autenticacion-token-session-base-de-datos-con-php

        private $usuariosModel;
        private $personasModel;
        private $data;

        public function __construct() {
            $this->usuariosModel = new Usuario();
        }
        public function registrarUsuario ($nombrePersona, $apellidoPersona, $codigoEmpleado, $fechaNacimiento, $idDepartamento, $idTipoUsuario, $correoInstitucional, $nombreUsuario, $idPais, $idDepartamentoPais, $idMunicipioCiudad, $nombreLugar) {
            $this->usuariosModel->setNombrePersona($nombrePersona);
            $this->usuariosModel->setApellidoPersona($apellidoPersona);
            $this->usuariosModel->setCodigoEmpleado($codigoEmpleado);
            $this->usuariosModel->setFechaNacimiento($fechaNacimiento);
            $this->usuariosModel->setIdDepartamento($idDepartamento);
            $this->usuariosModel->setIdTipoUsuario($idTipoUsuario);
            $this->usuariosModel->setCorreoInstitucional($correoInstitucional);
            $this->usuariosModel->setNombreUsuario($nombreUsuario);
            $this->usuariosModel->setIdLugar($idMunicipioCiudad);
            $this->usuariosModel->setDireccion($nombreLugar);

            $this->data = $this->usuariosModel->registrarUsuario();

            $_Respuesta = new Respuesta($this->data);
            $_Respuesta->respuestaPeticion();
        }

        public function obtenerUsuarios () {
            $this->data = $this->usuariosModel->getInformacionUsuarios();

            $_Respuesta = new Respuesta($this->data);
            $_Respuesta->respuestaPeticion();
        }

        public function obtenerUsuarioPorId () {

        }

        public function cambiarEstadoUsuario($idPersonaUsuario, $idEstadoUsuario) {
            $this->usuariosModel->setIdPersona($idPersonaUsuario);
            $this->usuariosModel->setIdEstadoUsuario($idEstadoUsuario);
            $this->data = $this->usuariosModel->modificarEstadoUsuario();

            $_Respuesta = new Respuesta($this->data);
            $_Respuesta->respuestaPeticion();
        }

        public function modificarInformacionGeneral ($idPersonaUsuario, $nombrePersona, $apellidoPersona, $codigoEmpleado, $fechaNacimiento, $idDepartamento, $idTipoUsuario) {
            $this->usuariosModel->setIdPersona($idPersonaUsuario);
            $this->usuariosModel->setNombrePersona($nombrePersona);
            $this->usuariosModel->setApellidoPersona($apellidoPersona);
            $this->usuariosModel->setCodigoEmpleado($codigoEmpleado);
            $this->usuariosModel->setFechaNacimiento($fechaNacimiento);
            $this->usuariosModel->setIdDepartamento($idDepartamento);
            $this->usuariosModel->setIdTipoUsuario($idTipoUsuario);
            
            $this->data = $this->usuariosModel->modificaInformacionGeneralUsuario();
            
            $_Respuesta = new Respuesta($this->data);
            $_Respuesta->respuestaPeticion();
        }

        public function reenviarCredencialesAcceso($idPersonaUsuario, $correoInstitucional, $nombrePersona, $apellidoPersona, $nombreUsuario) {
            $this->usuariosModel->setIdPersona($idPersonaUsuario);
            $this->usuariosModel->setNombrePersona($nombrePersona);
            $this->usuariosModel->setApellidoPersona($apellidoPersona);
            $this->usuariosModel->setCorreoInstitucional($correoInstitucional);
            $this->usuariosModel->setNombreUsuario($nombreUsuario);

            $this->data = $this->usuariosModel->reenviarCredenciales();

            $_Respuesta = new Respuesta($this->data);
            $_Respuesta->respuestaPeticion();
        }

        public function modificarCorreoUsuario($idPersonaUsuario, $correoInstitucional, $nombrePersona, $apellidoPersona, $nombreUsuario) {
            $this->usuariosModel->setIdPersona($idPersonaUsuario);
            $this->usuariosModel->setNombrePersona($nombrePersona);
            $this->usuariosModel->setApellidoPersona($apellidoPersona);
            $this->usuariosModel->setCorreoInstitucional($correoInstitucional);
            $this->usuariosModel->setNombreUsuario($nombreUsuario);

            $this->data = $this->usuariosModel->modificaCorreo();

            $_Respuesta = new Respuesta($this->data);
            $_Respuesta->respuestaPeticion();
        }

        public function modificarDireccion ($idPersonaUsuario, $idPais, $idDepartamentoPais, $idMunicipioCiudad, $nombreLugar) {
            $this->usuariosModel->setIdPersona($idPersonaUsuario);
            $this->usuariosModel->setIdLugar($idMunicipioCiudad);
            $this->usuariosModel->setDireccion($nombreLugar);
            $this->data = $this->usuariosModel->modificaDireccion();

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