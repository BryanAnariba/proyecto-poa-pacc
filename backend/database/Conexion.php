<?php
    require_once('../config/config.php');
    Class Conexion {
        private $host;
        private $dataBase;
        private $user;
        private $password;
        private $charset;
        private $conexion;

        public function __construct() {
            $this->host = constant('HOST');
            $this->dataBase = constant('DB');
            $this->user = constant('USER');
            $this->password = constant('PASSWORD');
            $this->charset = constant('CHARSET');
        }

        // Metodo que realiza la conexion
        public function connect () {
            try{
                $this->conexion = "mysql:host=" . $this->host . ";dbname=" . $this->dataBase . ";charset=" . $this->charset;
                $options = [
                    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
                    PDO::ATTR_EMULATE_PREPARES => false,
                ];
                
                $this->conexion = new PDO($this->conexion, $this->user, $this->password, $options);
                //echo('Conexión a MYSQL BD exitosa');
                return $this->conexion;
            }catch(PDOException $e){
                echo('Error connection: ' . $e->getMessage());
                die();
            }
        }

        public function closeConnection () {
            $this->conexion = null;
        }
    }

    // Testeo de la conexion
    //$miConexion = new Conexion();
    //$miConexion->connect();
