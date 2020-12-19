<?php
    require_once('../request-headers.php');
    require_once('../../controllers/DimensionesEstrategicasController.php');
    switch ($_SERVER['REQUEST_METHOD']) {
        case 'POST': 
            $_POST = json_decode(file_get_contents('php://input'), true);
            if (isset($_POST['idDimensionEstrategica']) && !empty($_POST['idDimensionEstrategica'])) {
                $dimension = new DimensionesEstrategicasController();
                $dimension->modificaEstadoDimension($_POST['idDimensionEstrategica']);
            } else {
                $dimension = new DimensionesEstrategicasController();
                $dimension->peticionNoValida();
            }
        break;
        default: 
            $dimension = new DimensionesEstrategicasController();
            $dimension->peticionNoValida();
        break;
    }
?>