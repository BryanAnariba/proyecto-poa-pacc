<?php
    require_once('../request-headers.php');
    require_once('../../controllers/UsuariosController.php');
    
    switch ($_SERVER['REQUEST_METHOD']) {
        case 'POST': 
            $_POST = json_decode(file_get_contents('php://input'), true);
            if (
                    isset($_POST['idUsuario']) && 
                    !empty($_POST['idUsuario']) && 
                    isset($_POST['idPais']) && 
                    !empty($_POST['idPais']) && 
                    isset($_POST['idCiudad']) && 
                    !empty($_POST['idCiudad']) && 
                    isset($_POST['idMunicipio']) && 
                    !empty($_POST['idMunicipio']) && 
                    isset($_POST['direccion']) && 
                    !empty($_POST['direccion'])
            ){
                $usuario = new UsuariosController();
                $usuario->modificarDireccion($_POST['idUsuario'], $_POST['idPais'], $_POST['idCiudad'], $_POST['idMunicipio'], $_POST['direccion']);
            } else {
                $usuario = new UsuariosController();
                $usuario->peticionNoValida();
            }
            
        break;
        default: 
            $usuario = new UsuariosController();
            $usuario->peticionNoValida();
        break;
    }
?> 