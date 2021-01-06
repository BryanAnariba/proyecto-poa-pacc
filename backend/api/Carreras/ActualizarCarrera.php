<?php
    require_once('../request-headers.php');
    require_once('../../controllers/CarrerasController.php');
    
    switch ($_SERVER['REQUEST_METHOD']) {
        case "POST": 
            //$_POST = json_decode(file_get_contents('php://input'));
            if ($_POST['idCarrera'] && $_POST['Carrera'] && $_POST['Abreviatura'] && $_POST['Departamento'] && $_POST['Estado']) {
                $carreras = new CarrerasController();
                
                $carreras->ActualizarCarrera(
                    $_POST['idCarrera'],
                    $_POST['Carrera'],
                    $_POST['Abreviatura'],
                    $_POST['Departamento'],
                    $_POST['Estado']
                );
            }else {
                $carreras = new CarrerasController();
                $carreras->peticionNoValida();
            }
        break;
        default: 
            $carreras = new CarrerasController();
            $carreras->peticionNoValida();
        break;
    }