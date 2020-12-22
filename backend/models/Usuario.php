<?php
    require_once('../../models/Persona.php');
    require_once('../../config/config.php');
    require_once('../../validators/validators.php');
    require_once('../../helpers/GeneradorClaves.php');
    require_once('../../helpers/Email.php');
    require_once('../../database/Conexion.php');
    class Usuario extends Persona {

        // Propiedades clase
        private $idTipoUsuario;
        private $idDepartamento;
        private $idEstadoDCDU;
        private $nombreUsuario;
        private $correoInstitucional;
        private $codigoEmpleado;
        private $passwordEmpleado;
        private $avatarUsuario;

        private $conexionBD;
        private $consulta;
        private $tablaBaseDatos;

        // constructor
        public function __construct() {
            $this->tablaBaseDatos = TBL_USUARIO;
        }

        // Metodos setters y getters
        public function getIdTipoUsuario() {
            return $this->idTipoUsuario;
        }

        public function setIdTipoUsuario($idTipoUsuario) {
            $this->idTipoUsuario = $idTipoUsuario;
            return $this;
        }

        public function getIdDepartamento() {
            return $this->idDepartamento;
        }

        public function setIdDepartamento($idDepartamento) {
            $this->idDepartamento = $idDepartamento;
            return $this;
        }

        public function getIdEstadoDCDU() {
            return $this->idEstadoDCDU;
        }

        public function setIdEstadoDCDU($idEstadoDCDU) {
            $this->idEstadoDCDU = $idEstadoDCDU;
            return $this;
        }

        public function getNombreUsuario() {
            return $this->nombreUsuario;
        }

        public function setNombreUsuario($nombreUsuario) {
            $this->nombreUsuario = $nombreUsuario;
            return $this;
        }

        public function getCorreoInstitucional() {
            return $this->correoInstitucional;
        }

        public function setCorreoInstitucional($correoInstitucional) {
            $this->correoInstitucional = $correoInstitucional;
            return $this;
        }

        public function getCodigoEmpleado() {
            return $this->codigoEmpleado;
        }

        public function setCodigoEmpleado($codigoEmpleado) {
            $this->codigoEmpleado = $codigoEmpleado;
            return $this;
        }

        public function getPasswordEmpleado() {
            return $this->passwordEmpleado;
        }

        public function setPasswordEmpleado($passwordEmpleado) {
            $this->passwordEmpleado = $passwordEmpleado;
            return $this;
        }

        public function getAvatarUsuario() {
                return $this->avatarUsuario;
        }

        public function setAvatarUsuario($avatarUsuario) {
            $this->avatarUsuario = $avatarUsuario;
            return $this;
        }

        //                                                 Metodos clase Usuario

        public function verificaEmailUsuario () {
            try {
                $this->conexionBD = new Conexion();
                $this->consulta = $this->conexionBD->connect();
                $stmt = $this->consulta->prepare('CALL SP_VERIFICA_EMAIL_USUARIO(:emailUsuario)');
                $stmt->bindValue(':emailUsuario', $this->correoInstitucional);

                //  Si la consulta se ejecuto y las filas que retorna la busqueda del email es 0 guarde si no notifique
                if ($stmt->execute() && ($stmt->rowCount() == 0)) {
                    return true;
                } else {
                    return false;
                }
            } catch (PDOException $ex) {
                return array(
                    'status'=> INTERNAL_SERVER_ERROR,
                    'data' => array('message' => $ex->getMessage())
                );
            } finally {
                $this->conexionBD = null;
            }            
        }

        public function registrarUsuario () {
            if (validaCampoNombreApellido($this->getNombrePersona(), 1, 80) && validaCampoNombreApellido($this->getApellidoPersona(), 1, 80) && is_int($this->getIdLugar()) && is_int($this->idTipoUsuario) && is_int($this->idDepartamento) && validaCampoEmail($this->correoInstitucional) && validaCampoCodigoEmpleado($this->codigoEmpleado)) {

                // Clave sin hashear aun solo generada
                $generadorClaves = new GeneradorClaves();
                $password = $generadorClaves->generarClave();

                // Clave Hasheada
                $passwordEncriptada = password_hash($password, PASSWORD_DEFAULT);
                $noEmailEnUso = $this->verificaEmailUsuario();
                if ($noEmailEnUso) {
                    try {
                        $idUsuario= parent::registrarPersona();
                        $this->conexionBD = new Conexion();
                        $this->consulta = $this->conexionBD->connect();
                        if ($idUsuario != null) {
                            $stmt = $this->consulta->prepare('CALL SP_INSERTA_USUARIO(:idUsuario, :idTUsuario, :idDepto, :idEstado, :usuario, :correo, :codigo, :password)');
                            $stmt->bindValue(':idUsuario', $idUsuario);
                            $stmt->bindValue(':idTUsuario', $this->idTipoUsuario);
                            $stmt->bindValue(':idDepto', $this->idDepartamento);
                            $stmt->bindValue(':idEstado', ESTADO_ACTIVO);
                            $stmt->bindValue(':usuario', $this->nombreUsuario);
                            $stmt->bindValue(':correo', $this->correoInstitucional);
                            $stmt->bindValue(':codigo', $this->codigoEmpleado);
                            $stmt->bindValue(':password', $passwordEncriptada);
    
                            if ($stmt->execute()) {
                                $email = new Email();
                                $email->setEmailDestino($this->correoInstitucional);
                                $email->setNombreUsuario($this->nombreUsuario);
                                $email->setNombre($this->nombrePersona);
                                $email->setApellido($this->apellidoPersona);
                                $email->setHeaderMensaje('Bienvenido Al Sistema POA PACC');
                                $email->setTituloMensaje('Estas son tus credenciales de acceso al sistema');
                                $email->setContenido($password);
                                $enviado = $email->notificarViaCorreo();
                                if ($enviado) {
                                    return array(
                                        'status'=> SUCCESS_REQUEST,
                                        'data' => array('message' => 'Usuario ' . $this->correoInstitucional . ' insertado con exito, se envio una notificacion con credenciales via correo')
                                    );
                                } else {
                                    return array(
                                        'status'=> BAD_REQUEST,
                                        'data' => array('message' => 'Ha ocurrido un error, el correo no fue enviado')
                                    );
                                }
                            } else {
                                return array(
                                    'status'=> INTERNAL_SERVER_ERROR,
                                    'data' => array('message' => 'El registro no se pudo completar')
                                );
                            }
    
                        } else {
                            return array(
                                'status'=> SUCCESS_REQUEST,
                                'data' => array('message' => 'El registro no se pudo completar')
                            );
                        }
                    } catch (PDOException $ex) {
                        return array(
                            'status'=> INTERNAL_SERVER_ERROR,
                            'data' => array('message' => $idUsuario . $ex->getMessage())
                        );
                    } finally {
                        $this->conexionBD = null;
                    } 
                } else {
                    return array(
                        'status'=> SUCCESS_REQUEST,
                        'data' => array('message' => 'El correo institucional '. $this->correoInstitucional . ' ya se encuentra en uso')
                    );
                }
            } else {
                return array(
                    'status'=> BAD_REQUEST,
                    'data' => array('message' => 'Ha ocurrido un error, los datos insertados son erroneos')
                );
            }
        }

        public function actualizarDatosUsuario () {

        }

        public function getInformacionUsuarios () {
            try {
                $idUsuario= parent::registrarPersona();
                $this->conexionBD = new Conexion();
                $this->consulta = $this->conexionBD->connect();
                
                $stmt = $this->consulta->prepare('CALL SP_LISTAR_USUARIOS()');
                if ($stmt->execute() && ($stmt->rowCount() >= 1)) {
                    return array(
                        'status' => SUCCESS_REQUEST,
                        'data' => $stmt->fetchAll(PDO::FETCH_OBJ)
                    );
                } else {
                    return array(
                        'status'=> BAD_REQUEST,
                        'data' => array('message' => 'Ha ocurrido un error al listar los usuarios del sistema')
                    );
                }
            } catch (PDOException $ex) {
                return array(
                    'status'=> INTERNAL_SERVER_ERROR,
                    'data' => array('message' => $idUsuario . $ex->getMessage())
                );
            } finally {
                $this->conexionBD = null;
            } 
        }

        public function actualizarEstadoUsuario () {

        }
    }
?>