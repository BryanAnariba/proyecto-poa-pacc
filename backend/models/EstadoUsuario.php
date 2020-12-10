<?php
    class EstadoUsuario {
        protected $idEstadoUsuario;
        protected $estadoUsuario;
        protected $abrev;

        public function __construct() {
            
        }

        public function getIdEstadoUsuario() {
            return $this->idEstadoUsuario;
        }

        public function setIdEstadoUsuario($idEstadoUsuario) {
            $this->idEstadoUsuario = $idEstadoUsuario;
            return $this;
        }

        public function getEstadoUsuario() {
            return $this->estadoUsuario;
        }

        public function setEstadoUsuario($estadoUsuario) {
            $this->estadoUsuario = $estadoUsuario;
            return $this;
        }

        public function getAbrev() {
            return $this->abrev;
        }

        public function setAbrev($abrev) {
            $this->abrev = $abrev;
            return $this;
        }
    }