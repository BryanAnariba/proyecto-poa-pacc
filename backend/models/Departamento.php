<?php
    class Departamento {
        protected $idDepartamento;
        protected $nombreDepartamento;
        protected $abrev;

        public function __construct($idDepartamento, $nombreDepartamento, $abrev) {
            $this->idDepartamento = $idDepartamento;
            $this->nombreDepartamento = $nombreDepartamento;
            $this->abrev = $abrev;
        }

        public function getIdDepartamento() {
            return $this->idDepartamento;
        }

        public function setIdDepartamento($idDepartamento) {
            $this->idDepartamento = $idDepartamento;
            return $this;
        }

        public function getNombreDepartamento() {
            return $this->nombreDepartamento;
        }

        public function setNombreDepartamento($nombreDepartamento) {
            $this->nombreDepartamento = $nombreDepartamento;
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