<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/proyecto-poa-pacc/backend/config/config.php');
    class Persona {
        protected $idPersona;
        private $idLugar;
        private $idGenero;
        private $nombrePersona;
        private $apellidoPersona;
        private $telefono;
        private $fechaNacimiento;
        private $tablaBaseDatos;

        private $conexionBD;
        private $consulta;
        private $data;

        // Constructor
        public function __construct() {
            $this->tablaBaseDatos = TBL_PERSONA;
        }

        // Metodos getters y setters
    
        public function getIdPersona() {
            return $this->idPersona;
        }

        public function setIdPersona($idPersona) {
            $this->idPersona = $idPersona;
            return $this;
        }

        public function getIdLugar() {
            return $this->idLugar;
        }

        public function setIdLugar($idLugar) {
            $this->idLugar = $idLugar;
            return $this;
        }

        public function getIdGenero() {
            return $this->idGenero;
        }

        public function setIdGenero($idGenero) {
            $this->idGenero = $idGenero;
            return $this;
        }
        
        public function getNombrePersona() {
            return $this->nombrePersona;
        }

        public function setNombrePersona($nombrePersona) {
            $this->nombrePersona = $nombrePersona;
            return $this;
        }

        public function getApellidoPersona() {
            return $this->apellidoPersona;
        }

        public function setApellidoPersona($apellidoPersona) {
            $this->apellidoPersona = $apellidoPersona;
            return $this;
        }

        public function getTelefono() {
                return $this->telefono;
        }

        public function setTelefono($telefono) {
            $this->telefono = $telefono;
            return $this;
        }

        public function getFechaNacimiento() {
                return $this->fechaNacimiento;
        }

        public function setFechaNacimiento($fechaNacimiento) {
            $this->fechaNacimiento = $fechaNacimiento;
            return $this;
        }

        //                                          Metodos para la clase Persona

        public function registrarPersona () {

        }

        public function actualizarDatosPersona () {

        }

    }
?>