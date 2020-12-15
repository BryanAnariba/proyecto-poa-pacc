<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/proyecto-poa-pacc/backend/api/request-headers.php');
    require_once($_SERVER['DOCUMENT_ROOT'] . '/proyecto-poa-pacc/backend/controllers/LugaresController.php');
    switch ($_SERVER['REQUEST_METHOD']) {
        case 'POST': 
            $_POST = json_decode(file_get_contents('php://input'), true);
            if (isset($_POST['idTipoLugar']) && !empty($_POST['idTipoLugar'])) {
                $lugares = new LugaresController();
                $lugares->listarPaises($_POST['idTipoLugar']);
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