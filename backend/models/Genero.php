<?php
    class Genero {
        protected $idGenero;
        protected $genero;
        protected $abrev;

        public function __construct($idGenero, $genero, $abrev) {
            $this->idGenero = $idGenero;
            $this->genero = $genero;
            $this->abrev = $abrev;
        }

        public function getIdGenero() {
            return $this->idGenero;
        }

        public function setIdGenero($idGenero) {
            $this->idGenero = $idGenero;
            return $this;
        }

        public function getGenero() {
                return $this->genero;
        }

        public function setGenero($genero) {
            $this->genero = $genero;
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