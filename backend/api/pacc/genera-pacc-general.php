<?php
    require_once('../request-headers.php');
    require_once('../../middlewares/VerificarToken.php');
    require_once('../../controllers/PaccController.php');
    switch ($_SERVER['REQUEST_METHOD']) {
        case 'POST':
            $verificarTokenAcceso = new verificarTokenAcceso();
            $tokenEsValido = $verificarTokenAcceso->verificarTokenAcceso();
            if ($tokenEsValido) {
                $_POST = json_decode(file_get_contents('php;//input'), true);
                if (isset($_POST['fechaPresupuestoAnual']) && !empty($_POST['fechaPresupuestoAnual'])) {
                    $pacc = new PaccController();
                    $pacc->generaReporteGeneral($_POST['fechaPresupuestoAnual']);
                } else {
                    $pacc = new PaccController();
                    $pacc->peticionNoValida();
                }
            } else {
                $pacc = new PaccController();
                $pacc->peticionNoAutorizada();
                require_once('../destruir-sesiones.php');
            }
        break;
        default: 
            $pacc = new PaccController();
            $pacc->peticionNoValida();
        break;
    }
?>