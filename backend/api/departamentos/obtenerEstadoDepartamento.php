<?php
    require_once('../request-headers.php');
    require_once('../../controllers/DepartamentosController.php');
    
    switch ($_SERVER['REQUEST_METHOD']) {
        case "POST": 
            //$_POST = json_decode(file_get_contents('php://input'));
            $departamento = new DepartamentosController();
            
            $resultado = $departamento->obtenerEstados();
            
        break;
        default: 
            $departamentos = new DepartamentosController();
            $departamentos->peticionNoValida();
        break;
    }