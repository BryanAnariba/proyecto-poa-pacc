<?php
    class RespuestaPeticion {
        private $codigoEstadoHttp;
        private $data;
        private $respuesta;

        public function __construct($codigoEstadoHttp, $data) {
            $this->codigoEstadoHttp = $codigoEstadoHttp;
            $this->data = $data;
        }

        public function respuestaDePeticion () {
            http_response_code($this->codigoEstadoHttp);
            $this->respuesta = array(
                'codigoEstado' => $this->codigoEstadoHttp,
                'data' => $this->data
            );
            echo json_encode($this->respuesta);
        }
    }