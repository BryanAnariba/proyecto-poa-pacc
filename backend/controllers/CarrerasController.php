<?php
    require_once('../../config/config.php');
    require_once('../../database/Conexion.php');
    require_once('../../helpers/Respuesta.php');
    require_once('../../models/Carrera.php');
    
    class CarrerasController {

        private $data;

        public function registrarCarrera ($Carrera,$Abreviatura,$idDepartamento,$idEstado) {
            
            $Carreras = new Carrera();

            $Carreras->setIdCarrera(0);
            $Carreras->setCarrera($Carrera);
            $Carreras->setAbreviatura($Abreviatura);
            $Carreras->setidDepartamento($idDepartamento);
            $Carreras->setidEstado($idEstado);

            $this->data = $Carreras->insertaCarrera();

            $_Respuesta = new Respuesta($this->data);
            $_Respuesta->respuestaPeticion();
        }

        public function obtenerDepartamentos () {
            $conexion = new Conexion();

            $pdo = $conexion->connect();

            $resp = $pdo->query('SELECT * FROM departamento;')->fetchAll();
            echo json_encode($resp);
        }

        public function obtenerEstados () {
            $conexion = new Conexion();

            $pdo = $conexion->connect();

            $resp = $pdo->query('SELECT * FROM estadodcdu;')->fetchAll();
            echo json_encode($resp);
        }

        public function obtenerCarreras () {
            $conexion = new Conexion();

            $pdo = $conexion->connect();

            $resp = $pdo->query('SELECT ca.idCarrera, ca.carrera, ca.abrev, dep.nombreDepartamento, es.estado
                                from carrera as ca
                                inner join departamento as dep
                                    on dep.idDepartamento=ca.idDepartamento
                                inner join estadodcdu as es
                                    on es.idEstadoDCDU=ca.idEstadoDCDU;')->fetchAll();
            echo json_encode($resp);
        }

        public function obtenerCarrerasPorDepa ($idDepartamento) {
            $conexion = new Conexion();

            $pdo = $conexion->connect();

            $resp = $pdo->query("SELECT * from carrera where idDepartamento=$idDepartamento")->fetchAll();
            echo json_encode($resp);
        }

        public function obtenerCarreraPorId ($idCarrera) {
            $conexion = new Conexion();

            $pdo = $conexion->connect();

            $resp = $pdo->query("SELECT * from carrera where idCarrera=$idCarrera")->fetchAll();
            echo json_encode($resp);
        }
        public function ActualizarCarrera ($idCarrera,$Carrera,$Abreviatura,$idDepartamento,$idEstado) {
            
            $Carreras = new Carrera();

            $Carreras->setIdCarrera($idCarrera);
            $Carreras->setCarrera($Carrera);
            $Carreras->setAbreviatura($Abreviatura);
            $Carreras->setidDepartamento($idDepartamento);
            $Carreras->setidEstado($idEstado);

            $this->data = $Carreras->modificarCarrera();

            $_Respuesta = new Respuesta($this->data);
            $_Respuesta->respuestaPeticion();
        }
        public function peticionNoValida () {
            $this->data = array('status' => BAD_REQUEST, 'data' => array('message' => 'Tipo de peticion no valida'));

            $_Respuesta = new Respuesta($this->data);
            $_Respuesta->respuestaPeticion();
        }
    }