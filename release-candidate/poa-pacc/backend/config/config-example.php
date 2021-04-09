<?php
    // Database fields
    define('HOST', '');
    define('DB', '');
    define('USER', '');
    define('PASSWORD', '');
    define('CHARSET', 'utf8');
    
    // Http status reques code
    define('SUCCESS_REQUEST', 200);
    define('RESOURCE_CREATED', 201);
    define('BAD_REQUEST', 400);
    define('UNAUTHORIZED_REQUEST', 401);
    define('INTERNAL_SERVER_ERROR', 500);

    // Secret key
    define('SECRET_KEY', 'mi_clave_secreta');

    // Rutas direcctorios
    define('DIRECTORIO_UPLOADS', 'localhost/proyecto-poa-pac/backend/uploads');
    define('DIRECTORIO_IMAGES', 'images');
    define('DIRECTORIO_PDFS', 'pdfs');
    define('DIRECTORIO_WORDS', 'words');
    define('DIRECTORIO_USUARIOS', 'usuarios');

    define('ESTADO_ACTIVO', 1);
    define('ESTADO_INACTIVO', 2);

    // Entidades
    define('TBL_PERSONA', 'Persona');
    define('TBL_USUARIO', 'Usuario');
    define('TBL_LUGARES', 'Lugar');
    define('TBL_TIPO_USUARIO', 'TipoUsuario');
    define('TBL_DEPARTAMENTO', 'Departamento');
    define('TBL_DIMENSIONES', 'DimensionEstrategica');
    define('TBL_OBJETIVO_INSTITUCIONAL', 'ObjetivoInstitucional');
    define('TBL_AREA_ESTRATEGICA', 'AreaEstrategica');
?>