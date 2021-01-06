<?php
    require_once('../request-headers.php');
    require_once('../../controllers/DimensionesAdministrativasController.php');
    switch ($_SERVER['REQUEST_METHOD']) {
        case 'POST': 
            $dimension = new DimensionesAdministrativasController();
            $dimension->listarDimensiones();
        break;
        default: 
            $dimension = new DimensionesAdministrativasController();
            $dimension->peticionNoValida();
        break;
    }
?>