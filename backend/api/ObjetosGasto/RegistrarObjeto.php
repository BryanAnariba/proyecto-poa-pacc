<?php
    require_once('../request-headers.php');
    require_once('../../controllers/ObjetosGastoController.php');
    
    switch ($_SERVER['REQUEST_METHOD']) {
        case "POST": 
            //$_POST = json_decode(file_get_contents('php://input'), true);
            if ($_POST['ObjetoDeGasto'] && $_POST['Abreviatura'] && $_POST['CodigoObjeto'] && $_POST['Estado']) {
                $Objeto = new ObjetosController();
  
                $Objeto->registrarObjeto(            
                    $_POST['ObjetoDeGasto'],
                    $_POST['Abreviatura'],
                    $_POST['CodigoObjeto'],
                    $_POST['Estado']
                );
            }else {
                $Objetos = new ObjetosController();
                $Objetos->peticionNoValida();
            }
        break;
        default: 
            $Objetos = new ObjetosController();
            $Objetos->peticionNoValida();
        break;
    }