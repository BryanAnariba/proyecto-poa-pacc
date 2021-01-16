<?php
    // Database fields
    define('HOST', 'localhost:3307');
    define('DB', 'poa-pacc-bd');
    define('USER', 'root');
    define('PASSWORD', 'root');
    define('CHARSET', 'utf8');
    
    // Http status reques code
    define('SUCCESS_REQUEST', 200);
    define('RESOURCE_CREATED', 201);
    define('BAD_REQUEST', 400);
    define('UNAUTHORIZED_REQUEST', 401);
    define('INTERNAL_SERVER_ERROR', 500);

    // Secret key
    define('TIEMPO_VIDA_TOKEN', 'PT50M');

    // Rutas direcctorios
    define('DIRECTORIO_UPLOADS', 'http://localhost/proyecto-poa-pacc/backend/uploads');
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
    define('TBL_PRESUPUESTO_ANUAL', 'controlPresupuestoActividad');
    define('TBL_PRESUPUESTO_DEPTO', 'presupuestoDepartamento');
    define('TBL_ESTADOS', 'estadoDCDUOAO');
    define('TBL_RESULTADOS_INSTITUCIONALES', 'ResultadoInstitucional');
    define('TBL_CONTROL_LLENADO_ACTIVIDADES', 'LlenadoActividadDimension');

    define('MIN_TAMANIO_CLAVE', 12);

    define('EMAIL_ADMIN_USERNAME','ariel.anarib@unah.edu.hn');
    define('EMAIL_ADMIN_PASSWORD','Ef5FrUd92D');
    define('APP_URI', 'https://aws.example.com');
?>