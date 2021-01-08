<?php
    require_once('../request-headers.php');
    require_once('../../controllers/DepartamentoController.php');
    
    switch ($_SERVER['REQUEST_METHOD']) {
        case "POST": 
            //$_POST = json_decode(file_get_contents('php://input'));
            $departamento = new DepartamentoController();
            
            $resultado = $departamento->obtenerEstados();
            
        break;
        default: 
            $departamentos = new DepartamentoController();
            $departamentos->peticionNoValida();
        break;
    }