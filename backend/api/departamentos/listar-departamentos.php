<?php
    require_once('../request-headers.php');
    require_once('../../controllers/DepartamentosController.php');
    switch ($_SERVER['REQUEST_METHOD']) {
        case 'POST': 
            $departamentos = new DepartamentosController();
            $departamentos->verDepartamentos();
        break;
        default: 
            $departamentos = new DepartamentosController();
            $departamentos->peticionNoValida();
        break;
    }
?>