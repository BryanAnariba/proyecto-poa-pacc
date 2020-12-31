<?php
    require_once('../request-headers.php');
    require_once('../../middlewares/VerificarToken.php');
    require_once('../../helpers/Imagen.php');
    require_once('../../controllers/PresupuestosController.php');
    switch ($_SERVER['REQUEST_METHOD']) {
        case 'POST':
            $verificarTokenAcceso = new verificarTokenAcceso();
            $tokenEsValido = $verificarTokenAcceso->verificarTokenAcceso();
            if ($tokenEsValido) {
                $_POST = json_decode(file_get_contents('php://input'), true);
                if (isset($_POST['presupuestoAnual']) && !empty($_POST['presupuestoAnual'])) {
                    $presupuesto = new PresupuestosController();
                    $presupuesto->registrarPresupuestoAnual($_POST['presupuestoAnual']);
                } else {
                    $presupuesto = new PresupuestosController();
                    $presupuesto->peticionNoValida();
                }
            } else {
                $presupuesto = new PresupuestosController();
                $presupuesto->peticionNoAutorizada();
                require_once('../destruir-sesiones.php');
            }
        break;
        default: 
            $presupuesto = new PresupuestosController();
            $presupuesto->peticionNoValida();
        break;
    }
?>