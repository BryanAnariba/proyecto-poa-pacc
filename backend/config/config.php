<?php
    // Database fields
    define('HOST', 'localhost:3307');
    define('DB', 'db-poa');
    define('USER', 'root');
    define('PASSWORD', 'root');
    define('CHARSET', 'utf8');
    
    // Http status reques code
    define('SUCCESS_REQUEST', 200);
    define('RESOURCE_CREATED', 201);
    define('BAD_REQUEST', 400);
    define('UNAUTHORIZED_REQUEST', 401);
    define('INTERNAL_SERVER_ERROR', 500);

    // Validaciones de campos
    define('INTEGER', '1');
    define('STRING', '2');
    define('NUMERIC', '3');

    // Secret key
    define('SECRET_KEY', 'mi_clave_secreta');