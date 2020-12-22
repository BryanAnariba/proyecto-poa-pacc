<?php
    require_once('../request-headers.php');
    require_once('../../controllers/UsuariosController.php');
    
    switch ($_SERVER['REQUEST_METHOD']) {
        case 'POST': 
            $usuario = new UsuariosController();
            $usuario->obtenerUsuarios();
        break;
        default: 
            $usuario = new UsuariosController();
            $usuario->peticionNoValida();
        break;
        }
    ?>