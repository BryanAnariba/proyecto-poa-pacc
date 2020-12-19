<?php
    require_once('../request-headers.php');
    require_once('../../controllers/ObjetivosInstitucionalesController.php');
    switch ($_SERVER['REQUEST_METHOD']) {
        case 'POST': 
            $_POST = json_decode(file_get_contents('php://input'), true);
            if (isset($_POST['idDimensionEstrategica']) && !empty($_POST['idDimensionEstrategica'])) {
                $objetivo = new ObjetivosIntitucionalesController();
                $objetivo->listarObjetivosPorDimension($_POST['idDimensionEstrategica']);
            } else {
                $objetivo = new ObjetivosIntitucionalesController();
                $objetivo->peticionNoValida();
            }
        break;
        default: 
            $objetivo = new ObjetivosIntitucionalesController();
            $objetivo->peticionNoValida();
        break;
    }
?>