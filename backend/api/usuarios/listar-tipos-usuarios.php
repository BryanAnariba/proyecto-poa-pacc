<?php
    require_once('../request-headers.php');
    require_once('../../controllers/TipoUsuarioController.php');
    switch ($_SERVER['REQUEST_METHOD']) {
        case 'POST':
            $tipoUsuario = new TipoUsuarioController();
            $tipoUsuario->listarTiposUsuarios();
        break;
        default: 
            $tipoUsuario = new TipoUsuarioController();
            $tipoUsuario->peticionNoValida();
        break;
    }
?>