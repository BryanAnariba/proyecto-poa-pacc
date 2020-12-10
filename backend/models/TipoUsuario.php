<?php
    class TipoUsuario {
        protected $idTipoUsuario;
        protected $tipoUsuario;
        protected $abrev;

        public function __construct($idTipoUsuario, $tipoUsuario, $abrev) {
            $this->idTipoUsuario = $idTipoUsuario;
            $this->tipoUsuario = $tipoUsuario;
            $this->abrev = $abrev;
        }

        public function getIdTipoUsuario() {
            return $this->idTipoUsuario;
        }

        public function setIdTipoUsuario($idTipoUsuario) {
            $this->idTipoUsuario = $idTipoUsuario;
            return $this;
        }

        public function getTipoUsuario() {
            return $this->tipoUsuario;
        }

        public function setTipoUsuario($tipoUsuario) {
            $this->tipoUsuario = $tipoUsuario;
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