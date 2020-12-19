<?php
    require_once('../request-headers.php');
    require_once('../../controllers/AreasEstrategicasController.php');
    switch ($_SERVER['REQUEST_METHOD']) {
        case 'POST': 
            $_POST = json_decode(file_get_contents('php://input'), true);
            if (isset($_POST['idArea']) && !empty($_POST['idArea']) && isset($_POST['areaEstrategica']) && !empty($_POST['areaEstrategica'])) {
                $objetivo = new AreasEstrategicasController();
                $objetivo->modificarArea($_POST['idArea'], $_POST['areaEstrategica']);
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