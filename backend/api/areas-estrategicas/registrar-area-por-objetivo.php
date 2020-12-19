<?php
    require_once('../request-headers.php');
    require_once('../../controllers/AreasEstrategicasController.php');
    switch ($_SERVER['REQUEST_METHOD']) {
        case 'POST': 
            $_POST = json_decode(file_get_contents('php://input'), true);
            if (isset($_POST['idObjetivo']) && !empty($_POST['idObjetivo']) && isset($_POST['areaEstrategica']) && !empty($_POST['areaEstrategica'])) {
                $objetivo = new AreasEstrategicasController();
                $objetivo->insertarAreaPorObjetivo($_POST['idObjetivo'], $_POST['areaEstrategica']);
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