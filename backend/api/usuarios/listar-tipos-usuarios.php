<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/proyecto-poa-pacc/backend/api/request-headers.php');
    require_once($_SERVER['DOCUMENT_ROOT'] . '/proyecto-poa-pacc/backend/controllers/TipoUsuarioController.php');
    switch ($_SERVER['REQUEST_METHOD']) {
        case 'POST':
            $tipoUsuario = new TipoUsuarioController();
            $tipoUsuario->listarTiposUsuarios();
        break;
        default: 
            $tipoUsuario = new TipoUsuarioController();
            $tipoUsuario->peticionNoValida();
        break;
    }