<?php
    // Funciones para verificar campos que vienen desde el frontend
    
    function campoTexto ($parametro, $min, $max) {
        if ((preg_match("/^[ñA-Za-z _]*[ñA-Za-z][ñA-Za-z _]/", $parametro) == true) &&  (strlen($parametro) >= $min) && (strlen($parametro) <= $max)) {
            return true;
        } else {
            return false;
        }
    }

    function campoCodigoEmpleado ($parametro) {
        
    }

    function campoEmail ($parametro) {

    }

    function campoNumerico ($parametro) {

    }

    function campoTextoSinNumeros ($parametro, $min, $max) {

    }
?>