<?php
    require_once('../request-headers.php');
    require_once('../../controllers/DepartamentosController.php');
    
    switch ($_SERVER['REQUEST_METHOD']) {
        case 'POST': 
            $_POST = json_decode(file_get_contents('php://input'), true);
            if (isset($_POST['estadoDepartamento']) && !empty($_POST['estadoDepartamento']) &&
                isset($_POST['nombreDepartamento']) && !empty($_POST['nombreDepartamento']) && 
                isset($_POST['telefonoDepartamento']) && !empty($_POST['telefonoDepartamento']) && 
                isset($_POST['abreviaturaDepartamento']) && !empty($_POST['abreviaturaDepartamento']) && 
                isset($_POST['correoDepartamento']) && !empty($_POST['correoDepartamento'])){
                $departamento = new DepartamentosController();
  
                $departamento->registrarDepartamento(            
                    $_POST['estadoDepartamento'], 
                    $_POST['nombreDepartamento'],              
                    $_POST['telefonoDepartamento'], 
                    $_POST['abreviaturaDepartamento'], 
                    $_POST['correoDepartamento']
                    
                );
            }else {
                $departamentos = new DepartamentosController();
                $departamentos->peticionNoValida();
            }
        break;
        default: 
            $departamentos = new DepartamentosController();
            $departamentos->peticionNoValida();
        break;
    }



  