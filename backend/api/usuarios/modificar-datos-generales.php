<?php
    require_once('../request-headers.php');
    require_once('../../controllers/UsuariosController.php');
    
    switch ($_SERVER['REQUEST_METHOD']) {
        case 'POST': 
            $_POST = json_decode(file_get_contents('php://input'), true);
            if (isset($_POST['idUsuario']) && !empty($_POST['idUsuario']) && isset($_POST['nombrePersona']) && !empty($_POST['nombrePersona']) && isset($_POST['apellidoPersona']) && !empty($_POST['apellidoPersona']) && isset($_POST['codigoEmpleado']) && !empty($_POST['codigoEmpleado']) && isset($_POST['fechaNacimiento']) && !empty($_POST['fechaNacimiento']) && isset($_POST['idDepartamento']) && !empty($_POST['idDepartamento']) && isset($_POST['idTipoUsuario']) && !empty($_POST['idTipoUsuario'])) {
                $usuario = new UsuariosController();
                $usuario->modificarInformacionGeneral($_POST['idUsuario'], $_POST['nombrePersona'], $_POST['apellidoPersona'], $_POST['codigoEmpleado'], $_POST['fechaNacimiento'], $_POST['idDepartamento'], $_POST['idTipoUsuario']);
            } else {
                $usuario = new UsuariosController();
                $usuario->peticionNoValida();
            }
            
        break;
        default: 
            $usuario = new UsuariosController();
            $usuario->peticionNoValida();
        break;
    }
?> 