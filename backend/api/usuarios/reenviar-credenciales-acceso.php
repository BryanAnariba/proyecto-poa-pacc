<?php
    require_once('../request-headers.php');
    require_once('../../controllers/UsuariosController.php');
    
    switch ($_SERVER['REQUEST_METHOD']) {
        case 'POST': 
            $_POST = json_decode(file_get_contents('php://input'), true);
            if (isset($_POST['idUsuario']) && !empty($_POST['idUsuario']) && isset($_POST['correoInstitucional']) && !empty($_POST['correoInstitucional']) && isset($_POST['nombrePersona']) && !empty($_POST['nombrePersona']) && isset($_POST['apellidoPersona']) && !empty($_POST['apellidoPersona']) && isset($_POST['nombreUsuario']) && !empty($_POST['nombreUsuario'])) {
                $usuario = new UsuariosController();
                $usuario->reenviarCredencialesAcceso($_POST['idUsuario'], $_POST['correoInstitucional'], $_POST['nombrePersona'], $_POST['apellidoPersona'], $_POST['nombreUsuario']);
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