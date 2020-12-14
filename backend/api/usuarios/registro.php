<?php
    require_once('request-headers.php');
    require_once('../../controllers/UsuariosController.php');
    
    switch ($_SERVER['REQUEST_METHOD']) {
        case "POST": 
            $_POST = json_decode(file_get_contents('php://input'));
            $usuario = new UsuariosController();
            
        break;
        default: 
        break;
    }

    /*
        Que necesito
        Insert -> 
            Generos, 
            TipoUsuario, 
            EstadoUsuario, 
            Departamentos, 
            Carreras, 
            lugar ,
            TipoLugar
    */

    