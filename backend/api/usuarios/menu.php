<?php
    require_once('../../middlewares/VerificarToken.php');
    require_once('../request-headers.php');
    require_once('../../controllers/UsuariosController.php');
    switch ($_SERVER['REQUEST_METHOD']) {
        case 'POST':
            $verificarTokenAcceso = new verificarTokenAcceso();
            $tokenEsValido = $verificarTokenAcceso->verificarTokenAcceso();
            if (!$tokenEsValido) {
                $usuario = new UsuariosController();
                $usuario->peticionNoAutorizada();
                require_once('../destruir-sesiones.php');
                header('Location: ../../frontend/index.php');
                exit;
            } else {
                $usuario = new UsuariosController();
                $usuario->logueado();
                exit;
            }
        break;
        default: 
            $usuario = new UsuariosController();
            $usuario->peticionNoValida();
        break;
    }
?>