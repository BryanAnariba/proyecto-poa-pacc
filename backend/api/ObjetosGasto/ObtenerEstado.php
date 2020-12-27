<?php
    require_once('../request-headers.php');
    require_once('../../controllers/ObjetosGastoController.php');
    
    switch ($_SERVER['REQUEST_METHOD']) {
        case "POST": 
            //$_POST = json_decode(file_get_contents('php://input'));
            $Objetos = new ObjetosController();
            
            $resultado = $Objetos->obtenerEstados();
            
        break;
        default: 
            $Objetoss = new ObjetosController();
            $Objetoss->peticionNoValida();
        break;
    }