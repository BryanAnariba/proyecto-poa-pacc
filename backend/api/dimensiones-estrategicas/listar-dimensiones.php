<?php
    require_once('../request-headers.php');
    require_once('../../controllers/DimensionesEstrategicasController.php');
    switch ($_SERVER['REQUEST_METHOD']) {
        case 'POST': 
            $dimension = new DimensionesEstrategicasController();
            $dimension->listarDimensiones();
        break;
        default: 
            $dimension = new DimensionesEstrategicasController();
            $dimension->peticionNoValida();
        break;
    }
?>