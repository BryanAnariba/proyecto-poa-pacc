<?php
    require_once('../request-headers.php');
    require_once('../../controllers/AreasEstrategicasController.php');
    switch ($_SERVER['REQUEST_METHOD']) {
        case 'POST': 
            $_POST = json_decode(file_get_contents('php://input'), true);
            if (isset($_POST['idObjetivo']) && !empty($_POST['idObjetivo'])) {
                $objetivo = new AreasEstrategicasController();
                $objetivo->listarAreasPorObjetivo($_POST['idObjetivo']);
            } else {
                $objetivo = new AreasEstrategicasController();
                $objetivo->peticionNoValida();
            }
        break;
        default: 
            $objetivo = new AreasEstrategicasController();
            $objetivo->peticionNoValida();
        break;
    }
?>