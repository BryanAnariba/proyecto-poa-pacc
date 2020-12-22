<?php
    require_once('../request-headers.php');
    require_once('../../controllers/CarrerasController.php');
    
    switch ($_SERVER['REQUEST_METHOD']) {
        case "POST": 
            //$_POST = json_decode(file_get_contents('php://input'));
            $carrera = new CarrerasController();
            
            $resultado = $carrera->obtenerEstados();
            
        break;
        default: 
        break;
    }