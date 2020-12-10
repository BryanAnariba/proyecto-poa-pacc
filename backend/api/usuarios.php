<?php
    header('Content-Type: application/json');
    require_once('../helpers/RespuestaPeticion.php');
    switch ($_SERVER['REQUEST_METHOD']) {
        case 'GET': 
        break;
        case 'POST': 
        break;
        case 'PUT': 
        break;
        case 'DELETE': 
        break;
        default: 
            $res = new RespuestaPeticion(400, array('mensaje' => 'El tipo de peticion no es valida'));
            $res->respuestaDePeticion();
        break;
    }