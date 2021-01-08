<?php
    require_once('../request-headers.php');
    require_once('../../controllers/DepartamentoController.php');
    switch ($_SERVER['REQUEST_METHOD']) {
        case 'POST': 
            $departamentos = new DepartamentoController();
            $departamentos->verDepartamentos();
        break;
        default: 
            $departamentos = new DepartamentoController();
            $departamentos->peticionNoValida();
        break;
    }
?>