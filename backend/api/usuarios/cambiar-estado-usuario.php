<?php
    require_once('../request-headers.php');
    require_once('../../controllers/UsuariosController.php');
    
    switch ($_SERVER['REQUEST_METHOD']) {
        case 'POST': 
            $_POST = json_decode(file_get_contents('php://input'), true);
            if (isset($_POST['idPersonaUsuario']) && !empty($_POST['idPersonaUsuario']) && isset($_POST['idEstadoUsuario']) && !empty($_POST['idEstadoUsuario'])) {
                $usuario = new UsuariosController();
                $usuario->cambiarEstadoUsuario($_POST['idPersonaUsuario'], $_POST['idEstadoUsuario']);
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