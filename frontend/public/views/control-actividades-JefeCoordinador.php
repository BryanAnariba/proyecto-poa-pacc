<?php
    include('../partials/doctype.php');;
?>
<title>Control de actividades</title>
<!--En esta zona podran poner estilos propios de la vista-->
<link rel="stylesheet" href="../css/Jefe-Coordinador/control-actividades.css" />
<link rel="stylesheet" href="../css/sweet-alert-two/sweetalert2.min.css">

<link rel="stylesheet" href="../js/data-tables/datatables.min.css">
<link rel="stylesheet" href="../js/data-tables/DataTables/css/dataTables.bootstrap4.min.css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

</head>

<body id="body-pd">
    <?php include('../layouts/Nabvar.php'); ?>
    <?php include('../layouts/Sidebar.php'); ?>
    
    <div id="profile-card" class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="card">
                    <div class="card-header indigo darken-4 text-white">
                        <h5 class="font-weight-bolder"> Maneja el llenado de las dimensiones desde este panel</h5>
                    </div>
                    <div class="card-body  blue lighten-5">
                        <div class="container-fluid">
                            <div class="row">
                                <div class="col-xl-4 col-lg-4 col-md-4 col-sm-12 mb-3">
                                    <div class="card border border-warning b-2 rounded mb-0 animate__animated animate__flipInY">
                                        <div class="card-header amber accent-4">
                                            <div class="row">
                                                <div class="col-xl-9 col-lg-9 col-md-9 col-sm-8">
                                                    <h6 class="text-white font-weight-bold">
                                                        Dimensiones Academicas Pendientes
                                                    </h6>
                                                </div>
                                                <div class="col-xl-3 col-lg-3 col-md-3 col-sm-4">
                                                    <img src="../img/partial-sidebar/departamentos-icon.svg" alt="Control de Departamentos">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <br>
                                            <div class="view overlay">
                                                <img 
                                                    class="card-img-top" 
                                                    src="../img/jefe-coordinador/pending_approval.svg" 
                                                    alt="visualizar carrera">
                                            </div>
                                            <hr>
                                            <button 
                                                type="button"
                                                class="btn btn-indigo btn-block"  
                                                data-toggle="modal" 
                                                data-target="#modalVisualizarCarreras"
                                                onclick="llenar('DimensionesTabla')">
                                                Ir
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xl-4 col-lg-4 col-md-4 col-sm-12 mb-3" id="mda">
                                    <div class="card border border-warning b-2 rounded mb-0 animate__animated animate__flipInY">
                                        <div class="card-header amber accent-4">
                                            <div class="row">
                                                <div class="col-xl-9 col-lg-9 col-md-9 col-sm-8">
                                                    <h6 class="text-white font-weight-bold">
                                                        Modidificar Actividades
                                                    </h6>
                                                </div>
                                                <div class="col-xl-3 col-lg-3 col-md-3 col-sm-4">
                                                    <img src="../img/partial-sidebar/departamentos-icon.svg" alt="Control de Departamentos">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <div class="view overlay">
                                                <img 
                                                    class="card-img-top" 
                                                    src="../img/jefe-coordinador/Reviewed_docs.svg" 
                                                    alt="registrar carrera">
                                            </div>
                                            <hr>
                                            <button 
                                                type="button"
                                                class="btn btn-indigo btn-block"  
                                                data-toggle="modal" 
                                                data-target="#modalRegistrarCarrera"
                                                onclick="llenar('DimensionesTablaModificar')">
                                                Ir
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xl-4 col-lg-4 col-md-4 col-sm-12 mb-3" id="aga">
                                    <div class="card border border-warning b-2 rounded mb-0 animate__animated animate__flipInY">
                                        <div class="card-header amber accent-4">
                                            <div class="row">
                                                <div class="col-xl-9 col-lg-9 col-md-9 col-sm-8">
                                                    <h6 class="text-white font-weight-bold">
                                                        Agregar actividad
                                                    </h6>
                                                </div>
                                                <div class="col-xl-3 col-lg-3 col-md-3 col-sm-4">
                                                    <img src="../img/partial-sidebar/departamentos-icon.svg" alt="Control de Departamentos">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <div class="view overlay">
                                                <img 
                                                    class="card-img-top" 
                                                    src="../img/jefe-coordinador/add_file.svg"  
                                                    alt="Modificar carrera">
                                            </div>
                                            <hr>
                                            <button 
                                                type="button"
                                                class="btn btn-indigo btn-block"  
                                                data-toggle="modal" 
                                                data-target="#modalModificarCarrera"
                                                onclick="llenar('DimensionesTablaAgregar')">
                                                Ir
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card-footer amber accent-4">

                    </div>
                </div>
            </div>
        </div>
    </div>

                                                    <!--modales-->
    <!--llenado de dimensiones-->
    <div 
        class="modal fade" 
        id="modalVisualizarCarreras" 
        tabindex="-1" role="dialog" 
        aria-labelledby="myModalLabel" 
        aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header indigo darken-4 text-white">
                    <h4 class="modal-title w-100" id="myModalLabel">Dimensiones Academicas pendientes</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body table-responsive">
                    <table id="DimensionesTabla" class="table" cellspacing="0" width="100%">
                        <thead>
                            <tr align="center">
                                <th scope="col">Estado</th>
                                <th scope="col">Dimension Acadaemica</th>
                                <th scope="col">Llenar dimension</th>
                            </tr>
                        </thead>
                    </table>
                </div>
                <div class="modal-footer card-footer amber accent-4">
                </div>
            </div>
        </div>
    </div>

    <!--Modificar Actividades-->
    <div 
        class="modal fade" 
        id="modalRegistrarCarrera" 
        tabindex="-1" role="dialog" 
        aria-labelledby="myModalLabel" 
        aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header indigo darken-4 text-white">
                    <h4 class="modal-title w-100" id="myModalLabel">Listado de dimensiones a modificar</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div id="ventana1">
                        <div class="table-responsive">
                            <table id="DimensionesTablaModificar" class="table" cellspacing="0" width="100%">
                                <thead>
                                    <tr align="center">
                                        <th scope="col">Estado</th>
                                        <th scope="col">Dimension Acadaemica</th>
                                        <th scope="col">Llenar dimension</th>
                                    </tr>
                                </thead>
                            </table>
                        </div>
                    </div>
                    <div id="ventana2">
                        <form class="text-center" style="color: #757575;" action="#!">
                            <div class="tabla">
                                <h4 align="center">Seleccione lista de actividades que desea editar:</h4>
                                <div class="form-row">
                                    <div class="input-field col-xl-6 col-lg-6 col-md-6 col-sm-12">
                                        <label>Dimension academica:</label>
                                        <select id="dimAc" class="browser-default custom-select mb-4" onchange="">

                                        </select>
                                    </div>
                                    <div id="carreraSel"  class="input-field col-xl-6 col-lg-6 col-md-6 col-sm-12">
                                        <label>Objetivo institucional:</label>
                                        <select id="ObIn" class="browser-default custom-select mb-4" onchange="">

                                        </select>
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="input-field col-xl-6 col-lg-6 col-md-6 col-sm-12">
                                        <label>Area estrategica:</label>
                                        <select id="ArEs" class="browser-default custom-select mb-4" onchange="">

                                        </select>
                                    </div>
                                </div>
                                <div class="container">
                                    <div class="row">
                                        <div class="input col-xl-5 col-lg-5 col-md-5 col-sm-5 row" style="margin:auto">
                                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6">Presupuesto Utilizado (Lps.):</div>
                                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6">
                                                <input type="text" id="PresupuestoUtilizado2" class="form-control" placeholder="10,000" readonly disable>
                                            </div>
                                        </div>
                                        <div class="input col-xl-5 col-lg-5 col-md-5 col-sm-5 row" style="margin:auto">
                                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6">Presupuesto Disponible (Lps.):</div>
                                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6">
                                                <input type="text" id="PresupuestoDisponible2" class="form-control" placeholder="10,000" readonly disable>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>
                        <div style="color: #757575;" class="tabla">
                            <h4 align="center">Listado de actividades:</h4>
                            <div class="table-responsive">
                                <table id="DimensionesTablaModificar3" class="table" cellspacing="0" width="100%">
                                    <thead>
                                        <tr align="center">
                                            <th scope="col">Estado</th>
                                            <th scope="col">Dimension Acadaemica</th>
                                            <th scope="col">Llenar dimension</th>
                                        </tr>
                                    </thead>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div id="ventana3">
                        <div class="container tabla">    
                            <form class="text-center" style="color: #757575;" action="#!">
                                <div class="form-row">
                                    <div class="col-12">
                                        <div class="md-form">
                                            <input type="text" id="Actividads" class="form-control">
                                            <span id="errorsActividads" class="text-danger text-small d-none">
                                            </span>
                                            <label 
                                                for="Actividads"
                                                id="labelActividads"
                                            >
                                            Actividad
                                            </label>
                                        </div>
                                    </div>
                                    <div class="col-3">
                                        <div class="md-form" style="width:50%; margin-left:auto;margin-right:auto;">
                                            <input type="number" id="Cantidad" class="form-control">
                                            <span id="errorsCantidad" class="text-danger text-small d-none">
                                            </span>
                                            <label 
                                                for="Cantidad"
                                                id="labelCantidad"
                                            >
                                            Cantidad
                                            </label>
                                        </div>
                                    </div>
                                    <div class="col-3">
                                        <div class="md-form" style="width:50%; margin-left:auto;margin-right:auto;">
                                            <input type="number" id="Costo" class="form-control">
                                            <span id="errorsCosto" class="text-danger text-small d-none">
                                            </span>
                                            <label 
                                                for="Costo"
                                                id="labelCosto"
                                            >
                                            Costo
                                            </label>
                                        </div>
                                    </div>
                                    <div class="col-6 row">
                                        <div class="md-form" style="width:50%; margin-left:auto;margin-right:auto;">
                                            <input type="number" id="Costo" class="form-control" readonly disabled>
                                            <label 
                                                for="Costo"
                                                id="labelCosto"
                                            >
                                            Costo Total
                                            </label>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="input-field col-xl-4 col-lg-4 col-md-4 col-sm-12" style="padding-left:0;margin-left:auto">
                                        <label for="TipoPresupuesto" id="labelTipoPresupuesto">Tipo de presupuesto:</label>
                                        <select name="TipoPresupuesto" id="TipoPresupuesto" class="browser-default custom-select mb-4">

                                        </select>
                                        <span id="errorsTipoPresupuesto" class="text-danger text-small d-none">
                                        </span>
                                    </div>
                                    <div class="input-field col-xl-4 col-lg-4 col-md-4 col-sm-12" style="padding-left:0;margin-right:auto">
                                        <label for="ObjGasto" id="labelObjGasto">Objeto de Gasto:</label>
                                        <select name="ObjGasto" id="ObjGasto" class="browser-default custom-select mb-4">

                                        </select>
                                        <span id="errorsObjGasto" class="text-danger text-small d-none">
                                        </span>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="md-form">
                                        <input type="text" id="DescripcionCuenta" class="form-control">
                                        <span id="errorsDescripcionCuenta" class="text-danger text-small d-none">
                                        </span>
                                        <label 
                                            for="DescripcionCuenta"
                                            id="labelDescripcionCuenta"
                                        >
                                        Descripcion de la cuenta
                                        </label>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="md-form">
                                        <input type="text" id="DimensionEstrategicaS" class="form-control">
                                        <span id="errorsDimensionEstrategicaS" class="text-danger text-small d-none">
                                        </span>
                                        <label 
                                            for="DimensionEstrategicaS"
                                            id="labelDimensionEstrategicaS"
                                        >
                                        Dimension Estrategica
                                        </label>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="md-form">
                                        <input type="text" id="Carrera" class="form-control">
                                        <span id="errorsCarrera" class="text-danger text-small d-none">
                                        </span>
                                        <label 
                                            for="Carrera"
                                            id="labelCarrera"
                                        >
                                        Mes requerido
                                        </label>
                                    </div>
                                </div>

                            </form>
                        </div>
                    </div>
                </div>
                <div class="modal-footer card-footer amber accent-4">
                    <div class="text-center foot-modif">
                        <button id="botonModif" type="button" class="btn btn-light-green btn-rounded btn-sm" onclick="" disabled>Guardar Cambios</button>
                    </div>
                    <div class="text-center foot-modif">
                        <button type="button" class="btn btn-danger btn-rounded btn-sm" data-dismiss="modal" aria-label="Close">Cancelar</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!--Agregar Actividades-->
    <div 
        class="modal fade" 
        id="modalModificarCarrera" 
        tabindex="-1" role="dialog" 
        aria-labelledby="myModalLabel" 
        aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header indigo darken-4 text-white">
                    <h4 class="modal-title w-100" id="myModalLabel">Seccion para agregar actividad</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div id="ventanaA" class="table-responsive">
                        <table id="DimensionesTablaAgregar" class="table" cellspacing="0" width="100%">
                            <thead>
                                <tr align="center">
                                    <th scope="col">Estado</th>
                                    <th scope="col">Dimension Acadaemica</th>
                                    <th scope="col">Llenar dimension</th>
                                </tr>
                            </thead>
                        </table>
                    </div>
                    <div id="ventana1A">
                        <form class="text-center" style="color: #757575;" action="#!">
                            <div class="tabla">
                                <h4 align="center">Seleccione lista de actividades que desea editar:</h4>
                                <div class="form-row">
                                    <div class="input-field col-xl-6 col-lg-6 col-md-6 col-sm-12">
                                        <label>Dimension academica:</label>
                                        <select id="DimensionAc" class="browser-default custom-select mb-4" onchange="">

                                        </select>
                                    </div>
                                    <div id="carreraSel"  class="input-field col-xl-6 col-lg-6 col-md-6 col-sm-12">
                                        <label>Objetivo institucional:</label>
                                        <select id="ObjInstitucional" class="browser-default custom-select mb-4" onchange="">

                                        </select>
                                    </div>
                                    <div class="input-field col-xl-6 col-lg-6 col-md-6 col-sm-12">
                                        <label>Area estrategica:</label>
                                        <select id="AreaE" class="browser-default custom-select mb-4" onchange="">
        
                                        </select>
                                    </div>
                                    <div class="input-field col-xl-6 col-lg-6 col-md-6 col-sm-12">
                                        <label>Actividad:</label>
                                        <select id="Activ" class="browser-default custom-select mb-4" onchange="">
        
                                        </select>
                                    </div>
                                    <div class="container">
                                        <div class="row">
                                            <div class="input col-xl-5 col-lg-5 col-md-5 col-sm-5 row" style="margin:auto">
                                                <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6">Presupuesto Utilizado (Lps.):</div>
                                                <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6">
                                                    <input type="text" id="PresupuestoUtilizado2" class="form-control" placeholder="10,000" readonly disable>
                                                </div>
                                            </div>
                                            <div class="input col-xl-5 col-lg-5 col-md-5 col-sm-5 row" style="margin:auto">
                                                <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6">Presupuesto Disponible (Lps.):</div>
                                                <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6">
                                                    <input type="text" id="PresupuestoDisponible2" class="form-control" placeholder="10,000" readonly disable>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="tabla">
                                <h4 align="center">Actividad: Contrtatacion personal</h4>
                                <div class="form-row">
                                    <div class="col-12">
                                        <div class="md-form">
                                            <input type="text" id="Actividads" class="form-control">
                                            <span id="errorsActividads" class="text-danger text-small d-none">
                                            </span>
                                            <label 
                                                for="Actividads"
                                                id="labelActividads"
                                            >
                                            Actividad
                                            </label>
                                        </div>
                                    </div>
                                    <div class="col-3">
                                        <div class="md-form" style="width:50%; margin-left:auto;margin-right:auto;">
                                            <input type="number" id="Cantidad" class="form-control">
                                            <span id="errorsCantidad" class="text-danger text-small d-none">
                                            </span>
                                            <label 
                                                for="Cantidad"
                                                id="labelCantidad"
                                            >
                                            Cantidad
                                            </label>
                                        </div>
                                    </div>
                                    <div class="col-3">
                                        <div class="md-form" style="width:50%; margin-left:auto;margin-right:auto;">
                                            <input type="number" id="Costo" class="form-control">
                                            <span id="errorsCosto" class="text-danger text-small d-none">
                                            </span>
                                            <label 
                                                for="Costo"
                                                id="labelCosto"
                                            >
                                            Costo
                                            </label>
                                        </div>
                                    </div>
                                    <div class="col-6 row">
                                        <div class="md-form" style="width:50%; margin-left:auto;margin-right:auto;">
                                            <input type="number" id="Costo" class="form-control" readonly disabled>
                                            <label 
                                                for="Costo"
                                                id="labelCosto"
                                            >
                                            Costo Total
                                            </label>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="input-field col-xl-4 col-lg-4 col-md-4 col-sm-12" style="padding-left:0;margin-left:auto">
                                        <label for="TipoPresupuesto" id="labelTipoPresupuesto">Tipo de presupuesto:</label>
                                        <select name="TipoPresupuesto" id="TipoPresupuesto" class="browser-default custom-select mb-4">

                                        </select>
                                        <span id="errorsTipoPresupuesto" class="text-danger text-small d-none">
                                        </span>
                                    </div>
                                    <div class="input-field col-xl-4 col-lg-4 col-md-4 col-sm-12" style="padding-left:0;margin-right:auto">
                                        <label for="ObjGasto" id="labelObjGasto">Objeto de Gasto:</label>
                                        <select name="ObjGasto" id="ObjGasto" class="browser-default custom-select mb-4">

                                        </select>
                                        <span id="errorsObjGasto" class="text-danger text-small d-none">
                                        </span>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="md-form">
                                        <input type="text" id="DescripcionCuenta" class="form-control">
                                        <span id="errorsDescripcionCuenta" class="text-danger text-small d-none">
                                        </span>
                                        <label 
                                            for="DescripcionCuenta"
                                            id="labelDescripcionCuenta"
                                        >
                                        Descripcion de la cuenta
                                        </label>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="md-form">
                                        <input type="text" id="DimensionEstrategicaS" class="form-control">
                                        <span id="errorsDimensionEstrategicaS" class="text-danger text-small d-none">
                                        </span>
                                        <label 
                                            for="DimensionEstrategicaS"
                                            id="labelDimensionEstrategicaS"
                                        >
                                        Dimension Estrategica
                                        </label>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="md-form">
                                        <input type="text" id="Carrera" class="form-control">
                                        <span id="errorsCarrera" class="text-danger text-small d-none">
                                        </span>
                                        <label 
                                            for="Carrera"
                                            id="labelCarrera"
                                        >
                                        Mes requerido
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="modal-footer card-footer amber accent-4">
                    <div class="text-center foot-agr">
                        <button id="botonModif" type="button" class="btn btn-light-green btn-rounded btn-sm" onclick="" disabled>Guardar Cambios</button>
                    </div>
                    <div class="text-center foot-agr">
                        <button type="button" class="btn btn-danger btn-rounded btn-sm" data-dismiss="modal" aria-label="Close">Cancelar</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!--En esta zona podran poner javascripts propios de la vista-->
    
    <script src="../js/sweet-alert-two/sweetalert2.min.js"></script>
    <script src="../js/libreria-bootstrap-mdb/jquery.min.js"></script>

    <script src="../js/data-tables/datatables.min.js"></script>

    <script src="../js/data-tables/Buttons/js/dataTables.buttons.min.js"></script>
    <script src="../js/data-tables/JSZip/jszip.min.js"></script>
    <script src="../js/data-tables/pdfmake/pdfmake.min.js"></script>
    <script src="../js/data-tables/pdfmake/vfs_fonts.js"></script>
    <script src="../js/data-tables/Buttons/js/buttons.html5.min.js"></script>
    
    <script src="../js/config/config.js"></script>
    <script src="../js/validators/form-validator.js"></script>
    <script src="../js/Jefe-Coordinador/principal.js"></script>

<?php
    include('../partials/endDoctype.php');
?>
