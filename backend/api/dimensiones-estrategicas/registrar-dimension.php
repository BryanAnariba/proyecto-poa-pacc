<?php
    require_once('../request-headers.php');
    require_once('../../helpers/Respuesta.php');
    require_once('../../controllers/DimensionesEstrategicasController.php');
    switch ($_SERVER['REQUEST_METHOD']) {
        case 'POST': 
            $_POST = json_decode(file_get_contents('php://input'), true);
            if (isset($_POST['dimensionEstrategica']) && !empty($_POST['dimensionEstrategica'])) {
                $dimension = new DimensionesEstrategicasController();
                $dimension->insertaDimension($_POST['dimensionEstrategica']);
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