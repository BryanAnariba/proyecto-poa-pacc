<?php
    require_once('../../config/config.php');    
    require_once('../../validators/validators.php');
    require_once('../../database/Conexion.php');

    class EnvioSolicitudesPermisos {
        private $idUsuario; 
        private $idSolicitud; 
        private $idTipoSolicitud; 
        private $idEstadoSolicitud; 
        private $motivoSolicitud;
        private $edificioAsistencia;
        private $firmaDigital;
        private $documentoRespaldo;
        private $horaInicio;
        private $horaFin;
        private $fechaInicio;
        private $fechaFin;
        private $diasSolicitados;
        private $observaciones;
        private $nombreEmpleado;
        private $codigoEmpleado;
        private $departamento;

        private $conexionBD;
        private $consulta;
        private $idUltimaInsercion;
        //private $tablaBaseDatos;

        public function getIdUsuario(){
            return $this->idUsuario;
        }
 
        public function setIdUsuario($idUsuario){
            $this->idUsuario = $idUsuario;
            return $this;
        }

        public function getIdSolicitud(){
            return $this->idSolicitud;
        }        

        public function setIdSolicitud($idSolicitud){
            $this->idSolicitud = $idSolicitud;
            return $this;
        }

        public function getIdTipoSolicitud(){
            return $this->idTipoSolicitud;
        }
        
        public function setIdTipoSolicitud($idTipoSolicitud){
            $this->idTipoSolicitud = $idTipoSolicitud;
            return $this;
        }

        public function getIdEstadoSolicitud(){
            return $this->idEstadoSolicitud;

        }

        public function setIdEstadoSolicitud($idEstadoSolicitud){
            $this->idEstadoSolicitud = $idEstadoSolicitud;
            return $this;
        }

        public function getMotivoSolicitud(){
            return $this->motivoSolicitud;
        }
        
        public function setMotivoSolicitud($motivoSolicitud){
            $this->motivoSolicitud = $motivoSolicitud;
            return $this;
        }

        public function getEdificioAsistencia(){
            return $this->edificioAsistencia;
        }

        public function setEdificioAsistencia($edificioAsistencia){
            $this->edificioAsistencia = $edificioAsistencia;
            return $this;
        }
        
        public function getFirmaDigital(){
            return $this->firmaDigital;
        }

        public function setFirmaDigital($firmaDigital){
            $this->firmaDigital = $firmaDigital;
            return $this;
        }

        public function getDocumentoRespaldo(){
            return $this->documentoRespaldo;
        }

        public function setDocumentoRespaldo($documentoRespaldo){
            $this->documentoRespaldo = $documentoRespaldo;
            return $this;
        }

        public function getHoraInicio(){
            return $this->horaInicio;
        }

        public function setHoraInicio($horaInicio){
            $this->horaInicio = $horaInicio;
            return $this;
        }

        public function getHoraFin(){
            return $this->horaFin;
        }

        public function setHoraFin($horaFin){
            $this->horaFin = $horaFin;
            return $this;
        }

        public function getFechaInicio(){
            return $this->fechaInicio;
        }

        public function setFechaInicio($fechaInicio){
            $this->fechaInicio = $fechaInicio;
            return $this;
        }

        public function getFechaFin(){
            return $this->fechaFin;
        }

        public function setFechaFin($fechaFin){
            $this->fechaFin = $fechaFin;
            return $this;
        }

        public function getDiasSolicitados(){
            return $this->diasSolicitados;
        }

        public function setDiasSolicitados($diasSolicitados){
            $this->diasSolicitados = $diasSolicitados;
            return $this;
        }
        
        public function getObservaciones(){
            return $this->observaciones;
        }

        public function setObsevaciones($observaciones){
            $this->observaciones = $observaciones;
            return $this;
        }

        public function getNombreEmpleado(){
            return $this->nombreEmpleado;
        }

        public function setNombreEmpleado($nombreEmpleado){
            $this->nombreEmpleado = $nombreEmpleado;
            return $this;
        }

        public function getCodigoEmpleado(){
            return $this->codigoEmpleado;
        }

        public function setCodigoEmpleado($codigoEmpleado){
            $this->codigoEmpleado = $codigoEmpleado;
            return $this;
        }

        public function getDepartamento(){
            return $this->departamento;
        }

        public function setDepartamento($departamento){
            $this->departamento = $departamento;
            return $this;
        }
        

        //Función para ver solicitudes de permisos enviadas, segun el id de usuario de la sesión activa
        public function getSolicitudesEnviadas () {
            try {
                $this->conexionBD = new Conexion();
                $this->consulta = $this->conexionBD->connect();
                $stmt = $this->consulta->prepare("SELECT B.idSolicitud,
                                                        C.idTipoEstadoSolicitud,
                                                        A.tipoSolicitudSalida,
                                                        B.fechaRegistroSolicitud,
                                                        D.TipoEstadoSolicitudSalida
                                                FROM tiposolicitudsalida A
                                                INNER JOIN solicitudsalida B
                                                ON (A.idTipoSolicitudSalida = B.idTipoSolicitud AND
                                                    B.idPersonaUsuario = $this->idUsuario)
                                                INNER JOIN estadosolicitudsalida C
                                                ON (B.idSolicitud = C.idSolicitudSalida)
                                                INNER JOIN tipoestadosolicitudsalida D
                                                ON (C.idTipoEstadoSolicitud = D.idTipoEstadoSolicitud)
                                                ORDER BY B.idSolicitud DESC"); 
                if ($stmt->execute()) {
                    return array(
                        'status' => SUCCESS_REQUEST,
                        'data' => $stmt->fetchAll(PDO::FETCH_OBJ)
                    );
                } else {
                    return array(
                        'status'=> BAD_REQUEST,
                        'data' => array('message' => 'Ha ocurrido un error al listar sus solicitudes enviadas')
                    );
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




        //ObtenerSolicitudPorId
        public function ObtenerSolicitudPorId () {
            try {
                $this->conexionBD = new Conexion();
                $this->consulta = $this->conexionBD->connect();
                $stmt = $this->consulta->prepare("SELECT A.motivoSolicitud,
                                                        A.edificioAsistencia,
                                                        A.fechaInicioPermiso,
                                                        A.fechaFinPermiso,
                                                        A.horaInicioSolicitudSalida,
                                                        A.horaFinSolicitudSalida,
                                                        A.diasSolicitados,
                                                        B.fechaRevisionSolicitud
                                                FROM solicitudsalida A
                                                INNER JOIN estadosolicitudsalida B
                                                ON (A.idSolicitud = B.idSolicitudSalida AND
                                                    A.idSolicitud = $this->idSolicitud)"); 
                if ($stmt->execute()) {
                    return array(
                        'status' => SUCCESS_REQUEST,
                        'data' => $stmt->fetchAll(PDO::FETCH_OBJ)
                    );
                } else {
                    return array(
                        'status'=> BAD_REQUEST,
                        'data' => array('message' => 'Ha ocurrido un error al listar sus solicitudes enviadas')
                    );
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


        //ObtenerObservacionesPorId
        public function ObtenerObservacionesPorId() {
            try {
                $this->conexionBD = new Conexion();
                $this->consulta = $this->conexionBD->connect();
                $stmt = $this->consulta->prepare("SELECT observacionesSolicitud
                                                FROM estadosolicitudsalida
                                                WHERE idSolicitudSalida = $this->idSolicitud"); 
                if ($stmt->execute()) {
                    return array(
                        'status' => SUCCESS_REQUEST,
                        'data' => $stmt->fetchAll(PDO::FETCH_OBJ)
                    );
                } else {
                    return array(
                        'status'=> BAD_REQUEST,
                        'data' => array('message' => 'Ha ocurrido un error al listar la observacion enviadas')
                    );
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

       
        //registrarSolicitudSinImagenes
        public function registrarSolicitudSinImagenes() {
            if (is_numeric($this->idTipoSolicitud) && 
                is_numeric($this->idUsuario) && 
                campoTexto($this->motivoSolicitud,1,1000) &&                  
                campoTexto($this->edificioAsistencia,1,80)) {
                $this->conexionBD = new Conexion();
                $this->consulta = $this->conexionBD->connect();

                try {
                    $fechaActual = date('Y-m-d');
                    $this->conexionBD = new Conexion();
                    $this->consulta = $this->conexionBD->connect();
                    $stmt = $this->consulta->prepare("INSERT INTO solicitudsalida
                                                        (idTipoSolicitud, 
                                                            idPersonaUsuario, 
                                                            motivoSolicitud, 
                                                            edificioAsistencia, 
                                                            firmaDigital, 
                                                            documentoRespaldo, 
                                                            horaInicioSolicitudSalida, 
                                                            horaFinSolicitudSalida, 
                                                            diasSolicitados, 
                                                            fechaInicioPermiso, 
                                                            fechaFinPermiso,
                                                            fechaRegistroSolicitud
                                                        ) 
                                                        VALUES ($this->idTipoSolicitud, 
                                                                $this->idUsuario, 
                                                                '$this->motivoSolicitud', 
                                                                '$this->edificioAsistencia', 
                                                                NULL, 
                                                                NULL, 
                                                                '$this->horaInicio',
                                                                '$this->horaFin',
                                                                NULL, 
                                                                '$this->fechaInicio',
                                                                '$this->fechaFin',
                                                                '$fechaActual'
                                                                )"
                                                    );
                    if ($stmt->execute()) {
                    //$id variable para guardar el id de la ultima iserción que se hizo en la tabla
                    //solicitudSalida, usando la funcion lastInsertId(); de php, para obtener dicho id
                    // esta función de php solo se puede usar cuando el id de una tabla es auto incremental                              
                        $id = $this->consulta->lastInsertId();
                        //insertando en la tabla estadosolicitudsalida
                        $this->conexionBD = new Conexion();
                        $this->consulta = $this->conexionBD->connect();
                        $stmt1 = $this->consulta->prepare("INSERT INTO estadosolicitudsalida(
                                                                idPersonaUsuarioVeedor,
                                                                idSolicitudSalida,
                                                                idTipoEstadoSolicitud,
                                                                observacionesSolicitud,
                                                                fechaRevisionSolicitud
                                                            )
                                                            VALUES(NULL,
                                                                $id,
                                                                1,
                                                                NULL,
                                                                NULL)"
                                                        );
                        $stmt1->execute();

                        $this->conexionBD = new Conexion();
                        $this->consulta = $this->conexionBD->connect();
                        $stmt2 = $this->consulta->prepare("UPDATE solicitudsalida 
                                                            SET diasSolicitados = DATEDIFF(fechaFinPermiso,fechaInicioPermiso)
                                                            WHERE idSolicitud = $id");
                        $stmt2->execute();

                        return array(
                            'status' => SUCCESS_REQUEST,
                            'data' => array('message' => 'Solicitud registrada con exito')
                        );
                    } else {
                        return array(
                            'status'=> BAD_REQUEST,
                            'data' => array('error' => 'Ha ocurrido un error al insertar la solicitud')
                        );
                    }
                } catch (PDOException $ex) {
                    return array(
                        'status'=> INTERNAL_SERVER_ERROR,
                        'data' => array('message' => array($ex->getMessage()))
                    );
                } finally {
                    $this->conexionBD = null;
                }

            } else {
                return array(
                    'status'=> BAD_REQUEST,
                    'data' => array('message' => 'Ha ocurrido un error, los datos insertados son erroneos')
                );
            }
        }



        //registrarSolicitudConImagenes
        public function registrarSolicitudConImagenes() {
            if (is_numeric($this->idTipoSolicitud) && 
                is_numeric($this->idUsuario) && 
                campoTexto($this->motivoSolicitud,1,1000) &&                  
                campoTexto($this->edificioAsistencia,1,80)) {
                $this->conexionBD = new Conexion();
                $this->consulta = $this->conexionBD->connect();

                try {
                    $fechaActual = date('Y-m-d');
                    $this->conexionBD = new Conexion();
                    $this->consulta = $this->conexionBD->connect();
                    $stmt = $this->consulta->prepare("INSERT INTO solicitudsalida
                                                        (idTipoSolicitud, 
                                                            idPersonaUsuario, 
                                                            motivoSolicitud, 
                                                            edificioAsistencia, 
                                                            firmaDigital, 
                                                            documentoRespaldo, 
                                                            horaInicioSolicitudSalida, 
                                                            horaFinSolicitudSalida, 
                                                            diasSolicitados, 
                                                            fechaInicioPermiso, 
                                                            fechaFinPermiso,
                                                            fechaRegistroSolicitud 
                                                        ) 
                                                        VALUES ($this->idTipoSolicitud, 
                                                                $this->idUsuario, 
                                                                '$this->motivoSolicitud', 
                                                                '$this->edificioAsistencia', 
                                                                '$this->firmaDigital', 
                                                                '$this->documentoRespaldo', 
                                                                '$this->horaInicio',
                                                                '$this->horaFin',
                                                                NULL, 
                                                                '$this->fechaInicio',
                                                                '$this->fechaFin',
                                                                '$fechaActual'
                                                                )"
                                                    );
                    if ($stmt->execute()) {
                    //$id variable para guardar el id de la ultima iserción que se hizo en la tabla
                    //solicitudSalida, usando la funcion lastInsertId(); de php, para obtener dicho id
                    // esta función de php solo se puede usar cuando el id de una tabla es auto incremental                              
                        $id = $this->consulta->lastInsertId();
                        //insertando en la tabla estadosolicitudsalida
                        $this->conexionBD = new Conexion();
                        $this->consulta = $this->conexionBD->connect();
                        $stmt1 = $this->consulta->prepare("INSERT INTO estadosolicitudsalida(
                                                                idPersonaUsuarioVeedor,
                                                                idSolicitudSalida,
                                                                idTipoEstadoSolicitud,
                                                                observacionesSolicitud,
                                                                fechaRevisionSolicitud
                                                            )
                                                            VALUES(NULL,
                                                                $id,
                                                                1,
                                                                NULL,
                                                                NULL)"
                                                        );
                        $stmt1->execute();

                        $this->conexionBD = new Conexion();
                        $this->consulta = $this->conexionBD->connect();
                        $stmt2 = $this->consulta->prepare("UPDATE solicitudsalida 
                                                            SET diasSolicitados = DATEDIFF(fechaFinPermiso,fechaInicioPermiso)
                                                            WHERE idSolicitud = $id");
                        $stmt2->execute();

                        return array(
                            'status' => SUCCESS_REQUEST,
                            'data' => array('message' => 'Solicitud registrada con exito')
                        );
                    } else {
                        return array(
                            'status'=> BAD_REQUEST,
                            'data' => array('error' => 'Ha ocurrido un error al insertar la solicitud')
                        );
                    }
                } catch (PDOException $ex) {
                    return array(
                        'status'=> INTERNAL_SERVER_ERROR,
                        'data' => array('message' => array($ex->getMessage()))
                    );
                } finally {
                    $this->conexionBD = null;
                }

            } else {
                return array(
                    'status'=> BAD_REQUEST,
                    'data' => array('message' => 'Ha ocurrido un error, los datos insertados son erroneos')
                );
            }
        }


        //registrarSolicitudConFirma
        public function registrarSolicitudConFirma() {
            if (is_numeric($this->idTipoSolicitud) && 
                is_numeric($this->idUsuario) && 
                campoTexto($this->motivoSolicitud,1,1000) &&                  
                campoTexto($this->edificioAsistencia,1,80)) {
                $this->conexionBD = new Conexion();
                $this->consulta = $this->conexionBD->connect();

                try {
                    $fechaActual = date('Y-m-d');
                    $this->conexionBD = new Conexion();
                    $this->consulta = $this->conexionBD->connect();
                    $stmt = $this->consulta->prepare("INSERT INTO solicitudsalida
                                                        (idTipoSolicitud, 
                                                            idPersonaUsuario, 
                                                            motivoSolicitud, 
                                                            edificioAsistencia, 
                                                            firmaDigital, 
                                                            documentoRespaldo, 
                                                            horaInicioSolicitudSalida, 
                                                            horaFinSolicitudSalida, 
                                                            diasSolicitados, 
                                                            fechaInicioPermiso, 
                                                            fechaFinPermiso,
                                                            fechaRegistroSolicitud
                                                        ) 
                                                        VALUES ($this->idTipoSolicitud, 
                                                                $this->idUsuario, 
                                                                '$this->motivoSolicitud', 
                                                                '$this->edificioAsistencia', 
                                                                '$this->firmaDigital', 
                                                                NULL, 
                                                                '$this->horaInicio',
                                                                '$this->horaFin',
                                                                NULL, 
                                                                '$this->fechaInicio',
                                                                '$this->fechaFin',
                                                                '$fechaActual'
                                                                )"
                                                    );
                    if ($stmt->execute()) {
                    //$id variable para guardar el id de la ultima iserción que se hizo en la tabla
                    //solicitudSalida, usando la funcion lastInsertId(); de php, para obtener dicho id
                    // esta función de php solo se puede usar cuando el id de una tabla es auto incremental                              
                        $id = $this->consulta->lastInsertId();
                        //insertando en la tabla estadosolicitudsalida
                        $this->conexionBD = new Conexion();
                        $this->consulta = $this->conexionBD->connect();
                        $stmt1 = $this->consulta->prepare("INSERT INTO estadosolicitudsalida(
                                                                idPersonaUsuarioVeedor,
                                                                idSolicitudSalida,
                                                                idTipoEstadoSolicitud,
                                                                observacionesSolicitud,
                                                                fechaRevisionSolicitud
                                                            )
                                                            VALUES(NULL,
                                                                $id,
                                                                1,
                                                                NULL,
                                                                NULL)"
                                                        );
                        $stmt1->execute();

                        $this->conexionBD = new Conexion();
                        $this->consulta = $this->conexionBD->connect();
                        $stmt2 = $this->consulta->prepare("UPDATE solicitudsalida 
                                                            SET diasSolicitados = DATEDIFF(fechaFinPermiso,fechaInicioPermiso)
                                                            WHERE idSolicitud = $id");
                        $stmt2->execute();

                        return array(
                            'status' => SUCCESS_REQUEST,
                            'data' => array('message' => 'Solicitud registrada con exito')
                        );
                    } else {
                        return array(
                            'status'=> BAD_REQUEST,
                            'data' => array('error' => 'Ha ocurrido un error al insertar la solicitud')
                        );
                    }
                } catch (PDOException $ex) {
                    return array(
                        'status'=> INTERNAL_SERVER_ERROR,
                        'data' => array('message' => array($ex->getMessage()))
                    );
                } finally {
                    $this->conexionBD = null;
                }

            } else {
                return array(
                    'status'=> BAD_REQUEST,
                    'data' => array('message' => 'Ha ocurrido un error, los datos insertados son erroneos')
                );
            }
        }


        //registrarSolicitudConRespaldo
        public function registrarSolicitudConRespaldo() {
            if (is_numeric($this->idTipoSolicitud) && 
                is_numeric($this->idUsuario) && 
                campoTexto($this->motivoSolicitud,1,1000) &&                  
                campoTexto($this->edificioAsistencia,1,80)) {
                $this->conexionBD = new Conexion();
                $this->consulta = $this->conexionBD->connect();

                try {
                    $fechaActual = date('Y-m-d');
                    $this->conexionBD = new Conexion();
                    $this->consulta = $this->conexionBD->connect();
                    $stmt = $this->consulta->prepare("INSERT INTO solicitudsalida
                                                        (idTipoSolicitud, 
                                                            idPersonaUsuario, 
                                                            motivoSolicitud, 
                                                            edificioAsistencia, 
                                                            firmaDigital, 
                                                            documentoRespaldo, 
                                                            horaInicioSolicitudSalida, 
                                                            horaFinSolicitudSalida, 
                                                            diasSolicitados, 
                                                            fechaInicioPermiso, 
                                                            fechaFinPermiso,
                                                            fechaRegistroSolicitud
                                                        ) 
                                                        VALUES ($this->idTipoSolicitud, 
                                                                $this->idUsuario, 
                                                                '$this->motivoSolicitud', 
                                                                '$this->edificioAsistencia', 
                                                                NULL, 
                                                                '$this->documentoRespaldo', 
                                                                '$this->horaInicio',
                                                                '$this->horaFin',
                                                                NULL, 
                                                                '$this->fechaInicio',
                                                                '$this->fechaFin',
                                                                '$fechaActual'
                                                                )"
                                                    );
                    if ($stmt->execute()) {
                    //$id variable para guardar el id de la ultima iserción que se hizo en la tabla
                    //solicitudSalida, usando la funcion lastInsertId(); de php, para obtener dicho id
                    // esta función de php solo se puede usar cuando el id de una tabla es auto incremental                              
                        $id = $this->consulta->lastInsertId();
                        //insertando en la tabla estadosolicitudsalida
                        $this->conexionBD = new Conexion();
                        $this->consulta = $this->conexionBD->connect();
                        $stmt1 = $this->consulta->prepare("INSERT INTO estadosolicitudsalida(
                                                                idPersonaUsuarioVeedor,
                                                                idSolicitudSalida,
                                                                idTipoEstadoSolicitud,
                                                                observacionesSolicitud,
                                                                fechaRevisionSolicitud
                                                            )
                                                            VALUES(NULL,
                                                                $id,
                                                                1,
                                                                NULL,
                                                                NULL)"
                                                        );
                        $stmt1->execute();

                        $this->conexionBD = new Conexion();
                        $this->consulta = $this->conexionBD->connect();
                        $stmt2 = $this->consulta->prepare("UPDATE solicitudsalida 
                                                            SET diasSolicitados = DATEDIFF(fechaFinPermiso,fechaInicioPermiso)
                                                            WHERE idSolicitud = $id");
                        $stmt2->execute();

                        return array(
                            'status' => SUCCESS_REQUEST,
                            'data' => array('message' => 'Solicitud registrada con exito')
                        );
                    } else {
                        return array(
                            'status'=> BAD_REQUEST,
                            'data' => array('error' => 'Ha ocurrido un error al insertar la solicitud')
                        );
                    }
                } catch (PDOException $ex) {
                    return array(
                        'status'=> INTERNAL_SERVER_ERROR,
                        'data' => array('message' => array($ex->getMessage()))
                    );
                } finally {
                    $this->conexionBD = null;
                }

            } else {
                return array(
                    'status'=> BAD_REQUEST,
                    'data' => array('message' => 'Ha ocurrido un error, los datos insertados son erroneos')
                );
            }
        }



        //verImagenRespaldoPorId
        public function verImagenRespaldoPorId() {
            try {
                $this->conexionBD = new Conexion();
                $this->consulta = $this->conexionBD->connect();
                $stmt = $this->consulta->prepare("SELECT documentoRespaldo, firmaDigital 
                                                FROM solicitudsalida 
                                                WHERE idSolicitud  = $this->idSolicitud"); 
                if ($stmt->execute()) {
                    return array(
                        'status' => SUCCESS_REQUEST,
                        'data' => $stmt->fetchAll(PDO::FETCH_OBJ)
                    );
                } else {
                    return array(
                        'status'=> BAD_REQUEST,
                        'data' => array('message' => 'Ha ocurrido un error al listar la imagen de respaldo')
                    );
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




    }
?>