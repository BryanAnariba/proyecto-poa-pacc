<?php
    require_once('../request-headers.php');
    require_once('../../controllers/DepartamentoController.php');
    
    switch ($_SERVER['REQUEST_METHOD']) {
        case "POST": 
            //$_POST = json_decode(file_get_contents('php://input'));
            if ($_POST['idDepartamentoM'] && 
                $_POST['nombreDepartamentoM'] && 
                $_POST['estadoDepartamentoM'] && 
                $_POST['abreviaturaDepartamentoM'] && 
                $_POST['telefonoDepartamentoM'] && 
                $_POST['correoDepartamentoM']) {
                $Departamentos = new DepartamentoController();
                
                $Departamentos->modificarDepartamento(
                    $_POST['idDepartamentoM'],
                    $_POST['nombreDepartamentoM'],
                    $_POST['estadoDepartamentoM'],
                    $_POST['abreviaturaDepartamentoM'],
                    $_POST['telefonoDepartamentoM'],
                    $_POST['correoDepartamentoM'],
                );
            }else {
                $Departamentos = new DepartamentoController();
                $Departamentos->peticionNoValida();
            }
        break;
        default: 
            $Departamentos = new DepartamentoController();
            $Departamentos->peticionNoValida();
        break;
    }