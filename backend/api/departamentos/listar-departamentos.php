<?php
    require_once('../request-headers.php');
    require_once('../../controllers/DepartamentosController.php');
    switch ($_SERVER['REQUEST_METHOD']) {
        case 'POST':
            $_POST = json_decode(file_get_contents('php://input'),true);
            if (isset($_POST['idEstadoDepartamento']) && !empty($_POST['idEstadoDepartamento'])) {
                $departamentos = new DepartamentosController();
                $departamentos->listarDepartamentos($_POST['idEstadoDepartamento']);
            } else {
                $departamentos = new DepartamentosController();
                $departamentos->peticionNoValida();    
            }
            
        break;
        default: 
            $departamentos = new DepartamentosController();
            $departamentos->peticionNoValida();
        break;
    }
?>