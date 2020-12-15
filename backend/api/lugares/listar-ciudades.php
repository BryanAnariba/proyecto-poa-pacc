<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/proyecto-poa-pacc/backend/api/request-headers.php');
    require_once($_SERVER['DOCUMENT_ROOT'] . '/proyecto-poa-pacc/backend/controllers/LugaresController.php');
    switch ($_SERVER['REQUEST_METHOD']) {
        case 'POST': 
            $_POST = json_decode(file_get_contents('php://input'), true);
            if (isset($_POST['idPais']) && !empty($_POST['idPais'])) {
                $lugares = new LugaresController();
                $lugares->listarCiudades($_POST['idPais']);
            } else {
                $lugares = new LugaresController();
                $lugares->peticionNoValida();
            }
            
        break;
        default: 
            $lugares = new LugaresController();
            $lugares->peticionNoValida();
        break;
    }