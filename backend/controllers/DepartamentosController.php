<?php
    require_once('../../config/config.php');
    require_once('../../database/Conexion.php');
    require_once('../../helpers/Respuesta.php');
    require_once('../../models/Departamento.php');

    class DepartamentosController {
        
        private $data;

        
        
        
        public function VerDepartamentos () {
            $Departamentos = new Departamento();
            //$this->data = $this->departamentoModel->getDepartamentos();
            $this->data = $Departamentos->getDepartamentos();
            $_Respuesta = new Respuesta($this->data);
            $_Respuesta->respuestaPeticion();
        }


        public function obtenerEstados () {

            $Departamentos = new Departamento();

            $this->data = $Departamentos->getEstados();

            $_Respuesta = new Respuesta($this->data);
            $_Respuesta->respuestaPeticion();
        }


        public function registrarDepartamento ($idEstadoDepartamento,
                                                $nombreDepartamento,                                
                                                $telefonoDepartamento, 
                                                $abreviaturaDepartamento,
                                                $correoDepartamento) {
            
            $Departamentos = new Departamento();

            $Departamentos->setIdDepartamento(0);
            $Departamentos->setIdEstadoDepartamento($idEstadoDepartamento); 
            $Departamentos->setNombreDepartamento($nombreDepartamento);
            $Departamentos->setTelefonoDepartamento($telefonoDepartamento);
            $Departamentos->setAbreviaturaDepartamento($abreviaturaDepartamento);
            $Departamentos->setCorreoDepartamento($correoDepartamento);
            
            $this->data = $Departamentos->registraDepartamento();

            $_Respuesta = new Respuesta($this->data);
            $_Respuesta->respuestaPeticion();
        }


        public function obtenerDepartamentos () {

            $Departamentos = new Departamento();

            $this->data = $Departamentos->Departamentos();

            $_Respuesta = new Respuesta($this->data);
            $_Respuesta->respuestaPeticion();
        }


        public function obtenerDepartamentoPorId ($idDepartamento) {

            $Departamentos = new Departamento();

            $Departamentos->setIdDepartamento($idDepartamento);
            $this->data = $Departamentos->getDepartamentosPorId();
        public function peticionNoAutorizada () {
            $this->data = array('status' => UNAUTHORIZED_REQUEST, 'data' => array(
                'message' => 'No esta autorizado para realizar esta peticion o su token de acceso ha caducado, debes cerrar sesion y loguearse nuevamente'));

            $_Respuesta = new Respuesta($this->data);
            $_Respuesta->respuestaPeticion();
        }
        

        public function modificarDepartamento ($idDepartamento,
                                                $nombreDepartamento,
                                                $idEstadoDepartamento,
                                                $abreviaturaDepartamento,
                                                $telefonoDepartamento,    
                                                $correoDepartamento
                                                ) {
            
            $Departamentos = new Departamento();

            $Departamentos->setIdDepartamento($idDepartamento);
            $Departamentos->setNombreDepartamento($nombreDepartamento);
            $Departamentos->setIdEstadoDepartamento($idEstadoDepartamento);
            $Departamentos->setAbreviaturaDepartamento($abreviaturaDepartamento);
            $Departamentos->setTelefonoDepartamento($telefonoDepartamento);
            $Departamentos->setCorreoDepartamento($correoDepartamento);
             

            $this->data = $Departamentos->modificarDepartamento();

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